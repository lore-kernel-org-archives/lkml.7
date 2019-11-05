Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7641ECA9EDB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0391B20717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUeW9LBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbfKEHyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:54:10 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:32890 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387711AbfKEHyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:54:09 -0500
Received: by mail-qk1-f202.google.com with SMTP id o184so20506860qke.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 23:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=S5VqHIu+eLDNzJCbcLeE0VkSv70gQK741ebD7ZS2Q6k=;
        b=sUeW9LBAtS3M1fDo41OUkgDVo7KkpVH66WnFngsadCHSgTFL2f9f2L+M9RuOkYvbMK
         /QeTnxk6UpmSkOdYmPxFh4nNVzms8TXV0nLw+j8tJFWjwtfw6KrTHf2pc69uBRU9IFfM
         7wIxFMpqDOVM2dbIUXxY+N+ctvcCiufnfKGeRGUnZHU32LGS1mAFFmv/L8w4X09qJ+Ij
         CAaxXHx+nes22Qc+mKVwt6T0YLzgiJJ7VlZTTC326Oj4h+l3BaLjT4j3giDwIgKygVNN
         yaQB1vGs50b7j7x0jzYIUKDXMHtllL85sVGZTv0Dl29tAq55YYcR/NWYMWARQSD4Ejlj
         ar/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=S5VqHIu+eLDNzJCbcLeE0VkSv70gQK741ebD7ZS2Q6k=;
        b=FEHoBuyL/fMPo5vL05A5DhbKBGj3CsgXd5mxFiTLdPk3Di+WCPmIaQJth7Ve+E/nFS
         gjiQrNJ2SMhFQqxMBmhYo4d46fY8lo19RQi6M1+1xriafKRgbMJ1uHuo8Gaq38Rn0D66
         oGHBHFbqiol/KYFW+rpcHZguMpINE30Upf+bPaFeB5tk4A3B5tjRe3LE+BJ6ggOYTtoP
         quQgTiyYkMafZ7BwcGwdec+1uepKW8qyEq+rc3QmT98Idxogq4dENk5V6rHiOIVM65Hz
         l+XATWqOsBEr63RFQAO2Ke+oSBMbf32N67v/kB/BFYAF2RUGxr0drErrVXpREGYgUqz2
         1gKQ==
X-Gm-Message-State: APjAAAVgm4QofQGUNt+XWBbXteMPwX0YLFEQJf9XjEuhYmfBicEQqngU
        aMnz/lvnN9wWXSuY5Bn/H6aPwK7rTj4=
X-Google-Smtp-Source: APXvYqwdWkmVk3AGcPgphOoi3S/M0RBoZ5rgb1HI2R+0c6/EhudeM/qyn9lB75UsM9To02EyY9Nk4F2k2dI=
X-Received: by 2002:ad4:58a9:: with SMTP id ea9mr26062556qvb.179.1572940445727;
 Mon, 04 Nov 2019 23:54:05 -0800 (PST)
Date:   Tue,  5 Nov 2019 16:53:39 +0900
Message-Id: <20191105075339.15280-1-pliard@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v2] squashfs: Migrate from ll_rw_block usage to BIO
From:   Philippe Liard <pliard@google.com>
To:     phillip@squashfs.org.uk, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        pliard@google.com
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
Changes in v2:
- changed all decompressors to take a bio pointer
- removed usage of buffer_head in block.c

 arch/x86/configs/x86_64_arcvm_defconfig |   3 +
 fs/squashfs/block.c                     | 294 +++++++++++++-----------
 fs/squashfs/decompressor.h              |   5 +-
 fs/squashfs/decompressor_multi.c        |   9 +-
 fs/squashfs/decompressor_single.c       |   9 +-
 fs/squashfs/lz4_wrapper.c               |  17 +-
 fs/squashfs/lzo_wrapper.c               |  16 +-
 fs/squashfs/squashfs.h                  |   4 +-
 fs/squashfs/xz_wrapper.c                |  33 +--
 fs/squashfs/zlib_wrapper.c              |  34 ++-
 fs/squashfs/zstd_wrapper.c              |  33 ++-
 11 files changed, 251 insertions(+), 206 deletions(-)

