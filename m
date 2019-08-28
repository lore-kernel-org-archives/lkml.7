Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DD1C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36EC22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfH1NbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:31:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47264 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfH1NbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:31:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2y2J-0004MS-5C; Wed, 28 Aug 2019 15:30:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C55241C07D2;
        Wed, 28 Aug 2019 15:30:54 +0200 (CEST)
Date:   Wed, 28 Aug 2019 13:30:54 -0000
From:   "tip-bot2 for Thomas Hellstrom" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Update platform detection code for
 VMCALL/VMMCALL hypercalls
Cc:     Doug Covelli <dcovelli@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-graphics-maintainer@vmware.com,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org, <pv-drivers@vmware.com>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190828080353.12658-2-thomas_os@shipmail.org>
References: <20190828080353.12658-2-thomas_os@shipmail.org>
MIME-Version: 1.0
Message-ID: <156699905467.5310.17325936546223421628.tip-bot2@tip-bot2>
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

Commit-ID:     bac7b4e843232a3a49a042410cf743341eb0887e
Gitweb:        https://git.kernel.org/tip/bac7b4e843232a3a49a042410cf743341eb0887e
Author:        Thomas Hellstrom <thellstrom@vmware.com>
AuthorDate:    Wed, 28 Aug 2019 10:03:50 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 28 Aug 2019 10:48:30 +02:00

x86/vmware: Update platform detection code for VMCALL/VMMCALL hypercalls

Vmware has historically used an INL instruction for this, but recent
hardware versions support using VMCALL/VMMCALL instead, so use this
method if supported at platform detection time. Explicitly code separate
macro versions since the alternatives self-patching has not been
performed at platform detection time.

Also put tighter constraints on the assembly input parameters.

Co-developed-by: Doug Covelli <dcovelli@vmware.com>
Signed-off-by: Doug Covelli <dcovelli@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-graphics-maintainer@vmware.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: virtualization@lists.linux-foundation.org
Cc: <pv-drivers@vmware.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190828080353.12658-2-thomas_os@shipmail.org
---
 arch/x86/kernel/cpu/vmware.c | 88 ++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 3c64847..757dded 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -34,30 +34,65 @@
 #undef pr_fmt
 #define pr_fmt(fmt)	"vmware: " fmt
 
-#define CPUID_VMWARE_INFO_LEAF	0x40000000
+#define CPUID_VMWARE_INFO_LEAF               0x40000000
+#define CPUID_VMWARE_FEATURES_LEAF           0x40000010
+#define CPUID_VMWARE_FEATURES_ECX_VMMCALL    BIT(0)
+#define CPUID_VMWARE_FEATURES_ECX_VMCALL     BIT(1)
+
 #define VMWARE_HYPERVISOR_MAGIC	0x564D5868
 #define VMWARE_HYPERVISOR_PORT	0x5658
 
