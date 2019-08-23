Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD17C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3605C233FD
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="VNemFZLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392369AbfHWINv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:13:51 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:58266 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbfHWINu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:13:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id D96333F68F;
        Fri, 23 Aug 2019 10:13:47 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=VNemFZLM;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YPZUC8YpLuKe; Fri, 23 Aug 2019 10:13:47 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id DA44D3F451;
        Fri, 23 Aug 2019 10:13:45 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 55C45360327;
        Fri, 23 Aug 2019 10:13:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566548025; bh=8TJ1hcSl0csUhsKggZZWmkrOM9qp00puRQyW2sKgfe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNemFZLMynxKk3L65ciagEwT045888HhBB4lNs5mZaJUg577wvadn55SNOer9ECQO
         bcOLwgpmgU52KR57RVagahTp4m/0y16bf3MisU8TafDx7eTDQ3+LAHxi8RcvpJcdHW
         h7tfA63t6X+vhBbjCHbaruuoUokwqKcsEVPpgNsA=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        dri-devel@lists.freedekstop.org, Doug Covelli <dcovelli@vmware.com>
Subject: [PATCH v2 1/4] x86/vmware: Update platform detection code for VMCALL/VMMCALL hypercalls
Date:   Fri, 23 Aug 2019 10:13:13 +0200
Message-Id: <20190823081316.28478-2-thomas_os@shipmail.org>
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

Vmware has historically used an "inl" instruction for this, but recent
hardware versions support using VMCALL/VMMCALL instead, so use this method
if supported at platform detection time. We explicitly need to code
separate macro versions since the alternatives self-patching has not
been performed at platform detection time.

Also put tighter constraints on the assembly input parameters.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: <dri-devel@lists.freedekstop.org>
Co-developed-by: Doug Covelli <dcovelli@vmware.com>
Signed-off-by: Doug Covelli <dcovelli@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 88 +++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 3c648476d4fb..fcb84b1e099e 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -30,34 +30,70 @@
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
 
@@ -136,7 +172,7 @@ static void __init vmware_platform_setup(void)
 	uint32_t eax, ebx, ecx, edx;
 	uint64_t lpj, tsc_khz;
 
-	VMWARE_PORT(GETHZ, eax, ebx, ecx, edx);
+	VMWARE_CMD(GETHZ, eax, ebx, ecx, edx);
 
 	if (ebx != UINT_MAX) {
 		lpj = tsc_khz = eax | (((uint64_t)ebx) << 32);
@@ -174,6 +210,16 @@ static void __init vmware_platform_setup(void)
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
-- 
2.20.1