diff --git a/arch/x86/configs/x86_64_arcvm_defconfig b/arch/x86/configs/x86_64_arcvm_defconfig
index 0a4872edba05..8103880713b6 100644
--- a/arch/x86/configs/x86_64_arcvm_defconfig
+++ b/arch/x86/configs/x86_64_arcvm_defconfig
@@ -542,6 +542,9 @@ CONFIG_SQUASHFS_FILE_DIRECT=y
 CONFIG_SQUASHFS_XATTR=y
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
+CONFIG_SQUASHFS_ZSTD=y
+CONFIG_SQUASHFS_ZLIB=y
+CONFIG_SQUASHFS_XZ=y
 CONFIG_PSTORE=y
 CONFIG_PSTORE_CONSOLE=y
 CONFIG_PSTORE_RAM=y
diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index f098b9f1c396..4b27e81da92e 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -26,6 +26,7 @@
  * datablocks and metadata blocks.
  */
 
+#include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/vfs.h>
 #include <linux/slab.h>
@@ -40,44 +41,132 @@
 #include "page_actor.h"
 
 /*
- * Read the metadata block length, this is stored in the first two
- * bytes of the metadata block.
+ * Returns the amount of bytes copied to the page actor.
  */
-static struct buffer_head *get_block_length(struct super_block *sb,
-			u64 *cur_index, int *offset, int *length)
+static int copy_bio_to_actor(struct bio *bio,
+			     struct squashfs_page_actor *actor,
+			     int offset, int req_length)
 {
-	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	struct buffer_head *bh;
-
-	bh = sb_bread(sb, *cur_index);
-	if (bh == NULL)
-		return NULL;
-
-	if (msblk->devblksize - *offset == 1) {
-		*length = (unsigned char) bh->b_data[*offset];
-		put_bh(bh);
-		bh = sb_bread(sb, ++(*cur_index));
-		if (bh == NULL)
-			return NULL;
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
+	void *actor_addr = squashfs_first_page(actor);
+	struct bio_vec bvec = bio->bi_io_vec[0];
+	int copied_bytes = 0;
+	int actor_offset = 0;
+	int bvec_index = 0;
+
+	while (actor_addr && bvec_index < bio->bi_vcnt &&
+	       copied_bytes < req_length) {
+		int bytes_to_copy = min_t(int, bvec.bv_len - offset,
+					  PAGE_SIZE - actor_offset);
+
+		bytes_to_copy = min_t(int, bytes_to_copy,
+				      req_length - copied_bytes);
+		memcpy(actor_addr + actor_offset,
+		       page_address(bvec.bv_page) + bvec.bv_offset + offset,
+		       bytes_to_copy);
+
+		actor_offset += bytes_to_copy;
+		copied_bytes += bytes_to_copy;
+		offset += bytes_to_copy;
+
+		if (actor_offset >= PAGE_SIZE) {
+			actor_offset = 0;
+			actor_addr = squashfs_next_page(actor);
+		}
+		if (offset >= bvec.bv_len) {
+			offset = 0;
+			++bvec_index;
+			if (bvec_index < bio->bi_vcnt)
+				bvec = bio->bi_io_vec[bvec_index];
 		}
 	}
+	squashfs_finish_page(actor);
+	return copied_bytes;
+}
+
+struct bio_read_context {
+	struct bio *bio;
+	struct page **pages;
+	int page_count;
+};
 
-	return bh;
+static void free_bio_read_context(struct bio_read_context *bio_ctx)
+{
+	if (bio_ctx->bio)
+		bio_put(bio_ctx->bio);
+
+	if (bio_ctx->pages) {
+		int i;
+
+		for (i = 0; i < bio_ctx->page_count; ++i)
+			if (bio_ctx->pages[i])
+				__free_page(bio_ctx->pages[i]);
+		kfree(bio_ctx->pages);
+	}
 }
 
+static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
+			     struct bio_read_context *bio_ctx,
+			     int *block_offset)
+{
+	struct squashfs_sb_info *msblk = sb->s_fs_info;
+	const u64 read_start = round_down(index, msblk->devblksize);
+	const sector_t block = read_start >> msblk->devblksize_log2;
+	const u64 read_end = round_up(index + length, msblk->devblksize);
+	const sector_t block_end = read_end >> msblk->devblksize_log2;
+
+	const int blksz = msblk->devblksize;
+	const int block_count = block_end - block;
+	const int bio_max_pages = min_t(int, block_count, BIO_MAX_PAGES);
+	int offset = read_start - round_down(index, PAGE_SIZE);
+	int res = 0;
+	int i, page_index;
+
+	memset(bio_ctx, 0, sizeof(*bio_ctx));
+	*block_offset = index & ((1 << msblk->devblksize_log2) - 1);
+	bio_ctx->page_count =
+		DIV_ROUND_UP(block_count * blksz + offset, PAGE_SIZE);
+	bio_ctx->pages =
+		kcalloc(bio_ctx->page_count, sizeof(struct page *), GFP_NOIO);
+	if (!bio_ctx->pages)
+		return -ENOMEM;
+
+	for (i = 0; i < bio_ctx->page_count; ++i) {
+		bio_ctx->pages[i] = alloc_page(GFP_NOIO);
+		if (!bio_ctx->pages[i]) {
+			res = -ENOMEM;
+			goto out;
+		}
+	}
+
+	bio_ctx->bio = bio_alloc(GFP_NOIO, bio_max_pages);
+	if (!bio_ctx->bio) {
+		res = -ENOMEM;
+		goto out;
+	}
+	bio_set_dev(bio_ctx->bio, sb->s_bdev);
+	bio_ctx->bio->bi_opf = READ;
+	bio_ctx->bio->bi_iter.bi_sector =
+		block * (msblk->devblksize >> SECTOR_SHIFT);
+
+	for (i = 0, page_index = 0; i < block_count; ++i) {
+		if (!bio_add_page(bio_ctx->bio, bio_ctx->pages[page_index],
+				  blksz, offset)) {
+			res = -EIO;
+			goto out;
+		}
+		offset += blksz;
+		if (offset >= PAGE_SIZE) {
+			offset = 0;
+			++page_index;
+		}
+	}
+	res = submit_bio_wait(bio_ctx->bio);
+out:
+	if (res)
+		free_bio_read_context(bio_ctx);
+
+	return res;
+}
 
 /*
  * Read and decompress a metadata block or datablock.  Length is non-zero
@@ -89,129 +178,78 @@ static struct buffer_head *get_block_length(struct super_block *sb,
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
+	struct bio_read_context bio_ctx;
+	struct bio_vec bvec;
+	int compressed;
+	int res;
+	int offset;
 
 	if (length) {
 		/*
 		 * Datablock.
 		 */
