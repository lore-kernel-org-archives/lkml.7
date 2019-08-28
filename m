Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C6BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0488C22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfH1Nbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:31:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47288 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfH1Nbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:31:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2y2J-0004MZ-M7; Wed, 28 Aug 2019 15:30:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4ACB51C0DE2;
        Wed, 28 Aug 2019 15:30:55 +0200 (CEST)
Date:   Wed, 28 Aug 2019 13:30:55 -0000
From:   "tip-bot2 for Thomas Hellstrom" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Add a header file for hypercall definitions
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Borislav Petkov <bp@suse.de>,
        Doug Covelli <dcovelli@vmware.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-graphics-maintainer@vmware.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Robert Hoo <robert.hu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org, <pv-drivers@vmware.com>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190828080353.12658-3-thomas_os@shipmail.org>
References: <20190828080353.12658-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Message-ID: <156699905522.5313.7855443081930586035.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     b4dd4f6e3648dfd66576515f2222d885a9a765c0
Gitweb:        https://git.kernel.org/tip/b4dd4f6e3648dfd66576515f2222d885a9a765c0
Author:        Thomas Hellstrom <thellstrom@vmware.com>
AuthorDate:    Wed, 28 Aug 2019 10:03:51 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 28 Aug 2019 13:32:06 +02:00

x86/vmware: Add a header file for hypercall definitions

The new header is intended to be used by drivers using the backdoor.
Follow the KVM example using alternatives self-patching to choose
between vmcall, vmmcall and io instructions.

Also define two new CPU feature flags to indicate hypervisor support
for vmcall- and vmmcall instructions. The new XF86_FEATURE_VMW_VMMCALL
flag is needed because using XF86_FEATURE_VMMCALL might break QEMU/KVM
setups using the vmmouse driver. They rely on XF86_FEATURE_VMMCALL
on AMD to get the kvm_hypercall() right. But they do not yet implement
vmmcall for the VMware hypercall used by the vmmouse driver.

 [ bp: reflow hypercall %edx usage explanation comment. ]

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
Cc: Aaron Lewis <aaronlewis@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-graphics-maintainer@vmware.com
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Robert Hoo <robert.hu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: virtualization@lists.linux-foundation.org
Cc: <pv-drivers@vmware.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190828080353.12658-3-thomas_os@shipmail.org
---
 MAINTAINERS                        |  1 +-
 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/include/asm/vmware.h      | 53 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/vmware.c       |  6 ++-
 4 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/vmware.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9cbcf16..47efc1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17206,6 +17206,7 @@ M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Supported
 F:	arch/x86/kernel/cpu/vmware.c
+F:	arch/x86/include/asm/vmware.h
 
 VMWARE PVRDMA DRIVER
 M:	Adit Ranadive <aditr@vmware.com>
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index e880f24..aaeae2f 100644
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
index 0000000..e00c9e8
--- /dev/null
+++ b/arch/x86/include/asm/vmware.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+#ifndef _ASM_X86_VMWARE_H
+#define _ASM_X86_VMWARE_H
+
+#include <asm/cpufeatures.h>
+#include <asm/alternative.h>
+
+/*
+ * The hypercall definitions differ in the low word of the %edx argument
+ * in the following way: the old port base interface uses the port
+ * number to distinguish between high- and low bandwidth versions.
+ *
+ * The new vmcall interface instead uses a set of flags to select
+ * bandwidth mode and transfer direction. The flags should be loaded
+ * into %dx by any user and are automatically replaced by the port
+ * number if the VMWARE_HYPERVISOR_PORT method is used.
+ *
+ * In short, new driver code should strictly use the new definition of
+ * %dx content.
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
index 757dded..9735139 100644
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
