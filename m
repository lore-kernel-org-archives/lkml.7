Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A33CA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 01:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E61A21D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 01:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vEtB87qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408896AbfJRBK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 21:10:27 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:48442 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392283AbfJRBK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 21:10:26 -0400
Received: by mail-yb1-f202.google.com with SMTP id o141so3287574yba.15
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 18:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Gp4W8WzbrTQcxo8eBFvGUXqdblI90gnr8Ed2Sn/zXAw=;
        b=vEtB87qqsk5LnBICrCvE2lo4llre58CJ1+3SomEWQBwRSrBAy4uJtLZnhXx2Zzwr1Y
         q1/ekCamuQK90Rf3GwrYuzdCbQG/uj8PmtLgFa1Wkt0hobpPsF9CDQL71MyGXL9B24g1
         92Cm+0RfTszCtL+WsRNC+GYz77decCUqZxm3d+WMyHAWwOqzpBAoMW+ZoUorS9WLCB2s
         pTIMC3a89RjUd0g0qkxg6UvwTgtuDfOaRaWUoP4SF65jtaKxRnXu3Mu2Kwix6PfMcKYG
         +CT2RwQ/uwojhgsZcAX60oEVhBz03eoKwinjgZs3L+OjSRqwq07Uk9HIpxxMraJnM11T
         UIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Gp4W8WzbrTQcxo8eBFvGUXqdblI90gnr8Ed2Sn/zXAw=;
        b=rt97sE8Jdpsfb9Mxc7qg13nQdLcNU2Efa1XXuZQUOjfk2wU0xW+6Bwa1Wjj8iwZSY6
         2nH2DbOgTjBm63ZsCPGVPDyfHg5bfQn+LglWp741AofFM/ShN18ZWMs/0hYOVM1iI28D
         wFWN3lFiFMKtKtRVpl/6xEL1Y2fYc1lgx0sikYFaTSIx7v/tKMmX1uQsage0AviBbnee
         /9BhMxoiAnMXsSqJGe3QgTg5/MQ1ZW30KkndkcsTJi76n7jcwYWCTbrBezS8SQvzVp80
         Coe48ujmL1NKVTedPjS9nUxlHDv6e+5aKpv+Puvsga6c28tCgnmFXrBZIw1o56+stqeC
         WMnQ==
X-Gm-Message-State: APjAAAU1NMmaV9hyN7tyFaN82/f3+c0c2CeniiyGT30B7uTLfv7sacPO
        rJTjOSTqIEZhovi7IC0ZKGlENnMecxo=
X-Google-Smtp-Source: APXvYqyhPoNi2liOipCs5iHcM3qBG0KpM4LgsSZNcQoHNjuHVP0fgfVFk3C0rHDfjQZ1cORSZql3RPvaB7Y=
X-Received: by 2002:a81:4c4f:: with SMTP id z76mr818777ywa.25.1571361025266;
 Thu, 17 Oct 2019 18:10:25 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:08:46 +0900
Message-Id: <20191018010846.186484-1-pliard@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH] squashfs: Migrate from ll_rw_block usage to BIO
From:   Philippe Liard <pliard@google.com>
To:     phillip@squashfs.org.uk
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        Philippe Liard <pliard@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ll_rw_block() function has been deprecated in favor of BIO which
appears to come with large performance improvements.

