Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34639C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1338121951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfGXPZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:25:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44320 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:25:58 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqJ9N-0003tH-QL; Wed, 24 Jul 2019 17:25:53 +0200
Date:   Wed, 24 Jul 2019 17:25:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V4 13/25] x86/hotplug: Silence APIC and NMI when CPU is
 dead
In-Reply-To: <20190722105220.000867773@linutronix.de>
Message-ID: <alpine.DEB.2.21.1907241723290.1791@nanos.tec.linutronix.de>
References: <20190722104705.550071814@linutronix.de> <20190722105220.000867773@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support IPI/NMI broadcasting via the shorthand mechanism side
effects of shorthands need to be mitigated:

 Shorthand IPIs and NMIs hit all CPUs including unplugged CPUs

Neither of those can be handled on unplugged CPUs for obvious reasons.

It would be trivial to just fully disable the APIC via the enable bit in
MSR_APICBASE. But that's not possible because clearing that bit on systems
based on the 3 wire APIC bus would require a hardware reset to bring it
back as the APIC would lose track of bus arbitration. On systems with FSB
delivery APICBASE could be disabled, but it has to be guaranteed that no
interrupt is sent to the APIC while in that state and it's not clear from
the SDM whether it still responds to INIT/SIPI messages.

Therefore stay on the safe side and switch the APIC into soft disabled mode
so it won't deliver any regular vector to the CPU.

NMIs are still propagated to the 'dead' CPUs. To mitigate that add a check
for the CPU being offline on early nmi entry and if so bail.

Note, this cannot use the stop/restart_nmi() magic which is used in the
alternatives code. A dead CPU cannot invoke nmi_enter() or anything else
due to RCU and other reasons.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Use cpu_is_offline() instead of an extra per CPU variable - suggested
    by PeterZ.
---
 arch/x86/include/asm/apic.h |    1 +
 arch/x86/kernel/apic/apic.c |   35 ++++++++++++++++++++++++-----------
 arch/x86/kernel/nmi.c       |    3 +++
 arch/x86/kernel/smpboot.c   |    7 ++++++-
 4 files changed, 34 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -136,6 +136,7 @@ extern int lapic_get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void disconnect_bsp_APIC(int virt_wire_setup);
 extern void disable_local_APIC(void);
+extern void apic_soft_disable(void);
 extern void lapic_shutdown(void);
 extern void sync_Arb_IDs(void);
 extern void init_bsp_APIC(void);
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1182,25 +1182,38 @@ void clear_local_APIC(void)
 }
 
 /**
- * disable_local_APIC - clear and disable the local APIC
+ * apic_soft_disable - Clears and software disables the local APIC on hotplug
+ *
+ * Contrary to disable_local_APIC() this does not touch the enable bit in
+ * MSR_IA32_APICBASE. Clearing that bit on systems based on the 3 wire APIC
+ * bus would require a hardware reset as the APIC would lose track of bus
+ * arbitration. On systems with FSB delivery APICBASE could be disabled,
+ * but it has to be guaranteed that no interrupt is sent to the APIC while
+ * in that state and it's not clear from the SDM whether it still responds
+ * to INIT/SIPI messages. Stay on the safe side and use software disable.
  */
-void disable_local_APIC(void)
+void apic_soft_disable(void)
 {
-	unsigned int value;
-
-	/* APIC hasn't been mapped yet */
-	if (!x2apic_mode && !apic_phys)
-		return;
+	u32 value;
 
 	clear_local_APIC();
 
-	/*
-	 * Disable APIC (implies clearing of registers
-	 * for 82489DX!).
-	 */
+	/* Soft disable APIC (implies clearing of registers for 82489DX!). */
 	value = apic_read(APIC_SPIV);
 	value &= ~APIC_SPIV_APIC_ENABLED;
 	apic_write(APIC_SPIV, value);
+}
+
+/**
+ * disable_local_APIC - clear and disable the local APIC
+ */
+void disable_local_APIC(void)
+{
+	/* APIC hasn't been mapped yet */
+	if (!x2apic_mode && !apic_phys)
+		return;
+
+	apic_soft_disable();
 
 #ifdef CONFIG_X86_32
 	/*
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -512,6 +512,9 @@ NOKPROBE_SYMBOL(is_debug_stack);
 dotraplinkage notrace void
 do_nmi(struct pt_regs *regs, long error_code)
 {
+	if (IS_ENABLED(CONFIG_SMP) && cpu_is_offline(smp_processor_id()))
+		return;
+
 	if (this_cpu_read(nmi_state) != NMI_NOT_RUNNING) {
 		this_cpu_write(nmi_state, NMI_LATCHED);
 		return;
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1596,7 +1596,12 @@ int native_cpu_disable(void)
 	if (ret)
 		return ret;
 
-	clear_local_APIC();
+	/*
+	 * Disable the local APIC. Otherwise IPI broadcasts will reach
+	 * it. It still responds normally to INIT, NMI, SMI, and SIPI
+	 * messages.
+	 */
+	apic_soft_disable();
 	cpu_disable_common();
 
 	return 0;
