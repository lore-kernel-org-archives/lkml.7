Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B04C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC95E20879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfDHRla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:41:30 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:60562 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfDHRl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:41:29 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B7DFC72CCAC;
        Mon,  8 Apr 2019 20:41:27 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id AD23B7CCE4F; Mon,  8 Apr 2019 20:41:27 +0300 (MSK)
Date:   Mon, 8 Apr 2019 20:41:27 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH linux-next v9 1/7] nds32: fix asm/syscall.h
Message-ID: <20190408174127.GB11889@altlinux.org>
References: <20190408174036.GA11889@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408174036.GA11889@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All syscall_get_*() and syscall_set_*() functions must be defined
as static inline as on all other architectures, otherwise asm/syscall.h
cannot be included in more than one compilation unit.

This bug has to be fixed in order to extend the generic
ptrace API with PTRACE_GET_SYSCALL_INFO request.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 1932fbe36e02 ("nds32: System calls handling")
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Dear nds32 maintainers, this fix is waiting for ACK since early January.

Notes:
    v9: rebased to linux-next again due to syscall_get_arguments() signature change
    v8: unchanged
    v7: initial revision

 arch/nds32/include/asm/syscall.h | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
index 174b8571d362..d08439a54034 100644
--- a/arch/nds32/include/asm/syscall.h
+++ b/arch/nds32/include/asm/syscall.h
@@ -26,7 +26,8 @@ struct pt_regs;
  *
  * It's only valid to call this when @task is known to be blocked.
  */
-int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+static inline int
+syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
 {
 	return regs->syscallno;
 }
@@ -47,7 +48,8 @@ int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
  * system call instruction.  This may not be the same as what the
  * register state looked like at system call entry tracing.
  */
-void syscall_rollback(struct task_struct *task, struct pt_regs *regs)
+static inline void
+syscall_rollback(struct task_struct *task, struct pt_regs *regs)
 {
 	regs->uregs[0] = regs->orig_r0;
 }
@@ -62,7 +64,8 @@ void syscall_rollback(struct task_struct *task, struct pt_regs *regs)
  * It's only valid to call this when @task is stopped for tracing on exit
  * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
-long syscall_get_error(struct task_struct *task, struct pt_regs *regs)
+static inline long
+syscall_get_error(struct task_struct *task, struct pt_regs *regs)
 {
 	unsigned long error = regs->uregs[0];
 	return IS_ERR_VALUE(error) ? error : 0;
@@ -79,7 +82,8 @@ long syscall_get_error(struct task_struct *task, struct pt_regs *regs)
  * It's only valid to call this when @task is stopped for tracing on exit
  * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
-long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
+static inline long
+syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
 {
 	return regs->uregs[0];
 }
@@ -99,8 +103,9 @@ long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
  * It's only valid to call this when @task is stopped for tracing on exit
  * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
-void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
-			      int error, long val)
+static inline void
+syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
+			 int error, long val)
 {
 	regs->uregs[0] = (long)error ? error : val;
 }
@@ -118,8 +123,9 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
  * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
 #define SYSCALL_MAX_ARGS 6
-void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
-			   unsigned long *args)
+static inline void
+syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+		      unsigned long *args)
 {
 	args[0] = regs->orig_r0;
 	args++;
@@ -138,8 +144,9 @@ void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
  * It's only valid to call this when @task is stopped for tracing on
  * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
-void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
-			   const unsigned long *args)
+static inline void
+syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
+		      const unsigned long *args)
 {
 	regs->orig_r0 = args[0];
 	args++;
-- 
ldv
