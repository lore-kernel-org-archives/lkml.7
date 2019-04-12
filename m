Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C5DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC8221872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfDLLxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:53:52 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:48490 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726827AbfDLLxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:53:50 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id AD708BF7ACB4AB814E70;
        Fri, 12 Apr 2019 19:53:45 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 12 Apr 2019 19:53:45 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 12 Apr 2019 19:53:44 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: introduce DATA_GENERIC_ENHANCE
Date:   Fri, 12 Apr 2019 19:53:39 +0800
Message-ID: <20190412115339.16936-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190412115339.16936-1-yuchao0@huawei.com>
References: <20190412115339.16936-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
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

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 33 ++++++++++++++++++++++++++++++++-
 fs/f2fs/data.c       | 36 ++++++++++++++++++++----------------
 fs/f2fs/f2fs.h       | 12 ++----------
 fs/f2fs/file.c       | 13 ++++++++++---
 fs/f2fs/gc.c         |  7 ++++++-
 fs/f2fs/inode.c      |  7 ++++---
 fs/f2fs/node.c       | 14 +++++++++++---
 fs/f2fs/segment.c    |  4 ++--
 fs/f2fs/segment.h    | 13 +++++++------
 9 files changed, 94 insertions(+), 45 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 58eb2b66600b..accc7892bd97 100644
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
@@ -152,14 +174,23 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
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
+
 		}
 		break;
 	case META_GENERIC:
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9000134792f..7440f9364895 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -403,8 +403,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 			fio->encrypted_page : fio->page;
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
-			fio->is_por ? META_POR :
-			(__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC)))
+			fio->is_por ? META_POR : (__is_meta_io(fio) ?
+			META_GENERIC : DATA_GENERIC_ENHANCE)))
 		return -EFAULT;
 
 	trace_f2fs_submit_page_bio(page, fio);
@@ -454,9 +454,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		spin_unlock(&io->io_lock);
 	}
 
-	if (__is_valid_data_blkaddr(fio->old_blkaddr))
-		verify_block_addr(fio, fio->old_blkaddr);
-	verify_block_addr(fio, fio->new_blkaddr);
+	verify_fio_blkaddr(fio);
 
 	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
 
@@ -518,7 +516,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 			return ERR_CAST(ctx);
 	}
 
-	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC))
+	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
 		return ERR_PTR(-EFAULT);
 
 	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES), false);
@@ -539,8 +537,13 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
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
 
@@ -552,8 +555,8 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 		return -EFAULT;
 	}
 	ClearPageError(page);
-	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
-	__submit_bio(F2FS_I_SB(inode), bio, DATA);
+	inc_page_count(sbi, F2FS_RD_DATA);
+	__submit_bio(sbi, bio, DATA);
 	return 0;
 }
 
@@ -1043,12 +1046,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
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
@@ -1515,7 +1518,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			}
 
 			if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
-								DATA_GENERIC))
+							DATA_GENERIC_ENHANCE))
 				goto set_error_page;
 		} else {
 zero_out:
@@ -1746,7 +1749,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		fio->old_blkaddr = ei.blk + page->index - ei.fofs;
 
 		if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
-							DATA_GENERIC))
+							DATA_GENERIC_ENHANCE))
 			return -EFAULT;
 
 		ipu_force = true;
@@ -1773,7 +1776,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 got_it:
 	if (__is_valid_data_blkaddr(fio->old_blkaddr) &&
 		!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
-							DATA_GENERIC)) {
+							DATA_GENERIC_ENHANCE)) {
 		err = -EFAULT;
 		goto out_writepage;
 	}
@@ -1781,8 +1784,9 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.
 	 */
