Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00962C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB126208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3Hyla11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfH2VSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:18:47 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56888 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfH2VSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:18:46 -0400
Received: by mail-pl1-f201.google.com with SMTP id v4so2701180plp.23
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=muz/mefNWmdyJ+QsHis6xProTua0zL80kJRtqaN+yFU=;
        b=A3Hyla11hckmzA0TJo783Av8DGN28wN1VOHNbW0G42ZqhIYwc3vCPjIwQGce5AGnTv
         jABoA+eQAB4wEnkRoL/RfGbowzm1Bf1Yl98CY/vUNLfDflzeVT3s4/Lz0wykdK/P5dfi
         PqvKgUq0hLNWQUh2swuGRrmIr7CbmhzpNUcru8ulO5k6vMIqlqMh8BXizB7suxgM+jEp
         6xa4e4Tf+Q/hWqWnZRWyC3k8HC4Fhqkub5iXL8FJBjouxbXToz5pKsF3KZGJTTZXLEzV
         wash4B4xDHIHSbjPJqiqFx3j8dzpQ5H/twe0CV8wyhxpawxlABXXDmqFg8988tabFLSk
         lnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=muz/mefNWmdyJ+QsHis6xProTua0zL80kJRtqaN+yFU=;
        b=Vuq3pHfMMBx1PicbuPw+eNmlKrfOTOcEuIXXHM1iBXK1njFf4fodKXb67p7Apsn3cF
         y49Ry1QEy6VU+U/JprdQ0HRL8ajb2EGOs6/CnJmjsCxQvk51IDyT+D1ZcmwoDtLIdzhl
         J01XVWj1hfhFj78j/NODfQQEWbDyfMKr7p/ArIKZ59YQncuhxQaSkEbiIu5YJtiyxi3I
         lisQiqG1NTdSK87mLVb8gVpAjjNyIp+iUnAbN0DjgRe/sQJmKgA33pSfHWg/imyXMHG8
         r53QMnQmkv4ovFDzilNontU8mD1eQ2AeHIJjJkri6S69jj8bE9lIzb51eBT87SgjH7dd
         0a8A==
X-Gm-Message-State: APjAAAW4oz+6e0voTTVr1uBCBGDdhHyAUJy5hnuUrBdliL6ElJdRQZtF
        453mcQUO05uiyPvhIauFA7umWs0UgVU=
X-Google-Smtp-Source: APXvYqzBSIGzfFUBsHojw+KamA1MFwGNvjgxKGJVSOPjCs+DH4LEJ1bSi3A1AWFKqe8Lvw1VKNbYtBusR0o=
X-Received: by 2002:a65:6259:: with SMTP id q25mr10357168pgv.145.1567113525812;
 Thu, 29 Aug 2019 14:18:45 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:18:11 -0700
In-Reply-To: <20190829211812.32520-1-hridya@google.com>
Message-Id: <20190829211812.32520-4-hridya@google.com>
Mime-Version: 1.0
References: <20190829211812.32520-1-hridya@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 3/4] binder: Make transaction_log available in binderfs
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

Currently, the binder transaction log files 'transaction_log'
and 'failed_transaction_log' live in debugfs at the following locations:

/sys/kernel/debug/binder/failed_transaction_log
/sys/kernel/debug/binder/transaction_log

This patch makes these files also available in a binderfs instance
mounted with the mount option "stats=global".
It does not affect the presence of these files in debugfs.
If a binderfs instance is mounted at path /dev/binderfs, the location of
these files will be as follows:

/dev/binderfs/binder_logs/failed_transaction_log
/dev/binderfs/binder_logs/transaction_log

This change provides an alternate option to access these files when
debugfs is not mounted.

Signed-off-by: Hridya Valsaraju <hridya@google.com>
---

 Changes in v2:
 -Consistent variable naming accross functions as per Christian Brauner.

 drivers/android/binder.c          | 34 +++++--------------------------
 drivers/android/binder_internal.h | 30 +++++++++++++++++++++++++++
 drivers/android/binderfs.c        | 18 ++++++++++++++++
 3 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index de795bd229c4..bed217310197 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -197,30 +197,8 @@ static inline void binder_stats_created(enum binder_stat_types type)
 	atomic_inc(&binder_stats.obj_created[type]);
 }
 
