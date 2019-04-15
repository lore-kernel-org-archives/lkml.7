Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCC8C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F0920825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDOH0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:26:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2532 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726095AbfDOH0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:26:40 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 9A8DA5755AC696AE0BA9;
        Mon, 15 Apr 2019 15:26:38 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 15 Apr 2019 15:26:38 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 15 Apr 2019 15:26:37 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 2/2] f2fs: introduce DATA_GENERIC_ENHANCE
Date:   Mon, 15 Apr 2019 15:26:32 +0800
Message-ID: <20190415072632.2158-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190415072632.2158-1-yuchao0@huawei.com>
References: <20190415072632.2158-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, f2fs_is_valid_blkaddr(, blkaddr, DATA_GENERIC) will check
whether @blkaddr locates in main area or not.

That check is weak, since the block address in range of main area can
point to the address which is not valid in segment info table, and we
can not detect such condition, we may suffer worse corruption as system
continues running.

So this patch introduce DATA_GENERIC_ENHANCE to enhance the sanity check
which trigger SIT bitmap check rather than only range check.

This patch did below changes as wel:
- set SBI_NEED_FSCK in f2fs_is_valid_blkaddr().
- get rid of is_valid_data_blkaddr() to avoid panic if blkaddr is invalid.
- introduce verify_fio_blkaddr() to wrap fio {new,old}_blkaddr validation check.
- spread blkaddr check in:
 * f2fs_get_node_info()
 * __read_out_blkaddrs()
 * f2fs_submit_page_read()
 * ra_data_block()
 * do_recover_data()

This patch can fix bug reported from bugzilla below:

https://bugzilla.kernel.org/show_bug.cgi?id=203215
https://bugzilla.kernel.org/show_bug.cgi?id=203223
https://bugzilla.kernel.org/show_bug.cgi?id=203231
https://bugzilla.kernel.org/show_bug.cgi?id=203235
https://bugzilla.kernel.org/show_bug.cgi?id=203241

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- update issue list this patch can fix.
- check blkaddr in do_recover_data().
- rebase code to last dev branch.
 fs/f2fs/checkpoint.c | 32 +++++++++++++++++++++++++++++++-
 fs/f2fs/data.c       | 34 +++++++++++++++++++---------------
 fs/f2fs/f2fs.h       | 12 ++----------
 fs/f2fs/file.c       | 15 ++++++++++++---
 fs/f2fs/gc.c         | 10 ++++++++--
 fs/f2fs/inode.c      |  7 ++++---
 fs/f2fs/node.c       | 13 ++++++++++---
 fs/f2fs/recovery.c   | 12 ++++++++++++
 fs/f2fs/segment.c    |  4 ++--
 fs/f2fs/segment.h    | 13 +++++++------
 10 files changed, 107 insertions(+), 45 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f42b0015724b..a7ad1b1e5750 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -130,6 +130,28 @@ struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
 	return __get_meta_page(sbi, index, false);
 }
 
+static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr)
+{
+	struct seg_entry *se;
+	unsigned int segno, offset;
+	bool exist;
+
+	segno = GET_SEGNO(sbi, blkaddr);
+	offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
+	se = get_seg_entry(sbi, segno);
+
+	exist = f2fs_test_bit(offset, se->cur_valid_map);
+
+	if (!exist) {
+		f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent error "
+			"blkaddr:%u, sit bitmap:%d", blkaddr, exist);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		WARN_ON(1);
+		return false;
+	}
+	return true;
+}
+
 bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type)
 {
@@ -152,14 +174,22 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 		break;
 	case META_POR:
 	case DATA_GENERIC:
+	case DATA_GENERIC_ENHANCE:
 		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
 			blkaddr < MAIN_BLKADDR(sbi))) {
-			if (type == DATA_GENERIC) {
+			if (type == DATA_GENERIC ||
+				type == DATA_GENERIC_ENHANCE) {
 				f2fs_msg(sbi->sb, KERN_WARNING,
 					"access invalid blkaddr:%u", blkaddr);
+				set_sbi_flag(sbi, SBI_NEED_FSCK);
 				WARN_ON(1);
 			}
 			return false;
+		} else {
+			if (type == DATA_GENERIC_ENHANCE) {
+				if (!__is_bitmap_valid(sbi, blkaddr))
+					return false;
+			}
 		}
 		break;
 	case META_GENERIC:
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index eabd34a79451..ee5c7962b0f3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -456,8 +456,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 			fio->encrypted_page : fio->page;
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
-			fio->is_por ? META_POR :
-			(__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC)))
+			fio->is_por ? META_POR : (__is_meta_io(fio) ?
+			META_GENERIC : DATA_GENERIC_ENHANCE)))
 		return -EFAULT;
 
 	trace_f2fs_submit_page_bio(page, fio);
