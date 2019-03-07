Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30086C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067BC20661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfCGCFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:05:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:40332 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfCGCEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:04:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 18:04:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,450,1544515200"; 
   d="scan'208";a="132216931"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga007.fm.intel.com with ESMTP; 06 Mar 2019 18:04:50 -0800
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [RFC PATCH 2/3] arch/x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for Acrn upcall vector
Date:   Thu,  7 Mar 2019 10:04:10 +0800
Message-Id: <1551924251-19466-3-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WHen it works in hypervisor guest mode, Linux kernel uses the
HYPERVISOR_CALLBACK_VECTOR for hypervisor upcall vector. And it is already
used for Xen and HyperV. After Acrn hypervisor is detected, it will also
use this defined vector as notify vector to kernel.
And two APIs are added so that the other module can add/remove the
hypervisor callback irq handler.

Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 arch/x86/entry/entry_64.S        |  5 +++++
 arch/x86/include/asm/acrnhyper.h | 16 ++++++++++++++++
 arch/x86/include/asm/hardirq.h   |  2 +-
 arch/x86/kernel/cpu/acrn.c       | 38 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/irq.c            |  2 +-
 5 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/acrnhyper.h

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb..23f12e8 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1129,6 +1129,11 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
 	hv_stimer0_callback_vector hv_stimer0_vector_handler
 #endif /* CONFIG_HYPERV */
 
+#if IS_ENABLED(CONFIG_ACRN)
+apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
+	acrn_hv_callback_vector acrn_hv_vector_handler
+#endif
+
 idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
 idtentry int3			do_int3			has_error_code=0
 idtentry stack_segment		do_stack_segment	has_error_code=1
diff --git a/arch/x86/include/asm/acrnhyper.h b/arch/x86/include/asm/acrnhyper.h
new file mode 100644
index 0000000..2562a82
--- /dev/null
+++ b/arch/x86/include/asm/acrnhyper.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ACRNHYPER_H
+#define _ASM_X86_ACRNHYPER_H
+
+#include <linux/types.h>
+#include <asm/io.h>
+
+#ifdef CONFIG_ACRN
+/* ACRN Hypervisor callback */
+void acrn_hv_callback_vector(void);
+
+void acrn_setup_intr_irq(void (*handler)(void));
+void acrn_remove_intr_irq(void);
+#endif
+
+#endif
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index d9069bb..5aa52d2 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -37,7 +37,7 @@ typedef struct {
 #ifdef CONFIG_X86_MCE_AMD
 	unsigned int irq_deferred_error_count;
 #endif
-#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
+#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN) || defined(CONFIG_ACRN)
 	unsigned int irq_hv_callback_count;
 #endif
 #if IS_ENABLED(CONFIG_HYPERV)
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index ddeaafb..c802fe6 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -10,6 +10,11 @@
  */
 
 #include <asm/hypervisor.h>
+#include <asm/acrnhyper.h>
+#include <asm/irq_vectors.h>
+#include <asm/irq_regs.h>
+#include <asm/desc.h>
+#include <linux/interrupt.h>
 
 static uint32_t __init acrn_detect(void)
 {
@@ -18,6 +23,8 @@ static uint32_t __init acrn_detect(void)
 
 static void __init acrn_init_platform(void)
 {
+	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
+			acrn_hv_callback_vector);
 }
 
 static bool acrn_x2apic_available(void)
@@ -26,6 +33,37 @@ static bool acrn_x2apic_available(void)
 	return false;
 }
 
+
+static void (*acrn_intr_handler)(void);
+/*
+ * Handler for ACRN_HV_CALLBACK.
+ */
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
+void acrn_setup_intr_irq(void (*handler)(void))
+{
+	acrn_intr_handler = handler;
+}
+EXPORT_SYMBOL(acrn_setup_intr_irq);
+
+void acrn_remove_intr_irq(void)
+{
+	acrn_intr_handler = NULL;
+}
+EXPORT_SYMBOL(acrn_remove_intr_irq);
+
 const struct hypervisor_x86 x86_hyper_acrn = {
 	.name                   = "ACRN",
 	.detect                 = acrn_detect,
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 59b5f2e..6b3eaab 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -134,7 +134,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ", per_cpu(mce_poll_count, j));
 	seq_puts(p, "  Machine check polls\n");
 #endif
-#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
+#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN) || defined(CONFIG_ACRN)
 	if (test_bit(HYPERVISOR_CALLBACK_VECTOR, system_vectors)) {
 		seq_printf(p, "%*s: ", prec, "HYP");
 		for_each_online_cpu(j)
-- 
2.7.4

