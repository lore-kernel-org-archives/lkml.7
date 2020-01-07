Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0068AC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 00:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB502073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 00:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgAGAnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 19:43:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:3981 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbgAGAnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 19:43:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 16:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="scan'208";a="395186614"
Received: from cliu38-mobl3.sh.intel.com (HELO 286ab234718b.sh.intel.com) ([10.239.147.26])
  by orsmga005.jf.intel.com with ESMTP; 06 Jan 2020 16:43:29 -0800
From:   Chuansheng Liu <chuansheng.liu@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, chuansheng.liu@intel.com
Subject: [PATCH v2] x86/mce/therm_throt: Fix the access of uninitialized therm_work
Date:   Tue,  7 Jan 2020 00:41:16 +0000
Message-Id: <20200107004116.59353-1-chuansheng.liu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ICL platform, it is easy to hit bootup failure with panic
in thermal interrupt handler during early bootup stage.

Such issue makes my platform almost can not boot up with
latest kernel code.

The call stack is like:
kernel BUG at kernel/timer/timer.c:1152!

Call Trace:
__queue_delayed_work
queue_delayed_work_on
therm_throt_process
intel_thermal_interrupt
...

When one CPU is up, the irq is enabled prior to CPU UP
notification which will then initialize therm_worker.
Such race will cause the posssibility that interrupt
handler therm_throt_process() accesses uninitialized
therm_work, then system hit panic at very early bootup
stage.

In my ICL platform, it can be reproduced in several times
of reboot stress. With this fix, the system keeps alive
for more than 200 times of reboot stress.

V2: Boris shares a good suggestion that we can moving the
interrupt unmasking at the end of therm_work initialization.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
---
 arch/x86/kernel/cpu/mce/therm_throt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index b38010b541d6..528b85664b46 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -467,6 +467,7 @@ static int thermal_throttle_online(unsigned int cpu)
 {
 	struct thermal_state *state = &per_cpu(thermal_state, cpu);
 	struct device *dev = get_cpu_device(cpu);
+	u32 l;
 
 	state->package_throttle.level = PACKAGE_LEVEL;
 	state->core_throttle.level = CORE_LEVEL;
@@ -474,6 +475,12 @@ static int thermal_throttle_online(unsigned int cpu)
 	INIT_DELAYED_WORK(&state->package_throttle.therm_work, throttle_active_work);
 	INIT_DELAYED_WORK(&state->core_throttle.therm_work, throttle_active_work);
 
+	/* Unmask the thermal vector after
+	 * therm_works are initialized.
+	 */
+	l = apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
+
 	return thermal_throttle_add_dev(dev, cpu);
 }
 
@@ -722,10 +729,6 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
 	wrmsr(MSR_IA32_MISC_ENABLE, l | MSR_IA32_MISC_ENABLE_TM1, h);
 
-	/* Unmask the thermal vector: */
-	l = apic_read(APIC_LVTTHMR);
-	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
-
 	pr_info_once("CPU0: Thermal monitoring enabled (%s)\n",
 		      tm2 ? "TM2" : "TM1");
 
-- 
2.17.1

