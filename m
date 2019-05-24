Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461E4C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E124321773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yx6m/VB2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ipYr7kWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbfEXDQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 23:16:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32880 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbfEXDQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:16:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C2137607F4; Fri, 24 May 2019 03:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558667777;
        bh=UfUOkq1yueIuFHRCYwReJukg9DnuYytlPgBSWsYteYI=;
        h=Date:From:To:Cc:Subject:From;
        b=Yx6m/VB2KcpMl2a85QuiJUCONQ5dv/ZK0PkE2IXk/NglQdiAslKZCIlbBB8CtAAAN
         0Sz8KHOHQi658aI+qT+MYSM6Fm22LFnDTL7OS2th6i2ZQiXyx5MXPWIKAXFP3Rp97c
         yiS/QA5W4P6lXfXeHRl/kMjgB3EIR4AFb+hg3vFY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7ED2C602F8;
        Fri, 24 May 2019 03:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558667776;
        bh=UfUOkq1yueIuFHRCYwReJukg9DnuYytlPgBSWsYteYI=;
        h=Date:From:To:Cc:Subject:From;
        b=ipYr7kWrhDYzMDqvpORoOVR37GGSUGG5J1iH61s8hM2Kbbc8Fb+oJQy6zdPy6/D7G
         zc7T4QauzYvsCK9YTxkIqwqyJn9UED08wp2wBL4mNpb7pTuObCfc3WMYv9eryfZIq7
         3+7vxYy9KpPgGRNca09vcC4TjXbzWbxlh8Y79k7Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 24 May 2019 11:16:16 +0800
From:   tengfeif@codeaurora.org
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, andreyknvl@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tengfei@codeaurora.org
Subject: [PATCH] arm64: break while loop if task had been rescheduled
Message-ID: <52076172bb8a55305846f6d4dc97bb52@codeaurora.org>
X-Sender: tengfeif@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When task isn't current task, this task's state have
chance to be changed during printing this task's
backtrace, so it is possible that task's fp and fp+8
have the same vaule, so cannot break the while loop.
To fix this issue, we first save the task's state, sp
and fp, then we will get the task's current state, sp
and fp in each while again. we will stop to print
backtrace if we found any of the values are different
than what we saved.

/********************************answer 
question**********************************/
This is very confusing. IIUC it suggests that while printing
the backtrace for non-current tasks the do/while loop does not
exit because fp and fp+8 might have the same value ? When would
this happen ? Even in that case the commit message here does not
properly match the change in this patch.

In our issue, we got fp=pc=0xFFFFFF8025A13BA0, so cannot exit while
loop in dump_basktrace().
After analyze our issue's dump, we found one task(such as: task A)
is exiting via invoke do_exit() during another task is showing task
A's dumptask. In kernel code, do_exit() and exit_notify are defined
as follows:
void noreturn do_exit(long code)
{
      ......
      exit_notify(tsk, group_dead);
      ......
}
static void exit_notify(struct task_struct *tsk, int group_dead)
{
      ......
}
Because of exit_notify() is a static function, so it is inlined to
do_exit() when compile kernel, so we can get partial assembly code
of do_exit() as follows:
……
{
         bool autoreap;
         struct task_struct *p, *n;
         LIST_HEAD(dead);

         write_lock_irq(&tasklist_lock);
      c10:       90000000        adrp    x0, 0 <tasklist_lock>
      c14:       910003e8        mov     x8, sp
      c18:       91000000        add     x0, x0, #0x0
*/
static void exit_notify(struct task_struct *tsk, int group_dead)
{
         bool autoreap;
         struct task_struct *p, *n;
         LIST_HEAD(dead);
      c1c:       a90023e8        stp     x8, x8, [sp]

         write_lock_irq(&tasklist_lock);
      c20:       94000000        bl      0 <_raw_write_lock_irq>
      c24:       f9435268        ldr     x8, [x19,#1696]
……
 From the code "c14:" and "c1c:", we will find sp's addr value is stored
in sp and sp+8, so sp's vaule equal (sp+8)'s value.
In our issue, there is a chance of fp point sp, so there will be 
fp=pc=fp's
addr value,so code cannot break from while loop in dump_backtrace().

/********************************answer 
question**********************************/

/********************************answer 
question**********************************/
This patch tries to stop printing the stack for non-current tasks
if their state change while there is one dump_backtrace() trying
to print back trace. Dont we have any lock preventing a task in
this situation (while dumping it's backtrace) from running again
or changing state.
I haven't found any lock preventing a task in this situation, and I 
think we shouldn't
prevent task running if this task is scheduled.
/********************************answer 
question**********************************/

Signed-off-by: Tengfei Fan <tengfeif@codeaurora.org>
---
  arch/arm64/kernel/traps.c | 23 +++++++++++++++++++++++
  1 file changed, 23 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 2975598..9df6e02 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -103,6 +103,9 @@ void dump_backtrace(struct pt_regs *regs, struct 
task_struct *tsk)
  {
      struct stackframe frame;
      int skip = 0;
+    long cur_state = 0;
+    unsigned long cur_sp = 0;
+    unsigned long cur_fp = 0;

      pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);

@@ -127,6 +130,9 @@ void dump_backtrace(struct pt_regs *regs, struct 
task_struct *tsk)
           */
          frame.fp = thread_saved_fp(tsk);
          frame.pc = thread_saved_pc(tsk);
+        cur_state = tsk->state;
+        cur_sp = thread_saved_sp(tsk);
+        cur_fp = frame.fp;

/********************************answer 
question**********************************/
Should 'saved_state|sp|fp' instead as its applicable to non-current
tasks only.
'saved_state|sp|fp' only applies to non-current tasks.

/********************************answer 
question**********************************/

      }
  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
      frame.graph = 0;
@@ -134,6 +140,23 @@ void dump_backtrace(struct pt_regs *regs, struct 
task_struct *tsk)

      printk("Call trace:\n");
      do {
+        if (tsk != current && (cur_state != tsk->state
+            /*
+             * We would not be printing backtrace for the task
+             * that has changed state from "saved" state to ohter
+             * state before hitting the do-while loop but after
+             * saving the current state. If task's current state
+             * not equal the "saved" state, then we may print
+             * wrong call trace or end up in infinite while loop
+             * if *(fp) and *(fp+8) are same. While the situation
+             * should be stoped once we found the task's state
+             * is changed, so we detect the task's current state,
+             * sp and fp in each while.
+             */
+            || cur_sp != thread_saved_sp(tsk)
+            || cur_fp != thread_saved_fp(tsk))) {

/********************************answer 
question**********************************/
Why does any of these three mismatches detect the problematic transition
not just the state ?
1. we can use "cur_state != tsk->state" prevent printing backtrace if 
the task's
    state is changed after "saved" task's state.
2. we can use "cur_sp != thread_saved_sp(tsk)" and "cur_fp != 
thread_saved_fp(tsk)"
    prevent printing backtrace if the task's state is changed before 
"saved" task's
    state. Because the value of "thread_saved_sp(tsk)" and 
"thread_saved_fp(tsk)"
    will not equal "saved" sp(cur_sp) and fp(cur_fp).
/********************************answer 
question**********************************/
