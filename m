Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF23C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE14C206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfDVJfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:35:11 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2986 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726172AbfDVJfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:35:11 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 629F1E17E0A1EE3B3412;
        Mon, 22 Apr 2019 17:35:00 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 22 Apr 2019 17:34:59 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 22 Apr 2019 17:34:59 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <linux-f2fs-devel@lists.sourceforge.net>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs-tools: relocate chksum_offset for large_nat_bitmap feature
Date:   Mon, 22 Apr 2019 17:34:52 +0800
Message-ID: <20190422093452.61134-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190422093452.61134-1-yuchao0@huawei.com>
References: <20190422093452.61134-1-yuchao0@huawei.com>
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

For large_nat_bitmap feature, there is a design flaw:

Previous:

struct f2fs_checkpoint layout:
+--------------------------+  0x0000
| checkpoint_ver           |
| ......                   |
| checksum_offset          |------+
| ......                   |      |
| sit_nat_version_bitmap[] |<-----|-------+
| ......                   |      |       |
| checksum_value           |<-----+       |
+--------------------------+  0x1000      |
|                          |      nat_bitmap + sit_bitmap
| payload blocks           |              |
|                          |              |
+--------------------------|<-------------+

Obviously, if nat_bitmap size + sit_bitmap size is larger than
MAX_BITMAP_SIZE_IN_CKPT, nat_bitmap or sit_bitmap may overlap
checkpoint checksum's position, once checkpoint() is triggered
from kernel, nat or sit bitmap will be damaged by checksum field.

In order to fix this, let's relocate checksum_value's position
to the head of sit_nat_version_bitmap as below, then nat/sit
bitmap and chksum value update will become safe.

After:

struct f2fs_checkpoint layout:
+--------------------------+  0x0000
| checkpoint_ver           |
| ......                   |
| checksum_offset          |------+
| ......                   |      |
| sit_nat_version_bitmap[] |<-----+
| ......                   |<-------------+
|                          |              |
+--------------------------+  0x1000      |
|                          |      nat_bitmap + sit_bitmap
| payload blocks           |              |
|                          |              |
+--------------------------|<-------------+

Related report and discussion:

https://sourceforge.net/p/linux-f2fs/mailman/message/36642346/

In addition, during writing checkpoint, if large_nat_bitmap feature is
enabled, we need to set CP_LARGE_NAT_BITMAP_FLAG flag in checkpoint.

Reported-by: Park Ju Hyung <qkrwngud825@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/f2fs.h        |  6 +++++-
 fsck/fsck.c        | 16 ++++++++++++++++
 fsck/fsck.h        |  1 +
 fsck/main.c        |  2 ++
 fsck/mount.c       | 42 +++++++++++++++++++++++++++---------------
 include/f2fs_fs.h  |  9 +++++++--
 mkfs/f2fs_format.c |  5 ++++-
 7 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 93f01e5..6a6c4a5 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -272,7 +272,11 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 	if (is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG)) {
 		offset = (flag == SIT_BITMAP) ?
 			le32_to_cpu(ckpt->nat_ver_bitmap_bytesize) : 0;
-		return &ckpt->sit_nat_version_bitmap + offset;
+		/*
+		 * if large_nat_bitmap feature is enabled, leave checksum
+		 * protection for all nat/sit bitmaps.
+		 */
+		return &ckpt->sit_nat_version_bitmap + offset + sizeof(__le32);
 	}
 
 	if (le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload) > 0) {
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 7ecdee1..8d7deb5 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1917,6 +1917,18 @@ int fsck_chk_meta(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
+void fsck_chk_checkpoint(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+
+	if (get_cp(ckpt_flags) & CP_LARGE_NAT_BITMAP_FLAG) {
+		if (get_cp(checksum_offset) != CP_MIN_CHKSUM_OFFSET) {
+			ASSERT_MSG("Deprecated layout of large_nat_bitmap, "
+				"chksum_offset:%u", get_cp(checksum_offset));
+		}
+	}
+}
+
 void fsck_init(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
@@ -2038,6 +2050,10 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 		flags |= CP_TRIMMED_FLAG;
 	if (is_set_ckpt_flags(cp, CP_DISABLED_FLAG))
 		flags |= CP_DISABLED_FLAG;
+	if (is_set_ckpt_flags(cp, CP_LARGE_NAT_BITMAP_FLAG)) {
+		flags |= CP_LARGE_NAT_BITMAP_FLAG;
+		set_cp(checksum_offset, CP_MIN_CHKSUM_OFFSET);
+	}
 
 	if (flags & CP_UMOUNT_FLAG)
 		cp_blocks = 8;
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 376ced7..dd831de 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -154,6 +154,7 @@ extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, struct child_info *,
 		int, int);
 int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
 		struct child_info *);
+void fsck_chk_checkpoint(struct f2fs_sb_info *sbi);
 int fsck_chk_meta(struct f2fs_sb_info *sbi);
 int fsck_chk_curseg_info(struct f2fs_sb_info *);
 int convert_encrypted_name(unsigned char *, u32, unsigned char *, int);
diff --git a/fsck/main.c b/fsck/main.c
index d3f0c0d..e61bb91 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -616,6 +616,8 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 		c.fix_on = 1;
 	}
 
