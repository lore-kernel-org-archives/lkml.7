Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1A1C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED39204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfHNKln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:41:43 -0400
Received: from foss.arm.com ([217.140.110.172]:51832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfHNKll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:41:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4671B360;
        Wed, 14 Aug 2019 03:41:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7ABDE3F706;
        Wed, 14 Aug 2019 03:41:39 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mark.rutland@arm.com, mingo@kernel.org, peterz@infradead.org,
        riel@surriel.com, will@kernel.org
Subject: [PATCH 1/9] sched/core: add is_kthread() helper
Date:   Wed, 14 Aug 2019 11:41:23 +0100
Message-Id: <20190814104131.20190-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190814104131.20190-1-mark.rutland@arm.com>
References: <20190814104131.20190-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code checking whether a task is a kthread isn't very consistent. Some
code correctly tests task->flags & PF_THREAD, while other code checks
task->mm (which can be true for a kthread which calls use_mm()).

So that we can clean this up and keep the code easy to follow, let's add
an obvious helper function to test whether a task is a kthread.
Subsequent patches will use this as part of cleaning up and correcting
open-coded tests.

At the same time, let's fix up the kerneldoc for is_idle_task() for
consistency with the new helper, using true/false rather than 0/1, given
the functions return bool.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/sched.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9f51932bd543..b7e96409d75f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1621,13 +1621,24 @@ extern struct task_struct *idle_task(int cpu);
  * is_idle_task - is the specified task an idle task?
  * @p: the task in question.
  *
- * Return: 1 if @p is an idle task. 0 otherwise.
+ * Return: true if @p is an idle task, false otherwise.
  */
 static inline bool is_idle_task(const struct task_struct *p)
 {
 	return !!(p->flags & PF_IDLE);
 }
 
+/**
+ * is_kthread - is the specified task a kthread
+ * @p: the task in question.
+ *
+ * Return: true if @p is a kthread, false otherwise.
+ */
+static inline bool is_kthread(const struct task_struct *p)
+{
+	return !!(p->flags & PF_KTHREAD);
+}
+
 extern struct task_struct *curr_task(int cpu);
 extern void ia64_set_curr_task(int cpu, struct task_struct *p);
 
-- 
2.11.0

