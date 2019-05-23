Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CE0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C820820851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfEWKlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 06:41:09 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:56381 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfEWKlJ (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 23 May 2019 06:41:09 -0400
Received: from ghe-pc.suse.asia (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 23 May 2019 04:40:58 -0600
From:   Gang He <ghe@suse.com>
To:     mark@fasheh.com, jlbec@evilplan.org, jiangqi903@gmail.com
Cc:     Gang He <ghe@suse.com>, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, akpm@linux-foundation.org
Subject: [PATCH 1/2] ocfs2: add last unlock times in locking_state
Date:   Thu, 23 May 2019 18:40:46 +0800
Message-Id: <20190523104047.14794-1-ghe@suse.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ocfs2 file system uses locking_state file under debugfs to dump
each ocfs2 file system's dlm lock resources, but the dlm lock
resources in memory are becoming more and more after the files
were touched by the user. it will become a bit difficult to analyze
these dlm lock resource records in locking_state file by the upper
scripts, though some files are not active for now, which were
accessed long time ago.
Then, I'd like to add last pr/ex unlock times in locking_state file
for each dlm lock resource record, the the upper scripts can use
last unlock time to filter inactive dlm lock resource record.

Signed-off-by: Gang He <ghe@suse.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/dlmglue.c | 21 +++++++++++++++++----
 fs/ocfs2/ocfs2.h   |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index af405586c5b1..dccf4136f8c1 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -448,7 +448,7 @@ static void ocfs2_update_lock_stats(struct ocfs2_lock_res *res, int level,
 				    struct ocfs2_mask_waiter *mw, int ret)
 {
 	u32 usec;
-	ktime_t kt;
+	ktime_t last, kt;
 	struct ocfs2_lock_stats *stats;
 
 	if (level == LKM_PRMODE)
@@ -458,7 +458,8 @@ static void ocfs2_update_lock_stats(struct ocfs2_lock_res *res, int level,
 	else
 		return;
 
-	kt = ktime_sub(ktime_get(), mw->mw_lock_start);
+	last = ktime_get();
+	kt = ktime_sub(last, mw->mw_lock_start);
 	usec = ktime_to_us(kt);
 
 	stats->ls_gets++;
@@ -474,6 +475,8 @@ static void ocfs2_update_lock_stats(struct ocfs2_lock_res *res, int level,
 
 	if (ret)
 		stats->ls_fail++;
+
+	stats->ls_last = ktime_to_timespec(last).tv_sec;
 }
 
 static inline void ocfs2_track_lock_refresh(struct ocfs2_lock_res *lockres)
@@ -3093,8 +3096,10 @@ static void *ocfs2_dlm_seq_next(struct seq_file *m, void *v, loff_t *pos)
  *	- Lock stats printed
  * New in version 3
  *	- Max time in lock stats is in usecs (instead of nsecs)
+ * New in version 4
+ *	- Add last pr/ex unlock times in secs
  */
-#define OCFS2_DLM_DEBUG_STR_VERSION 3
+#define OCFS2_DLM_DEBUG_STR_VERSION 4
 static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
 {
 	int i;
@@ -3145,6 +3150,8 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
 # define lock_max_prmode(_l)		((_l)->l_lock_prmode.ls_max)
 # define lock_max_exmode(_l)		((_l)->l_lock_exmode.ls_max)
 # define lock_refresh(_l)		((_l)->l_lock_refresh)
+# define lock_last_prmode(_l)		((_l)->l_lock_prmode.ls_last)
+# define lock_last_exmode(_l)		((_l)->l_lock_exmode.ls_last)
 #else
 # define lock_num_prmode(_l)		(0)
 # define lock_num_exmode(_l)		(0)
@@ -3155,6 +3162,8 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
 # define lock_max_prmode(_l)		(0)
 # define lock_max_exmode(_l)		(0)
 # define lock_refresh(_l)		(0)
+# define lock_last_prmode(_l)		(0)
+# define lock_last_exmode(_l)		(0)
 #endif
 	/* The following seq_print was added in version 2 of this output */
 	seq_printf(m, "%u\t"
@@ -3165,6 +3174,8 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
 		   "%llu\t"
 		   "%u\t"
 		   "%u\t"
+		   "%u\t"
+		   "%u\t"
 		   "%u\t",
 		   lock_num_prmode(lockres),
 		   lock_num_exmode(lockres),
@@ -3174,7 +3185,9 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
 		   lock_total_exmode(lockres),
 		   lock_max_prmode(lockres),
 		   lock_max_exmode(lockres),
-		   lock_refresh(lockres));
+		   lock_refresh(lockres),
+		   lock_last_prmode(lockres),
+		   lock_last_exmode(lockres));
 
 	/* End the line */
 	seq_printf(m, "\n");
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 1f029fbe8b8d..8efa022684f4 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -164,6 +164,7 @@ struct ocfs2_lock_stats {
 
 	/* Storing max wait in usecs saves 24 bytes per inode */
 	u32		ls_max;		/* Max wait in USEC */
+	u32		ls_last;	/* Last unlock time in SEC */
 };
 #endif
 
-- 
2.21.0

