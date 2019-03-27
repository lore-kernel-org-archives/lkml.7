Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A276C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B874F204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbfC0XtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:49:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfC0XtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:49:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 892112D7FD;
        Wed, 27 Mar 2019 23:49:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA2871001DC0;
        Wed, 27 Mar 2019 23:49:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 68/68] gfs2: Convert gfs2 to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Andrew Price <anprice@redhat.com>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:49:12 +0000
Message-ID: <155373055212.7602.16380236003548782656.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 27 Mar 2019 23:49:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Price <anprice@redhat.com>

Convert gfs2 and gfs2meta to fs_context. Removes the duplicated vfs code
from gfs2_mount and instead uses the new vfs_get_block_super() before
switching the ->root to the appropriate dentry.

The mount option parsing has been converted to the new API and error
reporting for invalid options has been made more precise at the same
time.

All of the mount/remount code has been moved into ops_fstype.c

Signed-off-by: Andrew Price <anprice@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: cluster-devel@redhat.com
---

 fs/gfs2/incore.h     |    8 -
 fs/gfs2/ops_fstype.c |  495 ++++++++++++++++++++++++++++++++++++++------------
 fs/gfs2/super.c      |  335 ----------------------------------
 fs/gfs2/super.h      |    3 
 4 files changed, 382 insertions(+), 459 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index cdf07b408f54..10febb298da5 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -587,10 +587,10 @@ struct gfs2_args {
 	unsigned int ar_rgrplvb:1;		/* use lvbs for rgrp info */
 	unsigned int ar_loccookie:1;		/* use location based readdir
 						   cookies */
-	int ar_commit;				/* Commit interval */
-	int ar_statfs_quantum;			/* The fast statfs interval */
-	int ar_quota_quantum;			/* The quota interval */
-	int ar_statfs_percent;			/* The % change to force sync */
+	s32 ar_commit;				/* Commit interval */
+	s32 ar_statfs_quantum;			/* The fast statfs interval */
+	s32 ar_quota_quantum;			/* The quota interval */
+	s32 ar_statfs_percent;			/* The % change to force sync */
 };
 
 struct gfs2_tune {
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index b041cb8ae383..8e8d624170a1 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -24,6 +24,7 @@
 #include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/backing-dev.h>
+#include <linux/fs_parser.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -1024,16 +1025,17 @@ void gfs2_online_uevent(struct gfs2_sbd *sdp)
 }
 
 /**
- * fill_super - Read in superblock
+ * gfs2_fill_super - Read in superblock
  * @sb: The VFS superblock
- * @data: Mount options
+ * @args: Mount options
  * @silent: Don't complain if it's not a GFS2 filesystem
  *
- * Returns: errno
+ * Returns: -errno
  */
-
-static int fill_super(struct super_block *sb, struct gfs2_args *args, int silent)
+static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct gfs2_args *args = fc->fs_private;
+	int silent = fc->sb_flags & SB_SILENT;
 	struct gfs2_sbd *sdp;
 	struct gfs2_holder mount_gh;
 	int error;
@@ -1200,161 +1202,415 @@ static int fill_super(struct super_block *sb, struct gfs2_args *args, int silent
 	return error;
 }
 
-static int set_gfs2_super(struct super_block *s, void *data)
+/**
+ * gfs2_get_tree - Get the GFS2 superblock and root directory
+ * @fc: The filesystem context
+ *
+ * Returns: 0 or -errno on error
+ */
+static int gfs2_get_tree(struct fs_context *fc)
 {
-	s->s_bdev = data;
-	s->s_dev = s->s_bdev->bd_dev;
-	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
+	struct gfs2_args *args = fc->fs_private;
+	struct gfs2_sbd *sdp;
+	int error;
+
+	error = vfs_get_block_super(fc, gfs2_fill_super);
+	if (error)
+		return error;
+
+	sdp = fc->root->d_sb->s_fs_info;
+	dput(fc->root);
+	if (args->ar_meta)
+		fc->root = dget(sdp->sd_master_dir);
+	else
+		fc->root = dget(sdp->sd_root_dir);
 	return 0;
 }
 
-static int test_gfs2_super(struct super_block *s, void *ptr)
+static void gfs2_fc_free(struct fs_context *fc)
 {
-	struct block_device *bdev = ptr;
-	return (bdev == s->s_bdev);
+	struct gfs2_args *args = fc->fs_private;
+
+	kfree(args);
 }
 
