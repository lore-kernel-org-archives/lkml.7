Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD38C07542
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 05:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449E02081C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 05:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfE2FiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 01:38:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:52068 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfE2FiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 01:38:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 22:37:59 -0700
X-ExtLoop1: 1
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga007.fm.intel.com with ESMTP; 28 May 2019 22:37:58 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de,
        Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [PATCH v7 3/3] x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for ACRN guest upcall vector
Date:   Wed, 29 May 2019 13:33:57 +0800
Message-Id: <1559108037-18813-4-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559108037-18813-1-git-send-email-yakui.zhao@intel.com>
References: <1559108037-18813-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel uses the HYPERVISOR_CALLBACK_VECTOR for hypervisor upcall
vector. It is already used for Xen and HyperV.
After the ACRN hypervisor is detected, it will also use this defined
vector to notify the ACRN guest.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
V1->V2: Remove the unused API definition of acrn_setup_intr_handler and
acrn_remove_intr_handler.
        Adjust the order of header file
        Add the declaration of acrn_hv_vector_handler and tracing
definition of acrn_hv_callback_vector.

v2->v3: No change
v3->v4: Refine the file name of acrnhyper.h to acrn.h
v5->v6: Add the "extern" for the function declarations in header file
	Add some comments for calling entering_ack_irq
	Some other minor changes(unnecessary spliting two lines.
and minor change in commit log)
v6->v7: Include the header file of asm/apic.h to fix the buidling error
        when enabling cflags="-Werror=implict-function-declaration".
---
 arch/x86/Kconfig            |  1 +
 arch/x86/entry/entry_64.S   |  5 +++++
 arch/x86/include/asm/acrn.h | 11 +++++++++++
 arch/x86/kernel/cpu/acrn.c  | 30 ++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)
 create mode 100644 arch/x86/include/asm/acrn.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3020bc7..170d5cf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -838,6 +838,7 @@ config JAILHOUSE_GUEST
 config ACRN_GUEST
 	bool "ACRN Guest support"
 	depends on X86_64
+	select X86_HV_CALLBACK_VECTOR
 	help
 	  This option allows to run Linux as guest in ACRN hypervisor. Enabling
 	  this will allow the kernel to boot in virtualized environment under
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 11aa3b2..2fe6289 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1142,6 +1142,11 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
 	hv_stimer0_callback_vector hv_stimer0_vector_handler
 #endif /* CONFIG_HYPERV */
 
+#if IS_ENABLED(CONFIG_ACRN_GUEST)
+apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
+	acrn_hv_callback_vector acrn_hv_vector_handler
+#endif
+
 idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=IST_INDEX_DB ist_offset=DB_STACK_OFFSET
 idtentry int3			do_int3			has_error_code=0	create_gap=1
 idtentry stack_segment		do_stack_segment	has_error_code=1
diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
new file mode 100644
index 0000000..4adb13f
--- /dev/null
+++ b/arch/x86/include/asm/acrn.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ACRN_H
+#define _ASM_X86_ACRN_H
+
+extern void acrn_hv_callback_vector(void);
+#ifdef CONFIG_TRACING
+#define trace_acrn_hv_callback_vector acrn_hv_callback_vector
+#endif
+
+extern void acrn_hv_vector_handler(struct pt_regs *regs);
+#endif /* _ASM_X86_ACRN_H */
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index f556640..a110c8b 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -9,7 +9,12 @@
  *
  */
 
+#include <linux/interrupt.h>
+#include <asm/acrn.h>
+#include <asm/apic.h>
+#include <asm/desc.h>
 #include <asm/hypervisor.h>
+#include <asm/irq_regs.h>
 
 static uint32_t __init acrn_detect(void)
 {
@@ -18,6 +23,8 @@ static uint32_t __init acrn_detect(void)
 
 static void __init acrn_init_platform(void)
 {
+	/* Setup the IDT for ACRN hypervisor callback */
+	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, acrn_hv_callback_vector);
 }
 
 static bool acrn_x2apic_available(void)
@@ -30,6 +37,29 @@ static bool acrn_x2apic_available(void)
 	return false;
 }
 
+static void (*acrn_intr_handler)(void);
+
+__visible void __irq_entry acrn_hv_vector_handler(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	/*
+	 * The hypervisor requires that the APIC EOI should be acked.
+	 * If the APIC EOI is not acked, the APIC ISR bit for the
+	 * HYPERVISOR_CALLBACK_VECTOR will not be cleared and then it
+	 * will block the interrupt whose vector is lower than
+	 * HYPERVISOR_CALLBACK_VECTOR.
+	 */
+	entering_ack_irq();
+	inc_irq_stat(irq_hv_callback_count);
+
+	if (acrn_intr_handler)
+		acrn_intr_handler();
+
+	exiting_irq();
+	set_irq_regs(old_regs);
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_acrn = {
 	.name                   = "ACRN",
 	.detect                 = acrn_detect,
-- 
2.7.4