-	if (ipu_force || (is_valid_data_blkaddr(fio->sbi, fio->old_blkaddr) &&
-					need_inplace_update(fio))) {
+	if (ipu_force ||
+		(__is_valid_data_blkaddr(fio->old_blkaddr) &&
+			need_inplace_update(fio))) {
 		err = encrypt_one_page(fio);
 		if (err)
 			goto out_writepage;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 80e17eab4fa7..3646bd79bc8f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -213,7 +213,8 @@ enum {
 	META_SSA,
 	META_MAX,
 	META_POR,
-	DATA_GENERIC,
+	DATA_GENERIC,		/* check range only */
+	DATA_GENERIC_ENHANCE,	/* strong check on range and segment bitmap */
 	META_GENERIC,
 };
 
@@ -2852,15 +2853,6 @@ static inline bool __is_valid_data_blkaddr(block_t blkaddr)
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
index c507b7299372..31802a304f6d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -357,7 +357,7 @@ static bool __found_offset(struct f2fs_sb_info *sbi, block_t blkaddr,
 	switch (whence) {
 	case SEEK_DATA:
 		if ((blkaddr == NEW_ADDR && dirty == pgofs) ||
-			is_valid_data_blkaddr(sbi, blkaddr))
+			__is_valid_data_blkaddr(blkaddr))
 			return true;
 		break;
 	case SEEK_HOLE:
@@ -423,7 +423,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 
 			if (__is_valid_data_blkaddr(blkaddr) &&
 				!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
-						blkaddr, DATA_GENERIC)) {
+					blkaddr, DATA_GENERIC_ENHANCE)) {
 				f2fs_put_dnode(&dn);
 				goto fail;
 			}
@@ -534,7 +534,8 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		f2fs_set_data_blkaddr(dn);
 
 		if (__is_valid_data_blkaddr(blkaddr) &&
-			!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC))
+			!f2fs_is_valid_blkaddr(sbi, blkaddr,
+					DATA_GENERIC_ENHANCE))
 			continue;
 
 		f2fs_invalidate_blocks(sbi, blkaddr);
@@ -1024,6 +1025,12 @@ static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
 	for (i = 0; i < done; i++, blkaddr++, do_replace++, dn.ofs_in_node++) {
 		*blkaddr = datablock_addr(dn.inode,
 					dn.node_page, dn.ofs_in_node);
+		if (__is_valid_data_blkaddr(*blkaddr) &&
+			!f2fs_is_valid_blkaddr(sbi, *blkaddr,
+					DATA_GENERIC_ENHANCE)) {
+			f2fs_put_dnode(&dn);
+			return -EFAULT;
+		}
 		if (!f2fs_is_checkpointed_data(sbi, *blkaddr)) {
 
 			if (test_opt(sbi, LFS)) {
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ba4caf54e136..3c8c334e662e 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -665,8 +665,13 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 		goto put_page;
 	f2fs_put_dnode(&dn);
 
+	if (!__is_valid_data_blkaddr(dn.data_blkaddr)) {
+		err = -ENOENT;
+		goto put_page;
+	}
+
 	if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
-						DATA_GENERIC))) {
+						DATA_GENERIC_ENHANCE))) {
 		err = -EFAULT;
 		goto put_page;
 	}
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index dbb77c1286c1..89cbd0ddbf89 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -70,7 +70,7 @@ static int __written_first_block(struct f2fs_sb_info *sbi,
 
 	if (!__is_valid_data_blkaddr(addr))
 		return 1;
-	if (!f2fs_is_valid_blkaddr(sbi, addr, DATA_GENERIC))
+	if (!f2fs_is_valid_blkaddr(sbi, addr, DATA_GENERIC_ENHANCE))
 		return -EFAULT;
 	return 0;
 }
@@ -264,9 +264,10 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
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
index c1444b55d284..072da49be5b5 100644
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
@@ -568,7 +569,13 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	ne = nat_blk->entries[nid - start_nid];
 	node_info_from_raw_nat(ni, &ne);
 	f2fs_put_page(page, 1);
+
 cache:
+	blkaddr = le32_to_cpu(ne.block_addr);
+	if (__is_valid_data_blkaddr(blkaddr) &&
+		!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
+		return -EFAULT;
+
 	/* cache nat entry */
 	cache_nat_entry(sbi, nid, &ne);
 	return 0;
@@ -1547,7 +1554,8 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	}
 
 	if (__is_valid_data_blkaddr(ni.blk_addr) &&
-		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC)) {
+		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr,
+					DATA_GENERIC_ENHANCE)) {
 		up_read(&sbi->node_write);
 		goto redirty_out;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index faf975ad7b02..8e214cc25afa 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2254,7 +2254,7 @@ bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
 	struct seg_entry *se;
 	bool is_cp = false;
 
-	if (!is_valid_data_blkaddr(sbi, blkaddr))
+	if (!__is_valid_data_blkaddr(blkaddr))
 		return true;
 
 	down_read(&sit_i->sentry_lock);
@@ -3380,7 +3380,7 @@ void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
 	if (!f2fs_encrypted_file(inode))
 		return;
 
-	if (!is_valid_data_blkaddr(sbi, blkaddr))
+	if (!__is_valid_data_blkaddr(blkaddr))
 		return;
 
 	cpage = find_lock_page(META_MAPPING(sbi), blkaddr);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5ce3c90a0fbb..7b59b346aa93 100644
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
@@ -666,14 +666,15 @@ static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
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

