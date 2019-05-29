Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B24C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 05:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0003C2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 05:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfE2Fh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 01:37:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:52060 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfE2Fh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 01:37:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 22:37:57 -0700
X-ExtLoop1: 1
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga007.fm.intel.com with ESMTP; 28 May 2019 22:37:56 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH v7 1/3] x86/Kconfig: Add new config symbol to unify conditional definition of hv_irq_callback_count
Date:   Wed, 29 May 2019 13:33:55 +0800
Message-Id: <1559108037-18813-2-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559108037-18813-1-git-send-email-yakui.zhao@intel.com>
References: <1559108037-18813-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a special Kconfig symbol X86_HV_CALLBACK_VECTOR so that the guests
using the hypervisor interrupt callback counter can select and thus
enable that counter. Select it when xen or hyperv support is enabled.
No functional changes.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v3->v4: Follow the comments to refine the commit log.
---
 arch/x86/Kconfig               | 3 +++
 arch/x86/include/asm/hardirq.h | 2 +-
 arch/x86/kernel/irq.c          | 2 +-
 arch/x86/xen/Kconfig           | 1 +
 drivers/hv/Kconfig             | 1 +
 5 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d..c9ab090 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -781,6 +781,9 @@ config PARAVIRT_SPINLOCKS
 
 	  If you are unsure how to answer this question, answer Y.
 
+config X86_HV_CALLBACK_VECTOR
+	def_bool n
+
 source "arch/x86/xen/Kconfig"
 
 config KVM_GUEST
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index d9069bb..0753379 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -37,7 +37,7 @@ typedef struct {
 #ifdef CONFIG_X86_MCE_AMD
 	unsigned int irq_deferred_error_count;
 #endif
-#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
+#ifdef CONFIG_X86_HV_CALLBACK_VECTOR
 	unsigned int irq_hv_callback_count;
 #endif
 #if IS_ENABLED(CONFIG_HYPERV)
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 9b68b5b..4e8f193 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -135,7 +135,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ", per_cpu(mce_poll_count, j));
 	seq_puts(p, "  Machine check polls\n");
 #endif
-#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
+#ifdef CONFIG_X86_HV_CALLBACK_VECTOR
 	if (test_bit(HYPERVISOR_CALLBACK_VECTOR, system_vectors)) {
 		seq_printf(p, "%*s: ", prec, "HYP");
 		for_each_online_cpu(j)
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index e07abef..ba5a418 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -7,6 +7,7 @@ config XEN
 	bool "Xen guest support"
 	depends on PARAVIRT
 	select PARAVIRT_CLOCK
+	select X86_HV_CALLBACK_VECTOR
 	depends on X86_64 || (X86_32 && X86_PAE)
 	depends on X86_LOCAL_APIC && X86_TSC
 	help
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 1c1a251..cafcb97 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -6,6 +6,7 @@ config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
 	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
 	select PARAVIRT
+	select X86_HV_CALLBACK_VECTOR
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
-- 
2.7.4

