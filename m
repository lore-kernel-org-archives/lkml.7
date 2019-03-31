Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0D8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CC021874
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbfCaKmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:42:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57219 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfCaKmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:42:22 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAXuu-0005Y7-Ri; Sun, 31 Mar 2019 12:42:21 +0200
Date:   Sun, 31 Mar 2019 10:39:43 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/hotplug updates for 5.1
References: <155402878327.25983.10899882979692424898.tglx@nanos.tec.linutronix.de>
Message-ID: <155402878327.25983.12240602392812564980.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus

up to:  bebd024e4815 ("x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=y")

Two SMT/hotplug related fixes:

 - Prevent crash when HOTPLUG_CPU is disabled and the CPU bringup
   aborts. This is triggered with the 'nosmt' command line option, but can
   happen by any abort condition. As the real unplug code is not compiled
   in, prevent the fail by keeping the CPU in zombie state.

 - Enforce HOTPLUG_CPU for SMP on x86 to avoid the above situation
   completely. With 'nosmt' being a popular option it's required to unplug
   the half brought up sibling CPUs (due to the MCE wreckage) completely.

Thanks,

	tglx

------------------>
Thomas Gleixner (2):
      cpu/hotplug: Prevent crash when CPU bringup fails on CONFIG_HOTPLUG_CPU=n
      x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=y


 arch/x86/Kconfig |  8 +-------
 kernel/cpu.c     | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1f9b3cf437c..5ad92419be19 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2217,14 +2217,8 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 	   If unsure, leave at the default value.
 
 config HOTPLUG_CPU
-	bool "Support for hot-pluggable CPUs"
+	def_bool y
 	depends on SMP
-	---help---
-	  Say Y here to allow turning CPUs off and on. CPUs can be
-	  controlled through /sys/devices/system/cpu.
-	  ( Note: power management support will enable this option
-	    automatically on SMP systems. )
-	  Say N if you want to disable CPU hotplug.
 
 config BOOTPARAM_HOTPLUG_CPU0
 	bool "Set default setting of cpu0_hotpluggable"
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 025f419d16f6..6754f3ecfd94 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -564,6 +564,20 @@ static void undo_cpu_up(unsigned int cpu, struct cpuhp_cpu_state *st)
 		cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
 }
 
+static inline bool can_rollback_cpu(struct cpuhp_cpu_state *st)
+{
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		return true;
+	/*
+	 * When CPU hotplug is disabled, then taking the CPU down is not
+	 * possible because takedown_cpu() and the architecture and
+	 * subsystem specific mechanisms are not available. So the CPU
+	 * which would be completely unplugged again needs to stay around
+	 * in the current state.
+	 */
+	return st->state <= CPUHP_BRINGUP_CPU;
+}
+
 static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 			      enum cpuhp_state target)
 {
@@ -574,8 +588,10 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 		st->state++;
 		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
 		if (ret) {
-			st->target = prev_state;
-			undo_cpu_up(cpu, st);
+			if (can_rollback_cpu(st)) {
+				st->target = prev_state;
+				undo_cpu_up(cpu, st);
+			}
 			break;
 		}
 	}

