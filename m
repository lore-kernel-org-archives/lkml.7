Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC707C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECE02073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576027646;
	bh=54LFNXxtwWsZjAmq7U8arZY1G7CFCNkVOiMObH/9ZzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AzSVoBuM4J5umt8SOahvUHuEpr80YdzYVVeLkgvJiJvE9LVnkV8sOlPgGufEDMUnF
	 zBfykW029/40sOujPrdNdJWhqN4hwG52yRkleVw/kFVmdACemK0OkuMKKzbR8e1AVT
	 ppXgzhpNHr1NAp68r7JsVbFEKQa8XiVj7iKAjFCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLKB1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:27:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfLKB1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:27:24 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD2DB206D5;
        Wed, 11 Dec 2019 01:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576027643;
        bh=54LFNXxtwWsZjAmq7U8arZY1G7CFCNkVOiMObH/9ZzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAdAeOsa9Jgtj65HrAGHbqHw4h6KcPZGgrzErpzsRU1E1SqrYPTc56tsB3YCkUIJ/
         P7aYCTPJkHPOh15BCoRpwBdUEfV4MrdQa4s5T/cOifeSPQcgFs291s58QN8SXERDQz
         rH1zOjKzerhKQSbNSyrN53Cppz223Q7zWGeluX7E=
Date:   Tue, 10 Dec 2019 17:27:23 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: support data compression
Message-ID: <20191211012723.GA57416@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191022171602.93637-2-jaegeuk@kernel.org>
 <20191027225006.GA321938@sol.localdomain>
 <da214cdc-0074-b7bf-7761-d4c4ad3d4f6a@huawei.com>
 <20191030025512.GA4791@sol.localdomain>
 <97c33fa1-15af-b319-29a1-22f254a26c0a@huawei.com>
 <20191030170246.GB693@sol.localdomain>
 <899f99e9-fdc7-a84b-14ec-623fa3a5e164@huawei.com>
 <20191118161146.GB41670@jaegeuk-macbookpro.roam.corp.google.com>
 <20191118205822.GA57882@jaegeuk-macbookpro.roam.corp.google.com>
 <20191125174204.GB71634@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125174204.GB71634@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

Let me know, if it's okay to integrate compression patch all together.
I don't have a critical bug to fix w/ them now.

Another fix:
---
 fs/f2fs/compress.c | 101 ++++++++++++++++++++++++++++-----------------
 fs/f2fs/data.c     |  15 ++++---
 fs/f2fs/f2fs.h     |   1 -
 3 files changed, 72 insertions(+), 45 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7ebd2bc018bd..af23ed6deffd 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -73,6 +73,17 @@ static void f2fs_put_compressed_page(struct page *page)
 	put_page(page);
 }
 
+static void f2fs_put_rpages(struct compress_ctx *cc)
+{
+	unsigned int i;
+
+	for (i = 0; i < cc->cluster_size; i++) {
+		if (!cc->rpages[i])
+			continue;
+		put_page(cc->rpages[i]);
+	}
+}
+
 struct page *f2fs_compress_control_page(struct page *page)
 {
 	return ((struct compress_io_ctx *)page_private(page))->rpages[0];
@@ -93,7 +104,10 @@ int f2fs_init_compress_ctx(struct compress_ctx *cc)
 void f2fs_destroy_compress_ctx(struct compress_ctx *cc)
 {
 	kfree(cc->rpages);
-	f2fs_reset_compress_ctx(cc);
+	cc->rpages = NULL;
+	cc->nr_rpages = 0;
+	cc->nr_cpages = 0;
+	cc->cluster_idx = NULL_CLUSTER;
 }
 
 void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page)
@@ -536,14 +550,6 @@ static bool cluster_may_compress(struct compress_ctx *cc)
 	return __cluster_may_compress(cc);
 }
 
-void f2fs_reset_compress_ctx(struct compress_ctx *cc)
-{
-	cc->rpages = NULL;
-	cc->nr_rpages = 0;
-	cc->nr_cpages = 0;
-	cc->cluster_idx = NULL_CLUSTER;
-}
-
 static void set_cluster_writeback(struct compress_ctx *cc)
 {
 	int i;
@@ -602,13 +608,13 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
 						&last_block_in_bio, false);
 		if (ret)