-		bytes = -offset;
 		compressed = SQUASHFS_COMPRESSED_BLOCK(length);
 		length = SQUASHFS_COMPRESSED_SIZE_BLOCK(length);
-		if (next_index)
-			*next_index = index + length;
-
 		TRACE("Block @ 0x%llx, %scompressed size %d, src size %d\n",
 			index, compressed ? "" : "un", length, output->length);
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
 	} else {
 		/*
 		 * Metadata block.
 		 */
-		if ((index + 2) > msblk->bytes_used)
-			goto read_failure;
+		const u8 *data;
 
-		bh[0] = get_block_length(sb, &cur_index, &offset, &length);
-		if (bh[0] == NULL)
-			goto read_failure;
-		b = 1;
+		if (index + 2 > msblk->bytes_used) {
+			res = -EIO;
+			goto out;
+		}
+		res = squashfs_bio_read(sb, index, 2, &bio_ctx, &offset);
+		if (res)
+			goto out;
+
+		/* Extract the length of the metadata block */
+		bvec = bio_ctx.bio->bi_io_vec[0];
+		data = page_address(bvec.bv_page) + bvec.bv_offset;
+		length = data[offset];
+		if (offset == bvec.bv_len - 1) {
+			bvec = bio_ctx.bio->bi_io_vec[1];
+			data = page_address(bvec.bv_page) + bvec.bv_offset;
+			length |= data[0] << 8;
+		} else {
+			length |= data[offset + 1] << 8;
+		}
+		free_bio_read_context(&bio_ctx);
 
-		bytes = msblk->devblksize - offset;
 		compressed = SQUASHFS_COMPRESSED(length);
 		length = SQUASHFS_COMPRESSED_SIZE(length);
-		if (next_index)
-			*next_index = index + length + 2;
+		index += 2;
 
 		TRACE("Block @ 0x%llx, %scompressed size %d\n", index,
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
+		      compressed ? "" : "un", length);
 	}
+	if (next_index)
+		*next_index = index + length;
 