-/**
- * gfs2_mount - Get the GFS2 superblock
- * @fs_type: The GFS2 filesystem type
- * @flags: Mount flags
- * @dev_name: The name of the device
- * @data: The mount arguments
- *
- * Q. Why not use get_sb_bdev() ?
- * A. We need to select one of two root directories to mount, independent
- *    of whether this is the initial, or subsequent, mount of this sb
- *
- * Returns: 0 or -ve on error
- */
+enum gfs2_param {
+	Opt_lockproto,
+	Opt_locktable,
+	Opt_hostdata,
+	Opt_spectator,
+	Opt_ignore_local_fs,
+	Opt_localflocks,
+	Opt_localcaching,
+	Opt_debug,
+	Opt_upgrade,
+	Opt_acl,
+	Opt_quota,
+	Opt_suiddir,
+	Opt_data,
+	Opt_meta,
+	Opt_discard,
+	Opt_commit,
+	Opt_errors,
+	Opt_statfs_quantum,
+	Opt_statfs_percent,
+	Opt_quota_quantum,
+	Opt_barrier,
+	Opt_rgrplvb,
+	Opt_loccookie,
+};
+
+enum opt_quota {
+	Opt_quota_unset = 0,
+	Opt_quota_off,
+	Opt_quota_account,
+	Opt_quota_on,
+};
+
+static const unsigned int opt_quota_values[] = {
+	[Opt_quota_off]     = GFS2_QUOTA_OFF,
+	[Opt_quota_account] = GFS2_QUOTA_ACCOUNT,
+	[Opt_quota_on]      = GFS2_QUOTA_ON,
+};
+
+enum opt_data {
+	Opt_data_writeback = GFS2_DATA_WRITEBACK,
+	Opt_data_ordered   = GFS2_DATA_ORDERED,
+};
+
+enum opt_errors {
+	Opt_errors_withdraw = GFS2_ERRORS_WITHDRAW,
+	Opt_errors_panic    = GFS2_ERRORS_PANIC,
+};
 
