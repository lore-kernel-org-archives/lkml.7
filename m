Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559A1C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFA7208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHO13PhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfH2VTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:19:04 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:46940 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfH2VTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:19:03 -0400
Received: by mail-pl1-f201.google.com with SMTP id k9so2726982pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=km1Ous4mqVOOKLZ9m/RRjHFgWBEtlWMoKP9Vl8ohW5c=;
        b=BHO13PhN7rNxNnPgQz2pSPKwRraOzVWIqkEmW3bChL6O8vI7BOrS8hdMdfD6V/62fr
         Kg8VRLrGJ8zrP8O5m7QHJORtDhR/MCUwTPixOXyElkoZKkdU0SxceVDplYKAcQTT0FGs
         Wqra6d11fM686isUB+pr3FpUDrFTqQHJweYdSINBUVlb7KWc+3Gef5J5q7n4spBTfcpb
         yAfLrswNQoXAQ2krCxxdNzN8PD99crT1MgN0WUO82nyaN7GN3+/UfMq31zc8emRqRDlL
         YgBhNuXRmYIHPXvBnLMjHOvc/rgg4zhXLVY7Lul2lvu96fmhKWEeYPc/tkP8xUxk9sFM
         iZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=km1Ous4mqVOOKLZ9m/RRjHFgWBEtlWMoKP9Vl8ohW5c=;
        b=iuESGAwOp1z8pG4xQGYzJ/fOmmaHPZgWTSVRZ79WikBeW/WgjjowGRgK35mT89RGfm
         7fVE1BiUD0v1FXhE65wtxDKuAR9ZE7h+oKUkoMj4O8v9Pq8ACuY3GUSmYCYK/F5knFg3
         eYRdo04tLEOby2kcBGyJgsI6TTd1BJtoKQE1Lxlc9zVU8gkDkoiVWhEA0MgeMJy/iwOR
         Qm2VFHXjKb9nu2j05B0XD6mbPmT+LqblVzASESer5aRDG7V9LQo2+JnhksB9IFS2Mpqx
         LuZaEt9LAQ5UQsM/DEtm3w9NMAZE6QBH0VgQRDk6UcBZKoQRXmxVtyLKvNPjZy69sOO5
         Q6RA==
X-Gm-Message-State: APjAAAU6OpdcKT5hhMweF2Wl5fcoA8u9w0wpwnyn59UnLqRNiUv14LEA
        BufLvnEaMji7yZLbL5JrjOtfUdTAQH8=
X-Google-Smtp-Source: APXvYqxAKgBqmvswnNdGXP1qJ+JkPBPdnvKO43P65lLDCO00DS5uCr+9ljdlzvjbEDCURCKp92jI5ycfpXM=
X-Received: by 2002:a65:68cd:: with SMTP id k13mr10095651pgt.411.1567113542312;
 Thu, 29 Aug 2019 14:19:02 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:18:12 -0700
In-Reply-To: <20190829211812.32520-1-hridya@google.com>
Message-Id: <20190829211812.32520-5-hridya@google.com>
Mime-Version: 1.0
References: <20190829211812.32520-1-hridya@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 4/4] binder: Add binder_proc logging to binderfs
From:   Hridya Valsaraju <hridya@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Hridya Valsaraju <hridya@google.com>
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
index 1715e72ce9c7..d6b50fe38218 100644
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

