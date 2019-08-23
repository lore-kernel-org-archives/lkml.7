Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6EAC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6944722CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="Rgi+8dxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404286AbfHWIN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:13:59 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:55772 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392425AbfHWIN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:13:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 7872D3F2EF;
        Fri, 23 Aug 2019 10:13:48 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Rgi+8dxt;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XVTpd7kfe3Gs; Fri, 23 Aug 2019 10:13:47 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 1206E3F6E1;
        Fri, 23 Aug 2019 10:13:47 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 9804A3601BA;
        Fri, 23 Aug 2019 10:13:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566548026; bh=WtBbkNnAMop3WDhawZXyUZUBZ0lCBoFyNp4umI0liy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rgi+8dxtMyysJll6ti+xzZFdY8tFBArn/BiOEdfGEdArJy1KGP3JiCiDqq9Y6V/Yr
         nmfsKFJJ9t8APzD9QZ1AkymG1bjzhyM/IOIdJwPeOH3F+0Y7nHDeBO9Fo8FVIf8exj
         p7xwOiByuwuHwXKMCNnnL2PfX7a0xy7pPwyzsFeY=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        dri-devel@lists.freedesktop.org, Doug Covelli <dcovelli@vmware.com>
Subject: [PATCH v2 2/4] x86/vmware: Add a header file for hypercall definitions
Date:   Fri, 23 Aug 2019 10:13:14 +0200
Message-Id: <20190823081316.28478-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190823081316.28478-1-thomas_os@shipmail.org>
References: <20190823081316.28478-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The new header is intended to be used by drivers using the backdoor.
Follow the kvm example using alternatives self-patching to
choose between vmcall, vmmcall and io instructions.

Also define two new CPU feature flags to indicate hypervisor support
for vmcall- and vmmcall instructions.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: <dri-devel@lists.freedesktop.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
---
 MAINTAINERS                        |  1 +
 arch/x86/include/asm/cpufeatures.h |  2 ++
 arch/x86/include/asm/vmware.h      | 48 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/vmware.c       |  6 +++-
 4 files changed, 56 insertions(+), 1 deletion(-)
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
index 000000000000..4b220e2bb3e8
--- /dev/null
+++ b/arch/x86/include/asm/vmware.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+#ifndef _ASM_X86_VMWARE_H
+#define _ASM_X86_VMWARE_H
+
+#include <asm/cpufeatures.h>
+#include <asm/alternative.h>
+
+/*
+ * The hypercall definitions differ in the low word of the edx argument in
+ * the following way: The old port base interface uses the port number to
+ * distinguish between high- and low bandwidth versions. The new vmcall
+ * interface instead uses a set of flags to select bandwidth mode and
+ * transfer direction. New driver code should strictly use the new
+ * definition of edx content.
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
index fcb84b1e099e..abaa1b27353c 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -31,6 +31,7 @@
 #include <asm/timer.h>
 #include <asm/apic.h>
 #include <asm/svm.h>
+#include <asm/vmware.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"vmware: " fmt
@@ -41,7 +42,6 @@
 #define CPUID_VMWARE_FEATURES_ECX_VMCALL     BIT(1)
 
 #define VMWARE_HYPERVISOR_MAGIC	0x564D5868
-#define VMWARE_HYPERVISOR_PORT	0x5658
 
 #define VMWARE_CMD_GETVERSION    10
 #define VMWARE_CMD_GETHZ         45
@@ -165,6 +165,10 @@ static void __init vmware_set_capabilities(void)
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

