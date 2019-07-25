Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B570C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC45B21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="27sj/+KV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfGYO3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:29:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37613 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfGYO3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:29:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PET2sF1040391
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:29:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PET2sF1040391
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564064943;
        bh=iVlbCFggiFclHMFMd5okp4ZHCwjv0o+FNdGpU78tNpo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=27sj/+KVFTl4Hvz6Up7+p+w8wF1mwl2d7QRtcAHAStum/Y49sEbzvsrdoi/vf9Gkw
         oInkVzkjI95xeRZOMPM3/JMfs+ov524tFlKWgeRM+mdYCimFwzkTF+BpvvjUy9RaMG
         CA+QaRZVe65jc8ViezevBkE+1Fphd0f+s066byrOcYmKboyUbhTqg7BhZvdqhhIZcQ
         JW6BEWR5LDyy+7j1W9lHoRGkC/v8gNLvUFmn0jICKRSsXzh+B8he/SsVs0525bg9xK
         KwGINVhSa/x/EeVXhXnuf1UQ7UfIr2YacxpKoneH3Dz/K0DwvkPi2oJ/k4NZEGNoXY
         6AWDqgFIowYvA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PET2501040385;
        Thu, 25 Jul 2019 07:29:02 -0700
Date:   Thu, 25 Jul 2019 07:29:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-60dcaad5736faff5a6b1abba5a292499f57197fe@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, peterz@infradead.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org, peterz@infradead.org
In-Reply-To: <alpine.DEB.2.21.1907241723290.1791@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907241723290.1791@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/hotplug: Silence APIC and NMI when CPU is dead
Git-Commit-ID: 60dcaad5736faff5a6b1abba5a292499f57197fe
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  60dcaad5736faff5a6b1abba5a292499f57197fe
Gitweb:     https://git.kernel.org/tip/60dcaad5736faff5a6b1abba5a292499f57197fe
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 24 Jul 2019 17:25:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:59 +0200

x86/hotplug: Silence APIC and NMI when CPU is dead

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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1907241723290.1791@nanos.tec.linutronix.de

---
 arch/x86/include/asm/apic.h |  1 +
 arch/x86/kernel/apic/apic.c | 35 ++++++++++++++++++++++++-----------
 arch/x86/kernel/nmi.c       |  3 +++
 arch/x86/kernel/smpboot.c   |  7 ++++++-
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index f53eda2c986b..cae7e0d02476 100644
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
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index fe30d1854a4e..831274e3c09f 100644
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
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4df7705022b9..e676a9916c49 100644
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
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fdbd47ceb84d..c19f8e21b748 100644
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
