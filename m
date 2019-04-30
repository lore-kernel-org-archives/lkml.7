Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A3AC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557382080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfD3Dsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 23:48:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:54863 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730081AbfD3DsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:48:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 20:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,412,1549958400"; 
   d="scan'208";a="138598245"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by orsmga008.jf.intel.com with ESMTP; 29 Apr 2019 20:48:20 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de,
        Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [PATCH v6 2/4] x86: Add the support of Linux guest on ACRN hypervisor
Date:   Tue, 30 Apr 2019 11:45:24 +0800
Message-Id: <1556595926-17910-3-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556595926-17910-1-git-send-email-yakui.zhao@intel.com>
References: <1556595926-17910-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACRN is an open-source hypervisor maintained by Linux Foundation.
It is built for embedded IOT with small footprint and real-time features.
Add the ACRN guest support so that it allows linux to be booted under the
ACRN hypervisor. Following this patch it will setup the upcall
notification vector, enable hypercall and provide the interface that is
used to manage the virtualized CPU/memory/device/interrupt for other
guest OS.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v1->v2: Change the CONFIG_ACRN to CONFIG_ACRN_GUEST, which makes it easy to
understand.
        Remove the export of x86_hyper_acrn.

v2->v3: Remove the unnecessary dependency of PARAVIRT
v3->v4: Refine the commit log and add more meaningful description in Kconfig
v4->v5: No change
v5->v6: No change
---
 arch/x86/Kconfig                  | 12 ++++++++++++
 arch/x86/include/asm/hypervisor.h |  1 +
 arch/x86/kernel/cpu/Makefile      |  1 +
 arch/x86/kernel/cpu/acrn.c        | 39 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/hypervisor.c  |  4 ++++
 5 files changed, 57 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/acrn.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2fc9297..8dc4200 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -845,6 +845,18 @@ config JAILHOUSE_GUEST
 	  cell. You can leave this option disabled if you only want to start
 	  Jailhouse and run Linux afterwards in the root cell.
 
+config ACRN_GUEST
+	bool "ACRN Guest support"
+	depends on X86_64
+	help
+	  This option allows to run Linux as guest in ACRN hypervisor. Enabling
+	  this will allow the kernel to boot in virtualized environment under
+	  the ACRN hypervisor.
+	  ACRN is a flexible, lightweight reference open-source hypervisor, built
+	  with real-time and safety-criticality in mind. It is built for embedded
+	  IOT with small footprint and real-time features. More details can be
+	  found in https://projectacrn.org/
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
index cfd24f9..17a7cdf 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_X86_CPU_RESCTRL)		+= resctrl/
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
+obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 
 ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
new file mode 100644
index 0000000..f556640
--- /dev/null
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACRN detection support
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
+	/* x2apic is not supported now.
+	 * Later it needs to check the X86_FEATURE_X2APIC bit of cpu info
+	 * returned by CPUID to determine whether the x2apic is
+	 * supported in Linux guest.
+	 */
+	return false;
+}
+
+const __initconst struct hypervisor_x86 x86_hyper_acrn = {
+	.name                   = "ACRN",
+	.detect                 = acrn_detect,
+	.type			= X86_HYPER_ACRN,
+	.init.init_platform     = acrn_init_platform,
+	.init.x2apic_available  = acrn_x2apic_available,
+};
diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
index 479ca47..87e39ad 100644
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
+#ifdef CONFIG_ACRN_GUEST
+	&x86_hyper_acrn,
+#endif
 };
 
 enum x86_hypervisor_type x86_hyper_type;
-- 
2.7.4

