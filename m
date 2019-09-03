Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81E9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DD52341F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lTAZXOgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfICQRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:17:23 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37517 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbfICQRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:17:23 -0400
Received: by mail-pf1-f201.google.com with SMTP id g1so11160459pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tc/6xMPOCODwRQXDXZAoTlmv4xWMQW8Z9gvcPjz67M4=;
        b=lTAZXOgpGkvRdf2QtU7Dd6EA9vbYF2IfuaWXOztXlj1jh/75qYj23OyU7S7wPjzfO/
         YSo86389nXkR3mXa/Vcr8Wi8/ZoF0/FtknGDVj0lbR3sEyOiqyikbuqTCwTJiqsPrzN+
         1yV8ishQwvXVk6zeUJpBqgLpcbkCmR9fNkMMMJriN3yzQC59NRtmkDvsznAPP1sJMrL3
         Vkn7hdjrS4HA33eNjL/nTFip67N7/KYXJRF65sgaRewIbioCByRQLWKDQGM8wu/rbamU
         yHf6MpeYmEceSBoDJe1IaAxsvXbWvWXF/0lulMO6KPSA61DL4UWbz1vOKmiwDQaMauXc
         GtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tc/6xMPOCODwRQXDXZAoTlmv4xWMQW8Z9gvcPjz67M4=;
        b=GXZ9ZtUeJi6OgjXK8dPPb6DGnOQUwXBdu/9Gewwn3zcw2B/0Mz1wQ3/gfYImeQUaOP
         xIQTIq/F8n95jiqF/FPC0umBXjp7mTODsAFWkGNUX+jNZhvB5XuU507mmIeNpdeBNDUV
         ubYY4K0P9z/nf76oXFY0v0/eTiHNniN+o+aiassIP9dO173p9FdVo0DuSvDu7D9s3GsS
         WN5v/fvuq75JvF2hpPSUEpRe8iPBpzRsihpylDY5WCe4HsAAuXEg0Nt1IBk+vsDRfi6y
         7swiiXi6NAYCxUKfcPaXy7Q1/XegMQdw6hIXQ+rHp+7ji038cLzV0GR4GW7JU6SyW5Rn
         VpWg==
X-Gm-Message-State: APjAAAXnDt8lcAljfEqDaOpiw9PPEDdyf+SxZqG75UiDEn7MGvU0c+Vz
        A9I3KStpmE/0ebE+BPj4s8pnrV2xs0I=
X-Google-Smtp-Source: APXvYqw1I3Tb80s9BnFuyPOltUSVFy5vVU6HeDCnUUMVJ+bsz0OWK/ev+zwinCIAr5kPBiHbPlDlb1oE5hM=
X-Received: by 2002:a63:4823:: with SMTP id v35mr31056905pga.138.1567527441827;
 Tue, 03 Sep 2019 09:17:21 -0700 (PDT)
Date:   Tue,  3 Sep 2019 09:16:55 -0700
In-Reply-To: <20190903161655.107408-1-hridya@google.com>
Message-Id: <20190903161655.107408-5-hridya@google.com>
Mime-Version: 1.0
References: <20190903161655.107408-1-hridya@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 4/4] binder: Add binder_proc logging to binderfs
From:   Hridya Valsaraju <hridya@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Hridya Valsaraju <hridya@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently /sys/kernel/debug/binder/proc contains
the debug data for every binder_proc instance.
This patch makes this information also available
in a binderfs instance mounted with a mount option
"stats=global" in addition to debugfs. The patch does
not affect the presence of the file in debugfs.

If a binderfs instance is mounted at path /dev/binderfs,
this file would be present at /dev/binderfs/binder_logs/proc.
This change provides an alternate way to access this file when debugfs
is not mounted.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Hridya Valsaraju <hridya@google.com>
---

 Changes in v2:
 - Consistent variable naming across functions as per Christian
 Brauner.
 - As suggested by Todd Kjos, log a failure to create a
   process-specific binderfs log file if the error code is not EEXIST
   since an error code of EEXIST is expected if
   multiple contexts of the same process try to create the file during
   binder_open().

 drivers/android/binder.c          | 46 ++++++++++++++++++++-
 drivers/android/binder_internal.h | 46 +++++++++++++++++++++
 drivers/android/binderfs.c        | 68 ++++++++++++++-----------------
 3 files changed, 121 insertions(+), 39 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bed217310197..ee610ea48309 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -481,6 +481,7 @@ struct binder_priority {
  * @inner_lock:           can nest under outer_lock and/or node lock
  * @outer_lock:           no nesting under innor or node lock
  *                        Lock order: 1) outer, 2) node, 3) inner
