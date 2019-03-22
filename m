Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D50C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60649218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257316;
	bh=/Qa2QOrCopwcalx/Qgi9Fq8tG9K3enciv2dPvjhx9yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ae2XmIZv90jUercXlysEOsxKUFGKMfTAo/qFIsg7d4sVy5NfOtUowNcARN4YA++Yd
	 0eYSq3XK2hW6eF6Ib2XvjpoKSCmXAGt33G+IasVl0/YF26O9Rc/kqwpcYErLdfCdWY
	 Sy4F4DvQcPixqjA2avKgrINaOspu11N4VG5y5eDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390927AbfCVMVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390737AbfCVMVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:21:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 565C1218A1;
        Fri, 22 Mar 2019 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257309;
        bh=/Qa2QOrCopwcalx/Qgi9Fq8tG9K3enciv2dPvjhx9yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09nSA36lQhurwSFijpCXPiVkXpjeJueH72843M1g4mL7hAcBFQXwrgQBNlSRGCrKr
         X7UeCrHvB9aSgXPEkPLCB3hER0GRTcoQnLx6Tq85VvbHlVNo63/Qj0e4BEfnx/vie/
         irjDzM6icC/m5+FcGdcRS636X/CsdAgkekP6xLF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.0 161/238] powerpc/powernv: Dont reprogram SLW image on every KVM guest entry/exit
Date:   Fri, 22 Mar 2019 12:16:20 +0100
Message-Id: <20190322111307.801129632@linuxfoundation.org>
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

From: Paul Mackerras <paulus@ozlabs.org>

commit 19f8a5b5be2898573a5e1dc1db93e8d40117606a upstream.

Commit 24be85a23d1f ("powerpc/powernv: Clear PECE1 in LPCR via stop-api
only on Hotplug", 2017-07-21) added two calls to opal_slw_set_reg()
inside pnv_cpu_offline(), with the aim of changing the LPCR value in
the SLW image to disable wakeups from the decrementer while a CPU is
offline.  However, pnv_cpu_offline() gets called each time a secondary
CPU thread is woken up to participate in running a KVM guest, that is,
not just when a CPU is offlined.

Since opal_slw_set_reg() is a very slow operation (with observed
execution times around 20 milliseconds), this means that an offline
secondary CPU can often be busy doing the opal_slw_set_reg() call
when the primary CPU wants to grab all the secondary threads so that
it can run a KVM guest.  This leads to messages like "KVM: couldn't
grab CPU n" being printed and guest execution failing.

There is no need to reprogram the SLW image on every KVM guest entry
and exit.  So that we do it only when a CPU is really transitioning
between online and offline, this moves the calls to
pnv_program_cpu_hotplug_lpcr() into pnv_smp_cpu_kill_self().

Fixes: 24be85a23d1f ("powerpc/powernv: Clear PECE1 in LPCR via stop-api only on Hotplug")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/powernv.h    |    2 ++
 arch/powerpc/platforms/powernv/idle.c |   27 ++-------------------------
 arch/powerpc/platforms/powernv/smp.c  |   25 +++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 25 deletions(-)

--- a/arch/powerpc/include/asm/powernv.h
+++ b/arch/powerpc/include/asm/powernv.h
@@ -23,6 +23,8 @@ extern int pnv_npu2_handle_fault(struct
 				unsigned long *flags, unsigned long *status,
 				int count);
 
+void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val);
+
 void pnv_tm_init(void);
 #else
 static inline void powernv_set_nmmu_ptcr(unsigned long ptcr) { }
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -458,7 +458,8 @@ EXPORT_SYMBOL_GPL(pnv_power9_force_smt4_
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
+
+void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
 {
 	u64 pir = get_hard_smp_processor_id(cpu);
 
@@ -481,20 +482,6 @@ unsigned long pnv_cpu_offline(unsigned i
 {
 	unsigned long srr1;
 	u32 idle_states = pnv_get_supported_cpuidle_states();
-	u64 lpcr_val;
-
-	/*
-	 * We don't want to take decrementer interrupts while we are
-	 * offline, so clear LPCR:PECE1. We keep PECE2 (and
-	 * LPCR_PECE_HVEE on P9) enabled as to let IPIs in.
-	 *
-	 * If the CPU gets woken up by a special wakeup, ensure that
-	 * the SLW engine sets LPCR with decrementer bit cleared, else
-	 * the CPU will come back to the kernel due to a spurious
-	 * wakeup.
-	 */
-	lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
-	pnv_program_cpu_hotplug_lpcr(cpu, lpcr_val);
 
 	__ppc64_runlatch_off();
 
@@ -526,16 +513,6 @@ unsigned long pnv_cpu_offline(unsigned i
 
 	__ppc64_runlatch_on();
 
-	/*
-	 * Re-enable decrementer interrupts in LPCR.
-	 *
-	 * Further, we want stop states to be woken up by decrementer
-	 * for non-hotplug cases. So program the LPCR via stop api as
-	 * well.
-	 */
-	lpcr_val = mfspr(SPRN_LPCR) | (u64)LPCR_PECE1;
-	pnv_program_cpu_hotplug_lpcr(cpu, lpcr_val);
-
 	return srr1;
 }
 #endif
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -39,6 +39,7 @@
 #include <asm/cpuidle.h>
 #include <asm/kexec.h>
 #include <asm/reg.h>
+#include <asm/powernv.h>
 
 #include "powernv.h"
 
@@ -153,6 +154,7 @@ static void pnv_smp_cpu_kill_self(void)
 {
 	unsigned int cpu;
 	unsigned long srr1, wmask;
+	u64 lpcr_val;
 
 	/* Standard hot unplug procedure */
 	/*
@@ -174,6 +176,19 @@ static void pnv_smp_cpu_kill_self(void)
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		wmask = SRR1_WAKEMASK_P8;
 
+	/*
+	 * We don't want to take decrementer interrupts while we are
+	 * offline, so clear LPCR:PECE1. We keep PECE2 (and
+	 * LPCR_PECE_HVEE on P9) enabled so as to let IPIs in.
+	 *
+	 * If the CPU gets woken up by a special wakeup, ensure that
+	 * the SLW engine sets LPCR with decrementer bit cleared, else
+	 * the CPU will come back to the kernel due to a spurious
+	 * wakeup.
+	 */
+	lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
+	pnv_program_cpu_hotplug_lpcr(cpu, lpcr_val);
+
 	while (!generic_check_cpu_restart(cpu)) {
 		/*
 		 * Clear IPI flag, since we don't handle IPIs while
@@ -246,6 +261,16 @@ static void pnv_smp_cpu_kill_self(void)
 
 	}
 
+	/*
+	 * Re-enable decrementer interrupts in LPCR.
+	 *
+	 * Further, we want stop states to be woken up by decrementer
+	 * for non-hotplug cases. So program the LPCR via stop api as
+	 * well.
+	 */
+	lpcr_val = mfspr(SPRN_LPCR) | (u64)LPCR_PECE1;
+	pnv_program_cpu_hotplug_lpcr(cpu, lpcr_val);
+
 	DBG("CPU%d coming online...\n", cpu);
 }
 


