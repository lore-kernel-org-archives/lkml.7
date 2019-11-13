Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79FAC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A441F222C6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nkxXB5V+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nr5Mnjmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKMKbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:31:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42886 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMKbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:31:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 77E306043F; Wed, 13 Nov 2019 10:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573641076;
        bh=/66u/Suwke1zMwFS5nxwNNZ4s1ARpfkENpmO/QNhmqc=;
        h=From:To:Cc:Subject:Date:From;
        b=nkxXB5V+fcmm//QLuYk23f31tl5cztvvmF98MUePWjsPmlmMukL8jbcJ2zbT2hHC+
         YYH9fCYQI+o+5kkxknyrM6I/NATjFTlSnN/OoyPVRef/xj0Hh0QCeF62KFvYZvBYli
         n1ufw3bZVyfGABnpYvkqFHwCYGER6l+KDesTx2G4=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D3A160592;
        Wed, 13 Nov 2019 10:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573641074;
        bh=/66u/Suwke1zMwFS5nxwNNZ4s1ARpfkENpmO/QNhmqc=;
        h=From:To:Cc:Subject:Date:From;
        b=Nr5MnjmbZ5sAfMwxAqXAepG0Es1g8ocLUj/anOxjmBb5lZxdQDdhAFyjmJDcFwJ9E
         HNpWSGu/noC7Tut/mKqQLFn4bETwV0P3sh2JeVO7/QSvsRO4/y8lHu1cILolmJadIq
         vOB70Rs3CFL0UxxSxdvmWPfvaFHvCTbDYVvQ7kv8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D3A160592
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: Fix deadlock in f2fs_gc() context during atomic files handling
Date:   Wed, 13 Nov 2019 16:01:03 +0530
Message-Id: <1573641063-21232-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FS got stuck in the below stack when the storage is almost
full/dirty condition (when FG_GC is being done).

schedule_timeout
io_schedule_timeout
congestion_wait
f2fs_drop_inmem_pages_all
f2fs_gc
f2fs_balance_fs
__write_node_page
f2fs_fsync_node_pages
f2fs_do_sync_file
f2fs_ioctl

The root cause for this issue is there is a potential infinite loop
in f2fs_drop_inmem_pages_all() for the case where gc_failure is true
and when there an inode whose i_gc_failures[GC_FAILURE_ATOMIC] is
not set. Fix this by keeping track of the total atomic files
currently opened and using that to exit from this condition.

Fix-suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
- change fix as per Chao's suggestion
- decrement sbi->atomic_files protected under sbi->inode_lock[ATOMIC_FILE] and
  only when atomic flag is cleared for the first time, otherwise, the count
  goes to an invalid/high value as f2fs_drop_inmem_pages() can be called from
  two contexts at the same time.

 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/file.c    |  1 +
 fs/f2fs/segment.c | 21 +++++++++++++++------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c681f51..e04a665 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1297,6 +1297,7 @@ struct f2fs_sb_info {
 	unsigned int gc_mode;			/* current GC state */
 	unsigned int next_victim_seg[2];	/* next segment in victim section */
 	/* for skip statistic */
+	unsigned int atomic_files;              /* # of opened atomic file */
 	unsigned long long skipped_atomic_files[2];	/* FG_GC and BG_GC */
 	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f6c038e..22c4949 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1919,6 +1919,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	if (list_empty(&fi->inmem_ilist))
 		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
+	sbi->atomic_files++;
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 
 	/* add inode in inmem_list first and set atomic_file */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index da830fc..0b7a33b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -288,6 +288,8 @@ void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
 	struct list_head *head = &sbi->inode_list[ATOMIC_FILE];
 	struct inode *inode;
 	struct f2fs_inode_info *fi;
+	unsigned int count = sbi->atomic_files;
+	unsigned int looped = 0;
 next:
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	if (list_empty(head)) {
@@ -296,22 +298,26 @@ void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
 	}
 	fi = list_first_entry(head, struct f2fs_inode_info, inmem_ilist);
 	inode = igrab(&fi->vfs_inode);
+	if (inode)
+		list_move_tail(&fi->inmem_ilist, head);
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 
 	if (inode) {
 		if (gc_failure) {
-			if (fi->i_gc_failures[GC_FAILURE_ATOMIC])
-				goto drop;
-			goto skip;
+			if (!fi->i_gc_failures[GC_FAILURE_ATOMIC])
+				goto skip;
 		}
-drop:
 		set_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
 		f2fs_drop_inmem_pages(inode);
+skip:
 		iput(inode);
 	}
-skip:
 	congestion_wait(BLK_RW_ASYNC, HZ/50);
 	cond_resched();
+	if (gc_failure) {
+		if (++looped >= count)
+			return;
+	}
 	goto next;
 }
 
@@ -327,13 +333,16 @@ void f2fs_drop_inmem_pages(struct inode *inode)
 		mutex_unlock(&fi->inmem_lock);
 	}
 
-	clear_inode_flag(inode, FI_ATOMIC_FILE);
 	fi->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
 	stat_dec_atomic_write(inode);
 
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	if (!list_empty(&fi->inmem_ilist))
 		list_del_init(&fi->inmem_ilist);
+	if (f2fs_is_atomic_file(inode)) {
+		clear_inode_flag(inode, FI_ATOMIC_FILE);
+		sbi->atomic_files--;
+	}
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

