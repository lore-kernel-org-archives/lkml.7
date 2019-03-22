Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF416C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53D721900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257231;
	bh=nYKO3duwE8t4y5KpkWgPauNQui/9ERZnmkrDRoM8LU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mweo9re9ZCAxUQWR5WjJMj+1qsB7kokZ7LcXbM9qoh0uPENjDDs7yNuirA+JAmnRq
	 UT/VyMmrPeAkQY7y/LOYnqvHwv1O/UyrFsTucEIGUf28Qufjdp9th5SiC3nbo/Qr7W
	 n3U2UlCSnKuxfBjfEvDUcB4KPA9/o1+hIZYnW268=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390566AbfCVMUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390716AbfCVMUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:20:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2A332054F;
        Fri, 22 Mar 2019 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257219;
        bh=nYKO3duwE8t4y5KpkWgPauNQui/9ERZnmkrDRoM8LU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v+7OmDUVdt5xEzx2t8HHPthR3L5+Zckzk+aS9UTNa01lByMj+PWpKBhmoNGdxIiZq
         9cBKcgolP6fTxAQn3ibk9FYp6KB41a+1KRh5I8xmFSrPdwKtIhIVnX/gdYkcbO3FCn
         nwkqFoSwqX1/a513jJxoSTjrFNoaDT1Y3K7PyMHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.0 167/238] powerpc/smp: Fix NMI IPI xmon timeout
Date:   Fri, 22 Mar 2019 12:16:26 +0100
Message-Id: <20190322111308.152896155@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 88b9a3d1425a436e95c41f09986fdae2daee437a upstream.

The xmon debugger IPI handler waits in the callback function while
xmon is still active. This means they don't complete the IPI, and the
initiator always times out waiting for them.

Things manage to work after the timeout because there is some fallback
logic to keep NMI IPI state sane in case of the timeout, but this is a
bit ugly.

This patch changes NMI IPI back to half-asynchronous (i.e., wait for
everyone to call in, do not wait for IPI function to complete), but
the complexity is avoided by going one step further and allowing new
IPIs to be issued before the IPI functions to all complete.

If synchronization against that is required, it is left up to the
caller, but current callers don't require that. In fact with the
timeout handling, callers must be able to cope with this already.

Fixes: 5b73151fff63 ("powerpc: NMI IPI make NMI IPIs fully sychronous")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/smp.c |   93 ++++++++++++++--------------------------------
 1 file changed, 29 insertions(+), 64 deletions(-)

