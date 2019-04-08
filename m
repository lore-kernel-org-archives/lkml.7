Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12329C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE3D208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDHIOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:14:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:12779 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbfDHIOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:14:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 01:14:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="147424268"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2019 01:14:07 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de,
        Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [RFC PATCH v3 3/4] x86: Use HYPERVISOR_CALLBACK_VECTOR for acrn_guest upcall vector
Date:   Mon,  8 Apr 2019 16:12:10 +0800
Message-Id: <1554711131-21514-4-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel uses the HYPERVISOR_CALLBACK_VECTOR for hypervisor upcall
vector. And it is already used for Xen and HyperV.
After Acrn hypervisor is detected, it will also use this defined vector
to notify kernel.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
V1->V2: Remove the unused API definition of acrn_setup_intr_handler and
acrn_remove_intr_handler.
        Adjust the order of header file
        Add the declaration of acrn_hv_vector_handler and tracing
definition of acrn_hv_callback_vector.
---
 arch/x86/Kconfig                 |  1 +
 arch/x86/entry/entry_64.S        |  5 +++++
 arch/x86/include/asm/acrnhyper.h | 19 +++++++++++++++++++
 arch/x86/kernel/cpu/acrn.c       | 22 ++++++++++++++++++++++
 4 files changed, 47 insertions(+)
 create mode 100644 arch/x86/include/asm/acrnhyper.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d77d215..ae4d38b 100644
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
diff --git a/arch/x86/include/asm/acrnhyper.h b/arch/x86/include/asm/acrnhyper.h
new file mode 100644
index 0000000..9f9c239
--- /dev/null
+++ b/arch/x86/include/asm/acrnhyper.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ACRNHYPER_H
+#define _ASM_X86_ACRNHYPER_H
+
+#include <linux/types.h>
+#include <linux/atomic.h>
+#include <linux/nmi.h>
+#include <asm/io.h>
+
+#ifdef CONFIG_ACRN_GUEST
+void acrn_hv_callback_vector(void);
+#ifdef CONFIG_TRACING
+#define trace_acrn_hv_callback_vector acrn_hv_callback_vector
+#endif
+
+void acrn_hv_vector_handler(struct pt_regs *regs);
+#endif
+
+#endif
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 3956567..7a233b5 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -9,7 +9,11 @@
  *
  */
 
+#include <linux/interrupt.h>
 #include <asm/hypervisor.h>
+#include <asm/acrnhyper.h>
+#include <asm/desc.h>
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
@@ -26,6 +32,22 @@ static bool acrn_x2apic_available(void)
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

