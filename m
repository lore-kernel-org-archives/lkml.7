Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906C7C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6672189F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kbhMHiqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfGZTqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:46:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17134 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfGZTqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564170409; x=1595706409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4G/AiivRvt04iQqbVTDPT9b5v5TEP81JdiptpePFLX8=;
  b=kbhMHiqz2to9iR+Vg1UjXHeF8S4OkHEVCybu87MmRw36LyagmS9aBljZ
   2jctNq7rRulWH3l6Kecq+IUXazjRPsZiE1ydjbwlCFcdFivzuGWwOzaOl
   e5SuvctxWai5mtjsqwQRAoBpPqCQ2LafOWhVlJkG28OW4fRDdRgfaTwg3
   jkFJ1G5v0L/b61W+0MiLiiyge61zZ+a7UBpHgNcX6f21i3MY8GIHpOpVX
   v6jebSA0xNL6ahTLCLmqetOPFk2A06g7NLPWNrMdBCKJnQR7I7SqOUrLb
   rkBmAjV4iN+SIFc3FhGtnDqTU8XYY1uhOO3Ogg8LZUrfExEToIHLBt+g0
   w==;
IronPort-SDR: VjMPj83Lrgwf5MV/myr/BJOW7KJGWKp8CJ1PQqHPZpRfUzKbVrxt9eDrZzzHqtqTSLZsXR9C1T
 VABfD93gM+1xxMPat4uIZqbmcXYHqjTb/8OOhUFARwPi/3CuIpS1UXpRqdUqW6HC5PcPDbB806
 icTJ1QWdZilYu3sQxYM29r2LxKzRfHcDEMQHKEoih6jFZjEt2T2e5SKwaVCjOimAhZMvkoy+Lm
 Q5CysZAlOknNyMlUTKFRSY8Q+PRZuDatLHrL7q5YOokS7E55/Sa5msQGWgG+iYEsAUSpk2+sux
 H5I=
X-IronPort-AV: E=Sophos;i="5.64,312,1559491200"; 
   d="scan'208";a="114239813"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2019 03:46:48 +0800
IronPort-SDR: 4esurgtfWkTuDEqyJRca9cVoDRGSe9HfzjmuSjsX52UGp8rNLHCjA/Pd9SnlIjNest+8fZ++nL
 1h/XKqBgJx+DQ35JKC9Q6rgAjplmyYXjU+7hqF/tZKSUBm5zXavjDVj6i83CN7aHSOCGUYx8bX
 eRJvNTdLH0ShVt/S1bBU3w4BI/D+yGgr5e/oeTvFRplJfX7MNwGjmgg/l9kQnt5hs28vosrm1G
 SSllSoVN1yIj5mnZ1K8f5UG92fKCWKhz5br/llpNWaTGxov+IiOgUOHbFWhpoLld8XRHnVLQQi
 M8xAL8tJaPQ1M16mAXUiygMa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jul 2019 12:44:57 -0700
IronPort-SDR: J+Ohxn5O071I/GlSvFKCslQ9U8iEOicbnZ4EcP2qBdVSymXxULqZFXIfnOnMBQFvrfRo8ZHBlm
 fFpNFzKwqBNbM0XfVEW+YRpM+1MQbVg4/t+Xwxpji2jecPcLABfxtsEcO8eILswds3CPKKERls
 R1MTIVpFz5P7/9+zl0AvLs+6yKfvCYsW4I7XaCjhX01og23X+/jlzsOfLnB6mLSnGdWs5F69Cv
 t0gCfuOsBiMP1ZYMyIfhHFZKG2FE5t3hOTvud6Dlgv4xYVIKMTx5bEfe9N4nm0/YTE60F4sS2n
 gco=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jul 2019 12:46:48 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4/4] RISC-V: Fix unsupported isa string info.
Date:   Fri, 26 Jul 2019 12:46:38 -0700
Message-Id: <20190726194638.8068-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190726194638.8068-1-atish.patra@wdc.com>
References: <20190726194638.8068-1-atish.patra@wdc.com>
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
index 185143478830..3d050440364c 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -8,6 +8,7 @@
 #include <linux/ctype.h>
 #include <linux/of.h>
 #include <asm/smp.h>
+#include <asm/hwcap.h>
 
 /*
  * Returns the hart ID of the given device tree node, or -ENODEV if the node
@@ -47,11 +48,14 @@ int riscv_of_processor_hartid(struct device_node *node)
 
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
@@ -71,27 +75,50 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
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
-		if (tolower(isa[0]) == e[0]) {
+	for (e = mandatory_ext; *e != '\0'; ++e) {
+		if (tolower(isa[0]) != e[0]) {
+#if defined(CONFIG_ISA_RISCV_C)
+			if (tolower(isa[0] == 'c'))
+				continue;
+#endif
+#if defined(CONFIG_FP)
+			if ((tolower(isa[0]) == 'f') || tolower(isa[0] == 'd'))
+				continue;
+#endif
+			unsupported_isa[index] = e[0];
+			index++;
+		}
+		if (isa[0] != '\0') {
+			/* Only write if part of isa string */
 			if (tolower(isa[0] != 's'))
 				seq_write(f, isa, 1);
-
 			isa++;
 		}
 	}
+	if (isa[0] != '\0') {
+		/* Add remainging isa strings */
+		for (e = isa; *e != '\0'; ++e) {
+#if !defined(CONFIG_VIRTUALIZATION)
+			if ((tolower(e[0]) != 'h'))
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
@@ -135,7 +162,7 @@ static int c_show(struct seq_file *m, void *v)
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

