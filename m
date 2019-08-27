Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C66C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE4520656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIEGF++r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbfH0Um0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:42:26 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:34197 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0Um0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:42:26 -0400
Received: by mail-pl1-f201.google.com with SMTP id b68so122354plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EmHdjqpWOkwN7QyDqYlPb8k3J4oHvfwy1O4QGHBsJTQ=;
        b=rIEGF++rukeOc4SYnZVqa4YoSg9x8ExCagym0n4NYRrgmemg2OUG/F0/euXZAiPSdS
         ySnDj93ohmptmaA5l/vci75jYdk/X4hjAj8n14JmXF6Xc6iJ3Sfqc2JLhrn+fdRXS45T
         vnV73xLzxdSoPWz6Nki/6rjMEsn/ptFwSrHhZrV+olpO94yEWluJISL7AjAK5haY2t9B
         oU5MJunWAsiKJSyDADZQa4kXxKLtfeOvlFMmiEEK8vLJzSIFzURi5aqzrWpXC3B3aH4n
         7lSZ8WejX8hwVzWkF0Jikl2S8+XoV4piPV2mRm/msZDJ6pVTxZEDzDI+cw0rs4Jd8B1z
         vakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EmHdjqpWOkwN7QyDqYlPb8k3J4oHvfwy1O4QGHBsJTQ=;
        b=qNyRFGU6lzWiHPnFHoNAPy0aU/POxCiF5FjQbY0JCCSeXXvO5IN8ynb2hpCuCFT/WV
         iPJAtofFCSdru3iZCbKEuA9haGZmDpbqCyp2xwt24F7qvVfExPtdpBk7/jO36bPlPmn+
         lS069wxWpY1hH3Arttldk32BY31sKHtm/1TANzIDY7X24lvD1CNm4kbGovLwkwOELup9
         2JH85TxE5Thsf3N4HXo0xukgNnSLdrGxPBq43x8MlMMOiy/0mzynRs1S8fxM/8HXQ6v2
         tzHcrAZ5+0ZSlxC7CYN3qnaCB22NwKHvQRGn+g0zy0I6fWoNQrF/EhXd31Dq0Gzub3BF
         4gcw==
X-Gm-Message-State: APjAAAUK46ZMGCOh5eQH2H7u+/ZVnJZYU5oH6aNV3OoK5W6vP/5C9gv6
        QoKwSPMQ32BFx7OGR1+om0RYyyrozjQ=
X-Google-Smtp-Source: APXvYqxcN4KrgyCS3F1BcJepFgEZJTRnesa9Z78AtmB++07tEo3qHBqbd9W028360YYWIMQZHFgg5QNO7jk=
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr285624pgd.13.1566938544084;
 Tue, 27 Aug 2019 13:42:24 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:41:51 -0700
In-Reply-To: <20190827204152.114609-1-hridya@google.com>
Message-Id: <20190827204152.114609-4-hridya@google.com>
Mime-Version: 1.0
References: <20190827204152.114609-1-hridya@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH 3/4] binder: Make transaction_log available in binderfs
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
 drivers/android/binder.c          | 34 +++++--------------------------
 drivers/android/binder_internal.h | 30 +++++++++++++++++++++++++++
 drivers/android/binderfs.c        | 19 +++++++++++++++++
 3 files changed, 54 insertions(+), 29 deletions(-)

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
index d542f9b8d8ab..dc25a7d759c9 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -630,8 +630,27 @@ static int init_binder_logs(struct super_block *sb)
 
 	file_dentry = binderfs_create_file(binder_logs_root_dir, "transactions",
 					   &binder_transactions_fops, NULL);
+	if (IS_ERR(file_dentry)) {
+		ret = PTR_ERR(file_dentry);
+		goto out;
+	}
+
+	file_dentry = binderfs_create_file(binder_logs_root_dir,
+					   "transaction_log",
+					   &binder_transaction_log_fops,
+					   &binder_transaction_log);
+	if (IS_ERR(file_dentry)) {
+		ret = PTR_ERR(file_dentry);
+		goto out;
+	}
+
+	file_dentry = binderfs_create_file(binder_logs_root_dir,
+					   "failed_transaction_log",
+					   &binder_transaction_log_fops,
+					   &binder_transaction_log_failed);
 	if (IS_ERR(file_dentry))
 		ret = PTR_ERR(file_dentry);
+
 out:
 	return ret;
 }
-- 
2.23.0.187.g17f5b7556c-goog