-struct binder_transaction_log_entry {
-	int debug_id;
-	int debug_id_done;
-	int call_type;
-	int from_proc;
-	int from_thread;
-	int target_handle;
-	int to_proc;
-	int to_thread;
-	int to_node;
-	int data_size;
-	int offsets_size;
-	int return_error_line;
-	uint32_t return_error;
-	uint32_t return_error_param;
-	const char *context_name;
-};
-struct binder_transaction_log {
-	atomic_t cur;
-	bool full;
-	struct binder_transaction_log_entry entry[32];
-};
-static struct binder_transaction_log binder_transaction_log;
-static struct binder_transaction_log binder_transaction_log_failed;
+struct binder_transaction_log binder_transaction_log;
+struct binder_transaction_log binder_transaction_log_failed;
 
 static struct binder_transaction_log_entry *binder_transaction_log_add(
 	struct binder_transaction_log *log)
@@ -6166,7 +6144,7 @@ static void print_binder_transaction_log_entry(struct seq_file *m,
 			"\n" : " (incomplete)\n");
 }
 
-static int transaction_log_show(struct seq_file *m, void *unused)
+int binder_transaction_log_show(struct seq_file *m, void *unused)
 {
 	struct binder_transaction_log *log = m->private;
 	unsigned int log_cur = atomic_read(&log->cur);
@@ -6198,8 +6176,6 @@ const struct file_operations binder_fops = {
 	.release = binder_release,
 };
 
-DEFINE_SHOW_ATTRIBUTE(transaction_log);
-
 static int __init init_binder_device(const char *name)
 {
 	int ret;
@@ -6268,12 +6244,12 @@ static int __init binder_init(void)
 				    0444,
 				    binder_debugfs_dir_entry_root,
 				    &binder_transaction_log,
-				    &transaction_log_fops);
+				    &binder_transaction_log_fops);
 		debugfs_create_file("failed_transaction_log",
 				    0444,
 				    binder_debugfs_dir_entry_root,
 				    &binder_transaction_log_failed,
-				    &transaction_log_fops);
+				    &binder_transaction_log_fops);
 	}
 
 	if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 12ef96f256c6..b9be42d9464c 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -65,4 +65,34 @@ DEFINE_SHOW_ATTRIBUTE(binder_state);
 
 int binder_transactions_show(struct seq_file *m, void *unused);
 DEFINE_SHOW_ATTRIBUTE(binder_transactions);
+
+int binder_transaction_log_show(struct seq_file *m, void *unused);
+DEFINE_SHOW_ATTRIBUTE(binder_transaction_log);
+
+struct binder_transaction_log_entry {
+	int debug_id;
+	int debug_id_done;
+	int call_type;
+	int from_proc;
+	int from_thread;
+	int target_handle;
+	int to_proc;
+	int to_thread;
+	int to_node;
+	int data_size;
+	int offsets_size;
+	int return_error_line;
+	uint32_t return_error;
+	uint32_t return_error_param;
+	const char *context_name;
+};
+
+struct binder_transaction_log {
+	atomic_t cur;
+	bool full;
+	struct binder_transaction_log_entry entry[32];
+};
+
+extern struct binder_transaction_log binder_transaction_log;
+extern struct binder_transaction_log binder_transaction_log_failed;
 #endif /* _LINUX_BINDER_INTERNAL_H */
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 0e1e7c87cd33..1715e72ce9c7 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -630,6 +630,24 @@ static int init_binder_logs(struct super_block *sb)
 
 	dentry = binderfs_create_file(binder_logs_root_dir, "transactions",
 				      &binder_transactions_fops, NULL);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	dentry = binderfs_create_file(binder_logs_root_dir,
+				      "transaction_log",
+				      &binder_transaction_log_fops,
+				      &binder_transaction_log);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	dentry = binderfs_create_file(binder_logs_root_dir,
+				      "failed_transaction_log",
+				      &binder_transaction_log_fops,
+				      &binder_transaction_log_failed);
 	if (IS_ERR(dentry))
 		ret = PTR_ERR(dentry);
 
-- 
2.23.0.187.g17f5b7556c-goog

