Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAFAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B4F22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="nrys4i9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfH1IEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:04:22 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:24858 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfH1IEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:04:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 665763F6BF;
        Wed, 28 Aug 2019 10:04:19 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=nrys4i9N;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FxS2OzjsSHpP; Wed, 28 Aug 2019 10:04:18 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 224053F685;
        Wed, 28 Aug 2019 10:04:16 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 8B33D36112D;
        Wed, 28 Aug 2019 10:04:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566979456; bh=4XtI0qHgeHp+CuBF0GkLJLEP5CmS3KUn7pLo3SYrBGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrys4i9NkpsXODQrKk025hW/BJjijfmZAkO6xMeSHtg0Ik6QaupO8bBHeY0eoCddr
         EuqBJxC0aLxL0IM603BM6ssZ4mg1PbtAxVPsOOhvFl1yfENCnbO1inaSEgfcuz6SkR
         8eg11GE5Njm0caCWnIjYoYFVTBxhJA9EBb3dyLrQ=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
Subject: [PATCH v3 2/4] x86/vmware: Add a header file for hypercall definitions
Date:   Wed, 28 Aug 2019 10:03:51 +0200
Message-Id: <20190828080353.12658-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828080353.12658-1-thomas_os@shipmail.org>
References: <20190828080353.12658-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The new header is intended to be used by drivers using the backdoor.
Follow the KVM example using alternatives self-patching to
choose between vmcall, vmmcall and io instructions.

Also define two new CPU feature flags to indicate hypervisor support
for vmcall- and vmmcall instructions. The new XF86_FEATURE_VMW_VMMCALL
flag is needed because using XF86_FEATURE_VMMCALL might break QEMU/KVM
setups using the vmmouse driver. They rely on XF86_FEATURE_VMMCALL
on AMD to get the kvm_hypercall() right. But they do not yet implement
vmmcall for the VMware hypercall used by the vmmouse driver.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
---
 MAINTAINERS                        |  1 +
 arch/x86/include/asm/cpufeatures.h |  2 ++
 arch/x86/include/asm/vmware.h      | 50 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/vmware.c       |  6 +++-
 4 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/vmware.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c2d975da561f..5bf65a49fa19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17203,6 +17203,7 @@ M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Supported
 F:	arch/x86/kernel/cpu/vmware.c
+F:	arch/x86/include/asm/vmware.h
 
 VMWARE PVRDMA DRIVER
 M:	Adit Ranadive <aditr@vmware.com>
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 998c2cc08363..55fa3b3f0bac 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -232,6 +232,8 @@
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
+#define X86_FEATURE_VMCALL		( 8*32+18) /* "" Hypervisor supports the VMCALL instruction */
+#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
new file mode 100644
index 000000000000..478bbc05746d
--- /dev/null
+++ b/arch/x86/include/asm/vmware.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+#ifndef _ASM_X86_VMWARE_H
+#define _ASM_X86_VMWARE_H
+
+#include <asm/cpufeatures.h>
+#include <asm/alternative.h>
+
+/*
+ * The hypercall definitions differ in the low word of the %edx argument in
+ * the following way: The old port base interface uses the port number to
+ * distinguish between high- and low bandwidth versions. The new vmcall
+ * interface instead uses a set of flags to select bandwidth mode and
+ * transfer direction. The flags should be loaded into %dx by any user
+ * and are automatically replaced by the port number if the
+ * VMWARE_HYPERVISOR_PORT method is used. In short, New driver code should
+ * strictly use the new definition of %dx content.
+ */
+
+/* Old port-based version */
+#define VMWARE_HYPERVISOR_PORT    "0x5658"
+#define VMWARE_HYPERVISOR_PORT_HB "0x5659"
+
+/* Current vmcall / vmmcall version */
+#define VMWARE_HYPERVISOR_HB   BIT(0)
+#define VMWARE_HYPERVISOR_OUT  BIT(1)
+
+/* The low bandwidth call. The low word of edx is presumed clear. */
+#define VMWARE_HYPERCALL						\
+	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT ", %%dx; inl (%%dx)", \
+		      "vmcall", X86_FEATURE_VMCALL,			\
+		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
+
+/*
+ * The high bandwidth out call. The low word of edx is presumed to have the
+ * HB and OUT bits set.
+ */
+#define VMWARE_HYPERCALL_HB_OUT						\
+	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep outsb", \
+		      "vmcall", X86_FEATURE_VMCALL,			\
+		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
+
+/*
+ * The high bandwidth in call. The low word of edx is presumed to have the
+ * HB bit set.
+ */
+#define VMWARE_HYPERCALL_HB_IN						\
+	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep insb", \
+		      "vmcall", X86_FEATURE_VMCALL,			\
+		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
+#endif
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 757dded223af..9735139cfdf8 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -30,6 +30,7 @@
 #include <asm/hypervisor.h>
 #include <asm/timer.h>
 #include <asm/apic.h>
+#include <asm/vmware.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"vmware: " fmt
@@ -40,7 +41,6 @@
 #define CPUID_VMWARE_FEATURES_ECX_VMCALL     BIT(1)
 
 #define VMWARE_HYPERVISOR_MAGIC	0x564D5868
-#define VMWARE_HYPERVISOR_PORT	0x5658
 
 #define VMWARE_CMD_GETVERSION    10
 #define VMWARE_CMD_GETHZ         45
@@ -164,6 +164,10 @@ static void __init vmware_set_capabilities(void)
 {
 	setup_force_cpu_cap(X86_FEATURE_CONSTANT_TSC);
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
+		setup_force_cpu_cap(X86_FEATURE_VMCALL);
+	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
+		setup_force_cpu_cap(X86_FEATURE_VMW_VMMCALL);
 }
 
 static void __init vmware_platform_setup(void)
-- 
2.20.1

