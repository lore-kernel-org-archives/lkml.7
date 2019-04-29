Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72ACC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0592147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfD2Lws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:52:48 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64466 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2Lwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:52:47 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3TBqP0x072228;
        Mon, 29 Apr 2019 20:52:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Mon, 29 Apr 2019 20:52:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3TBqLev072079
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 20:52:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] kernel/hung_task.c: Replace trigger_all_cpu_backtrace() with task traversal.
Date:   Mon, 29 Apr 2019 20:52:07 +0900
Message-Id: <1556538727-11876-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since trigger_all_cpu_backtrace() uses NMI interface, printk() from other
CPUs are called from interrupt context. Therefore, CONFIG_PRINTK_CALLER=y
needlessly separates printk() from khungtaskd kernel thread running on
current CPU and printk() from other threads running on other CPUs.

Also, it is completely a garbage that trigger_all_cpu_backtrace() reports
khungtaskd kernel thread running on current CPU, for the purpose of
calling trigger_all_cpu_backtrace() from khungtaskd is to report running
threads which might have caused other threads being blocked for so long.

Therefore, report threads (except khungtaskd kernel thread itself) which
are on the scheduler using task traversal approach. This allows syzbot to
include backtrace of running threads into its report files.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/hung_task.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index f108a95..2fddd98 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -164,6 +164,23 @@ static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
 	return can_cont;
 }
 
+static void print_all_running_threads(void)
+{
+#ifdef CONFIG_SMP
+	struct task_struct *g;
+	struct task_struct *t;
+
+	rcu_read_lock();
+	for_each_process_thread(g, t) {
+		if (!t->on_cpu || t == current)
+			continue;
+		pr_err("INFO: Currently running\n");
+		sched_show_task(t);
+	}
+	rcu_read_unlock();
+#endif
+}
+
 /*
  * Check whether a TASK_UNINTERRUPTIBLE does not get woken up for
  * a really long time (120 seconds). If that happens, print out
@@ -201,7 +218,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	if (hung_task_show_lock)
 		debug_show_all_locks();
 	if (hung_task_call_panic) {
-		trigger_all_cpu_backtrace();
+		print_all_running_threads();
 		panic("hung_task: blocked tasks");
 	}
 }
-- 
1.8.3.1