--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -358,13 +358,12 @@ void arch_send_call_function_ipi_mask(co
  * NMI IPIs may not be recoverable, so should not be used as ongoing part of
  * a running system. They can be used for crash, debug, halt/reboot, etc.
  *
- * NMI IPIs are globally single threaded. No more than one in progress at
- * any time.
- *
  * The IPI call waits with interrupts disabled until all targets enter the
- * NMI handler, then the call returns.
+ * NMI handler, then returns. Subsequent IPIs can be issued before targets
+ * have returned from their handlers, so there is no guarantee about
+ * concurrency or re-entrancy.
  *
- * No new NMI can be initiated until targets exit the handler.
+ * A new NMI can be issued before all targets exit the handler.
  *
  * The IPI call may time out without all targets entering the NMI handler.
  * In that case, there is some logic to recover (and ignore subsequent
@@ -375,7 +374,7 @@ void arch_send_call_function_ipi_mask(co
 
 static atomic_t __nmi_ipi_lock = ATOMIC_INIT(0);
 static struct cpumask nmi_ipi_pending_mask;
-static int nmi_ipi_busy_count = 0;
+static bool nmi_ipi_busy = false;
 static void (*nmi_ipi_function)(struct pt_regs *) = NULL;
 
 static void nmi_ipi_lock_start(unsigned long *flags)
@@ -414,7 +413,7 @@ static void nmi_ipi_unlock_end(unsigned
  */
 int smp_handle_nmi_ipi(struct pt_regs *regs)
 {
-	void (*fn)(struct pt_regs *);
+	void (*fn)(struct pt_regs *) = NULL;
 	unsigned long flags;
 	int me = raw_smp_processor_id();
 	int ret = 0;
@@ -425,29 +424,17 @@ int smp_handle_nmi_ipi(struct pt_regs *r
 	 * because the caller may have timed out.
 	 */
 	nmi_ipi_lock_start(&flags);
-	if (!nmi_ipi_busy_count)
-		goto out;
-	if (!cpumask_test_cpu(me, &nmi_ipi_pending_mask))
-		goto out;
-
-	fn = nmi_ipi_function;
-	if (!fn)
-		goto out;
-
-	cpumask_clear_cpu(me, &nmi_ipi_pending_mask);
-	nmi_ipi_busy_count++;
-	nmi_ipi_unlock();
-
-	ret = 1;
-
-	fn(regs);
-
-	nmi_ipi_lock();
-	if (nmi_ipi_busy_count > 1) /* Can race with caller time-out */
-		nmi_ipi_busy_count--;
-out:
+	if (cpumask_test_cpu(me, &nmi_ipi_pending_mask)) {
+		cpumask_clear_cpu(me, &nmi_ipi_pending_mask);
+		fn = READ_ONCE(nmi_ipi_function);
+		WARN_ON_ONCE(!fn);
+		ret = 1;
+	}
 	nmi_ipi_unlock_end(&flags);
 
+	if (fn)
+		fn(regs);
+
 	return ret;
 }
 
@@ -473,7 +460,7 @@ static void do_smp_send_nmi_ipi(int cpu,
  * - cpu is the target CPU (must not be this CPU), or NMI_IPI_ALL_OTHERS.
  * - fn is the target callback function.
  * - delay_us > 0 is the delay before giving up waiting for targets to
- *   complete executing the handler, == 0 specifies indefinite delay.
+ *   begin executing the handler, == 0 specifies indefinite delay.
  */
 int __smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us, bool safe)
 {
@@ -487,31 +474,33 @@ int __smp_send_nmi_ipi(int cpu, void (*f
 	if (unlikely(!smp_ops))
 		return 0;
 
-	/* Take the nmi_ipi_busy count/lock with interrupts hard disabled */
 	nmi_ipi_lock_start(&flags);
-	while (nmi_ipi_busy_count) {
+	while (nmi_ipi_busy) {
 		nmi_ipi_unlock_end(&flags);
-		spin_until_cond(nmi_ipi_busy_count == 0);
+		spin_until_cond(!nmi_ipi_busy);
 		nmi_ipi_lock_start(&flags);
 	}
-
+	nmi_ipi_busy = true;
 	nmi_ipi_function = fn;
 
+	WARN_ON_ONCE(!cpumask_empty(&nmi_ipi_pending_mask));
+
 	if (cpu < 0) {
 		/* ALL_OTHERS */
 		cpumask_copy(&nmi_ipi_pending_mask, cpu_online_mask);
 		cpumask_clear_cpu(me, &nmi_ipi_pending_mask);
 	} else {
-		/* cpumask starts clear */
 		cpumask_set_cpu(cpu, &nmi_ipi_pending_mask);
 	}
-	nmi_ipi_busy_count++;
+
 	nmi_ipi_unlock();
 
+	/* Interrupts remain hard disabled */
+
 	do_smp_send_nmi_ipi(cpu, safe);
 
 	nmi_ipi_lock();
-	/* nmi_ipi_busy_count is held here, so unlock/lock is okay */
+	/* nmi_ipi_busy is set here, so unlock/lock is okay */
 	while (!cpumask_empty(&nmi_ipi_pending_mask)) {
 		nmi_ipi_unlock();
 		udelay(1);
@@ -519,34 +508,19 @@ int __smp_send_nmi_ipi(int cpu, void (*f
 		if (delay_us) {
 			delay_us--;
 			if (!delay_us)
-				goto timeout;
+				break;
 		}
 	}
 
-	while (nmi_ipi_busy_count > 1) {
-		nmi_ipi_unlock();
-		udelay(1);
-		nmi_ipi_lock();
-		if (delay_us) {
-			delay_us--;
-			if (!delay_us)
-				goto timeout;
-		}
-	}
-
-timeout:
 	if (!cpumask_empty(&nmi_ipi_pending_mask)) {
 		/* Timeout waiting for CPUs to call smp_handle_nmi_ipi */
 		ret = 0;
 		cpumask_clear(&nmi_ipi_pending_mask);
 	}
-	if (nmi_ipi_busy_count > 1) {
-		/* Timeout waiting for CPUs to execute fn */
-		ret = 0;
-		nmi_ipi_busy_count = 1;
-	}
 
-	nmi_ipi_busy_count--;
+	nmi_ipi_function = NULL;
+	nmi_ipi_busy = false;
+
 	nmi_ipi_unlock_end(&flags);
 
 	return ret;
@@ -614,17 +588,8 @@ void crash_send_ipi(void (*crash_ipi_cal
 static void nmi_stop_this_cpu(struct pt_regs *regs)
 {
 	/*
-	 * This is a special case because it never returns, so the NMI IPI
-	 * handling would never mark it as done, which makes any later
-	 * smp_send_nmi_ipi() call spin forever. Mark it done now.
-	 *
 	 * IRQs are already hard disabled by the smp_handle_nmi_ipi.
 	 */
-	nmi_ipi_lock();
-	if (nmi_ipi_busy_count > 1)
-		nmi_ipi_busy_count--;
-	nmi_ipi_unlock();
-
 	spin_begin();
 	while (1)
 		spin_cpu_relax();


