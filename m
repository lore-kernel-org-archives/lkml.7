Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6677CC32792
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3776520865
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N5HJ/Pvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfJDBUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:20:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33208 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbfJDBUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1570152004; x=1601688004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JJtoW7EbTMq3z+5/83sAIqWFB2c/7rptzmLUxfNEu+A=;
  b=N5HJ/PvvpcJVISSLpP2vreZ8w7dmbcVEe74xbnPew2Bw5rleV1ibpNIP
   Hib7gT923v5L5N0ibIxJdT+MThb5ZbtALMyFgNBpG/zybFqkn4NSEOWfi
   X+/bTrO+wVTmy6OK94CXEvr3sgAB7ZVKzc5/FMrrnCLu5tH6e+gRlgB2c
   QPwRptYw1J6nlW7++VW3Vp6Ac0E8e70A6pgCzfulEk0td0uo0fQA53MHa
   sr1G7QKnBV3YZ0yqiyn1c6zQwKKusgxiepqw80GHQfax7lOIM9PRYy38b
   WmWyuL57s0B7kLGS67Qyol+W/bTs9Uculms4oMNL2hjBHPqdYua4KMmqk
   A==;
IronPort-SDR: eWHQVVSliA3qucQ0Awkg7gMD0oZ2NXaq3YVm2lLVYPwa/bBlT8Noea+9ndXOLZo48hVlewei+M
 RiMWEAiOcsac5VtuGsiWr0jNqHNjG9HD8bqHkVJMcK7yfEc7sl2w1FePS+OGH+AWS667yjZyDR
 XCliczwecwOGu4g8gjqcy9sTHa5wu4Z7KePO+tv2wLSMzhRpWBGBSK9qmqfz3EG5sQ0rJf4wSE
 nZp8xiy94SsKBxaZ4k3Z7vo2aweiSOXDpj9zySOObxnQ/XoPL/MAQMnd4hdO5ReN/5Uto+YhHu
 3i4=
X-IronPort-AV: E=Sophos;i="5.67,254,1566835200"; 
   d="scan'208";a="119765644"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2019 09:20:02 +0800
IronPort-SDR: ub3lWJdsXbhq5JeiG/TkAR4sau+43H3G/B3f1HAlwm4cHrPuQwbZ94yssY6KX6hFNcubgNIBvJ
 0Ifjd+syC2ETvUL0PwVzKTyQrVMf/+hTdA6pnNtpv8hVjY4zDNCEopzlsBWnMHXYsnnRnOrKlL
 WhpOsQzU2cN73Ld3rT02ezSazXndN58E9THewF4wRMX6FXKN96mFXT3Qa83ZPFGzqXypNAnOPi
 rguVY/qbEj5GPZkSHJK/t7bfQ51SagldzCqXpVFTKebqEKg20nZBqH3C404TlgT6LPyViNwTup
 ic2w/4diBPvqGvikAHuad5+9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 18:16:11 -0700
IronPort-SDR: u7A02DRehnzLmOmcpmq6YlaRr85A14SoW78LuIuz2ZMnPLX71NoDXU2MhZSFN9a4c5AdptRds/
 A71A4ILtiUrOQNQiGtRWu8PdN5+yGmW8BoadSqeO67X5Xiz4lmNIs4w4P7lDJ5+D2E06I2yFqq
 acM/NrAGFyQASXoRMIkvWPtOjulMpgDT8Iq729lqnp3fvSTtz7B/X1cXpTGX33yb9ldGPtCMvf
 UJnWi1cWmYzzsB+K+Ua5WQvYbVatVjtIWZEeOGgFMtb81XG8MdpQ7TBF8arAGEHi53zBFBPEsX
 caI=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Oct 2019 18:20:03 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <aghiti@upmem.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [v1 PATCH  2/2] RISC-V: Consolidate isa correctness check
Date:   Thu,  3 Oct 2019 18:20:00 -0700
Message-Id: <20191004012000.2661-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004012000.2661-1-atish.patra@wdc.com>
References: <20191004012000.2661-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, isa string is read and checked for correctness at multiple
places.

