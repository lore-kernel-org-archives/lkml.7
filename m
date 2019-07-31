Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D62C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14ED208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P20NFZJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfGaBYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:24:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64333 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfGaBYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 21:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564536278; x=1596072278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+zY9hAEVm58gSXJfAJQWINzIbb639f01AsOcw7UEO4w=;
  b=P20NFZJ210c1C9AxJy84xAXk+wBJ+GizVnCnoqJjHfNZEO8LkdIiEcU9
   5Bt6Umr6fUKATphDY+n1KDTVf4pKEJ7uAxLcqstBY9zAUw8icOsLJfHs1
   +wFvDbZ2lWJlb93qGBmB/599yb966W1z/qJLTsYz+DrEIJ+ZpBxs5NBMv
   2jlTFXFKcRooL+Nf47nWr5YA1+6o7SKrkRyqACGNL6tej/W4XW6bL6VsQ
   9zBNvOSLi/VwXhdE/0iDbK5krS/ZnM32N7LP//m7DDvvD1GNg5xWHzReT
   ecOMZlR6pcNQCJgqXvAe+Ycj72lysWHCMoxARazS/06JCgEpODlqXM/8H
   A==;
IronPort-SDR: AZF2Jb8S+yDrI7Zn6NLczfH/f7pfS6HyVJD0yI5r+Piki1hwAW4IKlwiiQQEzGewGdRWwHeKcT
 xcil2DITpxDwprHRJIZ7KZvbpXUUiIvGApicZNeL3w+7gJuf5n/AF8FBdf/V9HFeU9f4X0Ob0F
 poqHtx4lEU8vpp00TvjSZ4XG+BJM/1M6Ln1v4GTN3kKLw3GpaUvkT+LnaDjrwIs6NS7zdw+f1T
 xZoaMPmS1gdTlYk0XfpWx5pnJBIVJ9ckriS8X0F36YmCT+Jfj5LgoWiuscVudmNHJwisWfBApc
 hMs=
X-IronPort-AV: E=Sophos;i="5.64,328,1559491200"; 
   d="scan'208";a="115555806"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 09:24:37 +0800
IronPort-SDR: xT7Jc1NgIpfielIcW7hS1x7y3Mrj5r5ZnLLFW45hxfNYqpznJMRSydzoR8G3jwC09HtZi7fZhu
 xrfbeDedZGG2wi6ccBn26QDUwDefeRc2XBEXKLWLgJohUO2fDPAAOsMw5y20wvdR4yldUL/Z02
 gWlJBqauchulighY9/wYgT+tXGJkuj8GW2RdGiHsyVDmGXatDpCbueT4pd5uhGYTyV2G5LQg6W
 MQV1uQyVTRHp2rM620aA/tmQnxPk9IAAVS/6jRFfHr88RliDfkcJ/ubVfN9Rt6/V7mCDi7PBPg
 WXvkwlN0dhiYN6b3+cnRN7ui
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Jul 2019 18:22:39 -0700
IronPort-SDR: uH9oqNQNTYwcQqtIEcYCIgNqnHzHdX+JoR4A2KfOPDKCO9p3gl82GD81hDzFPGxl4tp/fVPTJ2
 YnsSfZhm6QgC5SBvHzb+Wvd/V+3azwrvMoPopoTAskjCq7zxiE2rv74CRdNmXUecdvHtKJ8Q7+
 7nYBc2iyr3OCJnCq8cgl/GS67q5fAcCiMtgVnufwwu04vBHWzkO5AOsz/MEzB6ekPGa8yuVpoB
 Oe6g4kRdZ/CdzNJW6kskJZ2vkKiM+pYTqwmOCebZ9LSuqjTANu3GP9ri7jIxiAMo7tlLY2k8sZ
 T/s=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jul 2019 18:24:37 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
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
Subject: [PATCH v2 3/5] RISC-V: Fix unsupported isa string info.
Date:   Tue, 30 Jul 2019 18:24:16 -0700
Message-Id: <20190731012418.24565-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731012418.24565-1-atish.patra@wdc.com>
References: <20190731012418.24565-1-atish.patra@wdc.com>
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

