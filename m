Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB790C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63AA2341F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWg3lB/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfICQRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:17:10 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:36579 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICQRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:17:09 -0400
Received: by mail-qt1-f201.google.com with SMTP id 38so19538870qtx.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x8dW1eobv46xxf8Qk5whq589HTl41TDtcRbBhNUlvgA=;
        b=iWg3lB/gimxrwQvHqRpk41oUEw7gODwiTIRgz/H8vwbj0lL3q8OSi8BSoAdngHXedF
         dAXKwG3OhxcSTjOyW7EhvMbzD+RjZeRBN/9r1WHbnhuqrluYLz2ZfZchh0ZQIkZe8uDR
         uzfopMYYCEKeaLgXtR5CQwXIMAFtITmme2uKVVGSzGvrrAlgyUhO3CXulS6wuSqImeiS
         e1yLYAp1v9fj6UtLOIEAgpsyQgq3CZ1ETjmbmw8yvso675rj1S7SPR2BoBMjR0mae/dB
         MC3A1XqFwMU8PAq0U6FvJNp/+diNM54GF0nen3rwnURcGAO8DljeBPkhd2p36zuC056B
         83vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x8dW1eobv46xxf8Qk5whq589HTl41TDtcRbBhNUlvgA=;
        b=saOQESANyDSd130RLl4GY8DMM85Ij62E/HVhFckb0Iz86TX1mG/c+S2kTSUjXcOqoT
         mpBr2Ibl6DM04QtuJfBbqUuNUwIkbgpZ5sAXZB7XmhxSSwSiiEv1OSoPVwV4U2BKJjUC
         m6i/vCcRoMW8kgIpSzAoqe4QClU3ASVKoxjrtx9JPaIKUHEGaHsN2lhKfwp3Rd8PEtep
         IYtvhspBgUJY7QKMXcClsMONr5QSYqDkxvz6HcK1+nzQq2hyr69nbhqlSsimbnjOKj8I
         k8QNb1Y0v1X8oj65U6GMZ7RZCCW3t1QDe5I1uwa93G2tHgmIEIeRfBWY+xKZURSSNwiu
         DBsA==
X-Gm-Message-State: APjAAAUkKnEbH1XksE8nL8QxBodncqLojOc7STTTcNTyLcxW+8Tqg8sf
        rhrMzDln4x+SFfQ2RDtvaU4jqGM7+Wk=
X-Google-Smtp-Source: APXvYqxpd18NioTuSph+EA39tRdWN/I2DGfd/t9Lk3BvoJHxqi6SkdTNtXpyYMsvCmuaTOmOz5MuQB2qM/w=
X-Received: by 2002:a0c:9638:: with SMTP id 53mr18528892qvx.13.1567527428298;
 Tue, 03 Sep 2019 09:17:08 -0700 (PDT)
Date:   Tue,  3 Sep 2019 09:16:52 -0700
In-Reply-To: <20190903161655.107408-1-hridya@google.com>
Message-Id: <20190903161655.107408-2-hridya@google.com>
Mime-Version: 1.0
References: <20190903161655.107408-1-hridya@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 1/4] binder: add a mount option to show global stats
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

Currently, all binder state and statistics live in debugfs.
We need this information even when debugfs is not mounted.
This patch adds the mount option 'stats' to enable a binderfs
instance to have binder debug information present in the same.
'stats=global' will enable the global binder statistics. In
the future, 'stats=local' will enable binder statistics local
to the binderfs instance. The two modes 'global' and 'local'
will be mutually exclusive. 'stats=global' option is only available
for a binderfs instance mounted in the initial user namespace.
An attempt to use the option to mount a binderfs instance in
another user namespace will return an EPERM error.

Signed-off-by: Hridya Valsaraju <hridya@google.com>
---

 Changes in v2:
 - Improve error check in binderfs_parse_mount_opts() as per Greg
   Kroah-Hartman.
 - Change pr_info() log before failure to pr_err() as per Greg
   Kroah-Hartman.

 drivers/android/binderfs.c | 45 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index cc2e71576396..7045bfe5b52b 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -51,18 +51,27 @@ static DEFINE_IDA(binderfs_minors);
 /**
  * binderfs_mount_opts - mount options for binderfs
  * @max: maximum number of allocatable binderfs binder devices
+ * @stats_mode: enable binder stats in binderfs.
  */
 struct binderfs_mount_opts {
 	int max;
+	int stats_mode;
 };
 
 enum {
 	Opt_max,
+	Opt_stats_mode,
 	Opt_err
 };
 
+enum binderfs_stats_mode {
+	STATS_NONE,
+	STATS_GLOBAL,
+};
+
 static const match_table_t tokens = {
 	{ Opt_max, "max=%d" },
+	{ Opt_stats_mode, "stats=%s" },
 	{ Opt_err, NULL     }
 };
 
@@ -290,8 +299,9 @@ static void binderfs_evict_inode(struct inode *inode)
 static int binderfs_parse_mount_opts(char *data,
 				     struct binderfs_mount_opts *opts)
 {
-	char *p;
+	char *p, *stats;
 	opts->max = BINDERFS_MAX_MINOR;
+	opts->stats_mode = STATS_NONE;
 
 	while ((p = strsep(&data, ",")) != NULL) {
 		substring_t args[MAX_OPT_ARGS];
@@ -311,6 +321,22 @@ static int binderfs_parse_mount_opts(char *data,
 
 			opts->max = max_devices;
 			break;
+		case Opt_stats_mode:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EINVAL;
+
+			stats = match_strdup(&args[0]);
+			if (!stats)
+				return -ENOMEM;
+
+			if (strcmp(stats, "global") != 0) {
+				kfree(stats);
+				return -EINVAL;
+			}
+
+			opts->stats_mode = STATS_GLOBAL;
+			kfree(stats);
+			break;
 		default:
 			pr_err("Invalid mount options\n");
 			return -EINVAL;
@@ -322,8 +348,21 @@ static int binderfs_parse_mount_opts(char *data,
 
 static int binderfs_remount(struct super_block *sb, int *flags, char *data)
 {
+	int prev_stats_mode, ret;
 	struct binderfs_info *info = sb->s_fs_info;
-	return binderfs_parse_mount_opts(data, &info->mount_opts);
+
+	prev_stats_mode = info->mount_opts.stats_mode;
+	ret = binderfs_parse_mount_opts(data, &info->mount_opts);
+	if (ret)
+		return ret;
+
+	if (prev_stats_mode != info->mount_opts.stats_mode) {
+		pr_err("Binderfs stats mode cannot be changed during a remount\n");
+		info->mount_opts.stats_mode = prev_stats_mode;
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int binderfs_show_mount_opts(struct seq_file *seq, struct dentry *root)
@@ -333,6 +372,8 @@ static int binderfs_show_mount_opts(struct seq_file *seq, struct dentry *root)
 	info = root->d_sb->s_fs_info;
 	if (info->mount_opts.max <= BINDERFS_MAX_MINOR)
 		seq_printf(seq, ",max=%d", info->mount_opts.max);
+	if (info->mount_opts.stats_mode == STATS_GLOBAL)
+		seq_printf(seq, ",stats=global");
 
 	return 0;
 }
-- 
2.23.0.187.g17f5b7556c-goog

