Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D16C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5875208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l4jleZRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbfGaBYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:24:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64336 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfGaBYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 21:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564536278; x=1596072278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y6AGFaAE1PMVJZ6+rsgH3B7LWIELYj+tSokwx8q21Gg=;
  b=l4jleZRsaJIbGEfj3mFadKVH5mMjg/N1ne21us47ctjojIxpWMnx4XFn
   BblS7SO5YbUQ8oOhcF2ZpYiJrV6wvvR+CYsiXJkkMqDmhm9F+Dh5gEfVj
   lQUinq79xK7McuDdDhcDVHaetxcUggYuSX1OAX6kXmRLr8tye/Uatl9db
   X25B/hFuzwJ0ddTxe0FSEP4A6qzreNLvyMy9qJx7ZDUyj3VDD7K/iIblL
   y8AeM+3UXf4jPkPXwg0bEdu/hVDZo3yanYyctSf/A4N4TgWgFMzbk24em
   yRAs5D/xsWom61wqpvXnFR0a7u1/t9GoyvM3khfPlYAnGtIB814ojfXjE
   Q==;
IronPort-SDR: 25hWv9ODF9g8VJuyqK4JMsLyFaq5BrJNkz52uRiAql5obTfu3/NGBqyEUcehywuOd68juSQ0eB
 MX0Gw+H+Vq3hS2gTo7HlYBsT5j0inrB2f1/tEOpDk1t8Hb0Vfor8oifii/6Wiyu/X3n+YIMT7c
 NdLDWNaMBFPD0jyjspTkDpI1L9WWoJfFha+JGnE9tKEaxTEw1/CWhvqwTktMvKSQfLIc1BgCGF
 MG6l1eXGMeTd0XMKIPtv+DeO36AiWf/7Hh963Nq5Seh9pOPQ3bLZ0PfiqJd0cAZVonBdxajdTp
 rBM=
X-IronPort-AV: E=Sophos;i="5.64,328,1559491200"; 
   d="scan'208";a="115555804"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 09:24:37 +0800
IronPort-SDR: OnXp1I4YrGwbZzZrYhLfFdrrNt29tGwdpQq/pjlwyET40k+roOJ5P+Q1o0OKFLO9tvuCjTekt1
 2Le/KE/+IGzxoSXOadLWAW5jqgWXa6A3eJvsVESslh7tOu8oRLuI4uTRFMjU16MxNdcoiX+vWZ
 zPKVRLV+M1JYSPmZKqmAfStNNOFeR6Qe092GhNmVAKWu7My641ZHKncEn0um454/Ek3uSUd2gg
 FGHuovvTRhvy8dMi3gkDzzTwPzlUvYvF7I5zDzga4bWFoq1zb6qBFcFkiR/9j5ae4TP1Z1n2JH
 Gz3wME/1y38v6yKo1/OJ9EwW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Jul 2019 18:22:38 -0700
IronPort-SDR: xNRp1O/Qr49vPg3S7RUEcytEJKT39eWC7sCIQ7RAoaIdl7XdAMDHcJjQWkNq/0hzCNZ5Pxx5Ya
 +Dei7WHbONIUPCU3+tcv2mPcLWV/ImofiPdDOCzmrnJogrIKQ0AuLV7t53N5WAZCo6aDHVU8Xz
 Z2j42T5y75hWW3MbvHeD2pQ5m2D/SDpGts+NhkqcGUM6cegK/g/YhRdf6ZggHyrEpZOTbEgNM0
 fo21GU7bpdxwwJz0tJIG/0cQ5j/6tzgbsSr+O3lgGjo7HYeKTP0Ju8lxAzjmD7UiXHE2cFfO3F
 MEg=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jul 2019 18:24:37 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
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
Subject: [PATCH v2 2/5] RISC-V: Add riscv_isa reprensenting ISA features common across CPUs
Date:   Tue, 30 Jul 2019 18:24:15 -0700
Message-Id: <20190731012418.24565-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731012418.24565-1-atish.patra@wdc.com>
References: <20190731012418.24565-1-atish.patra@wdc.com>
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
 arch/riscv/include/asm/hwcap.h | 25 +++++++++++++++++++++
 arch/riscv/kernel/cpufeature.c | 41 +++++++++++++++++++++++++++++++---
 2 files changed, 63 insertions(+), 3 deletions(-)

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
index b1ade9a49347..177529d48d87 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -12,6 +12,9 @@
 #include <asm/smp.h>
 
 unsigned long elf_hwcap __read_mostly;
+unsigned long riscv_isa __read_mostly;
+EXPORT_SYMBOL_GPL(riscv_isa);
+
 #ifdef CONFIG_FPU
 bool has_fpu __read_mostly;
 #endif
@@ -20,7 +23,8 @@ void riscv_fill_hwcap(void)
 {
 	struct device_node *node;
 	const char *isa;
-	size_t i;
+	char print_str[BITS_PER_LONG+1];
+	size_t i, j, isa_len;
 	static unsigned long isa2hwcap[256] = {0};
 
 	isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
@@ -31,9 +35,11 @@ void riscv_fill_hwcap(void)
 	isa2hwcap['c'] = isa2hwcap['C'] = COMPAT_HWCAP_ISA_C;
 
 	elf_hwcap = 0;
+	riscv_isa = 0;
 
 	for_each_of_cpu_node(node) {
 		unsigned long this_hwcap = 0;
+		unsigned long this_isa = 0;
 
 		if (riscv_of_processor_hartid(node) < 0)
 			continue;
@@ -43,8 +49,22 @@ void riscv_fill_hwcap(void)
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
@@ -55,6 +75,11 @@ void riscv_fill_hwcap(void)
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
@@ -64,7 +89,17 @@ void riscv_fill_hwcap(void)
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

