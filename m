Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4418CC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 04:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A305206C1
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 04:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K5CI8I93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfHCE10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 00:27:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20716 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfHCE1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 00:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564806445; x=1596342445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+zY9hAEVm58gSXJfAJQWINzIbb639f01AsOcw7UEO4w=;
  b=K5CI8I93+gTEWAiiy/qtzM6TmjbWHNqBXGUUqyZsgxz4gotFZEq2yXYu
   f4Qlcc/T3oD4RcQ7ea8T6aSOEirSX67AbE41uRbJI7fEfqmkIXZcGayOR
   Z1ovbc/bNc1gmK90AhMTOKOFEcGzp9xil8tyqYyQN/9xkCG1ZngtMDohk
   /a029sAdxoyNnFUOOs/38VyLnN9PzA2tcJlznt3aIbeADnvrF+UCz10Is
   wffVZ6oHhJ140gSWrfzBwcazA9QtgcTafpNEE0hpSvnEtxzXGpxt4F4Pa
   Z8zKXVisKSxDSNQ75LTQtjlsngQHBR+kNwHyhtcejfOCn1TXOThTg2SBD
   Q==;
IronPort-SDR: 4BQp+y9sQrgKYr8VCxsoBkfauS+z00AHcydFaI1llQvUrQ0PJjM+pt0AbK7Hvfaw8wxATfjzfD
 O/K9dQrpVvweTrXPzx7mX2/7w8+/Oge5UQ69nT7R1UlRloNtQbxSizLp6+/V8gmsAk0UMaNoEm
 uw/ZCNkX1RqJ+9rtHrUbwOr38j7S4+REPFoRTTONnN8R0P1tqj96SUKIpJ6sWKul1amaqSAS03
 ijc3sLmY+wcJmCM1KRMR0/aOogHsBCA2FismX1v4/R63Mun0dAl/DfDu737adWrWrcecWokqi0
 L7I=
X-IronPort-AV: E=Sophos;i="5.64,340,1559491200"; 
   d="scan'208";a="114857038"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2019 12:27:25 +0800
IronPort-SDR: a4MGPlg1VDj1+naF9ZzBpEcmsA7F57bLcUxwO3kJ9JblYi/xIKUVQeYMR2Szs8wHR9CIz0/bPJ
 kh6HlMi65NKQR4JTts1hXX+TX7kkKG0tHMT4zYfFzY5OyW5/waW5PjfdezBCPIyYDA6lzhuhJw
 8r2MUfOiN3aKYgRnhmKIvEpHEIN3mpg3TB7h/nrL6P0v24ZopBIyH7YIr+SS1EHFGygyisQhEM
 phA98pp5g3DBrpEzXAiTH0saeO4HznbBCBoHwAyJ0MbkGzGxU4Jy7mpz1MlkDb2k+axfXkdf2c
 JPFd1aBLXA7n3l1sWVXBjIXQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 21:25:19 -0700
IronPort-SDR: BEzUoDjKcLbUflMTZsDVbQM5dyaFux48KbdktLJp5GqtOdK5Dmd/+ONG2Nykk/p2xlQ2RaxExI
 WheLT/5rb81h3kSc84lsBtx6sy5eWTTdbpA4V9CpaYnrvgNUlyl3NKkhg3y2DlTjlE0onnvoWh
 eCDJUnJ7MErujte6/WSV4iiKXzBpeFM0eNnJ0DjGTsCdegr8OlF/V0GOYWUIE7+R9P3SKysLLg
 scNfP+FPFqz+v5DuItQkmXWFgNuvupNklyZyRTeNtRzfxel/TojI4BUri4kWrog55VuS8KPqsu
 aoQ=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Aug 2019 21:27:25 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 3/4] RISC-V: Fix unsupported isa string info.
Date:   Fri,  2 Aug 2019 21:27:22 -0700
Message-Id: <20190803042723.7163-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190803042723.7163-1-atish.patra@wdc.com>
References: <20190803042723.7163-1-atish.patra@wdc.com>
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

