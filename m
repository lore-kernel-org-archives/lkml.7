Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B86C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B91206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jXMGTNLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfHAA6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:58:41 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61763 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfHAA6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564621120; x=1596157120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+zY9hAEVm58gSXJfAJQWINzIbb639f01AsOcw7UEO4w=;
  b=jXMGTNLn+NPfbHeKgEns6pGPNR2TumrTXoO3L2v2cyTMQyyWY3dM5f7a
   hHe2KAGgq0kpSCsbsmDMIVcezxFWInjGmh3Dp31t/pn+VPHXTTSamIbu6
   mCP0i9/egnf3ht+x6pfPi02c0L6YOLRv4rINaGDSFAhKpaPOICPF7ymH2
   Cz0UipjxCBTWg1Psf0UfhBOPaiEMKTC/DEHZWejIZx0YqgbpiRPEIwUY7
   KG4OWCtITdxz4RZQtKO7BwazXGb93Ps6IfF6OD0jlkiT60IcmPn65VZbj
   5MS/8ZGW0y2zdd3rma9B6hJ8eiVVrxAv2xOd8D4h85FHmmkPjTpMXRoEj
   w==;
IronPort-SDR: 8Xte4gZn8SizZ51vGiL2gS9nCy3RGWwGUXAwbsfSWKUPkSRZR+BEXWeIeQV/rNbg+Y5WBafBCd
 xUwXSddt+ywP2SpQHVTsj5ErI1lUFvGM+6oKtTxl+J/BYsiOOb1hEA84iC2su0676KyBNp/aRQ
 mlBZ+0VJK1GoKBzJnsaLevthB83J5XWDu7/vY5Ski3c2y74fIK7kEHEuvkwJFlMVU15wS0ozbD
 dMvmtEfP1x6j5zrod7acW7tVTkjomFs57YZS9x8cPV+VbvMfEAQd1hf6aH8d2h4rLuQ92TCc++
 yfU=
X-IronPort-AV: E=Sophos;i="5.64,332,1559491200"; 
   d="scan'208";a="116247214"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 08:58:40 +0800
IronPort-SDR: J+ZG+bRmNQpySioU3qugfOU6n7N6Lgb/umSfSmC9EzbKPztV7oGqPrbmRIb8Xj5OdsmG+ZNmdQ
 5dRUTZt9Y78htchK4Vw0XlIgzZPMYJClinQPoANQ012otwxfNwWn0173fFYpLRxg+4OXCp1Uvw
 5guuSoB/sPjexN4bYtNmcJcmGLYONFXkFwxF3wrgvZgEyHqtEK4/709aJa0QrqwGijuXcG4kFR
 iDGX8dV3yrLJv0WJDaB1iZblhY/rl0U4ruGN7aHdBr+fztifGPILEgzG0RxXz+8Hb6K0g8uS21
 aCZWXjxdchSrZNrCCfDwoWYB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 17:56:39 -0700
IronPort-SDR: WfNKScKCSJLOm+bwKSqkTZLs6UXGdvplnSR2K1aC1Owz28W0cyBACGtINOxzf6kNaFOakw5sU7
 Jcht1d31lDGLyK+JEgOCCYQAOTkV34oz7QFcR85kYxv0LpE+vY8D/faTuV7lk2cA0SBtM5ZY7V
 35dWVcunseKb27my3S42oddaIwPm2914UrNA4j2jDFOsOE/cYvnXWvVGcuK/0iIVu8SNzuF9IV
 0SVjuBKV/swMjN+zDDrglszNuSuNk6LZ0vy5zlyoOX7QqD7Hd1PnpSBCueejD8PO/yAl7ZJIkt
 Aww=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Jul 2019 17:58:38 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3 3/5] RISC-V: Fix unsupported isa string info.
Date:   Wed, 31 Jul 2019 17:58:41 -0700
Message-Id: <20190801005843.10343-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801005843.10343-1-atish.patra@wdc.com>
References: <20190801005843.10343-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kernel prints a info warning if any of the extensions
from "mafdcsu" is missing in device tree. This is not entirely
correct as Linux can boot with "f or d" extensions if kernel is
configured accordingly. Moreover, it will continue to print the
info string for future extensions such as hypervisor as well which
is misleading. /proc/cpuinfo also doesn't print any other extensions
except "mafdcsu".

