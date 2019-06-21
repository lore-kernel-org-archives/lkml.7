Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739B8C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAC621530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561140089;
	bh=kk0SwYShH0N5Cjl23BV6nWVdm/thRR90X/WPRMwddZ4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=co8324relMPeNoARc6JSUdp27yAOA6QMa4ZpSoALPCT+N5RuFn0ixV+Q8pV3BbdSY
	 nyNN2lR1owGiI/r84HE4IsQYtN9qQxIqB6c5Feva/lUEiGY+9YoX/mOeVX02ln1NMw
	 UXAWdbFolMJyAqqnM5rCO/tkIcqRC9xNg8U9+fFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfFUSB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFUSB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:01:27 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B4EA2070B;
        Fri, 21 Jun 2019 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561140086;
        bh=kk0SwYShH0N5Cjl23BV6nWVdm/thRR90X/WPRMwddZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=QPDHhuTV5Lp4adKPf7x76+t0LCtvI1RqmFPdfswkG3drnYym8M3wtlFv1OVLZNiv5
         5gft3KQUZ0ZvAkOqYBbWm6gvXN72ZtYmCWqHHDumwMCoPBfzhqbQE9JjCkXQYbCtsd
         MQpA5kBcnidNDMJR88lWU12LI2vUyLbQ/XKN/7Lg=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@google.com>
Subject: [PATCH] f2fs: add wsync_mode for sysfs entry
Date:   Fri, 21 Jun 2019 11:01:24 -0700
Message-Id: <20190621180124.82842-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@google.com>

This add one sysfs entry to control REQ_SYNC/REQ_BACKGROUND for write bios
for data page writes.

Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++++++
 Documentation/filesystems/f2fs.txt      |  4 ++++
 fs/f2fs/data.c                          |  3 +--
 fs/f2fs/f2fs.h                          | 12 ++++++++++++
 fs/f2fs/sysfs.c                         |  2 ++
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index dca326e0ee3e..d3eca3eb3214 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -251,3 +251,10 @@ Description:
 		If checkpoint=disable, it displays the number of blocks that are unusable.
                 If checkpoint=enable it displays the enumber of blocks that would be unusable
                 if checkpoint=disable were to be set.
+
+What:		/sys/fs/f2fs/<disk>/wsync_mode
+Date		June 2019
+Contact:	"Jaegeuk Kim" <jaegeuk.kim@kernel.org>
+Description:
+		0 gives no change. 1 assigns all the data writes with REQ_SYNC.
+                2 does REQ_BACKGROUND instead.
diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index bebd1be3ba49..81c529801a88 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -413,6 +413,10 @@ Files in /sys/fs/f2fs/<devname>
                               that would be unusable if checkpoint=disable were
                               to be set.
 
+ wsync_mode                   0 is by default. 1 gives REQ_SYNC for all the data
+                              writes. 2 gives REQ_BACKGROUND for all. This can
+                              used for the performance tuning purpose.
+
 ================================================================================
 USAGE
 ================================================================================
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f4e1672bd96e..18c73a1fdef3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -9,7 +9,6 @@
 #include <linux/f2fs_fs.h>
 #include <linux/buffer_head.h>
 #include <linux/mpage.h>
-#include <linux/writeback.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 #include <linux/blkdev.h>
@@ -2021,7 +2020,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 		.ino = inode->i_ino,
 		.type = DATA,
 		.op = REQ_OP_WRITE,
-		.op_flags = wbc_to_write_flags(wbc),
+		.op_flags = f2fs_wbc_to_write_flags(sbi, wbc),
 		.old_blkaddr = NULL_ADDR,
 		.page = page,
 		.encrypted_page = NULL,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2be2b16573c3..1cc46a6dc340 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/page-flags.h>
 #include <linux/buffer_head.h>
+#include <linux/writeback.h>
 #include <linux/slab.h>
 #include <linux/crc32.h>
 #include <linux/magic.h>
@@ -1264,6 +1265,7 @@ struct f2fs_sb_info {
 
 	/* writeback control */
 	atomic_t wb_sync_req[META];	/* count # of WB_SYNC threads */
+	int wsync_mode;			/* write mode */
 
 	/* valid inode count */
 	struct percpu_counter total_valid_inode_count;
@@ -3631,6 +3633,16 @@ static inline void set_opt_mode(struct f2fs_sb_info *sbi, unsigned int mt)
 	}
 }
 
+static inline int f2fs_wbc_to_write_flags(struct f2fs_sb_info *sbi,
+				struct writeback_control *wbc)
+{
+	if (sbi->wsync_mode == 1)
+		return REQ_SYNC;
+	if (sbi->wsync_mode == 2)
+		return REQ_BACKGROUND;
+	return wbc_to_write_flags(wbc);
+}
+
 static inline bool f2fs_may_encrypt(struct inode *inode)
 {
 #ifdef CONFIG_FS_ENCRYPTION
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 3aeacd0aacfd..e3c164d921a1 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -455,6 +455,7 @@ F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
 F2FS_GENERAL_RO_ATTR(features);
 F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
 F2FS_GENERAL_RO_ATTR(unusable);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, wsync_mode, wsync_mode);
 
 #ifdef CONFIG_FS_ENCRYPTION
 F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
@@ -515,6 +516,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(features),
 	ATTR_LIST(reserved_blocks),
 	ATTR_LIST(current_reserved_blocks),
+	ATTR_LIST(wsync_mode),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.19.0.605.g01d371f741-goog

