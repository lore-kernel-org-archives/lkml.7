Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B283C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F2E204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OONu8W4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436505AbfFKUo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:44:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60691 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436492AbfFKUo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:44:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5BKiBfK367267
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 11 Jun 2019 13:44:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5BKiBfK367267
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560285852;
        bh=Tjoz5lCJ7AXeJeymPbPdWev2tDF/G9j0BwFWymHSKyQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OONu8W4qIZVjRY/WPmebcA0y0+Fclg7rTNOxxslB5XseuDScMXUgAhBTdKcxGSVzM
         KLeM+ZBUgwqWaPVkN0rWEb5AbLQi0sS+MddfyPh6m3OAA4ZbdJQt8+WRyapJrsV5xX
         HEv78rK00WogW5mc9FsVE2hT7NgFkxtunsErIytxKyDL40QALAEH1wBYFOhz/p3+HW
         gALlMXvBAjEgUr5wwpFNGIKYIC/vOwK/vQ4Ftfb7ZAs9qsAZPneF3TpeQaUzUFfS/3
         Yf5krLcqnYyD3MRV1Xelgl55ENIvlgQkCwygCNLi7WlOz0a1hbCYc2MQjuN3LTqlRP
         WpwcwPjyPIdIw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5BKiAAL367264;
        Tue, 11 Jun 2019 13:44:10 -0700
Date:   Tue, 11 Jun 2019 13:44:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhao Yakui <tipbot@zytor.com>
Message-ID: <tip-ec7972c99fffb4d2739f286ce9b544a71aa1d05f@git.kernel.org>
Cc:     jason.cj.chen@intel.com, mingo@kernel.org, x86@kernel.org,
        tglx@linutronix.de, bp@suse.de, yakui.zhao@intel.com,
        hpa@zytor.com, mingo@redhat.com, linux-kernel@vger.kernel.org
Reply-To: mingo@redhat.com, hpa@zytor.com, yakui.zhao@intel.com,
          linux-kernel@vger.kernel.org, jason.cj.chen@intel.com,
          mingo@kernel.org, tglx@linutronix.de, x86@kernel.org, bp@suse.de
In-Reply-To: <1559108037-18813-3-git-send-email-yakui.zhao@intel.com>
References: <1559108037-18813-3-git-send-email-yakui.zhao@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86: Add support for Linux guests on an ACRN
 hypervisor
Git-Commit-ID: ec7972c99fffb4d2739f286ce9b544a71aa1d05f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ec7972c99fffb4d2739f286ce9b544a71aa1d05f
Gitweb:     https://git.kernel.org/tip/ec7972c99fffb4d2739f286ce9b544a71aa1d05f
Author:     Zhao Yakui <yakui.zhao@intel.com>
AuthorDate: Tue, 30 Apr 2019 11:45:24 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 11 Jun 2019 21:29:22 +0200

x86: Add support for Linux guests on an ACRN hypervisor

ACRN is an open-source hypervisor maintained by The Linux Foundation. It
is built for embedded IOT with small footprint and real-time features.
Add ACRN guest support so that it allows Linux to be booted under the
ACRN hypervisor. This adds only the barebones implementation.

 [ bp: Massage commit message and help text. ]

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1559108037-18813-3-git-send-email-yakui.zhao@intel.com
---
 arch/x86/Kconfig                  | 10 ++++++++++
 arch/x86/include/asm/hypervisor.h |  1 +
 arch/x86/kernel/cpu/Makefile      |  1 +
 arch/x86/kernel/cpu/acrn.c        | 39 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/hypervisor.c  |  4 ++++
 5 files changed, 55 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c9ab09004b16..8a95c50e5c12 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -835,6 +835,16 @@ config JAILHOUSE_GUEST
 	  cell. You can leave this option disabled if you only want to start
 	  Jailhouse and run Linux afterwards in the root cell.
 
+config ACRN_GUEST
+	bool "ACRN Guest support"
+	depends on X86_64
+	help
+	  This option allows to run Linux as guest in the ACRN hypervisor. ACRN is
+	  a flexible, lightweight reference open-source hypervisor, built with
+	  real-time and safety-criticality in mind. It is built for embedded
+	  IOT with small footprint and real-time features. More details can be
+	  found in https://projectacrn.org/.
+
 endif #HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
index 8c5aaba6633f..50a30f6c668b 100644
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
index 5102bf7c8192..3ffe1b0b7516 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_X86_CPU_RESCTRL)		+= resctrl/
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
+obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 
 ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
new file mode 100644
index 000000000000..6d365e97cce6
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
+	/*
+	 * x2apic is not supported for now. Future enablement will have to check
+	 * X86_FEATURE_X2APIC to determine whether x2apic is supported in the
+	 * guest.
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
index 479ca4728de0..87e39ad8d873 100644
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
