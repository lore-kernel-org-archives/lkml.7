Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C79CC04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121A821773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfEUJ03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:26:29 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:52564 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbfEUJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:26:28 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2019 05:26:27 EDT
Received: from ironmsg03-tai.qualcomm.com ([10.249.140.8])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 21 May 2019 17:20:20 +0800
X-IronPort-AV: E=McAfee;i="5900,7806,9263"; a="29754389"
Received: from c-fan-gv.ap.qualcomm.com (HELO c-fan-gv) ([10.231.253.105])
  by ironmsg03-tai.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 May 2019 17:20:08 +0800
From:   Tengfei Fan <tengfeif@codeaurora.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     mark.rutland@arm.com, marc.zyngier@arm.com,
        anshuman.khandual@arm.com, andreyknvl@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tengfei@codeaurora.org, Tengfei Fan <tengfeif@codeaurora.org>
Subject: [PATCH] arm64: break while loop if task had been rescheduled
Date:   Tue, 21 May 2019 17:20:04 +0800
Message-Id: <1558430404-4840-1-git-send-email-tengfeif@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While printing a task's backtrace and this task isn't
current task, it is possible that task's fp and fp+8
have the same value, so cannot break the while loop.
This can break while loop if this task had been
rescheduled during print this task's backtrace.

Signed-off-by: Tengfei Fan <tengfeif@codeaurora.org>
---
 arch/arm64/kernel/traps.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 2975598..9df6e02 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -103,6 +103,9 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
 	struct stackframe frame;
 	int skip = 0;
+	long cur_state = 0;
+	unsigned long cur_sp = 0;
+	unsigned long cur_fp = 0;
 
 	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
 
@@ -127,6 +130,9 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		 */
 		frame.fp = thread_saved_fp(tsk);
 		frame.pc = thread_saved_pc(tsk);
+		cur_state = tsk->state;
+		cur_sp = thread_saved_sp(tsk);
+		cur_fp = frame.fp;
 	}
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	frame.graph = 0;
@@ -134,6 +140,23 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 
 	printk("Call trace:\n");
 	do {
+		if (tsk != current && (cur_state != tsk->state
+			/*
+			 * We would not be printing backtrace for the task
+			 * that has changed state from uninterruptible to
+			 * running before hitting the do-while loop but after
+			 * saving the current state. If task is in running
+			 * state before saving the state, then we may print
+			 * wrong call trace or end up in infinite while loop
+			 * if *(fp) and *(fp+8) are same. While the situation
+			 * will stop print when that task schedule out.
+			 */
+			|| cur_sp != thread_saved_sp(tsk)
+			|| cur_fp != thread_saved_fp(tsk))) {
+			printk("The task:%s had been rescheduled!\n",
+				tsk->comm);
+			break;
+		}
 		/* skip until specified stack frame */
 		if (!skip) {
 			dump_backtrace_entry(frame.pc);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

