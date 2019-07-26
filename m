Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B983C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84782189F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h1JGduKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfGZTqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:46:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17125 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfGZTqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564170408; x=1595706408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hokvHxTUgVK45jR+2fi50ThrUw3wJd/1zf9QL7Bw3Kw=;
  b=h1JGduKN6lmFhhCGwWYmvywkPjA9RSopuf0eKk4RNLeeT/04eXYpyp9X
   a0ttYWUM3tm2lCfUIae0TO21iKtnTOLGeCOGRFmRZly+yU2+5lKPKdTLQ
   EqCgThZWIyYJxlIoJV/AOg6yX8uxbnvUDsC9BCzqwM6EORswnnGvK8S/Y
   g4PfvtwaYbr2oKoQ5lfIx5tfDxjH5KOoIexfZ8PiiFFGehg96qNKMrVwr
   21/ZliBxlJ7Me17dUWl6sCcmSGJd2gavuOaZOUJg9cbP0Cg8fYs1V+xMh
   Ha1y2FqGJHc4CLUmN25x8w+WZN7f6eYpAYqppJ/QO4qFbhy/9ouEaYDhe
   Q==;
IronPort-SDR: sxiMR6eUnr1aHcNRpesIsUkKr32ZZgzzVaD8q+42L6pqPZTKx3vtfb6g3Sm9TED8OJdHAzBPnO
 q973YOMXHySnn1yajYg2pc+4Q/nKNZAdytQj7iwxKsznY3nqWItkgeTvJyns+s73wBFoDxiiCO
 2z/QGrRV5wj55K9an9odZevYx8FxDwNFHQexwGXkLPrwQmZyEyxyvXXlbA4IolCMvxK6EPARDl
 Q4Coc0is6S2kZad2FU69Fr+4clxwRqAPV9kCba2Y3CHEtoiLPhh6Fn3PT/GA/xc+xi9+ydurkT
 3Ww=
X-IronPort-AV: E=Sophos;i="5.64,312,1559491200"; 
   d="scan'208";a="114239805"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2019 03:46:48 +0800
IronPort-SDR: XxsU6iAiWMCzTWTKBBeT794s5ViW/E0eG98jMAPulnhlQnl+zv+8f3K+AYpggN8h9R4pZfkgu7
 jPqP9ROHJMvOR/O2KCbsA7Ol26vJh81DTgQLf1b+K0nBLzCGzXZjx5G9PSJ9gljwN3/hlIIstp
 rjgQ0gGOkDf8lpDpeiWxMvZPs8CfLx80MljVkQUeHhV3LVYtlwX6R592lnjZ0QP7UhpObwQOf8
 2p7ROgu8S29vrWLOF+5WNtVNYJpz6HzXn7cvbG8D/FGApqX8N+9bJYn8PI6c7y1qXFi88oSmr6
 PLbaOFSWIoXYHB3OrUSv4rzA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jul 2019 12:44:56 -0700
IronPort-SDR: 9iMwrXBU5LvFTWyA+niCgR2Co2erNZr114as8cLaEkSoetsTrmHnNDs4WIz8+HxDKaoUQAU4JI
 sJob0TmRZdRycFnETTgmhlmYaK+o1vb4GVAH+XjhlRU+0qy6myp0aV1biVLLC/GJ9WgYVkHZM3
 RmvBMjWxxgRbeASeOj77r6fz8Tb4kP5mlQ864x/dsW5um5AsJyTiBnnzonE33V44zdOWkuzJLk
 RBqvkfSAFQsTAKDKboBxGzbOdwnPxhugKeumV2kWQX+5bHoqd8Qv0cMMGU2gBDaN8iph2/MbQG
 QG4=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jul 2019 12:46:47 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/4] RISC-V: Add riscv_isa reprensenting ISA features common across CPUs
Date:   Fri, 26 Jul 2019 12:46:36 -0700
Message-Id: <20190726194638.8068-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190726194638.8068-1-atish.patra@wdc.com>
References: <20190726194638.8068-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

This patch adds riscv_isa integer to represent ISA features common
across all CPUs. The riscv_isa is not same as elf_hwcap because
elf_hwcap will only have ISA features relevant for user-space apps
whereas riscv_isa will have ISA features relevant to both kernel
and user-space apps.

One of the use case is KVM hypervisor where riscv_isa will be used
to do following operations:

1. Check whether hypervisor extension is available
2. Find ISA features that need to be virtualized (e.g. floating
   point support, vector extension, etc.)

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/hwcap.h | 25 ++++++++++++++++++++++
 arch/riscv/kernel/cpufeature.c | 39 +++++++++++++++++++++++++++++++---
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 7ecb7c6a57b1..e069f60ad5d2 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -22,5 +22,30 @@ enum {
 };
 
 extern unsigned long elf_hwcap;