-	for (i = 0; i < b; i++) {
-		wait_on_buffer(bh[i]);
-		if (!buffer_uptodate(bh[i]))
-			goto block_release;
-	}
+	res = squashfs_bio_read(sb, index, length, &bio_ctx, &offset);
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
+		if (msblk->stream) {
+			res = squashfs_decompress(msblk, bio_ctx.bio, offset,
+						  length, output);
+		} else {
+			res = -EIO;
 		}
-		squashfs_finish_page(output);
+	} else {
+		res = copy_bio_to_actor(bio_ctx.bio, output, offset, length);
 	}
+	free_bio_read_context(&bio_ctx);
+out:
+	if (res < 0)
+		ERROR("Failed to read block 0x%llx: %d\n", index, res);
 
-	kfree(bh);
-	return length;
-
-block_release:
-	for (; k < b; k++)
-		put_bh(bh[k]);
-
-read_failure:
-	ERROR("squashfs_read_data failed to read block 0x%llx\n",
-					(unsigned long long) index);
-	kfree(bh);
-	return -EIO;
+	return res;
 }
diff --git a/fs/squashfs/decompressor.h b/fs/squashfs/decompressor.h
index 0f5a8e4e58da..420fedd82f14 100644
--- a/fs/squashfs/decompressor.h
+++ b/fs/squashfs/decompressor.h
@@ -23,13 +23,14 @@
  * decompressor.h
  */
 
+#include <linux/bio.h>
+
 struct squashfs_decompressor {
 	void	*(*init)(struct squashfs_sb_info *, void *);
 	void	*(*comp_opts)(struct squashfs_sb_info *, void *, int);
 	void	(*free)(void *);
 	int	(*decompress)(struct squashfs_sb_info *, void *,
-		struct buffer_head **, int, int, int,
-		struct squashfs_page_actor *);
+		struct bio *, int, int, struct squashfs_page_actor *);
 	int	id;
 	char	*name;
 	int	supported;
diff --git a/fs/squashfs/decompressor_multi.c b/fs/squashfs/decompressor_multi.c
index d6008a636479..0bf1ac0f554e 100644
--- a/fs/squashfs/decompressor_multi.c
+++ b/fs/squashfs/decompressor_multi.c
@@ -8,7 +8,7 @@
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
-#include <linux/buffer_head.h>
+#include <linux/bio.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/cpumask.h>
@@ -182,14 +182,15 @@ static struct decomp_stream *get_decomp_stream(struct squashfs_sb_info *msblk,
 }
 
 
-int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
-	int b, int offset, int length, struct squashfs_page_actor *output)
+int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
+			int offset, int length,
+			struct squashfs_page_actor *output)
 {
 	int res;
 	struct squashfs_stream *stream = msblk->stream;
 	struct decomp_stream *decomp_stream = get_decomp_stream(msblk, stream);
 	res = msblk->decompressor->decompress(msblk, decomp_stream->stream,
-		bh, b, offset, length, output);
+		bio, offset, length, output);
 	put_decomp_stream(decomp_stream, stream);
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
diff --git a/fs/squashfs/decompressor_single.c b/fs/squashfs/decompressor_single.c
index a6c75929a00e..43dcfeadc33e 100644
--- a/fs/squashfs/decompressor_single.c
+++ b/fs/squashfs/decompressor_single.c
@@ -9,7 +9,7 @@
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
-#include <linux/buffer_head.h>
+#include <linux/bio.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
@@ -61,14 +61,15 @@ void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 	}
 }
 
