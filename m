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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E326C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7872341F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TsI58MWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfICQRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:17:19 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38362 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbfICQRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:17:18 -0400
Received: by mail-pf1-f202.google.com with SMTP id b8so14430229pfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dmiOATAqQyCo7lDcckxvNROZCBcaSq8xNO80WhRvGcQ=;
        b=TsI58MWS7f3U530lYsTZ6jA8H7TUbzJ2lAbG8FMV/MmP5L5tNdJN3ouegaSQiZCY6Y
         eYlSv5o/JvvUFo5sX+8NScDGK90div5hmZTLowMOGImoOqZs5wvu7AN+FCWoWJqKvzpi
         1TlC84q0JN99nxyeW9VMuepXdkSwFxQjxeuSjZUqxNAPKrdP/ck0oPSc1U8FiohkTVBG
         4pyyyLAu0+puqL3YX0Sy4iaq80cmxPr9J4iW1N25AXPGJAy/4qU0fkRWdV3dH164xnh0
         OGWECsP4FIvmTEyIEwLtrrW6sNP+eHm8b+m0CBBpHi+dVT7EmRgO7trbiaioIABx8vIF
         s3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dmiOATAqQyCo7lDcckxvNROZCBcaSq8xNO80WhRvGcQ=;
        b=UU5X94nTF1XlfLqTa03ejpBZDdhYmJfA/SMvrE9CCmvIUoX1mH3VqdI/jP9s8A8+IW
         NEYxbWkYFECmcPzMwsRg5eYdPzaKT52Ddm//cN+LRABNtnyOWi5OjfZWfQ+CkU8TD32S
         R41Hlms5j9pkSI0CPSRK9NUOasSgpE6QKELhEHbrq33wjPeXdaa431+cVp4Q4G2pN2Ma
         D3zWbO9Ar7WDHaWMlNLk3NDsYs3gJ62pM/sTJf6RzWwF8ur285NS7exlIKVFVu6W2Tmm
         aQZbunXEcl2IlvigX00ZPQxp+OITnFVi1M+D1dMnaq4o8yZA0OX0JwdM+lzkRpYMCU9m
         4VUw==
X-Gm-Message-State: APjAAAWsF4RWB+CZoiCCDg53UwahI6YU/IBCl8FmvmXUynVOIGQSBGDM
        36Jsyb28bmQ1r9erFi7yL/JwTZ80soo=
X-Google-Smtp-Source: APXvYqxfgtAIeG1oMjPvv+b73pWvMejl4RV6CQBC/6SoRO8ME6mSNSV3wTSK47APDFCANf+4jP2bYIaNcL0=
X-Received: by 2002:a63:58c:: with SMTP id 134mr3887883pgf.106.1567527437205;
 Tue, 03 Sep 2019 09:17:17 -0700 (PDT)
Date:   Tue,  3 Sep 2019 09:16:54 -0700
In-Reply-To: <20190903161655.107408-1-hridya@google.com>
Message-Id: <20190903161655.107408-4-hridya@google.com>
Mime-Version: 1.0
References: <20190903161655.107408-1-hridya@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 3/4] binder: Make transaction_log available in binderfs
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

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
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
index 01c1db463053..9bb54fd3a48a 100644
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

