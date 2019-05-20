Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E256C04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 02:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7348D20644
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 02:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfETCJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 22:09:44 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:50406 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727220AbfETCJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 22:09:44 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id D2DB9F943F1E560E3177;
        Mon, 20 May 2019 10:09:42 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 May 2019 10:09:42 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 20 May 2019 10:09:41 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to check layout on last valid checkpoint park
Date:   Mon, 20 May 2019 10:09:22 +0800
Message-ID: <20190520020922.62124-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Ju Hyung reported:

"
I was semi-forced today to use the new kernel and test f2fs.

My Ubuntu initramfs got a bit wonky and I had to boot into live CD and
fix some stuffs. The live CD was using 4.15 kernel, and just mounting
the f2fs partition there corrupted f2fs and my 4.19(with 5.1-rc1-4.19
f2fs-stable merged) refused to mount with "SIT is corrupted node"
message.

I used the latest f2fs-tools sent by Chao including "fsck.f2fs: fix to
repair cp_loads blocks at correct position"

It spit out 140M worth of output, but at least I didn't have to run it
twice. Everything returned "Ok" in the 2nd run.
The new log is at
http://arter97.com/f2fs/final

After fixing the image, I used my 4.19 kernel with 5.2-rc1-4.19
f2fs-stable merged and it mounted.

But, I got this:
[    1.047791] F2FS-fs (nvme0n1p3): layout of large_nat_bitmap is
deprecated, run fsck to repair, chksum_offset: 4092
[    1.081307] F2FS-fs (nvme0n1p3): Found nat_bits in checkpoint
[    1.161520] F2FS-fs (nvme0n1p3): recover fsync data on readonly fs
[    1.162418] F2FS-fs (nvme0n1p3): Mounted with checkpoint version = 761c7e00

But after doing a reboot, the message is gone:
[    1.098423] F2FS-fs (nvme0n1p3): Found nat_bits in checkpoint
[    1.177771] F2FS-fs (nvme0n1p3): recover fsync data on readonly fs
[    1.178365] F2FS-fs (nvme0n1p3): Mounted with checkpoint version = 761c7eda

I'm not exactly sure why the kernel detected that I'm still using the
old layout on the first boot. Maybe fsck didn't fix it properly, or
the check from the kernel is improper.
"

Although we have rebuild the old deprecated checkpoint with new layout
during repair, we only repair last checkpoint park, the other old one is
remained.

Once the image was mounted, we will 1) sanity check layout and 2) decide
which checkpoint park to use according to cp_ver. So that we will print
reported message unnecessarily at step 1), to avoid it, we simply move
layout check into f2fs_sanity_check_ckpt() after step 2).

Reported-by: Park Ju Hyung <qkrwngud825@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---

Hi Jaegeuk,

Ju Hyung suggested that we can show more detailed info about f2fs-tools
version to user, I think it's helpful, could you consider to change the
log as below?

			f2fs_msg(sbi->sb, KERN_WARNING, 
				"using deprecated layout of large_nat_bitmap, " 
				"please run fsck v1.13.0 or higher to repair, " 
				"chksum_offset: %u", chksum_offset); 

 fs/f2fs/checkpoint.c | 11 -----------
 fs/f2fs/super.c      |  9 +++++++++
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 22c2cac646f4..739b03c9677b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -832,17 +832,6 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
 		return -EINVAL;
 	}
 
-	if (__is_set_ckpt_flags(*cp_block, CP_LARGE_NAT_BITMAP_FLAG)) {
-		if (crc_offset != CP_MIN_CHKSUM_OFFSET) {
-			f2fs_put_page(*cp_page, 1);
-			f2fs_msg(sbi->sb, KERN_WARNING,
-				"layout of large_nat_bitmap is deprecated, "
-				"run fsck to repair, chksum_offset: %zu",
-				crc_offset);
-			return -EINVAL;
-		}
-	}
-
 	crc = f2fs_checkpoint_chksum(sbi, *cp_block);
 	if (crc != cur_cp_crc(*cp_block)) {
 		f2fs_put_page(*cp_page, 1);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f26f0ec78b3d..3c71b9a71932 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2727,6 +2727,15 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		return 1;
 	}
 
+	if (__is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG) &&
+		le32_to_cpu(ckpt->checksum_offset) != CP_MIN_CHKSUM_OFFSET) {
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"layout of large_nat_bitmap is deprecated, "
+			"run fsck to repair, chksum_offset: %u",
+			le32_to_cpu(ckpt->checksum_offset));
+		return 1;
+	}
+
 	if (unlikely(f2fs_cp_error(sbi))) {
 		f2fs_msg(sbi->sb, KERN_ERR, "A bug case: need to run fsck");
 		return 1;
-- 
2.18.0.rc1