-int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
-	int b, int offset, int length, struct squashfs_page_actor *output)
+int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
+			int offset, int length,
+			struct squashfs_page_actor *output)
 {
 	int res;
 	struct squashfs_stream *stream = msblk->stream;
 
 	mutex_lock(&stream->mutex);
-	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
+	res = msblk->decompressor->decompress(msblk, stream->stream, bio,
 		offset, length, output);
 	mutex_unlock(&stream->mutex);
 
diff --git a/fs/squashfs/lz4_wrapper.c b/fs/squashfs/lz4_wrapper.c
index 95da65366548..ae014118cb7a 100644
--- a/fs/squashfs/lz4_wrapper.c
+++ b/fs/squashfs/lz4_wrapper.c
@@ -6,7 +6,7 @@
  * the COPYING file in the top-level directory.
  */
 
-#include <linux/buffer_head.h>
+#include <linux/bio.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -91,20 +91,23 @@ static void lz4_free(void *strm)
 
 
 static int lz4_uncompress(struct squashfs_sb_info *msblk, void *strm,
-	struct buffer_head **bh, int b, int offset, int length,
+	struct bio *bio, int offset, int length,
 	struct squashfs_page_actor *output)
 {
 	struct squashfs_lz4 *stream = strm;
 	void *buff = stream->input, *data;
-	int avail, i, bytes = length, res;
+	int bytes = length, res;
+	int i;
 
-	for (i = 0; i < b; i++) {
-		avail = min(bytes, msblk->devblksize - offset);
-		memcpy(buff, bh[i]->b_data + offset, avail);
+	for (i = 0; i < bio->bi_vcnt; ++i) {
+		struct bio_vec bvec = bio->bi_io_vec[i];
+		int avail = min(bytes, ((int)bvec.bv_len) - offset);
+
+		data = page_address(bvec.bv_page) + bvec.bv_offset;
+		memcpy(buff, data + offset, avail);
 		buff += avail;
 		bytes -= avail;
 		offset = 0;
-		put_bh(bh[i]);
 	}
 
 	res = LZ4_decompress_safe(stream->input, stream->output,
diff --git a/fs/squashfs/lzo_wrapper.c b/fs/squashfs/lzo_wrapper.c
index 934c17e96590..572e0faca290 100644
--- a/fs/squashfs/lzo_wrapper.c
+++ b/fs/squashfs/lzo_wrapper.c
@@ -22,7 +22,7 @@
  */
 
 #include <linux/mutex.h>
-#include <linux/buffer_head.h>
+#include <linux/bio.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/lzo.h>
@@ -76,21 +76,23 @@ static void lzo_free(void *strm)
 
 
 static int lzo_uncompress(struct squashfs_sb_info *msblk, void *strm,
-	struct buffer_head **bh, int b, int offset, int length,
+	struct bio *bio, int offset, int length,
 	struct squashfs_page_actor *output)
 {
 	struct squashfs_lzo *stream = strm;
 	void *buff = stream->input, *data;
-	int avail, i, bytes = length, res;
+	int i, bytes = length, res;
 	size_t out_len = output->length;
 
-	for (i = 0; i < b; i++) {
-		avail = min(bytes, msblk->devblksize - offset);
-		memcpy(buff, bh[i]->b_data + offset, avail);
+	for (i = 0; i < bio->bi_vcnt; ++i) {
+		struct bio_vec bvec = bio->bi_io_vec[i];
+		int avail = min(bytes, ((int)bvec.bv_len) - offset);
+
+		data = page_address(bvec.bv_page) + bvec.bv_offset;
+		memcpy(buff, data + offset, avail);
 		buff += avail;
 		bytes -= avail;
 		offset = 0;
-		put_bh(bh[i]);
 	}
 
 	res = lzo1x_decompress_safe(stream->input, (size_t)length,
diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index f89f8a74c6ce..b2f2c1fa2d17 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -53,8 +53,8 @@ extern void *squashfs_decompressor_setup(struct super_block *, unsigned short);
 /* decompressor_xxx.c */
 extern void *squashfs_decompressor_create(struct squashfs_sb_info *, void *);
 extern void squashfs_decompressor_destroy(struct squashfs_sb_info *);
-extern int squashfs_decompress(struct squashfs_sb_info *, struct buffer_head **,
-	int, int, int, struct squashfs_page_actor *);
+extern int squashfs_decompress(struct squashfs_sb_info *, struct bio *,
+				int, int, struct squashfs_page_actor *);
 extern int squashfs_max_decompressors(void);
 
 /* export.c */
diff --git a/fs/squashfs/xz_wrapper.c b/fs/squashfs/xz_wrapper.c
index 6bfaef73d065..78ccaf9c5459 100644
--- a/fs/squashfs/xz_wrapper.c
+++ b/fs/squashfs/xz_wrapper.c
@@ -23,7 +23,7 @@
 
 
 #include <linux/mutex.h>
-#include <linux/buffer_head.h>
+#include <linux/bio.h>
 #include <linux/slab.h>
 #include <linux/xz.h>
 #include <linux/bitops.h>
@@ -130,11 +130,11 @@ static void squashfs_xz_free(void *strm)
 
 
 static int squashfs_xz_uncompress(struct squashfs_sb_info *msblk, void *strm,
-	struct buffer_head **bh, int b, int offset, int length,
+	struct bio *bio, int offset, int length,
 	struct squashfs_page_actor *output)
 {
 	enum xz_ret xz_err;
-	int avail, total = 0, k = 0;
+	int total = 0, k = 0;
 	struct squashfs_xz *stream = strm;
 
 	xz_dec_reset(stream->state);
@@ -145,10 +145,15 @@ static int squashfs_xz_uncompress(struct squashfs_sb_info *msblk, void *strm,
 	stream->buf.out = squashfs_first_page(output);
 
 	do {
-		if (stream->buf.in_pos == stream->buf.in_size && k < b) {
-			avail = min(length, msblk->devblksize - offset);
+		if (stream->buf.in_pos == stream->buf.in_size &&
+		    k < bio->bi_vcnt) {
+			struct bio_vec bvec = bio->bi_io_vec[k];
+			int avail = min(length, ((int)bvec.bv_len) - offset);
+			const void *data = page_address(bvec.bv_page) +
+				bvec.bv_offset;
+
 			length -= avail;
-			stream->buf.in = bh[k]->b_data + offset;
+			stream->buf.in = data + offset;
 			stream->buf.in_size = avail;
 			stream->buf.in_pos = 0;
 			offset = 0;
@@ -164,22 +169,18 @@ static int squashfs_xz_uncompress(struct squashfs_sb_info *msblk, void *strm,
 
 		xz_err = xz_dec_run(stream->state, &stream->buf);
 
-		if (stream->buf.in_pos == stream->buf.in_size && k < b)
-			put_bh(bh[k++]);
+		if (stream->buf.in_pos == stream->buf.in_size &&
+		    k < bio->bi_vcnt) {
+			k++;
+		}
 	} while (xz_err == XZ_OK);
 
 	squashfs_finish_page(output);
 
-	if (xz_err != XZ_STREAM_END || k < b)
-		goto out;
+	if (xz_err != XZ_STREAM_END || k < bio->bi_vcnt)
+		return -EIO;
 
 	return total + stream->buf.out_pos;
-
-out:
-	for (; k < b; k++)
-		put_bh(bh[k]);
-
-	return -EIO;
 }
 
 const struct squashfs_decompressor squashfs_xz_comp_ops = {
diff --git a/fs/squashfs/zlib_wrapper.c b/fs/squashfs/zlib_wrapper.c
index 2ec24d128bce..c620f342d31e 100644
--- a/fs/squashfs/zlib_wrapper.c
+++ b/fs/squashfs/zlib_wrapper.c
@@ -23,7 +23,7 @@
 
 
 #include <linux/mutex.h>
-#include <linux/buffer_head.h>
+#include <linux/bio.h>
 #include <linux/slab.h>
 #include <linux/zlib.h>
 #include <linux/vmalloc.h>
@@ -63,7 +63,7 @@ static void zlib_free(void *strm)
 
 
 static int zlib_uncompress(struct squashfs_sb_info *msblk, void *strm,
-	struct buffer_head **bh, int b, int offset, int length,
+	struct bio *bio, int offset, int length,
 	struct squashfs_page_actor *output)
 {
 	int zlib_err, zlib_init = 0, k = 0;
@@ -74,10 +74,14 @@ static int zlib_uncompress(struct squashfs_sb_info *msblk, void *strm,
 	stream->avail_in = 0;
 
 	do {
-		if (stream->avail_in == 0 && k < b) {
-			int avail = min(length, msblk->devblksize - offset);
+		if (stream->avail_in == 0 && k < bio->bi_vcnt) {
+			struct bio_vec bvec = bio->bi_io_vec[k];
+			int avail = min(length, ((int)bvec.bv_len) - offset);
+			const void *data = page_address(bvec.bv_page) +
+				bvec.bv_offset;
+
 			length -= avail;
-			stream->next_in = bh[k]->b_data + offset;
+			stream->next_in = data + offset;
 			stream->avail_in = avail;
 			offset = 0;
 		}
@@ -92,36 +96,30 @@ static int zlib_uncompress(struct squashfs_sb_info *msblk, void *strm,
 			zlib_err = zlib_inflateInit(stream);
 			if (zlib_err != Z_OK) {
 				squashfs_finish_page(output);
-				goto out;
+				return -EIO;
 			}
 			zlib_init = 1;
 		}
 
 		zlib_err = zlib_inflate(stream, Z_SYNC_FLUSH);
 
-		if (stream->avail_in == 0 && k < b)
-			put_bh(bh[k++]);
+		if (stream->avail_in == 0 && k < bio->bi_vcnt)
+			k++;
 	} while (zlib_err == Z_OK);
 
 	squashfs_finish_page(output);
 
 	if (zlib_err != Z_STREAM_END)
-		goto out;
+		return -EIO;
 
 	zlib_err = zlib_inflateEnd(stream);
 	if (zlib_err != Z_OK)
-		goto out;
+		return -EIO;
 
-	if (k < b)
-		goto out;
+	if (k < bio->bi_vcnt)
+		return -EIO;
 
 	return stream->total_out;
-
-out:
-	for (; k < b; k++)
-		put_bh(bh[k]);
-
-	return -EIO;
 }
 
 const struct squashfs_decompressor squashfs_zlib_comp_ops = {
diff --git a/fs/squashfs/zstd_wrapper.c b/fs/squashfs/zstd_wrapper.c
index eeaabf881159..0531d8b3a930 100644
--- a/fs/squashfs/zstd_wrapper.c
+++ b/fs/squashfs/zstd_wrapper.c
@@ -18,7 +18,7 @@
  */
 
 #include <linux/mutex.h>
-#include <linux/buffer_head.h>
+#include <linux/bio.h>
 #include <linux/slab.h>
 #include <linux/zstd.h>
 #include <linux/vmalloc.h>
@@ -68,7 +68,7 @@ static void zstd_free(void *strm)
 
 
 static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
-	struct buffer_head **bh, int b, int offset, int length,
+	struct bio *bio, int offset, int length,
 	struct squashfs_page_actor *output)
 {
 	struct workspace *wksp = strm;
@@ -83,18 +83,21 @@ static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
 
 	if (!stream) {
 		ERROR("Failed to initialize zstd decompressor\n");
-		goto out;
+		return -EIO;
 	}
 
 	out_buf.size = PAGE_SIZE;
 	out_buf.dst = squashfs_first_page(output);
 
 	do {
-		if (in_buf.pos == in_buf.size && k < b) {
-			int avail = min(length, msblk->devblksize - offset);
+		if (in_buf.pos == in_buf.size && k < bio->bi_vcnt) {
+			struct bio_vec bvec = bio->bi_io_vec[k];
+			int avail = min(length, ((int)bvec.bv_len) - offset);
+			const void *data = page_address(bvec.bv_page) +
+				bvec.bv_offset;
 
 			length -= avail;
-			in_buf.src = bh[k]->b_data + offset;
+			in_buf.src = data + offset;
 			in_buf.size = avail;
 			in_buf.pos = 0;
 			offset = 0;
@@ -107,7 +110,7 @@ static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
 				 * before stream is done.
 				 */
 				squashfs_finish_page(output);
-				goto out;
+				return -EIO;
 			}
 			out_buf.pos = 0;
 			out_buf.size = PAGE_SIZE;
@@ -117,8 +120,8 @@ static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
 		zstd_err = ZSTD_decompressStream(stream, &out_buf, &in_buf);
 		total_out += out_buf.pos; /* add the additional data produced */
 
-		if (in_buf.pos == in_buf.size && k < b)
-			put_bh(bh[k++]);
+		if (in_buf.pos == in_buf.size && k < bio->bi_vcnt)
+			k++;
 	} while (zstd_err != 0 && !ZSTD_isError(zstd_err));
 
 	squashfs_finish_page(output);
@@ -126,19 +129,13 @@ static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
 	if (ZSTD_isError(zstd_err)) {
 		ERROR("zstd decompression error: %d\n",
 				(int)ZSTD_getErrorCode(zstd_err));
-		goto out;
+		return -EIO;
 	}
 
-	if (k < b)
-		goto out;
+	if (k < bio->bi_vcnt)
+		return -EIO;
 
 	return (int)total_out;
-
-out:
-	for (; k < b; k++)
-		put_bh(bh[k]);
-
-	return -EIO;
 }
 
 const struct squashfs_decompressor squashfs_zstd_comp_ops = {
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

