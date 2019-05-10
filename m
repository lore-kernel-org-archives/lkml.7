Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7379EC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA1D20578
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfEJP1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:27:52 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:59848 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfEJP1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:27:52 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AC07672CCD0;
        Fri, 10 May 2019 18:27:49 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 8CF577CCE09; Fri, 10 May 2019 18:27:49 +0300 (MSK)
Date:   Fri, 10 May 2019 18:27:49 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Greentime Hu <greentime@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/7] nds32: fix asm/syscall.h
Message-ID: <20190510152749.GA28558@altlinux.org>
References: <20190510152640.GA28529@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510152640.GA28529@altlinux.org>
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
Acked-by: Greentime Hu <greentime@andestech.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v11: unchanged
    v10: added Acked-by from https://lore.kernel.org/lkml/CAEbi=3dzY7ihDLu=LFnHs_2_5BdAFyi4663W5g1JC+=QaiR7kQ@mail.gmail.com/
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
