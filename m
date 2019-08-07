Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AA0C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42C721E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Un+cInh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389328AbfHGSXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:23:37 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:6617 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388163AbfHGSXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565202217; x=1596738217;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ICuPazclqjqPUmwAWo1Qq1t08V25XRdrKY9dRhoRIRo=;
  b=Un+cInh5H79gsRgn+7NFC9Bed/E11Kqd2PVy3Hy+5pBZ23I4asgEQu5/
   ObsbJAtJwkEUw6IoCPDz6xhoaTydoDquWSXnIR4gwSwf/lP0sZyj/PdO7
   fVTy4SNYtzXoMeC3IP7up4QO1VCEDa9BzwtIT8KNc25wgQwgwamx2DCof
   t2I/gccxB6fzFyKOb6v6kLj2qSrys5njqVtTmxDFAFnQgTKVnsm06SHbv
   c5cT02ySMvL76iOMJaLR/7Zkg2VcTTtWxpSWZvIioI5nG4og5LHCQsX/S
   t/LIcbTCbhGh/5uP8eiEE4rpeSN2RTj8EwPl2/Xe788cP5lICATGy0cVy
   w==;
IronPort-SDR: DYtuRhsdf4NU9TifiHiNvAh2H4jw7bR3j5k0mNX6LlRcIlo66MIxC0gXyykCSqZtTRw+tEmkRl
 97bWKuzFhir/4PzWj0YBNBaDq9/5K+yJ7movZL8M6drAqBW5jRUXloCK+//3sx3KUb9NSktv2q
 36hemDDrCYYr/Neviq6wjQCF7M1hFqNQoP5VuSeDQIqIngujAfe0vmqKhUK4NpaD4L7YhVh9M2
 fd+UxnNxVNNoyISeld32k0aDDYkkEnuaVnpSTG0slH6Y9O1wEEVcgY3QP2ekx38Xu3hvHJy5uu
 axo=
X-IronPort-AV: E=Sophos;i="5.64,358,1559491200"; 
   d="scan'208";a="221758072"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 02:23:34 +0800
IronPort-SDR: maTJYxjmdhKQiijJ18PfkMaWkwjQR0SwLEHHEcHwVY+VHoEfy5RgRWtEJ6Uhy6kP04q14qkODu
 gdGlPkbM7XI8Xf+wo/UGjJgSaK2NkAqVztzn3ypdAFAemD4SPqPBzVYo7g8LNgKJZncZkGiQtG
 nUjdfkqPWjGOrVR9YJhuPjz5u3ljLuSqllGWEdo6ZkWL8vbc+HKrpQA1PYKDQcVbOykn7ytxFb
 ULLNP8rWQpoH5l/bh8iKzHJAmHdXsyGGhtUxUTfe2kxG1oqG7Gzc0Ky7vqBWWkW+lRlTI5tbfw
 oo19FgKTIKcGUwoBwycRRhzm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 11:21:22 -0700
IronPort-SDR: kWXPYgAEnldKXrFkOQTNQqEhek82VjyuPfGLPZPYbZfci9wBXghJ3SstPS9IxHLBac3X5tuGV7
 ykSeVxDp9buS6mdP5V2BkKYHUcMzvedf2EssHjtOxqBoDAwubtjHQPifuIZnST7hXZylOrigjF
 sCoIiMmX2OtkIpSTV7Jo0fLlA+NmZILpYlVMI1E0ozmsB9C9WET442pNBr2BQeww2hoVFsfnIQ
 RXqSJ8k4A0kvLTOBj7Kc9K1tKEpOZDzYUDpj7QZsSV/qTVgHLVb5uXzQbU8dL/m8X6msL3GMve
 yMw=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Aug 2019 11:23:35 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [v5 PATCH] RISC-V: Fix unsupported isa string info.
Date:   Wed,  7 Aug 2019 11:23:16 -0700
Message-Id: <20190807182316.28013-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kernel prints a info warning if any of the extensions
from "mafdcsu" is missing in device tree. Here are few issues with
this approach.

1. It is not entirely correct as Linux can boot with "f or d"
extensions if kernel is configured accordingly.
2. It will continue to print the info string for future extensions
such as hypervisor as well which is completely misleading.
3. As per the RISC-V user level specification, S extension
can not exist in single letter extensions and must use multi-letter
strings. There are no U extension defined at all.
4. /proc/cpuinfo also doesn't print any other extensions except
"mafdcsu".

Fix this by making sure that info log is only printed only if kernel
is configured to have any mandatory extensions but device tree doesn't
describe it. All the extensions present in device tree and follow the
order described in the RISC-V specification are printed via
/proc/cpuinfo always.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/cpu.c | 49 +++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 7da3c6a93abd..e521142e8ac3 100644
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
+	static const char *mandatory_ext = "mafdc";
 	const char *isa = orig_isa;
 	const char *e;
+	char unsupported_isa[26] = {0};
+	int index = 0;
 
 	/*
 	 * Linux doesn't support rv32e or rv128i, and we only support booting
@@ -70,27 +74,44 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
 	isa += 5;
 
 	/*
-	 * Check the rest of the ISA string for valid extensions, printing those
-	 * we find.  RISC-V ISA strings define an order, so we only print the
-	 * extension bits when they're in order. Hide the supervisor (S)
-	 * extension from userspace as it's not accessible from there.
+	 * RISC-V ISA strings define an order, so we only print all the
+	 * extension bits when they're in order. Throw a warning only if
+	 * any mandatory extensions are not available and kernel is
+	 * configured to have that mandatory extensions.
 	 */
-	for (e = ext; *e != '\0'; ++e) {
-		if (isa[0] == e[0]) {
-			if (isa[0] != 's')
-				seq_write(f, isa, 1);
-
+	for (e = mandatory_ext; *e != '\0'; ++e) {
+		if (isa[0] != e[0]) {
+#if defined(CONFIG_FP)
+			if ((isa[0] == 'f') || (isa[0] == 'd'))
+				continue;
+#endif
+			unsupported_isa[index] = e[0];
+			index++;
+		}
+		/* Only write if part of isa string */
+		if (isa[0] != '\0') {
+			seq_write(f, isa, 1);
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
@@ -134,7 +155,7 @@ static int c_show(struct seq_file *m, void *v)
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

