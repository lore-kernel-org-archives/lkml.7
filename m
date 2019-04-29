Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A619C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700012147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfD2Gq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:46:29 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:59745 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfD2Gq3 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 29 Apr 2019 02:46:29 -0400
Received: from ghe-pc.suse.asia (prva10-snat226-1.provo.novell.com [137.65.226.35])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Mon, 29 Apr 2019 00:46:17 -0600
From:   Gang He <ghe@suse.com>
To:     mark@fasheh.com, jlbec@evilplan.org, jiangqi903@gmail.com
Cc:     Gang He <ghe@suse.com>, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, akpm@linux-foundation.org
Subject: [PATCH 2/2] ocfs2: add locking filter debugfs file
Date:   Mon, 29 Apr 2019 14:46:13 +0800
Message-Id: <20190429064613.29365-2-ghe@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190429064613.29365-1-ghe@suse.com>
References: <20190429064613.29365-1-ghe@suse.com>
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

Signed-off-by: Gang He <ghe@suse.com>
---
 fs/ocfs2/dlmglue.c | 33 +++++++++++++++++++++++++++++++++
 fs/ocfs2/ocfs2.h   |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index dccf4136f8c1..2f36fe40295c 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -3006,6 +3006,8 @@ struct ocfs2_dlm_debug *ocfs2_new_dlm_debug(void)
 	kref_init(&dlm_debug->d_refcnt);
 	INIT_LIST_HEAD(&dlm_debug->d_lockres_tracking);
 	dlm_debug->d_locking_state = NULL;
+	dlm_debug->d_locking_filter = NULL;
+	dlm_debug->d_filter_secs = 0;
 out:
 	return dlm_debug;
 }
@@ -3104,11 +3106,28 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
 {
 	int i;
 	char *lvb;
+	u32 now, last;
 	struct ocfs2_lock_res *lockres = v;
+	struct ocfs2_dlm_debug *dlm_debug =
+			((struct ocfs2_dlm_seq_priv *)m->private)->p_dlm_debug;
 
 	if (!lockres)
 		return -EINVAL;
 
+	now = ktime_to_timespec(ktime_get()).tv_sec;
+	if (lockres->l_lock_prmode.ls_last > lockres->l_lock_exmode.ls_last)
+		last = lockres->l_lock_prmode.ls_last;
+	else
+		last = lockres->l_lock_exmode.ls_last;
+
+	/*
+	 * Use d_filter_secs field to filter lock resources dump,
+	 * the default d_filter_secs(0) value filters nothing,
+	 * otherwise, only dump the last N seconds active lock resources.
+	 */
+	if (dlm_debug->d_filter_secs && (now - last) > dlm_debug->d_filter_secs)
+		return 0;
+
 	seq_printf(m, "0x%x\t", OCFS2_DLM_DEBUG_STR_VERSION);
 
 	if (lockres->l_type == OCFS2_LOCK_TYPE_DENTRY)
@@ -3258,6 +3277,19 @@ static int ocfs2_dlm_init_debug(struct ocfs2_super *osb)
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
+		debugfs_remove(dlm_debug->d_locking_state);
+		dlm_debug->d_locking_state = NULL;
+		goto out;
+	}
+
 	ocfs2_get_dlm_debug(dlm_debug);
 out:
 	return ret;
@@ -3269,6 +3301,7 @@ static void ocfs2_dlm_shutdown_debug(struct ocfs2_super *osb)
 
 	if (dlm_debug) {
 		debugfs_remove(dlm_debug->d_locking_state);
+		debugfs_remove(dlm_debug->d_locking_filter);
 		ocfs2_put_dlm_debug(dlm_debug);
 	}
 }
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 8efa022684f4..f4da51099889 100644
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

