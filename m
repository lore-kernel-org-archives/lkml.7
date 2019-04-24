Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC81C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E670C218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfDXA5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:57:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:21806 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbfDXA4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:56:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 17:56:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,387,1549958400"; 
   d="scan'208";a="340195451"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga005.fm.intel.com with ESMTP; 23 Apr 2019 17:56:54 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de,
        Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [RFC PATCH v5 3/4] x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for ACRN guest upcall vector
Date:   Wed, 24 Apr 2019 08:54:19 +0800
Message-Id: <1556067260-9128-4-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel uses the HYPERVISOR_CALLBACK_VECTOR for hypervisor upcall
vector. And it is already used for Xen and HyperV.
After ACRN hypervisor is detected, it will also use this defined vector
to notify ACRN guest.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
V1->V2: Remove the unused API definition of acrn_setup_intr_handler and
acrn_remove_intr_handler.
        Adjust the order of header file
        Add the declaration of acrn_hv_vector_handler and tracing
definition of acrn_hv_callback_vector.

v2->v3: Select the X86_HV_CALLBACK_VECTOR for ACRN guest
v3->v4: Refine the file name of acrnhyper.h to acrn.h
v4->v5: no change
---
 arch/x86/Kconfig            |  1 +
 arch/x86/entry/entry_64.S   |  5 +++++
 arch/x86/include/asm/acrn.h | 11 +++++++++++
 arch/x86/kernel/cpu/acrn.c  | 22 ++++++++++++++++++++++
 4 files changed, 39 insertions(+)
 create mode 100644 arch/x86/include/asm/acrn.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8dc4200..d7a10f6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -848,6 +848,7 @@ config JAILHOUSE_GUEST
 config ACRN_GUEST
 	bool "ACRN Guest support"
 	depends on X86_64
+	select X86_HV_CALLBACK_VECTOR
 	help
 	  This option allows to run Linux as guest in ACRN hypervisor. Enabling
 	  this will allow the kernel to boot in virtualized environment under
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb..d1b8ad3 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1129,6 +1129,11 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
 	hv_stimer0_callback_vector hv_stimer0_vector_handler
 #endif /* CONFIG_HYPERV */
 
+#if IS_ENABLED(CONFIG_ACRN_GUEST)
+apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
+	acrn_hv_callback_vector acrn_hv_vector_handler
+#endif
+
 idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
 idtentry int3			do_int3			has_error_code=0
 idtentry stack_segment		do_stack_segment	has_error_code=1
diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
new file mode 100644
index 0000000..43ab032
--- /dev/null
+++ b/arch/x86/include/asm/acrn.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ACRN_H
+#define _ASM_X86_ACRN_H
+
+void acrn_hv_callback_vector(void);
+#ifdef CONFIG_TRACING
+#define trace_acrn_hv_callback_vector acrn_hv_callback_vector
+#endif
+
+void acrn_hv_vector_handler(struct pt_regs *regs);
+#endif /* _ASM_X86_ACRN_H */
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index f556640..d8072bf 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -9,7 +9,11 @@
  *
  */
 
+#include <linux/interrupt.h>
+#include <asm/acrn.h>
+#include <asm/desc.h>
 #include <asm/hypervisor.h>
+#include <asm/irq_regs.h>
 
 static uint32_t __init acrn_detect(void)
 {
@@ -18,6 +22,8 @@ static uint32_t __init acrn_detect(void)
 
 static void __init acrn_init_platform(void)
 {
+	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
+			acrn_hv_callback_vector);
 }
 
 static bool acrn_x2apic_available(void)
@@ -30,6 +36,22 @@ static bool acrn_x2apic_available(void)
 	return false;
 }
 
+static void (*acrn_intr_handler)(void);
+
+__visible void __irq_entry acrn_hv_vector_handler(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
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

