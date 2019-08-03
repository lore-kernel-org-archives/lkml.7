Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98919C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 04:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AC12166E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 04:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CVuySkEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfHCE1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 00:27:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20709 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHCE1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 00:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564806445; x=1596342445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YwZBgjDKqJC0ZZ1pMUEYPgwPKNXhIZ+3mPkTf+XP88Q=;
  b=CVuySkEZPupWWfefVu+RrYDl1xxFNNmpmCV01M82GlilztiphP/w75Py
   DWWFK+aNG+FNqTr3K8jlrp5XuotQJ3ke4hdNTDmxNSV7qkhdG5SZ2q81i
   46fBtVX5cutiOGWn1EJeLE9V01+7iHoVY0d5DyaEwjv4ML9sGDmoUPXvw
   LrlaLkVuh7sVeMuq3phJKvYWn+oMLAdltYtDGNNb6sJF1n+Qvl7u3ZP/v
   pH89VjeNUd2lfUUde0v51raEDegliE6/HsyFyPiBe0eiPU75hBfFGyrDA
   CeiIb1aJeYH5Ntk0At04mq63EnG8j+0edxM8Umn4YzTIMzDuG1IZNKsOc
   A==;
IronPort-SDR: wv1epBSRyuqFSrms1XWs1yMX2XN5Ii3/VozExOYCbMWWw+rSwW6yn5/wCKGvjy7uljO8odBLuM
 kIPM0QIjstx84w1TPg1JP48gWGBmEc8puGkVIzPxSwmxba8NK1cnVym9wQV4NdDTX3vAZA/N2w
 /77006vk7xz9bEI/GyrHDBtyTjgdtNov9hnJfzE5QNX7qwtlHY6upIS1FRM9LnaeCvBFd1e6kL
 mHkil3SNfVccMoD4huclmG+DK2QKXI9e89d48Pe/5bT0zm4h4Wjrq/Vpyvd0AChIgozbnRBTuN
 kMQ=
X-IronPort-AV: E=Sophos;i="5.64,340,1559491200"; 
   d="scan'208";a="114857035"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2019 12:27:25 +0800
IronPort-SDR: GPxeLPkYoV7hr+7kpqo7QyUvORpHzMwoTx+HZ8EGMc4vVwIPOjzJCyb/pOPHyq/5dcs6DEwcmi
 gW8B6yiGH9ycSswKIDQyWlQGaF0SeXyQa3hcJMBIQiWTW/E/Sa0b0pdrjmWmF45Sa0+xMHtRP9
 C85GUcDd0XMc9ah9j/b2NI3aTg1teomGHz1Lup1BGCiWDslepeeFzH4+HM7AoiC2qetgJT7AqJ
 Rd5wl5dXTV0NwaHMY2/1e5nWYP1T9zuZIx910HPBK3cLUGXU3HovyJ9GmbNky+txyBsavne7zk
 Hwqf36P8HdAyjWWkdAvArP4v
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 21:25:19 -0700
IronPort-SDR: TGgqUa3HMqMxaoqCTrW3QLhYzOybrFKDPM08KZJsMMokyJlt2xboQ3altV76Sv9C9uUZZkLWnI
 zVJqpFyVRR9/RWCbiE0HxBLFX06w3P5AuyXEgJHhpvCKMonHCKEAn1hASuNd7mITpiXXqX8VmP
 zeqUjphUfgNIlztN4eKpU9bua6UbA0LDRfNj+c0bqpFNv6I9Aa+dF4raJPHjJB6nYDIysT0r7y
 1CGPA5FIQqHpxMc9dSnJyFXl+y+J4pSxSrdqTQgJZMRn1IGAbKRvK1xjggyIUTJb17h5l3wN/P
 nh8=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Aug 2019 21:27:25 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
Subject: [PATCH v4 2/4] RISC-V: Add riscv_isa reprensenting ISA features common across CPUs
Date:   Fri,  2 Aug 2019 21:27:21 -0700
Message-Id: <20190803042723.7163-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190803042723.7163-1-atish.patra@wdc.com>
References: <20190803042723.7163-1-atish.patra@wdc.com>
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
 arch/riscv/include/asm/hwcap.h | 16 ++++++++++++++
 arch/riscv/kernel/cpufeature.c | 39 +++++++++++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 7ecb7c6a57b1..717306780add 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -22,5 +22,21 @@ enum {
 };
 
 extern unsigned long elf_hwcap;
+
+#define RISCV_ISA_EXT_a		(1UL << ('a' - 'a'))
+#define RISCV_ISA_EXT_c		(1UL << ('c' - 'a'))
+#define RISCV_ISA_EXT_d		(1UL << ('d' - 'a'))
+#define RISCV_ISA_EXT_f		(1UL << ('f' - 'a'))
+#define RISCV_ISA_EXT_h		(1UL << ('h' - 'a'))
+#define RISCV_ISA_EXT_i		(1UL << ('i' - 'a'))
+#define RISCV_ISA_EXT_m		(1UL << ('m' - 'a'))
+#define RISCV_ISA_EXT_s		(1UL << ('s' - 'a'))
+#define RISCV_ISA_EXT_u		(1UL << ('u' - 'a'))
+
+extern unsigned long riscv_isa;
+
+#define riscv_isa_extension_available(ext_char)	\
+		(riscv_isa & RISCV_ISA_EXT_##ext_char)
+
 #endif
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b1ade9a49347..becc99272341 100644
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
@@ -43,8 +49,20 @@ void riscv_fill_hwcap(void)
 			continue;
 		}
 
-		for (i = 0; i < strlen(isa); ++i)
+		i = 0;
+		isa_len = strlen(isa);
+#if defined(CONFIG_32BIT)
+		if (!strncmp(isa, "rv32", 4))
+			i += 4;
+#elif defined(CONFIG_64BIT)
+		if (!strncmp(isa, "rv64", 4))
+			i += 4;
+#endif
+		for (; i < isa_len; ++i) {
 			this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
+			if ('a' <= isa[i] && isa[i] <= 'z')
+				this_isa |= (1UL << (isa[i] - 'a'));
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
+			print_str[j++] = (char)('a' + i);
+	pr_info("riscv: ISA extensions %s\n", print_str);
+
+	memset(print_str, 0, sizeof(print_str));
+	for (i = 0, j = 0; i < BITS_PER_LONG; i++)
+		if (elf_hwcap & (1UL << i))
+			print_str[j++] = (char)('a' + i);
+	pr_info("riscv: ELF capabilities %s\n", print_str);
 
 #ifdef CONFIG_FPU
 	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
-- 
2.21.0

