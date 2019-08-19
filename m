Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C232DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF242070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfHSPrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:47:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47704 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbfHSPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:48 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqs-0006xp-2v; Mon, 19 Aug 2019 17:45:46 +0200
Message-Id: <20190819143803.772511300@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:06 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 25/44] sched: Move struct task_cputime to types.h
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For upcoming posix-timer changes to avoid include recursion hell.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched.h       |   17 +----------------
 include/linux/sched/types.h |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)

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
--- /dev/null
+++ b/include/linux/sched/types.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SCHED_TYPES_H
+#define _LINUX_SCHED_TYPES_H
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


