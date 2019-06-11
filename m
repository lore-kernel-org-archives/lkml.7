Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9570C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 01:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C1C2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 01:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbfFKByn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 21:54:43 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:53687 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390388AbfFKByn (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 10 Jun 2019 21:54:43 -0400
Received: from ghe-pc.suse.asia (prva10-snat226-1.provo.novell.com [137.65.226.35])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Mon, 10 Jun 2019 19:54:31 -0600
From:   Gang He <ghe@suse.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     Gang He <ghe@suse.com>, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, akpm@linux-foundation.org
Subject: [PATCH V4 2/3] ocfs2: add locking filter debugfs file
Date:   Tue, 11 Jun 2019 09:54:13 +0800
Message-Id: <20190611015414.27754-2-ghe@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190611015414.27754-1-ghe@suse.com>
References: <20190611015414.27754-1-ghe@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add locking filter debugfs file, which is used to filter lock
resources dump from locking_state debugfs file.
We use d_filter_secs field to filter lock resources dump,
the default d_filter_secs(0) value filters nothing,
otherwise, only dump the last N seconds active lock resources.
This enhancement can avoid dumping lots of old records.
The d_filter_secs value can be changed via locking_filter file.

Compared with v3, I need to do the related change since last
lock/unlock uses wall time in microsecond. secondly, adjust
CONFIG_OCFS2_FS_STATS macro positions.
Compared with v2, ocfs2_dlm_init_debug() returns directly with
error when creating locking filter debugfs file is failed, since
ocfs2_dlm_shutdown_debug() will handle this failure perfectly.
Compared with v1, the main change is to add CONFIG_OCFS2_FS_STATS
macro definition judgment.

Signed-off-by: Gang He <ghe@suse.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/dlmglue.c | 38 ++++++++++++++++++++++++++++++++++++++
 fs/ocfs2/ocfs2.h   |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 3b0e7d399df2..d4caa6d117c6 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -3005,6 +3005,8 @@ struct ocfs2_dlm_debug *ocfs2_new_dlm_debug(void)
 	kref_init(&dlm_debug->d_refcnt);
 	INIT_LIST_HEAD(&dlm_debug->d_lockres_tracking);
 	dlm_debug->d_locking_state = NULL;
+	dlm_debug->d_locking_filter = NULL;
+	dlm_debug->d_filter_secs = 0;
 out:
 	return dlm_debug;
 }
@@ -3104,10 +3106,34 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
 	int i;
 	char *lvb;
 	struct ocfs2_lock_res *lockres = v;
+#ifdef CONFIG_OCFS2_FS_STATS
+	u64 now, last;
+	struct ocfs2_dlm_debug *dlm_debug =
+			((struct ocfs2_dlm_seq_priv *)m->private)->p_dlm_debug;
+#endif
 
 	if (!lockres)
 		return -EINVAL;
 
+#ifdef CONFIG_OCFS2_FS_STATS
+	if (dlm_debug->d_filter_secs) {
+		now = ktime_to_us(ktime_get_real());
+		if (lockres->l_lock_prmode.ls_last >
+		    lockres->l_lock_exmode.ls_last)
+			last = lockres->l_lock_prmode.ls_last;
+		else
+			last = lockres->l_lock_exmode.ls_last;
+		/*
+		 * Use d_filter_secs field to filter lock resources dump,
+		 * the default d_filter_secs(0) value filters nothing,
+		 * otherwise, only dump the last N seconds active lock
+		 * resources.
+		 */
+		if ((now - last) / 1000000 > dlm_debug->d_filter_secs)
+			return 0;
+	}
+#endif
+
 	seq_printf(m, "0x%x\t", OCFS2_DLM_DEBUG_STR_VERSION);
 
 	if (lockres->l_type == OCFS2_LOCK_TYPE_DENTRY)
@@ -3257,6 +3283,17 @@ static int ocfs2_dlm_init_debug(struct ocfs2_super *osb)
 		goto out;
 	}
 
+	dlm_debug->d_locking_filter = debugfs_create_u32("locking_filter",
+						0600,
+						osb->osb_debug_root,
+						&dlm_debug->d_filter_secs);
+	if (!dlm_debug->d_locking_filter) {
+		ret = -EINVAL;
+		mlog(ML_ERROR,
+		     "Unable to create locking filter debugfs file.\n");
+		goto out;
+	}
+
 	ocfs2_get_dlm_debug(dlm_debug);
 out:
 	return ret;
@@ -3268,6 +3305,7 @@ static void ocfs2_dlm_shutdown_debug(struct ocfs2_super *osb)
 
 	if (dlm_debug) {
 		debugfs_remove(dlm_debug->d_locking_state);
+		debugfs_remove(dlm_debug->d_locking_filter);
 		ocfs2_put_dlm_debug(dlm_debug);
 	}
 }
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 6f43651f01b3..6d0a77703d0e 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -237,6 +237,8 @@ struct ocfs2_orphan_scan {
 struct ocfs2_dlm_debug {
 	struct kref d_refcnt;
 	struct dentry *d_locking_state;
+	struct dentry *d_locking_filter;
+	u32 d_filter_secs;
 	struct list_head d_lockres_tracking;
 };
 
-- 
2.21.0

