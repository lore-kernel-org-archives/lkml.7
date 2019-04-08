Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E171C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D1C20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDHIOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:14:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:12779 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfDHIOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:14:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 01:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="147424252"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2019 01:14:05 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de,
        Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC PATCH v3 1/4] x86: Add new config symbol to unify conditional definition of hv_irq_callback_count
Date:   Mon,  8 Apr 2019 16:12:08 +0800
Message-Id: <1554711131-21514-2-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the CONFIG_HYPERV and CONFIG_XEN can be used to control the definition
/usage of hv_irq_callback_count. If another linux guest also needs to use
the hv_irq_callback_count, current conditional definition looks unreadable.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 arch/x86/Kconfig               | 3 +++
 arch/x86/include/asm/hardirq.h | 2 +-
 arch/x86/kernel/irq.c          | 2 +-
 arch/x86/xen/Kconfig           | 1 +
 drivers/hv/Kconfig             | 1 +
 5 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ad9241..54d1fbc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -791,6 +791,9 @@ config QUEUED_LOCK_STAT
 	  behavior of paravirtualized queued spinlocks and report
 	  them on debugfs.
 
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
index 59b5f2e..a147826 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -134,7 +134,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
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

