Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30370C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0474520661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfCGCEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:04:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:40332 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfCGCEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:04:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 18:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,450,1544515200"; 
   d="scan'208";a="132216925"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga007.fm.intel.com with ESMTP; 06 Mar 2019 18:04:49 -0800
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [RFC PATCH 1/3] arch/x86: add ACRN hypervisor guest
Date:   Thu,  7 Mar 2019 10:04:09 +0800
Message-Id: <1551924251-19466-2-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACRN is one open-source hypervisour, which is maintained by Linux
foundation. This is to add the para-virtualization support so that
it allows to enable the Linux guest on acrn-hypervisor.

This adds x86_hyper_acrn into supported hypervisors array, which
enables ACRN services guest running on ACRN hypervisor. It is
restricted to X86_64.

Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 arch/x86/Kconfig                  |  8 ++++++++
 arch/x86/include/asm/hypervisor.h |  1 +
 arch/x86/kernel/cpu/Makefile      |  1 +
 arch/x86/kernel/cpu/acrn.c        | 36 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/hypervisor.c  |  4 ++++
 5 files changed, 50 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/acrn.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 90b562a..c7b64e7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -843,6 +843,14 @@ config JAILHOUSE_GUEST
 	  cell. You can leave this option disabled if you only want to start
 	  Jailhouse and run Linux afterwards in the root cell.
 
+config ACRN
+	bool "Enable services on ACRN hypervisor"
+	depends on X86_64 && PARAVIRT
+	help
+	  This option allows to run Linux as guest in ACRN hypervisor.
+	  It is needed if you want to run ACRN services linux on top of
+	  ACRN hypervisor.
+
 endif #HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
index 8c5aaba..50a30f6 100644
--- a/arch/x86/include/asm/hypervisor.h
+++ b/arch/x86/include/asm/hypervisor.h
@@ -29,6 +29,7 @@ enum x86_hypervisor_type {
 	X86_HYPER_XEN_HVM,
 	X86_HYPER_KVM,
 	X86_HYPER_JAILHOUSE,
+	X86_HYPER_ACRN,
 };
 
 #ifdef CONFIG_HYPERVISOR_GUEST
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index cfd24f9..cde1436 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_X86_CPU_RESCTRL)		+= resctrl/
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
+obj-$(CONFIG_ACRN)			+= acrn.o
 
 ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
new file mode 100644
index 0000000..ddeaafb
--- /dev/null
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACRN hypervisor support
+ *
+ * Copyright (C) 2019 Intel Corporation. All rights reserved.
+ *
+ * Jason Chen CJ <jason.cj.chen@intel.com>
+ * Zhao Yakui <yakui.zhao@intel.com>
+ *
+ */
+
+#include <asm/hypervisor.h>
+
+static uint32_t __init acrn_detect(void)
+{
+	return hypervisor_cpuid_base("ACRNACRNACRN\0\0", 0);
+}
+
+static void __init acrn_init_platform(void)
+{
+}
+
+static bool acrn_x2apic_available(void)
+{
+	/* do not support x2apic */
+	return false;
+}
+
+const struct hypervisor_x86 x86_hyper_acrn = {
+	.name                   = "ACRN",
+	.detect                 = acrn_detect,
+	.type			= X86_HYPER_ACRN,
+	.init.init_platform     = acrn_init_platform,
+	.init.x2apic_available  = acrn_x2apic_available,
+};
+EXPORT_SYMBOL(x86_hyper_acrn);
diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
index 479ca47..5a6f072 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -32,6 +32,7 @@ extern const struct hypervisor_x86 x86_hyper_xen_pv;
 extern const struct hypervisor_x86 x86_hyper_xen_hvm;
 extern const struct hypervisor_x86 x86_hyper_kvm;
 extern const struct hypervisor_x86 x86_hyper_jailhouse;
+extern const struct hypervisor_x86 x86_hyper_acrn;
 
 static const __initconst struct hypervisor_x86 * const hypervisors[] =
 {
@@ -49,6 +50,9 @@ static const __initconst struct hypervisor_x86 * const hypervisors[] =
 #ifdef CONFIG_JAILHOUSE_GUEST
 	&x86_hyper_jailhouse,
 #endif
+#ifdef CONFIG_ACRN
+	&x86_hyper_acrn,
+#endif
 };
 
 enum x86_hypervisor_type x86_hyper_type;
-- 
2.7.4

