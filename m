Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8BAC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 14:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8152087E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 14:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="d5SCL5BB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfHROnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 10:43:02 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:21544 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfHROnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 10:43:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 02ED13F6C7;
        Sun, 18 Aug 2019 16:33:52 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=d5SCL5BB;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u1_ZzgroBEbh; Sun, 18 Aug 2019 16:33:51 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 28C8B3F6BF;
        Sun, 18 Aug 2019 16:33:49 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 75D2C3600F4;
        Sun, 18 Aug 2019 16:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566138829; bh=j8QozsqC79jSVbbYQLmrWwSSwmzDe9qDry/0JCPkTco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5SCL5BBqBXg6Z3t+Py1tBUJ1SiHVOGkE9NabOb2IQKYUQkeqPbHmMVxaaSwQ4S62
         4P6MGARl43QnM6M1BL/viEb7A1wGUYbKyVKqQVs1lRlOEiqHLcgCK5q/pogEiIycUa
         a46JPOQtDoSqmiioYqlRcWtCfmWmGbm0ow5bJRuQ=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
Subject: [PATCH 1/4] x86/vmware: Update platform detection code for VMCALL/VMMCALL hypercalls
Date:   Sun, 18 Aug 2019 16:33:13 +0200
Message-Id: <20190818143316.4906-2-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190818143316.4906-1-thomas_os@shipmail.org>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Vmware has historically used an "inl" instruction for this, but recent
hardware versions support using VMCALL/VMMCALL instead, so use this method
if supported at platform detection time. We explicitly need to code
separate macro versions since the alternatives self-patching has not
been performed at platform detection time.

We also put tighter constraints on the assembly input parameters and update
the SPDX license info.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Co-developed-by: Doug Covelli <dcovelli@vmware.com>
Signed-off-by: Doug Covelli <dcovelli@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 89 +++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 3c648476d4fb..bf6786d86f2e 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * VMware Detection code.
  *
@@ -30,34 +31,70 @@
 #include <asm/hypervisor.h>
 #include <asm/timer.h>
 #include <asm/apic.h>
+#include <asm/svm.h>
 
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
+		"d"(VMWARE_HYPERVISOR_PORT), "b"(UINT_MAX) :		\
+		"memory")
+
+#define VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx)                         \
+	__asm__("vmmcall" :						\
+		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
+		"a"(VMWARE_HYPERVISOR_MAGIC),				\
+		"c"(VMWARE_CMD_##cmd),					\
+		"d"(VMWARE_HYPERVISOR_PORT), "b"(UINT_MAX) :		\
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
 
@@ -136,7 +173,7 @@ static void __init vmware_platform_setup(void)
 	uint32_t eax, ebx, ecx, edx;
 	uint64_t lpj, tsc_khz;
 
-	VMWARE_PORT(GETHZ, eax, ebx, ecx, edx);
+	VMWARE_CMD(GETHZ, eax, ebx, ecx, edx);
 
 	if (ebx != UINT_MAX) {
 		lpj = tsc_khz = eax | (((uint64_t)ebx) << 32);
@@ -174,6 +211,16 @@ static void __init vmware_platform_setup(void)
 	vmware_set_capabilities();
 }
 
+static u8
+vmware_select_hypercall(void)
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
@@ -187,8 +234,16 @@ static uint32_t __init vmware_platform(void)
 
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
@@ -200,9 +255,9 @@ static uint32_t __init vmware_platform(void)
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
-- 
2.20.1

