Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1EBC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9E9206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfDVJfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:35:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2937 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726172AbfDVJfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:35:23 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id C174B8BA0B22C9DC3948;
        Mon, 22 Apr 2019 17:35:17 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 22 Apr 2019 17:35:00 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 22 Apr 2019 17:34:59 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <linux-f2fs-devel@lists.sourceforge.net>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs-tools: allow unfixed f2fs_checkpoint.checksum_offset
Date:   Mon, 22 Apr 2019 17:34:51 +0800
Message-ID: <20190422093452.61134-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
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

Previously, f2fs_checkpoint.checksum_offset points fixed position of
f2fs_checkpoint structure:

"#define CP_CHKSUM_OFFSET	4092"

It is unnecessary, and it breaks the consecutiveness of nat and sit
bitmap stored across checkpoint park block and payload blocks.

This patch allows f2fs-tools to handle unfixed .checksum_offset.

In addition, for the case checksum value is stored in the middle of
checkpoint park, calculating checksum value with superposition method
like we did for inode_checksum.

In addition, using MAX_BITMAP_SIZE_IN_CKPT to clean up codes.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c        |  5 +++--
 fsck/mount.c       |  5 +++--
 fsck/resize.c      | 10 +++++-----
 include/f2fs_fs.h  |  1 +
 lib/libf2fs.c      | 14 ++++++++++++++
 mkfs/f2fs_format.c | 16 +++++++---------
 6 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index a17555c..7ecdee1 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2056,8 +2056,9 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	set_cp(valid_node_count, fsck->chk.valid_node_cnt);
 	set_cp(valid_inode_count, fsck->chk.valid_inode_cnt);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) = cpu_to_le32(crc);
+	crc = f2fs_checkpoint_chksum(cp);
+	*((__le32 *)((unsigned char *)cp + get_cp(checksum_offset))) =
+							cpu_to_le32(crc);
 
 	cp_blk_no = get_sb(cp_blkaddr);
 	if (sbi->cur_cp == 2)
diff --git a/fsck/mount.c b/fsck/mount.c
index aa64e93..da1d4c9 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2373,8 +2373,9 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 	flags = update_nat_bits_flags(sb, cp, flags);
 	set_cp(ckpt_flags, flags);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) = cpu_to_le32(crc);
+	crc = f2fs_checkpoint_chksum(cp);
+	*((__le32 *)((unsigned char *)cp + get_cp(checksum_offset))) =
+							cpu_to_le32(crc);
 
 	cp_blk_no = get_sb(cp_blkaddr);
 	if (sbi->cur_cp == 2)
diff --git a/fsck/resize.c b/fsck/resize.c
index 56c8103..2c623c5 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -90,11 +90,11 @@ static int get_new_sb(struct f2fs_super_block *sb)
 		 * It requires more pages for cp.
 		 */
 		if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
-			max_nat_bitmap_size = CP_CHKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
+			max_nat_bitmap_size = MAX_BITMAP_SIZE_IN_CKPT;
 			set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
 		} else {
-			max_nat_bitmap_size = CP_CHKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
-				- max_sit_bitmap_size;
+			max_nat_bitmap_size = MAX_BITMAP_SIZE_IN_CKPT -
+							max_sit_bitmap_size;
 			set_sb(cp_payload, 0);
 		}
 
@@ -520,8 +520,8 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 						(unsigned char *)cp);
 	new_cp->checkpoint_ver = cpu_to_le64(cp_ver + 1);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, new_cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)new_cp + CP_CHKSUM_OFFSET)) =
+	crc = f2fs_checkpoint_chksum(cp);
+	*((__le32 *)((unsigned char *)new_cp + get_cp(checksum_offset))) =
 							cpu_to_le32(crc);
 
 	/* Write a new checkpoint in the other set */
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index c6669c9..1bd935c 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1133,6 +1133,7 @@ extern int utf16_to_utf8(char *, const u_int16_t *, size_t, size_t);
 extern int log_base_2(u_int32_t);
 extern unsigned int addrs_per_inode(struct f2fs_inode *);
 extern __u32 f2fs_inode_chksum(struct f2fs_node *);
+extern __u32 f2fs_checkpoint_chksum(struct f2fs_checkpoint *);
 
 extern int get_bits_in_byte(unsigned char n);
 extern int test_and_set_bit_le(u32, u8 *);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 853e713..4202cd1 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -532,6 +532,20 @@ __u32 f2fs_inode_chksum(struct f2fs_node *node)
 	return chksum;
 }
 
+__u32 f2fs_checkpoint_chksum(struct f2fs_checkpoint *cp)
+{
+	unsigned int chksum_ofs = le32_to_cpu(cp->checksum_offset);
+	__u32 chksum;
+
+	chksum = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, chksum_ofs);
+	if (chksum_ofs < CP_CHKSUM_OFFSET) {
+		chksum_ofs += sizeof(chksum);
+		chksum = f2fs_cal_crc32(chksum, (__u8 *)cp + chksum_ofs,
+						F2FS_BLKSIZE - chksum_ofs);
+	}
+	return chksum;
+}
+
 /*
  * try to identify the root device
  */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 4560611..a534293 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -358,13 +358,11 @@ static int f2fs_prepare_super_block(void)
 		 * It requires more pages for cp.
 		 */
 		if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
-			max_nat_bitmap_size = CP_CHKSUM_OFFSET -
-					sizeof(struct f2fs_checkpoint) + 1;
+			max_nat_bitmap_size = MAX_BITMAP_SIZE_IN_CKPT;
 			set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
 	        } else {
-			max_nat_bitmap_size =
-				CP_CHKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
-				- max_sit_bitmap_size;
+			max_nat_bitmap_size = MAX_BITMAP_SIZE_IN_CKPT -
+							max_sit_bitmap_size;
 			set_sb(cp_payload, 0);
 		}
 		max_nat_segments = (max_nat_bitmap_size * 8) >> log_blks_per_seg;
@@ -710,8 +708,8 @@ static int f2fs_write_check_point_pack(void)
 
 	set_cp(checksum_offset, CP_CHKSUM_OFFSET);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) =
+	crc = f2fs_checkpoint_chksum(cp);
+	*((__le32 *)((unsigned char *)cp + get_cp(checksum_offset))) =
 							cpu_to_le32(crc);
 
 	blk_size_bytes = 1 << get_sb(log_blocksize);
@@ -956,8 +954,8 @@ static int f2fs_write_check_point_pack(void)
 	 */
 	cp->checkpoint_ver = 0;
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) =
+	crc = f2fs_checkpoint_chksum(cp);
+	*((__le32 *)((unsigned char *)cp + get_cp(checksum_offset))) =
 							cpu_to_le32(crc);
 	cp_seg_blk = get_sb(segment0_blkaddr) + c.blks_per_seg;
 	DBG(1, "\tWriting cp page 1 of checkpoint pack 2, at offset 0x%08"PRIx64"\n",
-- 
2.18.0.rc1

