Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901D0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB8B206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfJHNCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:02:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54861 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHNCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:02:11 -0400
Received: from p2e585ebf.dip0.t-ipconnect.de ([46.88.94.191] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iHp7t-0001iX-2O; Tue, 08 Oct 2019 13:02:05 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     jannh@google.com
Cc:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com, tkjos@google.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Todd Kjos <tkjos@android.com>,
        Hridya Valsaraju <hridya@google.com>
Subject: [PATCH] binder: prevent UAF read in print_binder_transaction_log_entry()
Date:   Tue,  8 Oct 2019 15:01:59 +0200
Message-Id: <20191008130159.10161-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
References: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a binder transaction is initiated on a binder device coming from a
binderfs instance, a pointer to the name of the binder device is stashed
in the binder_transaction_log_entry's context_name member. Later on it
is used to print the name in print_binder_transaction_log_entry(). By
the time print_binder_transaction_log_entry() accesses context_name
binderfs_evict_inode() might have already freed the associated memory
thereby causing a UAF. Do the simple thing and prevent this by copying
the name of the binder device instead of stashing a pointer to it.

Reported-by: Jann Horn <jannh@google.com>
Fixes: 03e2e07e3814 ("binder: Make transaction_log available in binderfs")
Link: https://lore.kernel.org/r/CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Todd Kjos <tkjos@android.com>
Cc: Hridya Valsaraju <hridya@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 drivers/android/binder.c          | 4 +++-
 drivers/android/binder_internal.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c0a491277aca..5b9ac2122e89 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -57,6 +57,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/seq_file.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/pid_namespace.h>
 #include <linux/security.h>
@@ -66,6 +67,7 @@
 #include <linux/task_work.h>
 
 #include <uapi/linux/android/binder.h>
+#include <uapi/linux/android/binderfs.h>
 
 #include <asm/cacheflush.h>
 
@@ -2876,7 +2878,7 @@ static void binder_transaction(struct binder_proc *proc,
 	e->target_handle = tr->target.handle;
 	e->data_size = tr->data_size;
 	e->offsets_size = tr->offsets_size;
-	e->context_name = proc->context->name;
+	strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);
 
 	if (reply) {
 		binder_inner_proc_lock(proc);
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index bd47f7f72075..ae991097d14d 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -130,7 +130,7 @@ struct binder_transaction_log_entry {
 	int return_error_line;
 	uint32_t return_error;
 	uint32_t return_error_param;
-	const char *context_name;
+	char context_name[BINDERFS_MAX_NAME + 1];
 };
 
 struct binder_transaction_log {
-- 
2.23.0

