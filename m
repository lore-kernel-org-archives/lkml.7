Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C95C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643A620656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIf+XNYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfH0UmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:42:10 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:43933 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfH0UmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:42:09 -0400
Received: by mail-vs1-f74.google.com with SMTP id p63so143579vsd.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6h3RXDkleqwSeFqf8A0vxqUeYj6Enzmb74sDLEq6U/8=;
        b=hIf+XNYEUQSXKtJDWrxGdw/5j20GGEWjVaH2b5AL4MYsKyZe4prNgrf5JXlUHYqgGY
         6ZP5MvNWdFUB7bWnJlJt0FS5GSHVfIkfwGnDb/swmXPE77hKQCom70QTNrYK8qP/Za4W
         HDPJDE7GmcYCIz0ar5Y12OLYP2heiC3VDmnBg2b7/CzQSh0oVLCWv5HkGRmgou10C5O+
         wJVCjRCgOsjKAChfQ3yVwyCtM16QKfhPIcQxKz4WXGmIECOhwqACTNuqUiyMPOhIyD13
         DP7C3HClweEGbdg0eO+7YtHVz2zjPjXzFTGv6TM9ZBmp5dUD773ZfgGn9Y8EsWlLUezB
         4VvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6h3RXDkleqwSeFqf8A0vxqUeYj6Enzmb74sDLEq6U/8=;
        b=OssoY0o8GayB4zSYKVBaMCOYQ4luX0XrmXYVQ8ThUwMrBIPikhjlXrtxQdEzrdnIEM
         h8g/zB33Bjdjzl5gxco5rThPblboIFQ0Dfj9pcKAEAQ/Zx8hjESjQLVJGdoabvPV8ESe
         PKLa+3aMao24gY4cz/SDsc2tLXy+HySiKNQyKcHy6vqEJPk6REfKwIDcw+UfGMh8Rviv
         /wc6hLffjsR3HqzwCe9sprAWxyqCSM6ZnH5JiMzq3fORqcFylvgmNroqD2sOUbrAOLYU
         9TvfM9jXPRctWq0ioGQkgfyt5qstUpccDMZVa5WlfsK4c0yu0pvr6qjwZujWTmkCof1v
         DOAQ==
X-Gm-Message-State: APjAAAU7sWUApVvXq/ikJi40gieec1GugjhZqbPkeI2CnCVHvz3JP5xh
        U4RBskO2T/YTtWNt4bCmeOtP2qPbQMY=
X-Google-Smtp-Source: APXvYqzVzwRWMuhucAFk4yPStyZ5DPzlB4p/7W3sns+k8ijHX6LpzCJvbvyZAY4fQQ8TVFzy3N2LQXFMtQ4=
X-Received: by 2002:a1f:7c0e:: with SMTP id x14mr486504vkc.0.1566938528429;
 Tue, 27 Aug 2019 13:42:08 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:41:49 -0700
In-Reply-To: <20190827204152.114609-1-hridya@google.com>
Message-Id: <20190827204152.114609-2-hridya@google.com>
Mime-Version: 1.0
References: <20190827204152.114609-1-hridya@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH 1/4] binder: add a mount option to show global stats
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
 drivers/android/binderfs.c | 47 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index cc2e71576396..d95d179aec58 100644
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
@@ -311,6 +321,24 @@ static int binderfs_parse_mount_opts(char *data,
 
 			opts->max = max_devices;
 			break;
+		case Opt_stats_mode:
+			stats = match_strdup(&args[0]);
+			if (!stats)
+				return -ENOMEM;
+
+			if (strcmp(stats, "global") != 0) {
+				kfree(stats);
+				return -EINVAL;
+			}
+
+			if (!capable(CAP_SYS_ADMIN)) {
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
@@ -322,8 +350,21 @@ static int binderfs_parse_mount_opts(char *data,
 
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
+		pr_info("Binderfs stats mode cannot be changed during a remount\n");
+		info->mount_opts.stats_mode = prev_stats_mode;
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int binderfs_show_mount_opts(struct seq_file *seq, struct dentry *root)
@@ -333,6 +374,8 @@ static int binderfs_show_mount_opts(struct seq_file *seq, struct dentry *root)
 	info = root->d_sb->s_fs_info;
 	if (info->mount_opts.max <= BINDERFS_MAX_MINOR)
 		seq_printf(seq, ",max=%d", info->mount_opts.max);
+	if (info->mount_opts.stats_mode == STATS_GLOBAL)
+		seq_printf(seq, ",stats=global");
 
 	return 0;
 }
-- 
2.23.0.187.g17f5b7556c-goog

