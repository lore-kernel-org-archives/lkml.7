Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49384C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7A32070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfCNOmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:42:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbfCNOmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:42:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6468DACEF;
        Thu, 14 Mar 2019 14:42:18 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Len Brown <lenb@kernel.org>
Cc:     Rafael Wysocki <rafael@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Simon Schricker <sschricker@suse.de>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH] [RESEND] Do not modify perf bias performance setting by default at boot
Date:   Thu, 14 Mar 2019 15:42:16 +0100
Message-ID: <6369897.qxlu8PgE1t@house>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a revert of mainline git commits:
commit b51ef52df71cb28e9d90cd1d48b79bf19f0bab06
commit 17edf2d79f1ea6dfdb4c444801d928953b9f98d6
commit abe48b108247e9b90b4c6739662a2e5c765ed114

It is about this kernel message showing up on quite a lot servers:
[    0.072652] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.076003] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)

The background afaik were some BIOS which "forgot to set a default value".
Certainly some (one?) broken laptop BIOS was meant, because
the value zero (performance) is quite a reasonable default value on server systems
and this is how a lot CPUs typically come up there.

Another sever bug with above patches:
If you really set performance BIAS MSR value to 'performance'
as mentioned in kernel boot log, it is reset on next CPU offline/online cycle
(see below). Unfortunately one does not see this in the logs anymore, because
of the printk_once() usage:

dmesg |grep -i bias
[    0.026642] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.028002] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
liszt:~/:[0]# x86_energy_perf_policy 
cpu0: EPB 6
cpu1: EPB 6
cpu2: EPB 6
cpu3: EPB 6
liszt:~/:[0]# x86_energy_perf_policy 0
liszt:~/:[0]# x86_energy_perf_policy 
cpu0: EPB 0
cpu1: EPB 0
cpu2: EPB 0
cpu3: EPB 0
liszt:~/:[0]# echo offline > /sys/devices/system/cpu/cpu1/online
liszt:~/:[0]# echo online > /sys/devices/system/cpu/cpu1/online
liszt:~/:[0]# x86_energy_perf_policy 
cpu0: EPB 0
cpu1: EPB 6
cpu2: EPB 0
cpu3: EPB 0


Signed-off-by: Thomas Renninger <trenn@suse.de>
Tested-by: Simon Schricker <sschricker@suse.de>

Index: do_not_modify_perf_bias/arch/x86/kernel/cpu/common.c
===================================================================
--- do_not_modify_perf_bias.orig/arch/x86/kernel/cpu/common.c	2019-03-13 17:33:06.849890801 +0100
+++ do_not_modify_perf_bias/arch/x86/kernel/cpu/common.c	2019-03-13 18:01:54.781983906 +0100
@@ -18,7 +18,6 @@
 #include <linux/kgdb.h>
 #include <linux/smp.h>
 #include <linux/io.h>
-#include <linux/syscore_ops.h>
 
 #include <asm/stackprotector.h>
 #include <asm/perf_event.h>
@@ -1864,23 +1863,6 @@ void cpu_init(void)
 }
 #endif
 
-static void bsp_resume(void)
-{
-	if (this_cpu->c_bsp_resume)
-		this_cpu->c_bsp_resume(&boot_cpu_data);
-}
-
-static struct syscore_ops cpu_syscore_ops = {
-	.resume		= bsp_resume,
-};
-
-static int __init init_cpu_syscore(void)
-{
-	register_syscore_ops(&cpu_syscore_ops);
-	return 0;
-}
-core_initcall(init_cpu_syscore);
-
 /*
  * The microcode loader calls this upon late microcode load to recheck features,
  * only when microcode has been updated. Caller holds microcode_mutex and CPU
Index: do_not_modify_perf_bias/arch/x86/kernel/cpu/cpu.h
===================================================================
--- do_not_modify_perf_bias.orig/arch/x86/kernel/cpu/cpu.h	2019-03-13 17:33:06.849890801 +0100
+++ do_not_modify_perf_bias/arch/x86/kernel/cpu/cpu.h	2019-03-13 18:01:53.973983863 +0100
@@ -14,7 +14,6 @@ struct cpu_dev {
 	void		(*c_init)(struct cpuinfo_x86 *);
 	void		(*c_identify)(struct cpuinfo_x86 *);
 	void		(*c_detect_tlb)(struct cpuinfo_x86 *);
-	void		(*c_bsp_resume)(struct cpuinfo_x86 *);
 	int		c_x86_vendor;
 #ifdef CONFIG_X86_32
 	/* Optional vendor specific routine to obtain the cache size. */
Index: do_not_modify_perf_bias/arch/x86/kernel/cpu/intel.c
===================================================================
--- do_not_modify_perf_bias.orig/arch/x86/kernel/cpu/intel.c	2019-03-13 17:33:06.853890801 +0100
+++ do_not_modify_perf_bias/arch/x86/kernel/cpu/intel.c	2019-03-13 18:01:52.789983799 +0100
@@ -596,36 +596,6 @@ detect_keyid_bits:
 	c->x86_phys_bits -= keyid_bits;
 }
 
-static void init_intel_energy_perf(struct cpuinfo_x86 *c)
-{
-	u64 epb;
-
-	/*
-	 * Initialize MSR_IA32_ENERGY_PERF_BIAS if not already initialized.
-	 * (x86_energy_perf_policy(8) is available to change it at run-time.)
-	 */
-	if (!cpu_has(c, X86_FEATURE_EPB))
-		return;
-
-	rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
-	if ((epb & 0xF) != ENERGY_PERF_BIAS_PERFORMANCE)
-		return;
-
-	pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
-	pr_warn_once("ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)\n");
-	epb = (epb & ~0xF) | ENERGY_PERF_BIAS_NORMAL;
-	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
-}
-
-static void intel_bsp_resume(struct cpuinfo_x86 *c)
-{
-	/*
-	 * MSR_IA32_ENERGY_PERF_BIAS is lost across suspend/resume,
-	 * so reinitialize it properly like during bootup:
-	 */
-	init_intel_energy_perf(c);
-}
-
 static void init_cpuid_fault(struct cpuinfo_x86 *c)
 {
 	u64 msr;
@@ -763,8 +733,6 @@ static void init_intel(struct cpuinfo_x8
 	if (cpu_has(c, X86_FEATURE_TME))
 		detect_tme(c);
 
-	init_intel_energy_perf(c);
-
 	init_intel_misc_features(c);
 }
 
@@ -1023,7 +991,6 @@ static const struct cpu_dev intel_cpu_de
 	.c_detect_tlb	= intel_detect_tlb,
 	.c_early_init   = early_init_intel,
 	.c_init		= init_intel,
-	.c_bsp_resume	= intel_bsp_resume,
 	.c_x86_vendor	= X86_VENDOR_INTEL,
 };
 