-			return ret;
+			goto release_pages;
 		if (bio)
 			f2fs_submit_bio(sbi, bio, DATA);
 
 		ret = f2fs_init_compress_ctx(cc);
 		if (ret)
-			return ret;
+			goto release_pages;
 	}
 
 	for (i = 0; i < cc->cluster_size; i++) {
@@ -638,9 +644,11 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 
 		for (i = cc->cluster_size - 1; i > 0; i--) {
 			ret = f2fs_get_block(&dn, start_idx + i);
-			if (ret)
+			if (ret) {
 				/* TODO: release preallocate blocks */
-				goto release_pages;
+				i = cc->cluster_size;
+				goto unlock_pages;
+			}
 
 			if (dn.data_blkaddr != NEW_ADDR)
 				break;
@@ -769,7 +777,11 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	cic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
 	cic->inode = inode;
 	refcount_set(&cic->ref, 1);
-	cic->rpages = cc->rpages;
+	cic->rpages = f2fs_kzalloc(sbi, sizeof(struct page *) <<
+			cc->log_cluster_size, GFP_NOFS);
+	if (!cic->rpages)
+		goto out_put_cic;
+
 	cic->nr_rpages = cc->cluster_size;
 
 	for (i = 0; i < cc->nr_cpages; i++) {
@@ -793,7 +805,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 		blkaddr = datablock_addr(dn.inode, dn.node_page,
 							dn.ofs_in_node);
-		fio.page = cc->rpages[i];
+		fio.page = cic->rpages[i] = cc->rpages[i];
 		fio.old_blkaddr = blkaddr;
 
 		/* cluster header */
@@ -819,7 +831,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 		f2fs_bug_on(fio.sbi, blkaddr == NULL_ADDR);
 
-
 		if (fio.encrypted)
 			fio.encrypted_page = cc->cpages[i - 1];
 		else if (fio.compressed)
@@ -859,17 +870,22 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 			fi->last_disk_size = psize;
 		up_write(&fi->i_sem);
 	}
-	f2fs_reset_compress_ctx(cc);
+	f2fs_put_rpages(cc);
+	f2fs_destroy_compress_ctx(cc);
 	return 0;
 
 out_destroy_crypt:
-	for (i -= 1; i >= 0; i--)
+	kfree(cic->rpages);
+
+	for (--i; i >= 0; i--)
 		fscrypt_finalize_bounce_page(&cc->cpages[i]);
 	for (i = 0; i < cc->nr_cpages; i++) {
 		if (!cc->cpages[i])
 			continue;
 		f2fs_put_page(cc->cpages[i], 1);
 	}
+out_put_cic:
+	kfree(cic);
 out_put_dnode:
 	f2fs_put_dnode(&dn);
 out_unlock_op:
@@ -963,37 +979,39 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 	struct f2fs_inode_info *fi = F2FS_I(cc->inode);
 	const struct f2fs_compress_ops *cops =
 			f2fs_cops[fi->i_compress_algorithm];
-	int err = -EAGAIN;
+	bool compressed = false;
+	int err;
 
 	*submitted = 0;
 	if (cluster_may_compress(cc)) {
 		err = f2fs_compress_pages(cc);
-		if (err) {
-			err = -EAGAIN;
+		if (err == -EAGAIN)
 			goto write;
-		}
+		else if (err)
+			goto put_out;
+
 		err = f2fs_write_compressed_pages(cc, submitted,
 							wbc, io_type);
 		cops->destroy_compress_ctx(cc);
+		if (!err)
+			return 0;
+		f2fs_bug_on(F2FS_I_SB(cc->inode), err != -EAGAIN);
 	}
 write:
-	if (err == -EAGAIN) {
-		bool compressed = false;
-
-		f2fs_bug_on(F2FS_I_SB(cc->inode), *submitted);
+	f2fs_bug_on(F2FS_I_SB(cc->inode), *submitted);
 
-		if (is_compressed_cluster(cc))
-			compressed = true;
+	if (is_compressed_cluster(cc))
+		compressed = true;
 
-		err = f2fs_write_raw_pages(cc, submitted, wbc,
-						io_type, compressed);
-		if (compressed) {
-			stat_sub_compr_blocks(cc->inode, *submitted);
-			F2FS_I(cc->inode)->i_compressed_blocks -= *submitted;
-			f2fs_mark_inode_dirty_sync(cc->inode, true);
-		}
-		f2fs_destroy_compress_ctx(cc);
+	err = f2fs_write_raw_pages(cc, submitted, wbc, io_type, compressed);
+	if (compressed) {
+		stat_sub_compr_blocks(cc->inode, *submitted);
+		F2FS_I(cc->inode)->i_compressed_blocks -= *submitted;
+		f2fs_mark_inode_dirty_sync(cc->inode, true);
 	}
+put_out:
+	f2fs_put_rpages(cc);
+	f2fs_destroy_compress_ctx(cc);
 	return err;
 }
 
@@ -1055,7 +1073,13 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 		dic->tpages[i] = cc->rpages[i];
 	}
 
-	dic->rpages = cc->rpages;
+	dic->rpages = f2fs_kzalloc(sbi, sizeof(struct page *) <<
+			cc->log_cluster_size, GFP_NOFS);
+	if (!dic->rpages)
+		goto out_free;
+
+	for (i = 0; i < dic->cluster_size; i++)
+		dic->rpages[i] = cc->rpages[i];
 	dic->nr_rpages = cc->cluster_size;
 	return dic;
 
@@ -1072,8 +1096,7 @@ void f2fs_free_dic(struct decompress_io_ctx *dic)
 		for (i = 0; i < dic->cluster_size; i++) {
 			if (dic->rpages[i])
 				continue;
-			unlock_page(dic->tpages[i]);
-			put_page(dic->tpages[i]);
+			f2fs_put_page(dic->tpages[i], 1);
 		}
 		kfree(dic->tpages);
 	}
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7046b222e8de..19cd03450066 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2099,7 +2099,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 							false);
 				f2fs_free_dic(dic);
 				f2fs_put_dnode(&dn);