Consolidate them into one function and use it only during early bootup.
In case of a incorrect isa string, the cpu shouldn't boot at all.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/processor.h |  1 +
 arch/riscv/kernel/cpu.c            | 40 ++++++++++++++++++++++--------
 arch/riscv/kernel/cpufeature.c     |  4 +--
 arch/riscv/kernel/smpboot.c        |  4 +++
 4 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f539149d04c2..189bf98f9a3f 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -74,6 +74,7 @@ static inline void wait_for_interrupt(void)
 }
 
 struct device_node;
+int riscv_read_check_isa(struct device_node *node, const char **isa);
 int riscv_of_processor_hartid(struct device_node *node);
 
 extern void riscv_fill_hwcap(void);
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 40a3c442ac5f..95ef5c91823d 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -8,13 +8,42 @@
 #include <linux/of.h>
 #include <asm/smp.h>
 
+int riscv_read_check_isa(struct device_node *node, const char **isa)
+{
+	u32 hart;
+
+	if (of_property_read_u32(node, "reg", &hart)) {
+		pr_warn("Found CPU without hart ID\n");
+		return -ENODEV;
+	}
+
+	if (of_property_read_string(node, "riscv,isa", isa)) {
+		pr_warn("CPU with hartid=%d has no \"riscv,isa\" property\n",
+			hart);
+		return -ENODEV;
+	}
+
+	/*
+	 * Linux doesn't support rv32e or rv128i, and we only support booting
+	 * kernels on harts with the same ISA that the kernel is compiled for.
+	 */
+#if defined(CONFIG_32BIT)
+	if (strncmp(*isa, "rv32i", 5) != 0)
+		return -ENODEV;
+#elif defined(CONFIG_64BIT)
+	if (strncmp(*isa, "rv64i", 5) != 0)
+		return -ENODEV;
+#endif
+
+	return 0;
+}
+
 /*
  * Returns the hart ID of the given device tree node, or -ENODEV if the node
  * isn't an enabled and valid RISC-V hart node.
  */
 int riscv_of_processor_hartid(struct device_node *node)
 {
-	const char *isa;
 	u32 hart;
 
 	if (!of_device_is_compatible(node, "riscv")) {
@@ -32,15 +61,6 @@ int riscv_of_processor_hartid(struct device_node *node)
 		return -ENODEV;
 	}
 
-	if (of_property_read_string(node, "riscv,isa", &isa)) {
-		pr_warn("CPU with hartid=%d has no \"riscv,isa\" property\n", hart);
-		return -ENODEV;
-	}
-	if (isa[0] != 'r' || isa[1] != 'v') {
-		pr_warn("CPU with hartid=%d has an invalid ISA of \"%s\"\n", hart, isa);
-		return -ENODEV;
-	}
-
 	return hart;
 }
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b1ade9a49347..eaad5aa07403 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -38,10 +38,8 @@ void riscv_fill_hwcap(void)
 		if (riscv_of_processor_hartid(node) < 0)
 			continue;
 
-		if (of_property_read_string(node, "riscv,isa", &isa)) {
-			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
+		if (riscv_read_check_isa(node, &isa) < 0)
 			continue;
-		}
 
 		for (i = 0; i < strlen(isa); ++i)
 			this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 18ae6da5115e..15ee71297abf 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -60,12 +60,16 @@ void __init setup_smp(void)
 	int hart;
 	bool found_boot_cpu = false;
 	int cpuid = 1;
+	const char *isa;
 
 	for_each_of_cpu_node(dn) {
 		hart = riscv_of_processor_hartid(dn);
 		if (hart < 0)
 			continue;
 
+		if (riscv_read_check_isa(dn, &isa) < 0)
+			continue;
+
 		if (hart == cpuid_to_hartid_map(0)) {
 			BUG_ON(found_boot_cpu);
 			found_boot_cpu = 1;
-- 
2.21.0