+	fsck_chk_checkpoint(sbi);
+
 	fsck_chk_quota_node(sbi);
 
 	/* Traverse all block recursively from root inode */
diff --git a/fsck/mount.c b/fsck/mount.c
index da1d4c9..843742e 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -769,15 +769,33 @@ int init_sb_info(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
+static int verify_checksum_chksum(struct f2fs_checkpoint *cp)
+{
+	unsigned int chksum_offset = get_cp(checksum_offset);
+	unsigned int crc, cal_crc;
+
+	if (chksum_offset < CP_MIN_CHKSUM_OFFSET ||
+			chksum_offset > CP_CHKSUM_OFFSET) {
+		MSG(0, "\tInvalid CP CRC offset: %u\n", chksum_offset);
+		return -1;
+	}
+
+	crc = le32_to_cpu(*(__le32 *)((unsigned char *)cp + chksum_offset));
+	cal_crc = f2fs_checkpoint_chksum(cp);
+	if (cal_crc != crc) {
+		MSG(0, "\tInvalid CP CRC: offset:%u, crc:0x%x, calc:0x%x\n",
+			chksum_offset, crc, cal_crc);
+		return -1;
+	}
+	return 0;
+}
+
 void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 				unsigned long long *version)
 {
 	void *cp_page_1, *cp_page_2;
 	struct f2fs_checkpoint *cp;
-	unsigned long blk_size = sbi->blocksize;
 	unsigned long long cur_version = 0, pre_version = 0;
-	unsigned int crc = 0;
-	size_t crc_offset;
 
 	/* Read the 1st cp block in this CP pack */
 	cp_page_1 = malloc(PAGE_SIZE);
@@ -787,12 +805,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 		goto invalid_cp1;
 
 	cp = (struct f2fs_checkpoint *)cp_page_1;
-	crc_offset = get_cp(checksum_offset);
-	if (crc_offset > (blk_size - sizeof(__le32)))
-		goto invalid_cp1;
-
-	crc = le32_to_cpu(*(__le32 *)((unsigned char *)cp + crc_offset));
-	if (f2fs_crc_valid(crc, cp, crc_offset))
+	if (verify_checksum_chksum(cp))
 		goto invalid_cp1;
 
 	if (get_cp(cp_pack_total_block_count) > sbi->blocks_per_seg)
@@ -810,12 +823,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 		goto invalid_cp2;
 
 	cp = (struct f2fs_checkpoint *)cp_page_2;
-	crc_offset = get_cp(checksum_offset);
-	if (crc_offset > (blk_size - sizeof(__le32)))
-		goto invalid_cp2;
-
-	crc = le32_to_cpu(*(__le32 *)((unsigned char *)cp + crc_offset));
-	if (f2fs_crc_valid(crc, cp, crc_offset))
+	if (verify_checksum_chksum(cp))
 		goto invalid_cp2;
 
 	cur_version = get_cp(checkpoint_ver);
@@ -2365,6 +2373,10 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 		flags |= CP_TRIMMED_FLAG;
 	if (is_set_ckpt_flags(cp, CP_DISABLED_FLAG))
 		flags |= CP_DISABLED_FLAG;
+	if (is_set_ckpt_flags(cp, CP_LARGE_NAT_BITMAP_FLAG)) {
+		flags |= CP_LARGE_NAT_BITMAP_FLAG;
+		set_cp(checksum_offset, CP_MIN_CHKSUM_OFFSET);
+	}
 
 	set_cp(free_segment_count, get_free_segments(sbi));
 	set_cp(valid_block_count, sbi->total_valid_block_count);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 1bd935c..89b8a0c 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -692,10 +692,15 @@ struct f2fs_checkpoint {
 	unsigned char sit_nat_version_bitmap[1];
 } __attribute__((packed));
 
+#define CP_BITMAP_OFFSET	\
+	(offsetof(struct f2fs_checkpoint, sit_nat_version_bitmap))
+#define CP_MIN_CHKSUM_OFFSET	CP_BITMAP_OFFSET
+
+#define MIN_NAT_BITMAP_SIZE	64
 #define MAX_SIT_BITMAP_SIZE_IN_CKPT    \
-	(CP_CHKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1 - 64)
+	(CP_CHKSUM_OFFSET - CP_BITMAP_OFFSET - MIN_NAT_BITMAP_SIZE)
 #define MAX_BITMAP_SIZE_IN_CKPT	\
-	(CP_CHKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1)
+	(CP_CHKSUM_OFFSET - CP_BITMAP_OFFSET)
 
 /*
  * For orphan inode management
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index a534293..eabffce 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -706,7 +706,10 @@ static int f2fs_write_check_point_pack(void)
 	set_cp(nat_ver_bitmap_bytesize, ((get_sb(segment_count_nat) / 2) <<
 			 get_sb(log_blocks_per_seg)) / 8);
 
-	set_cp(checksum_offset, CP_CHKSUM_OFFSET);
+	if (c.large_nat_bitmap)
+		set_cp(checksum_offset, CP_MIN_CHKSUM_OFFSET);
+	else
+		set_cp(checksum_offset, CP_CHKSUM_OFFSET);
 
 	crc = f2fs_checkpoint_chksum(cp);
 	*((__le32 *)((unsigned char *)cp + get_cp(checksum_offset))) =
-- 
2.18.0.rc1