-				f2fs_reset_compress_ctx(cc);
+				f2fs_destroy_compress_ctx(cc);
 				*bio_ret = bio;
 				return ret;
 			}
@@ -2117,7 +2117,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 	f2fs_put_dnode(&dn);
 
-	f2fs_reset_compress_ctx(cc);
+	f2fs_destroy_compress_ctx(cc);
 	*bio_ret = bio;
 	return 0;
 
@@ -2125,7 +2125,6 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	f2fs_put_dnode(&dn);
 out:
 	f2fs_decompress_end_io(cc->rpages, cc->cluster_size, true, false);
-	f2fs_destroy_compress_ctx(cc);
 	*bio_ret = bio;
 	return ret;
 }
@@ -2192,8 +2191,10 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 							max_nr_pages,
 							&last_block_in_bio,
 							is_readahead);
-				if (ret)
+				if (ret) {
+					f2fs_destroy_compress_ctx(&cc);
 					goto set_error_page;
+				}
 			}
 			ret = f2fs_is_compressed_cluster(inode, page->index);
 			if (ret < 0)
@@ -2229,11 +2230,14 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (f2fs_compressed_file(inode)) {
 			/* last page */
-			if (nr_pages == 1 && !f2fs_cluster_is_empty(&cc))
+			if (nr_pages == 1 && !f2fs_cluster_is_empty(&cc)) {
 				ret = f2fs_read_multi_pages(&cc, &bio,
 							max_nr_pages,
 							&last_block_in_bio,
 							is_readahead);
+				if (ret)
+					f2fs_destroy_compress_ctx(&cc);
+			}
 		}
 #endif
 	}
@@ -2856,6 +2860,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 			if (f2fs_compressed_file(inode)) {
+				get_page(page);
 				f2fs_compress_ctx_add_page(&cc, page);
 				continue;
 			}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 26a4cc1fd686..5d55cef66410 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3765,7 +3765,6 @@ static inline bool f2fs_post_read_required(struct inode *inode)
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 bool f2fs_is_compressed_page(struct page *page);
 struct page *f2fs_compress_control_page(struct page *page);
-void f2fs_reset_compress_ctx(struct compress_ctx *cc);
 int f2fs_prepare_compress_overwrite(struct inode *inode,
 			struct page **pagep, pgoff_t index, void **fsdata);
 bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
-- 
2.24.0.525.g8f36a354ae-goog

