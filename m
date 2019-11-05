Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07591C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D945E21928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389866AbfKEPVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:21:52 -0500
Received: from verein.lst.de ([213.95.11.211]:46056 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389577AbfKEPVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:21:52 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB77368AFE; Tue,  5 Nov 2019 16:21:49 +0100 (CET)
Date:   Tue, 5 Nov 2019 16:21:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Philippe Liard <pliard@google.com>
Cc:     phillip@squashfs.org.uk, hch@lst.de, linux-kernel@vger.kernel.org,
        groeck@chromium.org
Subject: Re: [PATCH v2] squashfs: Migrate from ll_rw_block usage to BIO
Message-ID: <20191105152149.GA10104@lst.de>
References: <20191105075339.15280-1-pliard@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105075339.15280-1-pliard@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think you need the read context.  The bio tracks how many pages
have been added, and there actually is a block layer helper to free them.
Also this patch has some direct access to the bvec array, which is
forbidden.  Take a look at the completely untested patch below to
switch to using the bio iterators and kill off the read context.

Also note that you should generally not update defconfigs, especially
ones that don't exist in patches to file systems or drivers.

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 358afb676e66..5ee501d611dd 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -35,20 +35,19 @@ static int copy_bio_to_actor(struct bio *bio,
 			     int offset, int req_length)
 {
 	void *actor_addr = squashfs_first_page(actor);
-	struct bio_vec bvec = bio->bi_io_vec[0];
+	struct bvec_iter_all iter_all = { };
+	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
 	int copied_bytes = 0;
 	int actor_offset = 0;
-	int bvec_index = 0;
 
-	while (actor_addr && bvec_index < bio->bi_vcnt &&
-	       copied_bytes < req_length) {
-		int bytes_to_copy = min_t(int, bvec.bv_len - offset,
+	while (copied_bytes < req_length) {
+		int bytes_to_copy = min_t(int, bvec->bv_len - offset,
 					  PAGE_SIZE - actor_offset);
 
 		bytes_to_copy = min_t(int, bytes_to_copy,
 				      req_length - copied_bytes);
 		memcpy(actor_addr + actor_offset,
-		       page_address(bvec.bv_page) + bvec.bv_offset + offset,
+		       page_address(bvec->bv_page) + bvec->bv_offset + offset,
 		       bytes_to_copy);
 
 		actor_offset += bytes_to_copy;
@@ -56,103 +55,73 @@ static int copy_bio_to_actor(struct bio *bio,
 		offset += bytes_to_copy;
 
 		if (actor_offset >= PAGE_SIZE) {
-			actor_offset = 0;
 			actor_addr = squashfs_next_page(actor);
+			if (!actor_addr)
+				break;
+			actor_offset = 0;
 		}
-		if (offset >= bvec.bv_len) {
+
+		if (offset >= bvec->bv_len) {
+			if (!bio_next_segment(bio, &iter_all))
+				break;
 			offset = 0;
-			++bvec_index;
-			if (bvec_index < bio->bi_vcnt)
-				bvec = bio->bi_io_vec[bvec_index];
 		}
 	}
 	squashfs_finish_page(actor);
 	return copied_bytes;
 }
 
-struct bio_read_context {
-	struct bio *bio;
-	struct page **pages;
-	int page_count;
-};
-
-static void free_bio_read_context(struct bio_read_context *bio_ctx)
-{
-	if (bio_ctx->bio)
-		bio_put(bio_ctx->bio);
-
-	if (bio_ctx->pages) {
-		int i;
-
-		for (i = 0; i < bio_ctx->page_count; ++i)
-			if (bio_ctx->pages[i])
-				__free_page(bio_ctx->pages[i]);
-		kfree(bio_ctx->pages);
-	}
-}
-
 static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
-			     struct bio_read_context *bio_ctx,
-			     int *block_offset)
+			     struct bio **biop, int *block_offset)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
 	const u64 read_start = round_down(index, msblk->devblksize);
 	const sector_t block = read_start >> msblk->devblksize_log2;
 	const u64 read_end = round_up(index + length, msblk->devblksize);
 	const sector_t block_end = read_end >> msblk->devblksize_log2;
+	unsigned int offset = read_start - round_down(index, PAGE_SIZE);
+	unsigned int total_len = (block_end - block) << msblk->devblksize_log2;
+	unsigned int page_count = DIV_ROUND_UP(total_len + offset, PAGE_SIZE);
+	int error = -ENOMEM, i;
+	struct bio *bio;
 
-	const int blksz = msblk->devblksize;
-	const int block_count = block_end - block;
-	const int bio_max_pages = min_t(int, block_count, BIO_MAX_PAGES);
-	int offset = read_start - round_down(index, PAGE_SIZE);
-	int res = 0;
-	int i, page_index;
-
-	memset(bio_ctx, 0, sizeof(*bio_ctx));
 	*block_offset = index & ((1 << msblk->devblksize_log2) - 1);
-	bio_ctx->page_count =
-		DIV_ROUND_UP(block_count * blksz + offset, PAGE_SIZE);
-	bio_ctx->pages =
-		kcalloc(bio_ctx->page_count, sizeof(struct page *), GFP_NOIO);
-	if (!bio_ctx->pages)
-		return -ENOMEM;
-
-	for (i = 0; i < bio_ctx->page_count; ++i) {
-		bio_ctx->pages[i] = alloc_page(GFP_NOIO);
-		if (!bio_ctx->pages[i]) {
-			res = -ENOMEM;
-			goto out;
-		}
-	}
 
-	bio_ctx->bio = bio_alloc(GFP_NOIO, bio_max_pages);
-	if (!bio_ctx->bio) {
-		res = -ENOMEM;
-		goto out;
-	}
-	bio_set_dev(bio_ctx->bio, sb->s_bdev);
-	bio_ctx->bio->bi_opf = READ;
-	bio_ctx->bio->bi_iter.bi_sector =
-		block * (msblk->devblksize >> SECTOR_SHIFT);
-
-	for (i = 0, page_index = 0; i < block_count; ++i) {
-		if (!bio_add_page(bio_ctx->bio, bio_ctx->pages[page_index],
-				  blksz, offset)) {
-			res = -EIO;
-			goto out;
-		}
-		offset += blksz;
-		if (offset >= PAGE_SIZE) {
-			offset = 0;
-			++page_index;
+	bio = bio_alloc(GFP_NOIO, page_count);
+	if (!bio)
+		goto out_free_bio;
+
+	bio_set_dev(bio, sb->s_bdev);
+	bio->bi_opf = READ;
+	bio->bi_iter.bi_sector = block * (msblk->devblksize >> SECTOR_SHIFT);
+
+	for (i = 0; i < page_count; ++i) {
+		struct page *page = alloc_page(GFP_NOIO);
+		unsigned int len =
+			min_t(unsigned int, PAGE_SIZE - offset, total_len);
+
+		if (!page)
+			goto out_free_bio;
+
+		if (!bio_add_page(bio, page, len, offset)) {
+			error = -EIO;
+			goto out_free_bio;
 		}
+
+		offset = 0;
+		total_len -= len;
 	}
-	res = submit_bio_wait(bio_ctx->bio);
-out:
-	if (res)
-		free_bio_read_context(bio_ctx);
 
-	return res;
+	error = submit_bio_wait(bio);
+	if (error)
+		goto out_free_bio;
+
+	*biop = bio;
+	return 0;
+
+out_free_bio:
+	bio_free_pages(bio);
+	return error;
 }
 
 /*
@@ -168,8 +137,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		       u64 *next_index, struct squashfs_page_actor *output)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	struct bio_read_context bio_ctx;
-	struct bio_vec bvec;
+	struct bio *bio = NULL;
 	int compressed;
 	int res;
 	int offset;
@@ -186,28 +154,31 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		/*
 		 * Metadata block.
 		 */
+		struct bvec_iter_all iter_all = { };
+		struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
 		const u8 *data;
 
 		if (index + 2 > msblk->bytes_used) {
 			res = -EIO;
 			goto out;
 		}
-		res = squashfs_bio_read(sb, index, 2, &bio_ctx, &offset);
+		res = squashfs_bio_read(sb, index, 2, &bio, &offset);
 		if (res)
 			goto out;
 
 		/* Extract the length of the metadata block */
-		bvec = bio_ctx.bio->bi_io_vec[0];
-		data = page_address(bvec.bv_page) + bvec.bv_offset;
+		data = page_address(bvec->bv_page) + bvec->bv_offset;
 		length = data[offset];
-		if (offset == bvec.bv_len - 1) {
-			bvec = bio_ctx.bio->bi_io_vec[1];
-			data = page_address(bvec.bv_page) + bvec.bv_offset;
-			length |= data[0] << 8;
-		} else {
+		if (offset <= bvec->bv_len - 1) {
 			length |= data[offset + 1] << 8;
+		} else {
+			if (WARN_ON_ONCE(!bio_next_segment(bio, &iter_all))) {
+				res = -EIO;
+				goto out;
+			}
+			data = page_address(bvec->bv_page) + bvec->bv_offset;
 		}
-		free_bio_read_context(&bio_ctx);
+		bio_free_pages(bio);
 
 		compressed = SQUASHFS_COMPRESSED(length);
 		length = SQUASHFS_COMPRESSED_SIZE(length);
@@ -219,21 +190,21 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 	if (next_index)
 		*next_index = index + length;
 
-	res = squashfs_bio_read(sb, index, length, &bio_ctx, &offset);
+	res = squashfs_bio_read(sb, index, length, &bio, &offset);
 	if (res)
 		goto out;
 
 	if (compressed) {
 		if (msblk->stream) {
-			res = squashfs_decompress(msblk, bio_ctx.bio, offset,
+			res = squashfs_decompress(msblk, bio, offset,
 						  length, output);
 		} else {
 			res = -EIO;
 		}
 	} else {
-		res = copy_bio_to_actor(bio_ctx.bio, output, offset, length);
+		res = copy_bio_to_actor(bio, output, offset, length);
 	}
-	free_bio_read_context(&bio_ctx);
+	bio_free_pages(bio);
 out:
 	if (res < 0)
 		ERROR("Failed to read block 0x%llx: %d\n", index, res);