@@ -507,9 +507,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		spin_unlock(&io->io_lock);
 	}
 
-	if (__is_valid_data_blkaddr(fio->old_blkaddr))
-		verify_block_addr(fio, fio->old_blkaddr);
-	verify_block_addr(fio, fio->new_blkaddr);
+	verify_fio_blkaddr(fio);
 
 	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
 
@@ -566,7 +564,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	struct bio_post_read_ctx *ctx;
 	unsigned int post_read_steps = 0;
 
-	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC))
+	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
 		return ERR_PTR(-EFAULT);
 
 	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES), false);
@@ -596,8 +594,13 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 							block_t blkaddr)
 {
-	struct bio *bio = f2fs_grab_read_bio(inode, blkaddr, 1, 0);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct bio *bio;
+
+	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
+		return -EFAULT;
 
+	bio = f2fs_grab_read_bio(inode, blkaddr, 1, 0);
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
@@ -609,8 +612,8 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 		return -EFAULT;
 	}
 	ClearPageError(page);
-	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
-	__submit_bio(F2FS_I_SB(inode), bio, DATA);
+	inc_page_count(sbi, F2FS_RD_DATA);
+	__submit_bio(sbi, bio, DATA);
 	return 0;
 }
 
@@ -1093,12 +1096,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	blkaddr = datablock_addr(dn.inode, dn.node_page, dn.ofs_in_node);
 
 	if (__is_valid_data_blkaddr(blkaddr) &&
-		!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC)) {
+		!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
 		err = -EFAULT;
 		goto sync_out;
 	}
 
-	if (is_valid_data_blkaddr(sbi, blkaddr)) {
+	if (__is_valid_data_blkaddr(blkaddr)) {
 		/* use out-place-update for driect IO under LFS mode */
 		if (test_opt(sbi, LFS) && flag == F2FS_GET_BLOCK_DIO &&
 							map->m_may_create) {
@@ -1591,7 +1594,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			}
 
 			if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
-								DATA_GENERIC))
+							DATA_GENERIC_ENHANCE))
 				goto set_error_page;
 		} else {
 zero_out:
@@ -1822,7 +1825,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		fio->old_blkaddr = ei.blk + page->index - ei.fofs;
 
 		if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
-							DATA_GENERIC))
+						DATA_GENERIC_ENHANCE))
 			return -EFAULT;
 
 		ipu_force = true;
@@ -1849,7 +1852,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 got_it:
 	if (__is_valid_data_blkaddr(fio->old_blkaddr) &&
 		!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
-							DATA_GENERIC)) {
+						DATA_GENERIC_ENHANCE)) {
 		err = -EFAULT;
 		goto out_writepage;
 	}
@@ -1857,7 +1860,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.
 	 */
