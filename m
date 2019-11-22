Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7FAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283572071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574453365;
	bh=sUU5ZHY5o7dMVF1G7nOuopKx1TMsfFOufwaWDvxep14=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=njSp0R7AXecck3MeZngiFKkZI4hZK7l4eEyPg76xSZLnll0v4DrRFMHStUAsiKx9+
	 /u2BUOyz/5dDc2qMgNYPuZGKA8M0xS6KJFpHBZUyF2hHplpDt0hJ6zk0t38GBve/pq
	 bgmRZU3Kmb7fO5Uwg4pnBZYCOULVpK0q/a2p02WM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfKVUJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfKVUJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:09:24 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B9AF2068F;
        Fri, 22 Nov 2019 20:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574453362;
        bh=sUU5ZHY5o7dMVF1G7nOuopKx1TMsfFOufwaWDvxep14=;
        h=From:To:Cc:Subject:Date:From;
        b=p3AersLtERcCiWgiHG0s79dPmiHB2nPQF2Ibr+jLXXalGxmxpLAOkIqWFUzaMh813
         HI7a/gu38NO7AIXzEzt0eQETT1sfw7VdV6Mix+D1IQLAbfE2ZruFEtUKCk5PIgqQYD
         AZ9VfK5k9//yIe3EcYAI2HUXUC0IBnTKvYAVPgp0=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Ramon Pantin <pantin@google.com>
Subject: [PATCH 1/2] f2fs: expose main_blkaddr in sysfs
Date:   Fri, 22 Nov 2019 12:09:19 -0800
Message-Id: <20191122200920.83941-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose in /sys/fs/f2fs/<blockdev>/main_blkaddr the block address where the
main area starts. This allows user mode programs to determine:

- That pinned files that are made exclusively of fully allocated 2MB
  segments will never be unpinned by the file system.

- Where the main area starts. This is required by programs that want to
  verify if a file is made exclusively of 2MB f2fs segments, the alignment
  boundary for segments starts at this address. Testing for 2MB alignment
  relative to the start of the device is incorrect, because for some
  filesystems main_blkaddr is not at a 2MB boundary relative to the start
  of the device.

The entry will be used when validating reliable pinning file feature proposed
by "f2fs: support aligned pinned file".

Signed-off-by: Ramon Pantin <pantin@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 Documentation/filesystems/f2fs.txt      | 3 +++
 fs/f2fs/sysfs.c                         | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 7ab2b1b5e255..aedeae1e8ec1 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -31,6 +31,12 @@ Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
 Description:
 		 Controls the issue rate of segment discard commands.
 
+What:		/sys/fs/f2fs/<disk>/max_blkaddr
+Date:		November 2019
+Contact:	"Ramon Pantin" <pantin@google.com>
+Description:
+		 Shows first block address of MAIN area.
+
 What:		/sys/fs/f2fs/<disk>/ipu_policy
 Date:		November 2013
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 29020af0cff9..3135b80df6da 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -297,6 +297,9 @@ Files in /sys/fs/f2fs/<devname>
 			      reclaim the prefree segments to free segments.
 			      By default, 5% over total # of segments.
 
+ main_blkaddr                 This value gives the first block address of
+			      MAIN area in the partition.
+
  max_small_discards	      This parameter controls the number of discard
 			      commands that consist small blocks less than 2MB.
 			      The candidates to be discarded are cached until
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index f164959e4224..70945ceb9c0c 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -445,6 +445,7 @@ F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_idle, gc_mode);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent, gc_mode);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
+F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, main_blkaddr, main_blkaddr);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_small_discards, max_discards);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
 F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
@@ -512,6 +513,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
+	ATTR_LIST(main_blkaddr),
 	ATTR_LIST(max_small_discards),
 	ATTR_LIST(discard_granularity),
 	ATTR_LIST(batched_trim_sections),
-- 
2.19.0.605.g01d371f741-goog