-#define VMWARE_PORT_CMD_GETVERSION	10
-#define VMWARE_PORT_CMD_GETHZ		45
-#define VMWARE_PORT_CMD_GETVCPU_INFO	68
-#define VMWARE_PORT_CMD_LEGACY_X2APIC	3
-#define VMWARE_PORT_CMD_VCPU_RESERVED	31
+#define VMWARE_CMD_GETVERSION    10
+#define VMWARE_CMD_GETHZ         45
+#define VMWARE_CMD_GETVCPU_INFO  68
+#define VMWARE_CMD_LEGACY_X2APIC  3
+#define VMWARE_CMD_VCPU_RESERVED 31
 
 #define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
 	__asm__("inl (%%dx)" :						\
-			"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :	\
-			"0"(VMWARE_HYPERVISOR_MAGIC),			\
-			"1"(VMWARE_PORT_CMD_##cmd),			\
-			"2"(VMWARE_HYPERVISOR_PORT), "3"(UINT_MAX) :	\
-			"memory");
+		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
+		"a"(VMWARE_HYPERVISOR_MAGIC),				\
+		"c"(VMWARE_CMD_##cmd),					\
+		"d"(VMWARE_HYPERVISOR_PORT), "b"(UINT_MAX) :		\
+		"memory")
+
+#define VMWARE_VMCALL(cmd, eax, ebx, ecx, edx)				\
+	__asm__("vmcall" :						\
+		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
+		"a"(VMWARE_HYPERVISOR_MAGIC),				\
+		"c"(VMWARE_CMD_##cmd),					\
+		"d"(0), "b"(UINT_MAX) :					\
+		"memory")
+
+#define VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx)                         \
+	__asm__("vmmcall" :						\
+		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
+		"a"(VMWARE_HYPERVISOR_MAGIC),				\
+		"c"(VMWARE_CMD_##cmd),					\
+		"d"(0), "b"(UINT_MAX) :					\
+		"memory")
+
+#define VMWARE_CMD(cmd, eax, ebx, ecx, edx) do {		\
+	switch (vmware_hypercall_mode) {			\
+	case CPUID_VMWARE_FEATURES_ECX_VMCALL:			\
+		VMWARE_VMCALL(cmd, eax, ebx, ecx, edx);		\
+		break;						\
+	case CPUID_VMWARE_FEATURES_ECX_VMMCALL:			\
+		VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx);	\
+		break;						\
+	default:						\
+		VMWARE_PORT(cmd, eax, ebx, ecx, edx);		\
+		break;						\
+	}							\
+	} while (0)
 
 static unsigned long vmware_tsc_khz __ro_after_init;
+static u8 vmware_hypercall_mode     __ro_after_init;
 
 static inline int __vmware_platform(void)
 {
 	uint32_t eax, ebx, ecx, edx;
-	VMWARE_PORT(GETVERSION, eax, ebx, ecx, edx);
+	VMWARE_CMD(GETVERSION, eax, ebx, ecx, edx);
 	return eax != (uint32_t)-1 && ebx == VMWARE_HYPERVISOR_MAGIC;
 }
 
@@ -136,7 +171,7 @@ static void __init vmware_platform_setup(void)
 	uint32_t eax, ebx, ecx, edx;
 	uint64_t lpj, tsc_khz;
 
-	VMWARE_PORT(GETHZ, eax, ebx, ecx, edx);
+	VMWARE_CMD(GETHZ, eax, ebx, ecx, edx);
 
 	if (ebx != UINT_MAX) {
 		lpj = tsc_khz = eax | (((uint64_t)ebx) << 32);
@@ -174,10 +209,21 @@ static void __init vmware_platform_setup(void)
 	vmware_set_capabilities();
 }
 
+static u8 vmware_select_hypercall(void)
+{
+	int eax, ebx, ecx, edx;
+
+	cpuid(CPUID_VMWARE_FEATURES_LEAF, &eax, &ebx, &ecx, &edx);
+	return (ecx & (CPUID_VMWARE_FEATURES_ECX_VMMCALL |
+		       CPUID_VMWARE_FEATURES_ECX_VMCALL));
+}
+
 /*
  * While checking the dmi string information, just checking the product
  * serial key should be enough, as this will always have a VMware
  * specific string when running under VMware hypervisor.
+ * If !boot_cpu_has(X86_FEATURE_HYPERVISOR), vmware_hypercall_mode
+ * intentionally defaults to 0.
  */
 static uint32_t __init vmware_platform(void)
 {
@@ -187,8 +233,16 @@ static uint32_t __init vmware_platform(void)
 
 		cpuid(CPUID_VMWARE_INFO_LEAF, &eax, &hyper_vendor_id[0],
 		      &hyper_vendor_id[1], &hyper_vendor_id[2]);
-		if (!memcmp(hyper_vendor_id, "VMwareVMware", 12))
+		if (!memcmp(hyper_vendor_id, "VMwareVMware", 12)) {
+			if (eax >= CPUID_VMWARE_FEATURES_LEAF)
+				vmware_hypercall_mode =
+					vmware_select_hypercall();
+
+			pr_info("hypercall mode: 0x%02x\n",
+				(unsigned int) vmware_hypercall_mode);
+
 			return CPUID_VMWARE_INFO_LEAF;
+		}
 	} else if (dmi_available && dmi_name_in_serial("VMware") &&
 		   __vmware_platform())
 		return 1;
@@ -200,9 +254,9 @@ static uint32_t __init vmware_platform(void)
 static bool __init vmware_legacy_x2apic_available(void)
 {
 	uint32_t eax, ebx, ecx, edx;
-	VMWARE_PORT(GETVCPU_INFO, eax, ebx, ecx, edx);
-	return (eax & (1 << VMWARE_PORT_CMD_VCPU_RESERVED)) == 0 &&
-	       (eax & (1 << VMWARE_PORT_CMD_LEGACY_X2APIC)) != 0;
+	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
+	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
+	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
 }
 
 const __initconst struct hypervisor_x86 x86_hyper_vmware = {