-	if (ipu_force || (is_valid_data_blkaddr(fio->sbi, fio->old_blkaddr) &&
+	if (ipu_force ||
+		(__is_valid_data_blkaddr(fio->old_blkaddr) &&
 					need_inplace_update(fio))) {
 		err = encrypt_one_page(fio);
 		if (err)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 003a07bd56e3..691452448196 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -210,7 +210,8 @@ enum {
 	META_SSA,
 	META_MAX,
 	META_POR,
-	DATA_GENERIC,
+	DATA_GENERIC,		/* check range only */
+	DATA_GENERIC_ENHANCE,	/* strong check on range and segment bitmap */
 	META_GENERIC,
 };
 
@@ -2837,15 +2838,6 @@ static inline bool __is_valid_data_blkaddr(block_t blkaddr)
 	return true;
 }
 
-static inline bool is_valid_data_blkaddr(struct f2fs_sb_info *sbi,
-						block_t blkaddr)
-{
-	if (!__is_valid_data_blkaddr(blkaddr))
-		return false;
-	verify_blkaddr(sbi, blkaddr, DATA_GENERIC);
-	return true;
-}
-
 static inline void f2fs_set_page_private(struct page *page,
 						unsigned long data)
 {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 65e14ec7366f..f19a2ec9f0ef 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -358,7 +358,7 @@ static bool __found_offset(struct f2fs_sb_info *sbi, block_t blkaddr,
 	switch (whence) {
 	case SEEK_DATA:
 		if ((blkaddr == NEW_ADDR && dirty == pgofs) ||
-			is_valid_data_blkaddr(sbi, blkaddr))
+			__is_valid_data_blkaddr(blkaddr))
 			return true;
 		break;
 	case SEEK_HOLE:
@@ -424,7 +424,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 
 			if (__is_valid_data_blkaddr(blkaddr) &&
 				!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
-						blkaddr, DATA_GENERIC)) {
+					blkaddr, DATA_GENERIC_ENHANCE)) {
 				f2fs_put_dnode(&dn);
 				goto fail;
 			}
@@ -525,7 +525,8 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		f2fs_set_data_blkaddr(dn);
 
 		if (__is_valid_data_blkaddr(blkaddr) &&
-			!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC))
+			!f2fs_is_valid_blkaddr(sbi, blkaddr,
+					DATA_GENERIC_ENHANCE))
 			continue;
 
 		f2fs_invalidate_blocks(sbi, blkaddr);
@@ -1019,6 +1020,14 @@ static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
 	for (i = 0; i < done; i++, blkaddr++, do_replace++, dn.ofs_in_node++) {
 		*blkaddr = datablock_addr(dn.inode,
 					dn.node_page, dn.ofs_in_node);
+
+		if (__is_valid_data_blkaddr(*blkaddr) &&
+			!f2fs_is_valid_blkaddr(sbi, *blkaddr,
+					DATA_GENERIC_ENHANCE)) {
+			f2fs_put_dnode(&dn);
+			return -EFAULT;
+		}
+
 		if (!f2fs_is_checkpointed_data(sbi, *blkaddr)) {
 
 			if (test_opt(sbi, LFS)) {
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a66a8752e5f6..45781a1fc680 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -665,12 +665,18 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 		goto put_page;
 	f2fs_put_dnode(&dn);
 
+	if (!__is_valid_data_blkaddr(dn.data_blkaddr)) {
+		err = -ENOENT;
+		goto put_page;
+	}
+
+got_it:
 	if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
-						DATA_GENERIC))) {
+						DATA_GENERIC_ENHANCE))) {
 		err = -EFAULT;
 		goto put_page;
 	}
-got_it:
+
 	/* read page */
 	fio.page = page;
 	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index e7f2e8759315..06233375c129 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -73,7 +73,7 @@ static int __written_first_block(struct f2fs_sb_info *sbi,
 
 	if (!__is_valid_data_blkaddr(addr))
 		return 1;
-	if (!f2fs_is_valid_blkaddr(sbi, addr, DATA_GENERIC))
+	if (!f2fs_is_valid_blkaddr(sbi, addr, DATA_GENERIC_ENHANCE))
 		return -EFAULT;
 	return 0;
 }
