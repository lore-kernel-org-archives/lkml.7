Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B11BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89A32189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oq2JuZDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfH2VSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:18:36 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:36321 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfH2VSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:18:36 -0400
Received: by mail-qt1-f201.google.com with SMTP id 38so4870879qtx.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x8dW1eobv46xxf8Qk5whq589HTl41TDtcRbBhNUlvgA=;
        b=oq2JuZDPnrdiEZUE2201QMFcPToj3KIqIsam0bd9PtbV9C8qAhCC8foVP5ylX6dGKL
         BBWR7VUAqiKgeeKCsgQ1BKpieXF7anfbAMDMBYWPlRwQGdN5k4ShEN9Mw0kmgncqn9KI
         3t0EOOrM2ajTMkjOLBz+/g4HFjQUFoSi1FVXi10rPtdPJtcHOlVZgjAgAuLsV7qk7WJM
         8qaSNXQK/8uTVObl+Bp5exKBPfBRKP6fQrB10oPqJdP6EnqpyfywdkEd3TeR6FlLE8xu
         rfO+t2Nag8LvY+1+T1jX4NaFnZ94x/AJyebaxzxb5+d7nMGKAZLWs1a2exi4QzB9O7nu
         PqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x8dW1eobv46xxf8Qk5whq589HTl41TDtcRbBhNUlvgA=;
        b=fjTjfgNI1vSPLDzenFP8ZpYL9Ft957a304Fw5cSkRbtQl+YnfHjrvvhbQBoSvfe188
         4UMxA4OmQmT9vuZe2qOoT6KLt5Gt+PQ9HFvaZdS4XTQrgVXE7XIMXUBvVAKJjJjtMX9n
         9wJvLuhMH+iZT5nuUVnyWZjR1sSf5+mwdZTs+aWAAaIaPt+w0Gk8Pq+lGzB9QO4lPD8j
         Sxxrn2SFBxkSxNjuV1YuE1VSoA4C9o91dsY84nQYq9UnxN42tAzQOv0sdYj4jVU7B6xG
         trcssZAfq5gGghkXTzRRr31i6qT/Y8ARxh4bKcrNw9OSgDJyaCyxaQA1duIkpXM/Mc0H
         xQHg==
X-Gm-Message-State: APjAAAUegEeIEzFRiSbUtEc8s3f5ysbF4CS4Sgtt5wWBEkMoAX9dTcq1
        C5JRxow1SHikG6uHa7HsbJDUVhIxops=
X-Google-Smtp-Source: APXvYqwWd/cHbTCLORr8bpxWDL8cNzI/P4mBj8n+Rmyq6eSxJh4t92dm+nBe1eZ4szBDxYarMV/BwOpgnQ4=
X-Received: by 2002:a0c:fa89:: with SMTP id o9mr8142896qvn.165.1567113514869;
 Thu, 29 Aug 2019 14:18:34 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:18:09 -0700
In-Reply-To: <20190829211812.32520-1-hridya@google.com>
Message-Id: <20190829211812.32520-2-hridya@google.com>
Mime-Version: 1.0
References: <20190829211812.32520-1-hridya@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 1/4] binder: add a mount option to show global stats
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

