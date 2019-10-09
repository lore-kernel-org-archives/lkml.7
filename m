Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722F9ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48458218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PGRm3frG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbfJIWBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:01:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58909 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731736AbfJIWBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1570658490; x=1602194490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=glioQ9gbQCwDyZ1lhDR7P9tsfgoc1+ZWkzIr2khfKYM=;
  b=PGRm3frGjgvMORRBMxaITscBg9zHXgcpbn/ZxT33CZaQaP0kDnxavQ76
   8UwceYfjKNgt00foQptAOm+b8Cngb/Yxpt2a6aP9NXHGM8RJy/197faJY
   F1NdcJ6Pd/yzNswy/qWO6oaQU2xbNSMN8jEc+XaitWaf/Ih4GkdjkdwKc
   n3/pDTxWVyPDf1pj+LGZRfw1oUgU7XNQZsHVmdD5V13wSQEJo+TkiCA3P
   WRs35cJxGN3uRKvKfps3qgfXuKY3/jJPGdcV/tLpOOofPEQp025zRd52K
   4dcFvAozrOEqa6QqIYEPBiABCZf1BacblDDLvS1arBJPPuV1OknWyzXUF
   A==;
IronPort-SDR: Hix8DplbLu/t0uII8+vQEz3tXhhseZf0CqsSphcRw9gdjwBfeKCHjccJGI5voUxnUitT/3Qn/3
 AGyBhiINlGSXcBnx9AGgZlyO9WvFrffhE6pYEX9/zWn4vN3PnJZyljkdPw40qocY0uoMedriCp
 GCfQQ6MFbOpQQiiTghAXd3ji+rLCSXVywPnauHy/rYtd4+7qQKVltkeTDPP5tTNINFg1ElaAFa
 MuRalqmUfauUT5zqS3kI/uEVFNjfWTNc3PhLUwI7t6EXASNPIc/eBpY6aJtNdJDIkKVtMw9Xoc
 6wY=
X-IronPort-AV: E=Sophos;i="5.67,277,1566835200"; 
   d="scan'208";a="121776287"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2019 06:01:30 +0800
IronPort-SDR: 8pKUP6XiutD+fjqbk40Am0sN534JqPDfCVP4TDCgNhZsZTHiEA2o4TzxonjkVbA/OZVnR9D7IE
 TYJbO6FfqBWHIWZfd48zNQaJEbLOStbUxYLpmfnIDgN/keh0n6FM4ykY3YYTY6MEDda7HsbYrO
 MEWCUDr10uInZTeN0llL4MaOT8TfbFWL5lea33zy2Nx1EjZuoLiJp/PrWYxMt7a/ohnEpSPZFm
 vzYv5klVG1FzwCv0RxB2pToNL/arWv2KkBSK23gUIlHyjQNUZlxOhLrnDAaBF31N3cZxFbouSD
 9m187ZOP3nWn0GLIGxTMKKlY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 14:57:28 -0700
IronPort-SDR: NyxctKEn7ncwH/wA8FjcZp+ShlYaHe5YcCbwrG7kc3vUEoYiZzialcvIWkyZMDcgCofvTkPo+G
 rU4chCkgn3vdYe7QKBSzx9mPmUzKJhQDvpU97V5tN0IyRMHBVVio47LNeKEh31SdyRo+3MS+fM
 /+h7dM/yttFW8wtmuMpxpts7jFKS9H+cRw5OmcItbGRcp5NlKJpwfIt7VGW6ksoN3TsfjkvvRi
 B5YmcR7746rsJ+v4M8PyaWad30CWqc3TIAhxeXE766F+LdQkGgJT61vkSkpLLkgvEO2AMebrFq
 K90=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Oct 2019 15:01:29 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2  2/2] RISC-V: Consolidate isa correctness check
Date:   Wed,  9 Oct 2019 15:00:58 -0700
Message-Id: <20191009220058.24964-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009220058.24964-1-atish.patra@wdc.com>
References: <20191009220058.24964-1-atish.patra@wdc.com>
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
 arch/riscv/kernel/cpu.c            | 41 ++++++++++++++++++++++--------
 arch/riscv/kernel/cpufeature.c     |  4 +--
 arch/riscv/kernel/smpboot.c        |  4 +++
 4 files changed, 37 insertions(+), 13 deletions(-)

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
index 40a3c442ac5f..6bd4c7176bf6 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -8,13 +8,43 @@
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
+	/*
+	 * Linux doesn't support rv32e or rv128i, and we only support booting
+	 * kernels on harts with the same ISA that the kernel is compiled for.
+	 */
+	if (IS_ENABLED(CONFIG_32BIT) && (strncmp(*isa, "rv32i", 5) != 0)) {
+		pr_warn("hartid=%d has an invalid ISA \"%s\" for 32bit config\n",
+			hart, *isa);
+		return -ENODEV;
+	} else if (IS_ENABLED(CONFIG_64BIT) &&
+		  (strncmp(*isa, "rv64i", 5) != 0)) {
+		pr_warn("hartid=%d has an invalid ISA \"%s\" for 64bit config\n",
+			hart, *isa);
+		return -ENODEV;
+	}
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
@@ -32,15 +62,6 @@ int riscv_of_processor_hartid(struct device_node *node)
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

