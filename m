Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC82FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0C5217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfH1KQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46428 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfH1KQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0D-0000Fk-7E; Wed, 28 Aug 2019 12:16:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C34041C0DE6;
        Wed, 28 Aug 2019 12:16:26 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:26 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] sched: Move struct task_cputime to types.h
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192920.909530418@linutronix.de>
References: <20190821192920.909530418@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738671.5740.12669290463759417859.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9eacb5c7e6607aba00a7322b21cad83fc8b101c8
Gitweb:        https://git.kernel.org/tip/9eacb5c7e6607aba00a7322b21cad83fc8b101c8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:34 +02:00

sched: Move struct task_cputime to types.h

For upcoming posix-timer changes to avoid include recursion hell.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190821192920.909530418@linutronix.de

---
 include/linux/sched.h       | 17 +----------------
 include/linux/sched/types.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/sched/types.h

diff --git a/include/linux/sched.h b/include/linux/sched.h
index fde844a..37c39df 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -25,6 +25,7 @@
 #include <linux/resource.h>
 #include <linux/latencytop.h>
 #include <linux/sched/prio.h>
+#include <linux/sched/types.h>
 #include <linux/signal_types.h>
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
@@ -245,22 +246,6 @@ struct prev_cputime {
 #endif
 };
 
-/**
- * struct task_cputime - collected CPU time counts
- * @utime:		time spent in user mode, in nanoseconds
- * @stime:		time spent in kernel mode, in nanoseconds
- * @sum_exec_runtime:	total time spent on the CPU, in nanoseconds
- *
- * This structure groups together three kinds of CPU time that are tracked for
- * threads and thread groups.  Most things considering CPU time want to group
- * these counts together and treat all three of them in parallel.
- */
-struct task_cputime {
-	u64				utime;
-	u64				stime;
-	unsigned long long		sum_exec_runtime;
-};
-
 /* Alternate field names when used on cache expirations: */
 #define virt_exp			utime
 #define prof_exp			stime
diff --git a/include/linux/sched/types.h b/include/linux/sched/types.h
new file mode 100644
index 0000000..2c5c28d
--- /dev/null
+++ b/include/linux/sched/types.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SCHED_TYPES_H
+#define _LINUX_SCHED_TYPES_H
+
+#include <linux/types.h>
+
+/**
+ * struct task_cputime - collected CPU time counts
+ * @utime:		time spent in user mode, in nanoseconds
+ * @stime:		time spent in kernel mode, in nanoseconds
+ * @sum_exec_runtime:	total time spent on the CPU, in nanoseconds
+ *
+ * This structure groups together three kinds of CPU time that are tracked for
+ * threads and thread groups.  Most things considering CPU time want to group
+ * these counts together and treat all three of them in parallel.
+ */
+struct task_cputime {
+	u64				utime;
+	u64				stime;
+	unsigned long long		sum_exec_runtime;
+};
+
+#endif