+
+#define RISCV_ISA_EXT_A		(1UL << ('A' - 'A'))
+#define RISCV_ISA_EXT_a		RISCV_ISA_EXT_A
+#define RISCV_ISA_EXT_C		(1UL << ('C' - 'A'))
+#define RISCV_ISA_EXT_c		RISCV_ISA_EXT_C
+#define RISCV_ISA_EXT_D		(1UL << ('D' - 'A'))
+#define RISCV_ISA_EXT_d		RISCV_ISA_EXT_D
+#define RISCV_ISA_EXT_F		(1UL << ('F' - 'A'))
+#define RISCV_ISA_EXT_f		RISCV_ISA_EXT_F
+#define RISCV_ISA_EXT_H		(1UL << ('H' - 'A'))
+#define RISCV_ISA_EXT_h		RISCV_ISA_EXT_H
+#define RISCV_ISA_EXT_I		(1UL << ('I' - 'A'))
+#define RISCV_ISA_EXT_i		RISCV_ISA_EXT_I
+#define RISCV_ISA_EXT_M		(1UL << ('M' - 'A'))
+#define RISCV_ISA_EXT_m		RISCV_ISA_EXT_M
+#define RISCV_ISA_EXT_S		(1UL << ('S' - 'A'))
+#define RISCV_ISA_EXT_s		RISCV_ISA_EXT_S
+#define RISCV_ISA_EXT_U		(1UL << ('U' - 'A'))
+#define RISCV_ISA_EXT_u		RISCV_ISA_EXT_U
+
+extern unsigned long riscv_isa;
+
+#define riscv_isa_extension_available(ext_char)	\
+		(riscv_isa & RISCV_ISA_EXT_##ext_char)
+
 #endif
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b1ade9a49347..d76c806b4fc9 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -12,6 +12,7 @@
 #include <asm/smp.h>
 
 unsigned long elf_hwcap __read_mostly;
+unsigned long riscv_isa __read_mostly;
 #ifdef CONFIG_FPU
 bool has_fpu __read_mostly;
 #endif
@@ -20,7 +21,8 @@ void riscv_fill_hwcap(void)
 {
 	struct device_node *node;
 	const char *isa;
-	size_t i;
+	char print_str[BITS_PER_LONG+1];
+	size_t i, j, isa_len;
 	static unsigned long isa2hwcap[256] = {0};
 
 	isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
@@ -31,9 +33,11 @@ void riscv_fill_hwcap(void)
 	isa2hwcap['c'] = isa2hwcap['C'] = COMPAT_HWCAP_ISA_C;
 
 	elf_hwcap = 0;
+	riscv_isa = 0;
 
 	for_each_of_cpu_node(node) {
 		unsigned long this_hwcap = 0;
+		unsigned long this_isa = 0;
 
 		if (riscv_of_processor_hartid(node) < 0)
 			continue;
@@ -43,8 +47,22 @@ void riscv_fill_hwcap(void)
 			continue;
 		}
 
-		for (i = 0; i < strlen(isa); ++i)
+		i = 0;
+		isa_len = strlen(isa);
+#if defined(CONFIG_32BIT)
+		if (strncasecmp(isa, "rv32", 4) != 0)
+			i += 4;
+#elif defined(CONFIG_64BIT)
+		if (strncasecmp(isa, "rv64", 4) != 0)
+			i += 4;
+#endif
+		for (; i < isa_len; ++i) {
 			this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
+			if ('a' <= isa[i] && isa[i] <= 'z')
+				this_isa |= (1UL << (isa[i] - 'a'));
+			if ('A' <= isa[i] && isa[i] <= 'Z')
+				this_isa |= (1UL << (isa[i] - 'A'));
+		}
 
 		/*
 		 * All "okay" hart should have same isa. Set HWCAP based on
@@ -55,6 +73,11 @@ void riscv_fill_hwcap(void)
 			elf_hwcap &= this_hwcap;
 		else
 			elf_hwcap = this_hwcap;
+
+		if (riscv_isa)
+			riscv_isa &= this_isa;
+		else
+			riscv_isa = this_isa;
 	}
 
 	/* We don't support systems with F but without D, so mask those out
@@ -64,7 +87,17 @@ void riscv_fill_hwcap(void)
 		elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
 	}
 
-	pr_info("elf_hwcap is 0x%lx\n", elf_hwcap);
+	memset(print_str, 0, sizeof(print_str));
+	for (i = 0, j = 0; i < BITS_PER_LONG; i++)
+		if (riscv_isa & (1UL << i))
+			print_str[j++] = (char)('A' + i);
+	pr_info("riscv: ISA extensions %s\n", print_str);
+
+	memset(print_str, 0, sizeof(print_str));
+	for (i = 0, j = 0; i < BITS_PER_LONG; i++)
+		if (elf_hwcap & (1UL << i))
+			print_str[j++] = (char)('A' + i);
+	pr_info("riscv: ELF capabilities %s\n", print_str);
 
 #ifdef CONFIG_FPU
 	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
-- 
2.21.0