Make sure that info log is only printed only if kernel is configured
to have any mandatory extensions but device tree doesn't describe it.
All the extensions present in device tree and follow the order
described in the RISC-V specification (except 'S') are printed via
/proc/cpuinfo always.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/cpu.c | 47 ++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 7da3c6a93abd..9b1d4550fbe6 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -7,6 +7,7 @@
 #include <linux/seq_file.h>
 #include <linux/of.h>
 #include <asm/smp.h>
+#include <asm/hwcap.h>
 
 /*
  * Returns the hart ID of the given device tree node, or -ENODEV if the node
@@ -46,11 +47,14 @@ int riscv_of_processor_hartid(struct device_node *node)
 
 #ifdef CONFIG_PROC_FS
 
-static void print_isa(struct seq_file *f, const char *orig_isa)
+static void print_isa(struct seq_file *f, const char *orig_isa,
+		      unsigned long cpuid)
 {
-	static const char *ext = "mafdcsu";
+	static const char *mandatory_ext = "mafdcsu";
 	const char *isa = orig_isa;
 	const char *e;
+	char unsupported_isa[26] = {0};
+	int index = 0;
 
 	/*
 	 * Linux doesn't support rv32e or rv128i, and we only support booting
@@ -70,27 +74,50 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
 	isa += 5;
 
 	/*
-	 * Check the rest of the ISA string for valid extensions, printing those
-	 * we find.  RISC-V ISA strings define an order, so we only print the
+	 * RISC-V ISA strings define an order, so we only print all the
 	 * extension bits when they're in order. Hide the supervisor (S)
 	 * extension from userspace as it's not accessible from there.
+	 * Throw a warning only if any mandatory extensions are not available
+	 * and kernel is configured to have that mandatory extensions.
 	 */
-	for (e = ext; *e != '\0'; ++e) {
-		if (isa[0] == e[0]) {
+	for (e = mandatory_ext; *e != '\0'; ++e) {
+		if (isa[0] != e[0]) {
+#if defined(CONFIG_ISA_RISCV_C)
+			if (isa[0] == 'c')
+				continue;
+#endif
+#if defined(CONFIG_FP)
+			if ((isa[0] == 'f') || (isa[0] == 'd'))
+				continue;
+#endif
+			unsupported_isa[index] = e[0];
+			index++;
+		}
+		/* Only write if part of isa string */
+		if (isa[0] != '\0') {
 			if (isa[0] != 's')
 				seq_write(f, isa, 1);
-
 			isa++;
 		}
 	}
+	if (isa[0] != '\0') {
+		/* Add remainging isa strings */
+		for (e = isa; *e != '\0'; ++e) {
+#if !defined(CONFIG_VIRTUALIZATION)
+			if (e[0] != 'h')
+#endif
+				seq_write(f, e, 1);
+		}
+	}
 	seq_puts(f, "\n");
 
 	/*
 	 * If we were given an unsupported ISA in the device tree then print
 	 * a bit of info describing what went wrong.
 	 */
-	if (isa[0] != '\0')
-		pr_info("unsupported ISA \"%s\" in device tree\n", orig_isa);
+	if (unsupported_isa[0])
+		pr_info("unsupported ISA extensions \"%s\" in device tree for cpu [%ld]\n",
+			unsupported_isa, cpuid);
 }
 
 static void print_mmu(struct seq_file *f, const char *mmu_type)
@@ -134,7 +161,7 @@ static int c_show(struct seq_file *m, void *v)
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
 	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
 	if (!of_property_read_string(node, "riscv,isa", &isa))
-		print_isa(m, isa);
+		print_isa(m, isa, cpu_id);
 	if (!of_property_read_string(node, "mmu-type", &mmu))
 		print_mmu(m, mmu);
 	if (!of_property_read_string(node, "compatible", &compat)
-- 
2.21.0