+ * @binderfs_entry:       process-specific binderfs log file
  *
  * Bookkeeping structure for binder processes
  */
@@ -510,6 +511,7 @@ struct binder_proc {
 	struct binder_context *context;
 	spinlock_t inner_lock;
 	spinlock_t outer_lock;
+	struct dentry *binderfs_entry;
 };
 
 enum {
@@ -5347,6 +5349,8 @@ static int binder_open(struct inode *nodp, struct file *filp)
 {
 	struct binder_proc *proc;
 	struct binder_device *binder_dev;
+	struct binderfs_info *info;
+	struct dentry *binder_binderfs_dir_entry_proc = NULL;
 
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE, "%s: %d:%d\n", __func__,
 		     current->group_leader->pid, current->pid);
@@ -5368,11 +5372,14 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	}
 
 	/* binderfs stashes devices in i_private */
-	if (is_binderfs_device(nodp))
+	if (is_binderfs_device(nodp)) {
 		binder_dev = nodp->i_private;
-	else
+		info = nodp->i_sb->s_fs_info;
+		binder_binderfs_dir_entry_proc = info->proc_log_dir;
+	} else {
 		binder_dev = container_of(filp->private_data,
 					  struct binder_device, miscdev);
+	}
 	proc->context = &binder_dev->context;
 	binder_alloc_init(&proc->alloc);
 
@@ -5403,6 +5410,35 @@ static int binder_open(struct inode *nodp, struct file *filp)
 			&proc_fops);
 	}
 