This patch decreases boot time by close to 40% when using squashfs for
the root file-system. This is observed at least in the context of
starting an Android VM on Chrome OS using crosvm
(https://chromium.googlesource.com/chromiumos/platform/crosvm). The
patch was tested on 4.19 as well as master.

This patch is largely based on Adrien Schildknecht's patch that was
originally sent as https://lkml.org/lkml/2017/9/22/814 though with some
significant changes and simplifications while also taking Phillip
Lougher's feedback into account, around preserving support for
FILE_CACHE in particular.

Signed-off-by: Philippe Liard <pliard@google.com>
---
 fs/squashfs/block.c | 377 ++++++++++++++++++++++++++++----------------
 1 file changed, 244 insertions(+), 133 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index f098b9f1c396..5ec7528b9d2f 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -26,12 +26,14 @@
  * datablocks and metadata blocks.
  */
 
+#include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/vfs.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/buffer_head.h>
 #include <linux/bio.h>
+#include <linux/pagemap.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
@@ -39,45 +41,207 @@
 #include "decompressor.h"
 #include "page_actor.h"
 
+struct squashfs_bio_request {
+	struct buffer_head **bh;
+	int bh_start;
+	int bh_len;
+};
+
 /*
- * Read the metadata block length, this is stored in the first two
- * bytes of the metadata block.
+ * Returns the amount of bytes copied to the page actor or an error as
+ * a negative number.
  */
-static struct buffer_head *get_block_length(struct super_block *sb,
-			u64 *cur_index, int *offset, int *length)
+static int squashfs_bh_to_actor(struct buffer_head **bh, int nr_buffers,
+				struct squashfs_page_actor *actor,
+				int blk_offset, int req_length, int blk_size)
 {
-	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	struct buffer_head *bh;
+	int bytes_to_copy, copied_bytes = 0;
+	int actor_offset = 0, bh_offset = 0;
+	const int input_size = nr_buffers * blk_size;
+	const int output_capacity = actor->pages * PAGE_SIZE;
+	void *actor_addr = squashfs_first_page(actor);
+
+	if (blk_offset + req_length > input_size ||
+	    req_length > output_capacity)
+		return -EIO;
+
+	while (copied_bytes < req_length) {
+		bytes_to_copy = min_t(int, blk_size - blk_offset,
+				      PAGE_SIZE - actor_offset);
+		bytes_to_copy = min_t(int, bytes_to_copy,
+				      req_length - copied_bytes);
+		memcpy(actor_addr + actor_offset,
+		       bh[bh_offset]->b_data + blk_offset, bytes_to_copy);
+
+		actor_offset += bytes_to_copy;
+		copied_bytes += bytes_to_copy;
+		blk_offset += bytes_to_copy;
+
+		if (actor_offset >= PAGE_SIZE) {
+			actor_offset = 0;
+			actor_addr = squashfs_next_page(actor);
+		}
+		if (blk_offset >= blk_size) {
+			blk_offset = 0;
+			++bh_offset;
+		}
+	}
+	squashfs_finish_page(actor);
+	return copied_bytes;
+}
+
+static void squashfs_bio_end_io(struct bio *bio)
+{
+	struct squashfs_bio_request *bio_req = bio->bi_private;
+	blk_status_t error = bio->bi_status;
+	int i;
+
+	bio_put(bio);
+
+	for (i = bio_req->bh_start; i < bio_req->bh_start + bio_req->bh_len;
+	     ++i) {
+		if (error)
+			clear_buffer_uptodate(bio_req->bh[i]);
+		else
+			set_buffer_uptodate(bio_req->bh[i]);
+		unlock_buffer(bio_req->bh[i]);
+	}
+	kfree(bio_req);
+}
+
+static void put_bh_array(struct buffer_head **bh, int start, int len)
+{
+	int i;
+
+	for (i = start; i < start + len; ++i)
+		put_bh(bh[i]);
+}
 
-	bh = sb_bread(sb, *cur_index);
-	if (bh == NULL)
+static struct buffer_head **
+create_buffer_head_array(struct super_block *sb, int nr_buffers, u64 block)
+{
+	int i;
+	struct buffer_head **bh;
+
+	bh = kmalloc_array(nr_buffers, sizeof(*bh), GFP_NOIO);
+	if (!bh)
 		return NULL;
 
-	if (msblk->devblksize - *offset == 1) {
-		*length = (unsigned char) bh->b_data[*offset];
-		put_bh(bh);
-		bh = sb_bread(sb, ++(*cur_index));
-		if (bh == NULL)
+	for (i = 0; i < nr_buffers; ++i) {
+		bh[i] = sb_getblk(sb, block + i);
+		if (!bh[i]) {
+			put_bh_array(bh, 0, i);
+			kfree(bh);
 			return NULL;
-		*length |= (unsigned char) bh->b_data[0] << 8;
-		*offset = 1;
-	} else {
-		*length = (unsigned char) bh->b_data[*offset] |
-			(unsigned char) bh->b_data[*offset + 1] << 8;
-		*offset += 2;
-
-		if (*offset == msblk->devblksize) {
-			put_bh(bh);
-			bh = sb_bread(sb, ++(*cur_index));
-			if (bh == NULL)
-				return NULL;
-			*offset = 0;
 		}
 	}
-
 	return bh;
 }
 
+static void free_bh_array(struct buffer_head **bh, int nr_buffers)
+{
+	if (bh) {
+		put_bh_array(bh, 0, nr_buffers);
+		kfree(bh);
+	}
+}
+
+/*
+ * Returns 0 on success and fills bh_ptr, nr_buffers and block_offset. An error
+ * is otherwise returned as a negative number. Note that the caller must free
+ * *bh_ptr on success.
+ */
+static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
+			     struct buffer_head ***bh_ptr, int *nr_buffers,
+			     int *block_offset)
+{
+	struct bio *bio = NULL;
+	struct buffer_head *bh, **bh_array;
+	struct squashfs_bio_request *bio_req = NULL;
+	int i, prev_block = 0;
+
+	struct squashfs_sb_info *msblk = sb->s_fs_info;
+	const u64 read_start = round_down(index, msblk->devblksize);
+	const sector_t block = read_start >> msblk->devblksize_log2;
+
+	const u64 read_end = round_up(index + length, msblk->devblksize);
+	const sector_t block_end = read_end >> msblk->devblksize_log2;
+
+	const int blksz = msblk->devblksize;
+	const int bio_max_pages = min_t(int, block_end - block, BIO_MAX_PAGES);
+	int offset = read_start - round_down(index, PAGE_SIZE);
+	int res;
+
+	*block_offset = index & ((1 << msblk->devblksize_log2) - 1);
+	*nr_buffers = block_end - block;
+	bh_array = create_buffer_head_array(sb, *nr_buffers, block);
+	*bh_ptr = bh_array;
+	if (!bh_array)
+		return -ENOMEM;
+
+	/* Create and submit the BIOs */
+	for (i = 0; i < *nr_buffers; ++i, offset += blksz) {
+		bh = bh_array[i];
+		lock_buffer(bh);
+		if (buffer_uptodate(bh)) {
+			unlock_buffer(bh);
+			continue;
+		}
+		offset %= PAGE_SIZE;
+
+		/* Append the buffer to the current BIO if it is contiguous */
+		if (bio && bio_req && prev_block + 1 == i) {
+			if (bio_add_page(bio, bh->b_page, blksz, offset)) {
+				bio_req->bh_len++;
+				prev_block = i;
+				continue;
+			}
+		}
+
+		/* Otherwise, submit the current BIO and create a new one */
+		if (bio)
+			submit_bio(bio);
+
+		bio_req = kzalloc(sizeof(struct squashfs_bio_request),
+				  GFP_NOIO);
+		bio = bio_req ? bio_alloc(GFP_NOIO, bio_max_pages) : NULL;
+		if (!bio) {
+			kfree(bio_req);
+			unlock_buffer(bh);
+			res = -ENOMEM;
+			goto cleanup;
+		}
+
+		bio_set_dev(bio, sb->s_bdev);
+		bio->bi_iter.bi_sector =
+			(block + i) * (msblk->devblksize >> SECTOR_SHIFT);
+		bio->bi_private = bio_req;
+		bio->bi_end_io = squashfs_bio_end_io;
+		bio->bi_opf = READ;
+
+		bio_req->bh = bh_array;
+		bio_req->bh_start = i;
+		bio_req->bh_len = 1;
+		bio_add_page(bio, bh->b_page, blksz, offset);
+		prev_block = i;
+	}
+	if (bio)
+		submit_bio(bio);
+
+	res = 0;
+
+cleanup:
+	for (i = 0; i < *nr_buffers; ++i) {
+		wait_on_buffer(bh_array[i]);
+		if (!buffer_uptodate(bh_array[i]) && res == 0)
+			res = -EIO;
+	}
+	if (res) {
+		free_bh_array(bh_array, *nr_buffers);
+		*bh_ptr = NULL;
+	}
+	return res;
+}
 
 /*
  * Read and decompress a metadata block or datablock.  Length is non-zero
@@ -89,129 +253,76 @@ static struct buffer_head *get_block_length(struct super_block *sb,
  * algorithms).
  */
 int squashfs_read_data(struct super_block *sb, u64 index, int length,
-		u64 *next_index, struct squashfs_page_actor *output)
+		       u64 *next_index, struct squashfs_page_actor *output)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	struct buffer_head **bh;
-	int offset = index & ((1 << msblk->devblksize_log2) - 1);
-	u64 cur_index = index >> msblk->devblksize_log2;
-	int bytes, compressed, b = 0, k = 0, avail, i;
-
-	bh = kcalloc(((output->length + msblk->devblksize - 1)
-		>> msblk->devblksize_log2) + 1, sizeof(*bh), GFP_KERNEL);
-	if (bh == NULL)
-		return -ENOMEM;
+	int res;
+	struct buffer_head **bh = NULL;
+	int nr_buffers;
+	int compressed;
+	int offset;
 
-	if (length) {
-		/*
-		 * Datablock.
-		 */
-		bytes = -offset;
-		compressed = SQUASHFS_COMPRESSED_BLOCK(length);
-		length = SQUASHFS_COMPRESSED_SIZE_BLOCK(length);
-		if (next_index)
-			*next_index = index + length;
-
-		TRACE("Block @ 0x%llx, %scompressed size %d, src size %d\n",
-			index, compressed ? "" : "un", length, output->length);
-
-		if (length < 0 || length > output->length ||
-				(index + length) > msblk->bytes_used)
-			goto read_failure;
-
-		for (b = 0; bytes < length; b++, cur_index++) {
-			bh[b] = sb_getblk(sb, cur_index);
-			if (bh[b] == NULL)
-				goto block_release;
-			bytes += msblk->devblksize;
-		}
-		ll_rw_block(REQ_OP_READ, 0, b, bh);
-	} else {
+	if (length == 0) {
 		/*
 		 * Metadata block.
 		 */
-		if ((index + 2) > msblk->bytes_used)
-			goto read_failure;
+		length = 2;
+		if (index + length > msblk->bytes_used) {
+			res = -EIO;
+			goto out;
+		}
+		res = squashfs_bio_read(sb, index, length, &bh, &nr_buffers,
+					&offset);
+		if (res)
+			goto out;
 
-		bh[0] = get_block_length(sb, &cur_index, &offset, &length);
-		if (bh[0] == NULL)
-			goto read_failure;
-		b = 1;
+		/* Extract the length of the metadata block */
+		length = (u8) bh[0]->b_data[offset];
+		length |= offset == msblk->devblksize - 1
+			? (u8) bh[1]->b_data[0] << 8
+			: (u8) bh[0]->b_data[offset + 1] << 8;
 
-		bytes = msblk->devblksize - offset;
 		compressed = SQUASHFS_COMPRESSED(length);
 		length = SQUASHFS_COMPRESSED_SIZE(length);
-		if (next_index)
-			*next_index = index + length + 2;
 
-		TRACE("Block @ 0x%llx, %scompressed size %d\n", index,
-				compressed ? "" : "un", length);
-
-		if (length < 0 || length > output->length ||
-					(index + length) > msblk->bytes_used)
-			goto block_release;
-
-		for (; bytes < length; b++) {
-			bh[b] = sb_getblk(sb, ++cur_index);
-			if (bh[b] == NULL)
-				goto block_release;
-			bytes += msblk->devblksize;
-		}
-		ll_rw_block(REQ_OP_READ, 0, b - 1, bh + 1);
+		free_bh_array(bh, nr_buffers);
+		bh = NULL;
+		index += 2;
+	} else {
+		/*
+		 * Data block.
+		 */
+		compressed = SQUASHFS_COMPRESSED_BLOCK(length);
+		length = SQUASHFS_COMPRESSED_SIZE_BLOCK(length);
 	}
+	if (next_index)
+		*next_index = index + length;
 
-	for (i = 0; i < b; i++) {
-		wait_on_buffer(bh[i]);
-		if (!buffer_uptodate(bh[i]))
-			goto block_release;
-	}
+	res = squashfs_bio_read(sb, index, length, &bh, &nr_buffers, &offset);
+	if (res)
+		goto out;
 
 	if (compressed) {
-		if (!msblk->stream)
-			goto read_failure;
-		length = squashfs_decompress(msblk, bh, b, offset, length,
-			output);
-		if (length < 0)
-			goto read_failure;
-	} else {
-		/*
-		 * Block is uncompressed.
-		 */
-		int in, pg_offset = 0;
-		void *data = squashfs_first_page(output);
-
-		for (bytes = length; k < b; k++) {
-			in = min(bytes, msblk->devblksize - offset);
-			bytes -= in;
-			while (in) {
-				if (pg_offset == PAGE_SIZE) {
-					data = squashfs_next_page(output);
-					pg_offset = 0;
-				}
-				avail = min_t(int, in, PAGE_SIZE -
-						pg_offset);
-				memcpy(data + pg_offset, bh[k]->b_data + offset,
-						avail);
-				in -= avail;
-				pg_offset += avail;
-				offset += avail;
-			}
-			offset = 0;
-			put_bh(bh[k]);
+		if (!msblk->stream) {
+			res = -EIO;
+			goto out;
 		}
-		squashfs_finish_page(output);
+		/* Note that this calls put_bh() */
+		res = squashfs_decompress(msblk, bh, nr_buffers, offset, length,
+					  output);
+		kfree(bh);
+		bh = NULL;
+	} else {
+		res = squashfs_bh_to_actor(bh, nr_buffers, output, offset,
+					   length, msblk->devblksize);
 	}
+out:
+	TRACE("compressed=%d index=%lld length=%d next_index=%lld result=%d\n",
+	      compressed, index, length, next_index ? *next_index : -1, res);
 
-	kfree(bh);
-	return length;
-
-block_release:
-	for (; k < b; k++)
-		put_bh(bh[k]);
+	free_bh_array(bh, nr_buffers);
 
-read_failure:
-	ERROR("squashfs_read_data failed to read block 0x%llx\n",
-					(unsigned long long) index);
-	kfree(bh);
-	return -EIO;
+	if (res < 0)
+		ERROR("Failed to read block 0x%llx\n", index);
+	return res;
 }
-- 
2.23.0.866.gb869b98d4c-goog