@@ -267,9 +267,10 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		struct extent_info *ei = &F2FS_I(inode)->extent_tree->largest;
 
 		if (ei->len &&
-			(!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC) ||
+			(!f2fs_is_valid_blkaddr(sbi, ei->blk,
+						DATA_GENERIC_ENHANCE) ||
 			!f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
-							DATA_GENERIC))) {
+						DATA_GENERIC_ENHANCE))) {
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_msg(sbi->sb, KERN_WARNING,
 				"%s: inode (ino=%lx) extent info [%u, %u, %u] "
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3f99ab288695..b2c496c62921 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -454,7 +454,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 			new_blkaddr == NULL_ADDR);
 	f2fs_bug_on(sbi, nat_get_blkaddr(e) == NEW_ADDR &&
 			new_blkaddr == NEW_ADDR);
-	f2fs_bug_on(sbi, is_valid_data_blkaddr(sbi, nat_get_blkaddr(e)) &&
+	f2fs_bug_on(sbi, __is_valid_data_blkaddr(nat_get_blkaddr(e)) &&
 			new_blkaddr == NEW_ADDR);
 
 	/* increment version no as node is removed */
@@ -465,7 +465,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 
 	/* change address */
 	nat_set_blkaddr(e, new_blkaddr);
-	if (!is_valid_data_blkaddr(sbi, new_blkaddr))
+	if (!__is_valid_data_blkaddr(new_blkaddr))
 		set_nat_flag(e, IS_CHECKPOINTED, false);
 	__set_nat_cache_dirty(nm_i, e);
 
@@ -526,6 +526,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	struct f2fs_nat_entry ne;
 	struct nat_entry *e;
 	pgoff_t index;
+	block_t blkaddr;
 	int i;
 
 	ni->nid = nid;
@@ -569,6 +570,11 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	node_info_from_raw_nat(ni, &ne);
 	f2fs_put_page(page, 1);
 cache:
+	blkaddr = le32_to_cpu(ne.block_addr);
+	if (__is_valid_data_blkaddr(blkaddr) &&
+		!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
+		return -EFAULT;
+
 	/* cache nat entry */
 	cache_nat_entry(sbi, nid, &ne);
 	return 0;
@@ -1541,7 +1547,8 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	}
 
 	if (__is_valid_data_blkaddr(ni.blk_addr) &&
-		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC)) {
+		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr,
+					DATA_GENERIC_ENHANCE)) {
 		up_read(&sbi->node_write);
 		goto redirty_out;
 	}
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index d4f9d5408103..79f5812c5e1f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -559,6 +559,18 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		src = datablock_addr(dn.inode, dn.node_page, dn.ofs_in_node);
 		dest = datablock_addr(dn.inode, page, dn.ofs_in_node);
 
+		if (__is_valid_data_blkaddr(src) &&
+			!f2fs_is_valid_blkaddr(sbi, src, META_POR)) {
+			err = -EFAULT;
+			goto err;
+		}
+
+		if (__is_valid_data_blkaddr(dest) &&
+			!f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
+			err = -EFAULT;
+			goto err;
+		}
+
 		/* skip recovering if dest is the same as src */
 		if (src == dest)
 			continue;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a3380d1de600..b59d1c85863b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2217,7 +2217,7 @@ bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
 	struct seg_entry *se;
 	bool is_cp = false;
 
-	if (!is_valid_data_blkaddr(sbi, blkaddr))
+	if (!__is_valid_data_blkaddr(blkaddr))
 		return true;
 
 	down_read(&sit_i->sentry_lock);
@@ -3333,7 +3333,7 @@ void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
 	if (!f2fs_post_read_required(inode))
 		return;
 
-	if (!is_valid_data_blkaddr(sbi, blkaddr))
+	if (!__is_valid_data_blkaddr(blkaddr))
 		return;
 
 	cpage = find_lock_page(META_MAPPING(sbi), blkaddr);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5c7ed0442d6e..b333ecca6ed6 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -82,7 +82,7 @@
 	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & ((sbi)->blocks_per_seg - 1))
 
 #define GET_SEGNO(sbi, blk_addr)					\
-	((!is_valid_data_blkaddr(sbi, blk_addr)) ?			\
+	((!__is_valid_data_blkaddr(blk_addr)) ?			\
 	NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi),			\
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
 #define BLKS_PER_SEC(sbi)					\
@@ -656,14 +656,15 @@ static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
 	f2fs_bug_on(sbi, segno > TOTAL_SEGS(sbi) - 1);
 }
 
-static inline void verify_block_addr(struct f2fs_io_info *fio, block_t blk_addr)
+static inline void verify_fio_blkaddr(struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
 
-	if (__is_meta_io(fio))
-		verify_blkaddr(sbi, blk_addr, META_GENERIC);
-	else
-		verify_blkaddr(sbi, blk_addr, DATA_GENERIC);
+	if (__is_valid_data_blkaddr(fio->old_blkaddr))
+		verify_blkaddr(sbi, fio->old_blkaddr, __is_meta_io(fio) ?
+					META_GENERIC : DATA_GENERIC);
+	verify_blkaddr(sbi, fio->new_blkaddr, __is_meta_io(fio) ?
+					META_GENERIC : DATA_GENERIC_ENHANCE);
 }
 
 /*
-- 
2.18.0.rc1