+	if (binder_binderfs_dir_entry_proc) {
+		char strbuf[11];
+		struct dentry *binderfs_entry;
+
+		snprintf(strbuf, sizeof(strbuf), "%u", proc->pid);
+		/*
+		 * Similar to debugfs, the process specific log file is shared
+		 * between contexts. If the file has already been created for a
+		 * process, the following binderfs_create_file() call will
+		 * fail with error code EEXIST if another context of the same
+		 * process invoked binder_open(). This is ok since same as
+		 * debugfs, the log file will contain information on all
+		 * contexts of a given PID.
+		 */
+		binderfs_entry = binderfs_create_file(binder_binderfs_dir_entry_proc,
+			strbuf, &proc_fops, (void *)(unsigned long)proc->pid);
+		if (!IS_ERR(binderfs_entry)) {
+			proc->binderfs_entry = binderfs_entry;
+		} else {
+			int error;
+
+			error = PTR_ERR(binderfs_entry);
+			if (error != -EEXIST) {
+				pr_warn("Unable to create file %s in binderfs (error %d)\n",
+					strbuf, error);
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -5442,6 +5478,12 @@ static int binder_release(struct inode *nodp, struct file *filp)
 	struct binder_proc *proc = filp->private_data;
 
 	debugfs_remove(proc->debugfs_entry);
+
+	if (proc->binderfs_entry) {
+		binderfs_remove_file(proc->binderfs_entry);
+		proc->binderfs_entry = NULL;
+	}
+
 	binder_defer_work(proc, BINDER_DEFERRED_RELEASE);
 
 	return 0;
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index b9be42d9464c..bd47f7f72075 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -35,17 +35,63 @@ struct binder_device {
 	struct inode *binderfs_inode;
 };
 
+/**
+ * binderfs_mount_opts - mount options for binderfs
+ * @max: maximum number of allocatable binderfs binder devices
+ * @stats_mode: enable binder stats in binderfs.
+ */
+struct binderfs_mount_opts {
+	int max;
+	int stats_mode;
+};
+
+/**
+ * binderfs_info - information about a binderfs mount
+ * @ipc_ns:         The ipc namespace the binderfs mount belongs to.
+ * @control_dentry: This records the dentry of this binderfs mount
+ *                  binder-control device.
+ * @root_uid:       uid that needs to be used when a new binder device is
+ *                  created.
+ * @root_gid:       gid that needs to be used when a new binder device is
+ *                  created.
+ * @mount_opts:     The mount options in use.
+ * @device_count:   The current number of allocated binder devices.
+ * @proc_log_dir:   Pointer to the directory dentry containing process-specific
+ *                  logs.
+ */
+struct binderfs_info {
+	struct ipc_namespace *ipc_ns;
+	struct dentry *control_dentry;
+	kuid_t root_uid;
+	kgid_t root_gid;
+	struct binderfs_mount_opts mount_opts;
+	int device_count;
+	struct dentry *proc_log_dir;
+};
+
 extern const struct file_operations binder_fops;
 
 extern char *binder_devices_param;
 
 #ifdef CONFIG_ANDROID_BINDERFS
 extern bool is_binderfs_device(const struct inode *inode);
+extern struct dentry *binderfs_create_file(struct dentry *dir, const char *name,
+					   const struct file_operations *fops,
+					   void *data);
+extern void binderfs_remove_file(struct dentry *dentry);
 #else
 static inline bool is_binderfs_device(const struct inode *inode)
 {
 	return false;
 }
+static inline struct dentry *binderfs_create_file(struct dentry *dir,
+					   const char *name,
+					   const struct file_operations *fops,
+					   void *data)
+{
+	return NULL;
+}
+static inline void binderfs_remove_file(struct dentry *dentry) {}
 #endif
 
 #ifdef CONFIG_ANDROID_BINDERFS
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 9bb54fd3a48a..aee0b8aeff94 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -48,16 +48,6 @@ static dev_t binderfs_dev;
 static DEFINE_MUTEX(binderfs_minors_mutex);
 static DEFINE_IDA(binderfs_minors);
 
-/**
- * binderfs_mount_opts - mount options for binderfs
- * @max: maximum number of allocatable binderfs binder devices
- * @stats_mode: enable binder stats in binderfs.
- */
-struct binderfs_mount_opts {
-	int max;
-	int stats_mode;
-};
-
 enum {
 	Opt_max,
 	Opt_stats_mode,
@@ -75,27 +65,6 @@ static const match_table_t tokens = {
 	{ Opt_err, NULL     }
 };
 
-/**
- * binderfs_info - information about a binderfs mount
- * @ipc_ns:         The ipc namespace the binderfs mount belongs to.
- * @control_dentry: This records the dentry of this binderfs mount
- *                  binder-control device.
- * @root_uid:       uid that needs to be used when a new binder device is
- *                  created.
- * @root_gid:       gid that needs to be used when a new binder device is
- *                  created.
- * @mount_opts:     The mount options in use.
- * @device_count:   The current number of allocated binder devices.
- */
-struct binderfs_info {
-	struct ipc_namespace *ipc_ns;
-	struct dentry *control_dentry;
-	kuid_t root_uid;
-	kgid_t root_gid;
-	struct binderfs_mount_opts mount_opts;
-	int device_count;
-};
-
 static inline struct binderfs_info *BINDERFS_I(const struct inode *inode)
 {
 	return inode->i_sb->s_fs_info;
@@ -533,10 +502,24 @@ static struct dentry *binderfs_create_dentry(struct dentry *parent,
 	return dentry;
 }
 
-static struct dentry *binderfs_create_file(struct dentry *parent,
-					   const char *name,
-					   const struct file_operations *fops,
-					   void *data)
+void binderfs_remove_file(struct dentry *dentry)
+{
+	struct inode *parent_inode;
+
+	parent_inode = d_inode(dentry->d_parent);
+	inode_lock(parent_inode);
+	if (simple_positive(dentry)) {
+		dget(dentry);
+		simple_unlink(parent_inode, dentry);
+		d_delete(dentry);
+		dput(dentry);
+	}
+	inode_unlock(parent_inode);
+}
+
+struct dentry *binderfs_create_file(struct dentry *parent, const char *name,
+				    const struct file_operations *fops,
+				    void *data)
 {
 	struct dentry *dentry;
 	struct inode *new_inode, *parent_inode;
@@ -604,7 +587,8 @@ static struct dentry *binderfs_create_dir(struct dentry *parent,
 
 static int init_binder_logs(struct super_block *sb)
 {
-	struct dentry *binder_logs_root_dir, *dentry;
+	struct dentry *binder_logs_root_dir, *dentry, *proc_log_dir;
+	struct binderfs_info *info;
 	int ret = 0;
 
 	binder_logs_root_dir = binderfs_create_dir(sb->s_root,
@@ -648,8 +632,18 @@ static int init_binder_logs(struct super_block *sb)
 				      "failed_transaction_log",
 				      &binder_transaction_log_fops,
 				      &binder_transaction_log_failed);
-	if (IS_ERR(dentry))
+	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	proc_log_dir = binderfs_create_dir(binder_logs_root_dir, "proc");
+	if (IS_ERR(proc_log_dir)) {
+		ret = PTR_ERR(proc_log_dir);
+		goto out;
+	}
+	info = sb->s_fs_info;
+	info->proc_log_dir = proc_log_dir;
 
 out:
 	return ret;
-- 
2.23.0.187.g17f5b7556c-goog