-static struct dentry *gfs2_mount(struct file_system_type *fs_type, int flags,
-		       const char *dev_name, void *data)
+static const struct fs_parameter_spec gfs2_param_specs[] = {
+	fsparam_string ("lockproto",          Opt_lockproto),
+	fsparam_string ("locktable",          Opt_locktable),
+	fsparam_string ("hostdata",           Opt_hostdata),
+	fsparam_flag   ("spectator",          Opt_spectator),
+	fsparam_flag   ("norecovery",         Opt_spectator),
+	fsparam_flag   ("ignore_local_fs",    Opt_ignore_local_fs),
+	fsparam_flag   ("localflocks",        Opt_localflocks),
+	fsparam_flag   ("localcaching",       Opt_localcaching),
+	fsparam_flag_no("debug",              Opt_debug),
+	fsparam_flag   ("upgrade",            Opt_upgrade),
+	fsparam_flag_no("acl",                Opt_acl),
+	fsparam_flag_no("suiddir",            Opt_suiddir),
+	fsparam_enum   ("data",               Opt_data),
+	fsparam_flag   ("meta",               Opt_meta),
+	fsparam_flag_no("discard",            Opt_discard),
+	fsparam_s32    ("commit",             Opt_commit),
+	fsparam_enum   ("errors",             Opt_errors),
+	fsparam_s32    ("statfs_quantum",     Opt_statfs_quantum),
+	fsparam_s32    ("statfs_percent",     Opt_statfs_percent),
+	fsparam_s32    ("quota_quantum",      Opt_quota_quantum),
+	fsparam_flag_no("barrier",            Opt_barrier),
+	fsparam_flag_no("rgrplvb",            Opt_rgrplvb),
+	fsparam_flag_no("loccookie",          Opt_loccookie),
+	/* quota can be a flag or an enum so it gets special treatment */
+	__fsparam(fs_param_is_enum, "quota", Opt_quota, fs_param_neg_with_no|fs_param_v_optional),
+	{}
+};
+
+static const struct fs_parameter_enum gfs2_param_enums[] = {
+	{ Opt_quota,    "off",        Opt_quota_off },
+	{ Opt_quota,    "account",    Opt_quota_account },
+	{ Opt_quota,    "on",         Opt_quota_on },
+	{ Opt_data,     "writeback",  Opt_data_writeback },
+	{ Opt_data,     "ordered",    Opt_data_ordered },
+	{ Opt_errors,   "withdraw",   Opt_errors_withdraw },
+	{ Opt_errors,   "panic",      Opt_errors_panic },
+	{}
+};
+
+const struct fs_parameter_description gfs2_fs_parameters = {
+	.name = "gfs2",
+	.specs = gfs2_param_specs,
+	.enums = gfs2_param_enums,
+};
+
+/* Parse a single mount parameter */
+static int gfs2_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	struct block_device *bdev;
-	struct super_block *s;
-	fmode_t mode = FMODE_READ | FMODE_EXCL;
+	struct gfs2_args *args = fc->fs_private;
+	struct fs_parse_result result;
+	int o;
+
+	o = fs_parse(fc, &gfs2_fs_parameters, param, &result);
+	if (o < 0)
+		return o;
+
+	switch (o) {
+	case Opt_lockproto:
+		strlcpy(args->ar_lockproto, param->string, GFS2_LOCKNAME_LEN);
+		break;
+	case Opt_locktable:
+		strlcpy(args->ar_locktable, param->string, GFS2_LOCKNAME_LEN);
+		break;
+	case Opt_hostdata:
+		strlcpy(args->ar_hostdata, param->string, GFS2_LOCKNAME_LEN);
+		break;
+	case Opt_spectator:
+		args->ar_spectator = 1;
+		break;
+	case Opt_ignore_local_fs:
+		/* Retained for backwards compat only */
+		break;
+	case Opt_localflocks:
+		args->ar_localflocks = 1;
+		break;
+	case Opt_localcaching:
+		/* Retained for backwards compat only */
+		break;
+	case Opt_debug:
+		if (result.boolean && args->ar_errors == GFS2_ERRORS_PANIC)
+			return invalf(fc, "gfs2: -o debug and -o errors=panic are mutually exclusive");
+		args->ar_debug = result.boolean;
+		break;
+	case Opt_upgrade:
+		/* Retained for backwards compat only */
+		break;
+	case Opt_acl:
+		args->ar_posix_acl = result.boolean;
+		break;
+	case Opt_quota:
+		/* The quota option can be a flag or an enum. A non-zero int_32
+		   result means that we have an enum index. Otherwise we have
+		   to rely on the 'negated' flag to tell us whether 'quota' or
+		   'noquota' was specified. */
+		if (result.negated)
+			args->ar_quota = GFS2_QUOTA_OFF;
+		else if (result.int_32 > 0)
+			args->ar_quota = opt_quota_values[result.int_32];
+		else
+			args->ar_quota = GFS2_QUOTA_ON;
+		break;
+	case Opt_suiddir:
+		args->ar_suiddir = result.boolean;
+		break;
+	case Opt_data:
+		/* The uint_32 result maps directly to GFS2_DATA_* */
+		args->ar_data = result.uint_32;
+		break;
+	case Opt_meta:
+		args->ar_meta = 1;
+		break;
+	case Opt_discard:
+		args->ar_discard = result.boolean;
+		break;
+	case Opt_commit:
+		if (result.int_32 <= 0)
+			return invalf(fc, "gfs2: commit mount option requires a positive numeric argument");
+		args->ar_commit = result.int_32;
+		break;
+	case Opt_statfs_quantum:
+		if (result.int_32 < 0)
+			return invalf(fc, "gfs2: statfs_quantum mount option requires a non-negative numeric argument");
+		args->ar_statfs_quantum = result.int_32;
+		break;
+	case Opt_quota_quantum:
+		if (result.int_32 <= 0)
+			return invalf(fc, "gfs2: quota_quantum mount option requires a positive numeric argument");
+		args->ar_quota_quantum = result.int_32;
+		break;
+	case Opt_statfs_percent:
+		if (result.int_32 < 0 || result.int_32 > 100)
+			return invalf(fc, "gfs2: statfs_percent mount option requires a numeric argument between 0 and 100");
+		args->ar_statfs_percent = result.int_32;
+		break;
+	case Opt_errors:
+		if (args->ar_debug && result.uint_32 == GFS2_ERRORS_PANIC)
+			return invalf(fc, "gfs2: -o debug and -o errors=panic are mutually exclusive");
+		args->ar_errors = result.uint_32;
+		break;
+	case Opt_barrier:
+		args->ar_nobarrier = result.boolean;
+		break;
+	case Opt_rgrplvb:
+		args->ar_rgrplvb = result.boolean;
+		break;
+	case Opt_loccookie:
+		args->ar_loccookie = result.boolean;
+		break;
+	default:
+		return invalf(fc, "gfs2: invalid mount option: %s", param->key);
+	}
+	return 0;
+}
+
+static int gfs2_reconfigure(struct fs_context *fc)
+{
+	struct super_block *sb = fc->root->d_sb;
+	struct gfs2_sbd *sdp = sb->s_fs_info;
+	struct gfs2_args *oldargs = &sdp->sd_args;
+	struct gfs2_args *newargs = fc->fs_private;
+	struct gfs2_tune *gt = &sdp->sd_tune;
 	int error;
-	struct gfs2_args args;
-	struct gfs2_sbd *sdp;
 
-	if (!(flags & SB_RDONLY))
-		mode |= FMODE_WRITE;
+	sync_filesystem(sb);
 
-	bdev = blkdev_get_by_path(dev_name, mode, fs_type);
-	if (IS_ERR(bdev))
-		return ERR_CAST(bdev);
+	spin_lock(&gt->gt_spin);
+	oldargs->ar_commit = gt->gt_logd_secs;
+	oldargs->ar_quota_quantum = gt->gt_quota_quantum;
+	if (gt->gt_statfs_slow)
+		oldargs->ar_statfs_quantum = 0;
+	else
+		oldargs->ar_statfs_quantum = gt->gt_statfs_quantum;
+	spin_unlock(&gt->gt_spin);
 
-	/*
-	 * once the super is inserted into the list by sget, s_umount
-	 * will protect the lockfs code from trying to start a snapshot
-	 * while we are mounting
-	 */
-	mutex_lock(&bdev->bd_fsfreeze_mutex);
-	if (bdev->bd_fsfreeze_count > 0) {
-		mutex_unlock(&bdev->bd_fsfreeze_mutex);
-		error = -EBUSY;
-		goto error_bdev;
+	if (strcmp(newargs->ar_lockproto, oldargs->ar_lockproto)) {
+		errorf(fc, "gfs2: reconfiguration of locking protocol not allowed");
+		return -EINVAL;
 	}
-	s = sget(fs_type, test_gfs2_super, set_gfs2_super, flags, bdev);
-	mutex_unlock(&bdev->bd_fsfreeze_mutex);
-	error = PTR_ERR(s);
-	if (IS_ERR(s))
-		goto error_bdev;
-
-	if (s->s_root) {
-		/*
-		 * s_umount nests inside bd_mutex during
-		 * __invalidate_device().  blkdev_put() acquires
-		 * bd_mutex and can't be called under s_umount.  Drop
-		 * s_umount temporarily.  This is safe as we're
-		 * holding an active reference.
-		 */
-		up_write(&s->s_umount);
-		blkdev_put(bdev, mode);
-		down_write(&s->s_umount);
-	} else {
-		/* s_mode must be set before deactivate_locked_super calls */
-		s->s_mode = mode;
+	if (strcmp(newargs->ar_locktable, oldargs->ar_locktable)) {
+		errorf(fc, "gfs2: reconfiguration of lock table not allowed");
+		return -EINVAL;
 	}
-
-	memset(&args, 0, sizeof(args));
-	args.ar_quota = GFS2_QUOTA_DEFAULT;
-	args.ar_data = GFS2_DATA_DEFAULT;
-	args.ar_commit = 30;
-	args.ar_statfs_quantum = 30;
-	args.ar_quota_quantum = 60;
-	args.ar_errors = GFS2_ERRORS_DEFAULT;
-
-	error = gfs2_mount_args(&args, data);
-	if (error) {
-		pr_warn("can't parse mount arguments\n");
-		goto error_super;
+	if (strcmp(newargs->ar_hostdata, oldargs->ar_hostdata)) {
+		errorf(fc, "gfs2: reconfiguration of host data not allowed");
+		return -EINVAL;
 	}
+	if (newargs->ar_spectator != oldargs->ar_spectator) {
+		errorf(fc, "gfs2: reconfiguration of spectator mode not allowed");
+		return -EINVAL;
+	}
+	if (newargs->ar_localflocks != oldargs->ar_localflocks) {
+		errorf(fc, "gfs2: reconfiguration of localflocks not allowed");
+		return -EINVAL;
+	}
+	if (newargs->ar_meta != oldargs->ar_meta) {
+		errorf(fc, "gfs2: switching between gfs2 and gfs2meta not allowed");
+		return -EINVAL;
+	}
+	if (oldargs->ar_spectator)
+		fc->sb_flags |= SB_RDONLY;
 
-	if (s->s_root) {
-		error = -EBUSY;
-		if ((flags ^ s->s_flags) & SB_RDONLY)
-			goto error_super;
-	} else {
-		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
-		sb_set_blocksize(s, block_size(bdev));
-		error = fill_super(s, &args, flags & SB_SILENT ? 1 : 0);
-		if (error)
-			goto error_super;
-		s->s_flags |= SB_ACTIVE;
-		bdev->bd_super = s;
+	if ((sb->s_flags ^ fc->sb_flags) & SB_RDONLY) {
+		if (fc->sb_flags & SB_RDONLY) {
+			error = gfs2_make_fs_ro(sdp);
+			if (error) {
+				errorf(fc, "gfs2: unable to remount read-only");
+				return error;
+			}
+		} else {
+			error = gfs2_make_fs_rw(sdp);
+			if (error) {
+				errorf(fc, "gfs2: unable to remount read-write");
+				return error;
+			}
+		}
 	}
+	sdp->sd_args = *newargs;
 
-	sdp = s->s_fs_info;
-	if (args.ar_meta)
-		return dget(sdp->sd_master_dir);
+	if (sdp->sd_args.ar_posix_acl)
+		sb->s_flags |= SB_POSIXACL;
+	else
+		sb->s_flags &= ~SB_POSIXACL;
+	if (sdp->sd_args.ar_nobarrier)
+		set_bit(SDF_NOBARRIERS, &sdp->sd_flags);
 	else
-		return dget(sdp->sd_root_dir);
-
-error_super:
-	deactivate_locked_super(s);
-	return ERR_PTR(error);
-error_bdev:
-	blkdev_put(bdev, mode);
-	return ERR_PTR(error);
+		clear_bit(SDF_NOBARRIERS, &sdp->sd_flags);
+	spin_lock(&gt->gt_spin);
+	gt->gt_logd_secs = newargs->ar_commit;
+	gt->gt_quota_quantum = newargs->ar_quota_quantum;
+	if (newargs->ar_statfs_quantum) {
+		gt->gt_statfs_slow = 0;
+		gt->gt_statfs_quantum = newargs->ar_statfs_quantum;
+	}
+	else {
+		gt->gt_statfs_slow = 1;
+		gt->gt_statfs_quantum = 30;
+	}
+	spin_unlock(&gt->gt_spin);
+
+	gfs2_online_uevent(sdp);
+	return 0;
+}
+
+static const struct fs_context_operations gfs2_context_ops = {
+	.free        = gfs2_fc_free,
+	.parse_param = gfs2_parse_param,
+	.get_tree    = gfs2_get_tree,
+	.reconfigure = gfs2_reconfigure,
+};
+
+/* Set up the filesystem mount context */
+static int gfs2_init_fs_context(struct fs_context *fc)
+{
+	struct gfs2_args *args;
+
+	args = kzalloc(sizeof(*args), GFP_KERNEL);
+	if (args == NULL)
+		return -ENOMEM;
+
+	args->ar_quota = GFS2_QUOTA_DEFAULT;
+	args->ar_data = GFS2_DATA_DEFAULT;
+	args->ar_commit = 30;
+	args->ar_statfs_quantum = 30;
+	args->ar_quota_quantum = 60;
+	args->ar_errors = GFS2_ERRORS_DEFAULT;
+
+	fc->fs_private = args;
+	fc->ops = &gfs2_context_ops;
+	return 0;
 }
 
-static int set_meta_super(struct super_block *s, void *ptr)
+static int set_meta_super(struct super_block *s, struct fs_context *fc)
 {
 	return -EINVAL;
 }
 
-static struct dentry *gfs2_mount_meta(struct file_system_type *fs_type,
-			int flags, const char *dev_name, void *data)
+static int test_meta_super(struct super_block *s, struct fs_context *fc)
+{
+	return (fc->bdev == s->s_bdev);
+}
+
+static int gfs2_meta_get_tree(struct fs_context *fc)
 {
 	struct super_block *s;
 	struct gfs2_sbd *sdp;
 	struct path path;
 	int error;
 
-	if (!dev_name || !*dev_name)
-		return ERR_PTR(-EINVAL);
+	if (!fc->source || !*fc->source)
+		return -EINVAL;
 
-	error = kern_path(dev_name, LOOKUP_FOLLOW, &path);
+	error = kern_path(fc->source, LOOKUP_FOLLOW, &path);
 	if (error) {
 		pr_warn("path_lookup on %s returned error %d\n",
-			dev_name, error);
-		return ERR_PTR(error);
+		        fc->source, error);
+		return error;
 	}
-	s = sget(&gfs2_fs_type, test_gfs2_super, set_meta_super, flags,
-		 path.dentry->d_sb->s_bdev);
+	fc->fs_type = &gfs2_fs_type;
+	fc->bdev = path.dentry->d_sb->s_bdev;
+	s = sget_fc(fc, test_meta_super, set_meta_super);
 	path_put(&path);
 	if (IS_ERR(s)) {
 		pr_warn("gfs2 mount does not exist\n");
-		return ERR_CAST(s);
+		return PTR_ERR(s);
 	}
-	if ((flags ^ s->s_flags) & SB_RDONLY) {
+	if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY) {
 		deactivate_locked_super(s);
-		return ERR_PTR(-EBUSY);
+		return -EBUSY;
 	}
 	sdp = s->s_fs_info;
-	return dget(sdp->sd_master_dir);
+	fc->root = dget(sdp->sd_master_dir);
+	return 0;
+}
+
+static const struct fs_context_operations gfs2_meta_context_ops = {
+	.get_tree    = gfs2_meta_get_tree,
+};
+
+static int gfs2_meta_init_fs_context(struct fs_context *fc)
+{
+	int ret = gfs2_init_fs_context(fc);
+
+	if (ret)
+		return ret;
+
+	fc->ops = &gfs2_meta_context_ops;
+	return 0;
 }
 
 static void gfs2_kill_sb(struct super_block *sb)
@@ -1379,7 +1635,8 @@ static void gfs2_kill_sb(struct super_block *sb)
 struct file_system_type gfs2_fs_type = {
 	.name = "gfs2",
 	.fs_flags = FS_REQUIRES_DEV,
-	.mount = gfs2_mount,
+	.init_fs_context = gfs2_init_fs_context,
+	.parameters = &gfs2_fs_parameters,
 	.kill_sb = gfs2_kill_sb,
 	.owner = THIS_MODULE,
 };
@@ -1388,7 +1645,7 @@ MODULE_ALIAS_FS("gfs2");
 struct file_system_type gfs2meta_fs_type = {
 	.name = "gfs2meta",
 	.fs_flags = FS_REQUIRES_DEV,
-	.mount = gfs2_mount_meta,
+	.init_fs_context = gfs2_meta_init_fs_context,
 	.owner = THIS_MODULE,
 };
 MODULE_ALIAS_FS("gfs2meta");
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index ca71163ff7cf..18917f8ae7ea 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -46,258 +46,6 @@
 #include "sys.h"
 #include "xattr.h"
 
-#define args_neq(a1, a2, x) ((a1)->ar_##x != (a2)->ar_##x)
-
-enum {
-	Opt_lockproto,
-	Opt_locktable,
-	Opt_hostdata,
-	Opt_spectator,
-	Opt_ignore_local_fs,
-	Opt_localflocks,
-	Opt_localcaching,
-	Opt_debug,
-	Opt_nodebug,
-	Opt_upgrade,
-	Opt_acl,
-	Opt_noacl,
-	Opt_quota_off,
-	Opt_quota_account,
-	Opt_quota_on,
-	Opt_quota,
-	Opt_noquota,
-	Opt_suiddir,
-	Opt_nosuiddir,
-	Opt_data_writeback,
-	Opt_data_ordered,
-	Opt_meta,
-	Opt_discard,
-	Opt_nodiscard,
-	Opt_commit,
-	Opt_err_withdraw,
-	Opt_err_panic,
-	Opt_statfs_quantum,
-	Opt_statfs_percent,
-	Opt_quota_quantum,
-	Opt_barrier,
-	Opt_nobarrier,
-	Opt_rgrplvb,
-	Opt_norgrplvb,
-	Opt_loccookie,
-	Opt_noloccookie,
-	Opt_error,
-};
-
-static const match_table_t tokens = {
-	{Opt_lockproto, "lockproto=%s"},
-	{Opt_locktable, "locktable=%s"},
-	{Opt_hostdata, "hostdata=%s"},
-	{Opt_spectator, "spectator"},
-	{Opt_spectator, "norecovery"},
-	{Opt_ignore_local_fs, "ignore_local_fs"},
-	{Opt_localflocks, "localflocks"},
-	{Opt_localcaching, "localcaching"},
-	{Opt_debug, "debug"},
-	{Opt_nodebug, "nodebug"},
-	{Opt_upgrade, "upgrade"},
-	{Opt_acl, "acl"},
-	{Opt_noacl, "noacl"},
-	{Opt_quota_off, "quota=off"},
-	{Opt_quota_account, "quota=account"},
-	{Opt_quota_on, "quota=on"},
-	{Opt_quota, "quota"},
-	{Opt_noquota, "noquota"},
-	{Opt_suiddir, "suiddir"},
-	{Opt_nosuiddir, "nosuiddir"},
-	{Opt_data_writeback, "data=writeback"},
-	{Opt_data_ordered, "data=ordered"},
-	{Opt_meta, "meta"},
-	{Opt_discard, "discard"},
-	{Opt_nodiscard, "nodiscard"},
-	{Opt_commit, "commit=%d"},
-	{Opt_err_withdraw, "errors=withdraw"},
-	{Opt_err_panic, "errors=panic"},
-	{Opt_statfs_quantum, "statfs_quantum=%d"},
-	{Opt_statfs_percent, "statfs_percent=%d"},
-	{Opt_quota_quantum, "quota_quantum=%d"},
-	{Opt_barrier, "barrier"},
-	{Opt_nobarrier, "nobarrier"},
-	{Opt_rgrplvb, "rgrplvb"},
-	{Opt_norgrplvb, "norgrplvb"},
-	{Opt_loccookie, "loccookie"},
-	{Opt_noloccookie, "noloccookie"},
-	{Opt_error, NULL}
-};
-
-/**
- * gfs2_mount_args - Parse mount options
- * @args: The structure into which the parsed options will be written
- * @options: The options to parse
- *
- * Return: errno
- */
-
-int gfs2_mount_args(struct gfs2_args *args, char *options)
-{
-	char *o;
-	int token;
-	substring_t tmp[MAX_OPT_ARGS];
-	int rv;
-
-	/* Split the options into tokens with the "," character and
-	   process them */
-
-	while (1) {
-		o = strsep(&options, ",");
-		if (o == NULL)
-			break;
-		if (*o == '\0')
-			continue;
-
-		token = match_token(o, tokens, tmp);
-		switch (token) {
-		case Opt_lockproto:
-			match_strlcpy(args->ar_lockproto, &tmp[0],
-				      GFS2_LOCKNAME_LEN);
-			break;
-		case Opt_locktable:
-			match_strlcpy(args->ar_locktable, &tmp[0],
-				      GFS2_LOCKNAME_LEN);
-			break;
-		case Opt_hostdata:
-			match_strlcpy(args->ar_hostdata, &tmp[0],
-				      GFS2_LOCKNAME_LEN);
-			break;
-		case Opt_spectator:
-			args->ar_spectator = 1;
-			break;
-		case Opt_ignore_local_fs:
-			/* Retained for backwards compat only */
-			break;
-		case Opt_localflocks:
-			args->ar_localflocks = 1;
-			break;
-		case Opt_localcaching:
-			/* Retained for backwards compat only */
-			break;
-		case Opt_debug:
-			if (args->ar_errors == GFS2_ERRORS_PANIC) {
-				pr_warn("-o debug and -o errors=panic are mutually exclusive\n");
-				return -EINVAL;
-			}
-			args->ar_debug = 1;
-			break;
-		case Opt_nodebug:
-			args->ar_debug = 0;
-			break;
-		case Opt_upgrade:
-			/* Retained for backwards compat only */
-			break;
-		case Opt_acl:
-			args->ar_posix_acl = 1;
-			break;
-		case Opt_noacl:
-			args->ar_posix_acl = 0;
-			break;
-		case Opt_quota_off:
-		case Opt_noquota:
-			args->ar_quota = GFS2_QUOTA_OFF;
-			break;
-		case Opt_quota_account:
-			args->ar_quota = GFS2_QUOTA_ACCOUNT;
-			break;
-		case Opt_quota_on:
-		case Opt_quota:
-			args->ar_quota = GFS2_QUOTA_ON;
-			break;
-		case Opt_suiddir:
-			args->ar_suiddir = 1;
-			break;
-		case Opt_nosuiddir:
-			args->ar_suiddir = 0;
-			break;
-		case Opt_data_writeback:
-			args->ar_data = GFS2_DATA_WRITEBACK;
-			break;
-		case Opt_data_ordered:
-			args->ar_data = GFS2_DATA_ORDERED;
-			break;
-		case Opt_meta:
-			args->ar_meta = 1;
-			break;
-		case Opt_discard:
-			args->ar_discard = 1;
-			break;
-		case Opt_nodiscard:
-			args->ar_discard = 0;
-			break;
-		case Opt_commit:
-			rv = match_int(&tmp[0], &args->ar_commit);
-			if (rv || args->ar_commit <= 0) {
-				pr_warn("commit mount option requires a positive numeric argument\n");
-				return rv ? rv : -EINVAL;
-			}
-			break;
-		case Opt_statfs_quantum:
-			rv = match_int(&tmp[0], &args->ar_statfs_quantum);
-			if (rv || args->ar_statfs_quantum < 0) {
-				pr_warn("statfs_quantum mount option requires a non-negative numeric argument\n");
-				return rv ? rv : -EINVAL;
-			}
-			break;
-		case Opt_quota_quantum:
-			rv = match_int(&tmp[0], &args->ar_quota_quantum);
-			if (rv || args->ar_quota_quantum <= 0) {
-				pr_warn("quota_quantum mount option requires a positive numeric argument\n");
-				return rv ? rv : -EINVAL;
-			}
-			break;
-		case Opt_statfs_percent:
-			rv = match_int(&tmp[0], &args->ar_statfs_percent);
-			if (rv || args->ar_statfs_percent < 0 ||
-			    args->ar_statfs_percent > 100) {
-				pr_warn("statfs_percent mount option requires a numeric argument between 0 and 100\n");
-				return rv ? rv : -EINVAL;
-			}
-			break;
-		case Opt_err_withdraw:
-			args->ar_errors = GFS2_ERRORS_WITHDRAW;
-			break;
-		case Opt_err_panic:
-			if (args->ar_debug) {
-				pr_warn("-o debug and -o errors=panic are mutually exclusive\n");
-				return -EINVAL;
-			}
-			args->ar_errors = GFS2_ERRORS_PANIC;
-			break;
-		case Opt_barrier:
-			args->ar_nobarrier = 0;
-			break;
-		case Opt_nobarrier:
-			args->ar_nobarrier = 1;
-			break;
-		case Opt_rgrplvb:
-			args->ar_rgrplvb = 1;
-			break;
-		case Opt_norgrplvb:
-			args->ar_rgrplvb = 0;
-			break;
-		case Opt_loccookie:
-			args->ar_loccookie = 1;
-			break;
-		case Opt_noloccookie:
-			args->ar_loccookie = 0;
-			break;
-		case Opt_error:
-		default:
-			pr_warn("invalid mount option: %s\n", o);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
 /**
  * gfs2_jindex_free - Clear all the journal index information
  * @sdp: The GFS2 superblock
@@ -844,7 +592,7 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
  * Returns: errno
  */
 
-static int gfs2_make_fs_ro(struct gfs2_sbd *sdp)
+int gfs2_make_fs_ro(struct gfs2_sbd *sdp)
 {
 	struct gfs2_holder freeze_gh;
 	int error;
@@ -1223,86 +971,6 @@ static int gfs2_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-/**
- * gfs2_remount_fs - called when the FS is remounted
- * @sb:  the filesystem
- * @flags:  the remount flags
- * @data:  extra data passed in (not used right now)
- *
- * Returns: errno
- */
-
-static int gfs2_remount_fs(struct super_block *sb, int *flags, char *data)
-{
-	struct gfs2_sbd *sdp = sb->s_fs_info;
-	struct gfs2_args args = sdp->sd_args; /* Default to current settings */
-	struct gfs2_tune *gt = &sdp->sd_tune;
-	int error;
-
-	sync_filesystem(sb);
-
-	spin_lock(&gt->gt_spin);
-	args.ar_commit = gt->gt_logd_secs;
-	args.ar_quota_quantum = gt->gt_quota_quantum;
-	if (gt->gt_statfs_slow)
-		args.ar_statfs_quantum = 0;
-	else
-		args.ar_statfs_quantum = gt->gt_statfs_quantum;
-	spin_unlock(&gt->gt_spin);
-	error = gfs2_mount_args(&args, data);
-	if (error)
-		return error;
-
-	/* Not allowed to change locking details */
-	if (strcmp(args.ar_lockproto, sdp->sd_args.ar_lockproto) ||
-	    strcmp(args.ar_locktable, sdp->sd_args.ar_locktable) ||
-	    strcmp(args.ar_hostdata, sdp->sd_args.ar_hostdata))
-		return -EINVAL;
-
-	/* Some flags must not be changed */
-	if (args_neq(&args, &sdp->sd_args, spectator) ||
-	    args_neq(&args, &sdp->sd_args, localflocks) ||
-	    args_neq(&args, &sdp->sd_args, meta))
-		return -EINVAL;
-
-	if (sdp->sd_args.ar_spectator)
-		*flags |= SB_RDONLY;
-
-	if ((sb->s_flags ^ *flags) & SB_RDONLY) {
-		if (*flags & SB_RDONLY)
-			error = gfs2_make_fs_ro(sdp);
-		else
-			error = gfs2_make_fs_rw(sdp);
-		if (error)
-			return error;
-	}
-
-	sdp->sd_args = args;
-	if (sdp->sd_args.ar_posix_acl)
-		sb->s_flags |= SB_POSIXACL;
-	else
-		sb->s_flags &= ~SB_POSIXACL;
-	if (sdp->sd_args.ar_nobarrier)
-		set_bit(SDF_NOBARRIERS, &sdp->sd_flags);
-	else
-		clear_bit(SDF_NOBARRIERS, &sdp->sd_flags);
-	spin_lock(&gt->gt_spin);
-	gt->gt_logd_secs = args.ar_commit;
-	gt->gt_quota_quantum = args.ar_quota_quantum;
-	if (args.ar_statfs_quantum) {
-		gt->gt_statfs_slow = 0;
-		gt->gt_statfs_quantum = args.ar_statfs_quantum;
-	}
-	else {
-		gt->gt_statfs_slow = 1;
-		gt->gt_statfs_quantum = 30;
-	}
-	spin_unlock(&gt->gt_spin);
-
-	gfs2_online_uevent(sdp);
-	return 0;
-}
-
 /**
  * gfs2_drop_inode - Drop an inode (test for remote unlink)
  * @inode: The inode to drop
@@ -1758,7 +1426,6 @@ const struct super_operations gfs2_super_ops = {
 	.freeze_super		= gfs2_freeze,
 	.thaw_super		= gfs2_unfreeze,
 	.statfs			= gfs2_statfs,
-	.remount_fs		= gfs2_remount_fs,
 	.drop_inode		= gfs2_drop_inode,
 	.show_options		= gfs2_show_options,
 };
diff --git a/fs/gfs2/super.h b/fs/gfs2/super.h
index 73c97dccae21..b9dc2065dd72 100644
--- a/fs/gfs2/super.h
+++ b/fs/gfs2/super.h
@@ -27,8 +27,6 @@ static inline unsigned int gfs2_jindex_size(struct gfs2_sbd *sdp)
 
 extern void gfs2_jindex_free(struct gfs2_sbd *sdp);
 
-extern int gfs2_mount_args(struct gfs2_args *args, char *data);
-
 extern struct gfs2_jdesc *gfs2_jdesc_find(struct gfs2_sbd *sdp, unsigned int jid);
 extern int gfs2_jdesc_check(struct gfs2_jdesc *jd);
 
@@ -36,6 +34,7 @@ extern int gfs2_lookup_in_master_dir(struct gfs2_sbd *sdp, char *filename,
 				     struct gfs2_inode **ipp);
 
 extern int gfs2_make_fs_rw(struct gfs2_sbd *sdp);
+extern int gfs2_make_fs_ro(struct gfs2_sbd *sdp);
 extern void gfs2_online_uevent(struct gfs2_sbd *sdp);
 extern int gfs2_statfs_init(struct gfs2_sbd *sdp);
 extern void gfs2_statfs_change(struct gfs2_sbd *sdp, s64 total, s64 free,

