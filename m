Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702C2C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388942053B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MLBZ/IPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfHZXdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 19:33:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61044 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfHZXd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566862408; x=1598398408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NOwAjvHbcc50rcpd47uuWkr60xMZSOcYkQr+KzmxZ80=;
  b=MLBZ/IPL7Gkjb9LGAdLXZ3Ib5JuM2o+BbwUJbr2ls+Fzlw2rfOdzutCz
   DI0ycc6dljTXfeS1cqt7AOi9RuM3t8LgCPrPLxtPHEd/ba85boUpZ20jL
   d6NMyj+O9CudG8ygxiY6ji7nuY6AA6coIF0nFq5YwsXWCmNZOcLRBAiEH
   0DFronMUaxlFyAq8eV1pM6ihIkB//rv4RJ5EKTdXN1DSkuhUqAX/QWWsR
   IhEqocukX3TFB+VA0lrbQodtSmzT0r0l8FAQTAAtS5jhIby0NycvQGDIT
   NIwAt7D7/O/uYyKvYEdYb+3UvNwdq7f866Am+bZg3hwW1iqMYa+YZFBqZ
   g==;
IronPort-SDR: IUgWkJTWG0MkqUZsCYWqjnXEsqwmDX84fh6Cs/poMQ5vC7L1rbryv2CgRzl4YUO1d09yNEfL4w
 O/XbiyF0hTWw7OcpmQhtQFJNECPVixFxPxSwOt6550iTcx4iWskx9Z003cvs4LhnU2qmt5Mnj2
 dgUN8c0H4B021NhW4cFZ5Q4our/2qoT9xAf3i1Tu39U2Tx+ALKaThl1lgyewf84gWJyP3R7/er
 0rXUtWX1xLVPp2+IuMh/1xV8sEbHSoz4Is242FTnUhRq5fdBJcJikG6/BxB9ZF+94iGsC4pxIV
 VJk=
X-IronPort-AV: E=Sophos;i="5.64,435,1559491200"; 
   d="scan'208";a="116718028"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2019 07:33:27 +0800
IronPort-SDR: IeChZIITFe937Q0rew7gIOLNGyg0EbTvq9fOLNYRx6FS7lOlLY7riwlXPTLK+ygdwLxQCSGq9x
 7tCNH0xZX+DvcHg9TELGFsmbgm+S8xNyxhi5trC6V6r3Uc3mQoW5EusY1fTNgi4rq2ClqGhIsT
 mPKg1WC5kzgZ+ukDyTL+iHJewasAJTfGNrdg74pS8HI22j/M31Z+b2qdd66iTMonsSBxe61rBg
 dLPMALE0TVNSDyv0udX2jXMdoeyV23TupGXZwDlyM2t18tdWVbttg75VXzKM4DV4hBk+BYdWZT
 Kjc+zrlG3DY/kXfazgW7mdIc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 16:30:39 -0700
IronPort-SDR: URb8pJMR4ETxv6cJze0dd43lyc6gWQ1YGQRs+0YiVLlUBxpzdCKr2LwKae90PTni5TRqxUTGWj
 t64IroRNYC4XBYZ25n3+7ajzg5mogFRIPhu98SnXStyODOakhjf/LdyzgjPcjSiNzyew1N2ErJ
 VyQDtBY9tMq75Q8RvvW3XlPzsbZdg4Ys30gxHzSyVEFukSB6gUhT/Dtaz+sGSkvpVL8EbzT740
 6x0kWk/UW5UGrarLDnnCU08k2zhv/Y6XK3XLlvL2ShkRllwDg+F02/lpd5X+EHRKIyklmYu8tK
 umA=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Aug 2019 16:33:28 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <anup@brainfault.org>, Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 2/2] RISC-V: Add basic support for SBI v0.2
Date:   Mon, 26 Aug 2019 16:32:56 -0700
Message-Id: <20190826233256.32383-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190826233256.32383-1-atish.patra@wdc.com>
References: <20190826233256.32383-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBI v0.2 introduces a base extension which is backward compatible
with v0.1. Implement all helper functions and minimum required SBI
calls from v0.2 for now. All other base extension function will be
added later as per need.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sbi.h | 68 +++++++++++++++++++++++++++++-------
 arch/riscv/kernel/Makefile   |  1 +
 arch/riscv/kernel/sbi.c      | 50 ++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c    |  2 ++
 4 files changed, 108 insertions(+), 13 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi.c

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 7f5ecaaaa0d7..4a4476956693 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -8,7 +8,6 @@
 
 #include <linux/types.h>
 
-
 #define SBI_EXT_LEGACY_SET_TIMER 0x0
 #define SBI_EXT_LEGACY_CONSOLE_PUTCHAR 0x1
 #define SBI_EXT_LEGACY_CONSOLE_GETCHAR 0x2
@@ -19,28 +18,61 @@
 #define SBI_EXT_LEGACY_REMOTE_SFENCE_VMA_ASID 0x7
 #define SBI_EXT_LEGACY_SHUTDOWN 0x8
 
-#define SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3) ({             \
+#define SBI_EXT_BASE 0x10
+
+enum sbi_ext_base_fid {
+	SBI_EXT_BASE_GET_SPEC_VERSION = 0,
+	SBI_EXT_BASE_GET_IMP_ID,
+	SBI_EXT_BASE_GET_IMP_VERSION,
+	SBI_EXT_BASE_PROBE_EXT,
+	SBI_EXT_BASE_GET_MVENDORID,
+	SBI_EXT_BASE_GET_MARCHID,
+	SBI_EXT_BASE_GET_MIMPID,
+};
+
+#define SBI_CALL_LEGACY(ext, fid, arg0, arg1, arg2, arg3) ({	\
 	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
 	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);	\
 	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);	\
 	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);	\
-	register uintptr_t a7 asm ("a7") = (uintptr_t)(which);	\
+	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);	\
+	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);	\
 	asm volatile ("ecall"					\
-		      : "+r" (a0)				\
-		      : "r" (a1), "r" (a2), "r" (a3), "r" (a7)	\
+		      : "+r" (a0), "+r" (a1)			\
+		      : "r" (a2), "r" (a3), "r" (a6), "r" (a7) \
 		      : "memory");				\
 	a0;							\
 })
 
 /* Lazy implementations until SBI is finalized */
-#define SBI_CALL_LEGACY_0(which) SBI_CALL_LEGACY(which, 0, 0, 0, 0)
-#define SBI_CALL_LEGACY_1(which, arg0) SBI_CALL_LEGACY(which, arg0, 0, 0, 0)
-#define SBI_CALL_LEGACY_2(which, arg0, arg1) \
-		SBI_CALL_LEGACY(which, arg0, arg1, 0, 0)
-#define SBI_CALL_LEGACY_3(which, arg0, arg1, arg2) \
-		SBI_CALL_LEGACY(which, arg0, arg1, arg2, 0)
-#define SBI_CALL_LEGACY_4(which, arg0, arg1, arg2, arg3) \
-		SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3)
+#define SBI_CALL_LEGACY_0(ext) SBI_CALL_LEGACY(ext, 0, 0, 0, 0, 0)
+#define SBI_CALL_LEGACY_1(ext, arg0) SBI_CALL_LEGACY(ext, 0, arg0, 0, 0, 0)
+#define SBI_CALL_LEGACY_2(ext, arg0, arg1) \
+		SBI_CALL_LEGACY(ext, 0, arg0, arg1, 0, 0)
+#define SBI_CALL_LEGACY_3(ext, arg0, arg1, arg2) \
+		SBI_CALL_LEGACY(ext, 0, arg0, arg1, arg2, 0)
+#define SBI_CALL_LEGACY_4(ext, arg0, arg1, arg2, arg3) \
+		SBI_CALL_LEGACY(ext, 0, arg0, arg1, arg2, arg3)
+
+extern unsigned long sbi_firmware_version;
+struct sbiret {
+	long error;
+	long value;
+};
+
+void riscv_sbi_init(void);
+struct sbiret riscv_sbi_ecall(int ext, int fid, int arg0, int arg1,
+			       int arg2, int arg3);
+
+#define SBI_CALL_0(ext, fid) riscv_sbi_ecall(ext, fid, 0, 0, 0, 0)
+#define SBI_CALL_1(ext, fid, arg0) riscv_sbi_ecall(ext, fid, arg0, 0, 0, 0)
+#define SBI_CALL_2(ext, fid, arg0, arg1) \
+		riscv_sbi_ecall(ext, fid, arg0, arg1, 0, 0)
+#define SBI_CALL_3(ext, fid, arg0, arg1, arg2) \
+		riscv_sbi_ecall(ext, fid, arg0, arg1, arg2, 0)
+#define SBI_CALL_4(ext, fid, arg0, arg1, arg2, arg3) \
+		riscv_sbi_ecall(ext, fid, arg0, arg1, arg2, arg3)
+
 
 static inline void sbi_console_putchar(int ch)
 {
@@ -99,4 +131,14 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 			  start, size, asid);
 }
 
+static inline unsigned long riscv_sbi_major_version(void)
+{
+	return (sbi_firmware_version >> 24) & 0x7f;
+}
+
+static inline unsigned long riscv_sbi_minor_version(void)
+{
+	return sbi_firmware_version & 0xffffff;
+}
+
 #endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 2420d37d96de..faf862d26924 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -17,6 +17,7 @@ obj-y	+= irq.o
 obj-y	+= process.o
 obj-y	+= ptrace.o
 obj-y	+= reset.o
+obj-y	+= sbi.o
 obj-y	+= setup.o
 obj-y	+= signal.o
 obj-y	+= syscall_table.o
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
new file mode 100644
index 000000000000..457b8cc0e9d9
--- /dev/null
+++ b/arch/riscv/kernel/sbi.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SBI initialilization and base extension implementation.
+ *
+ * Copyright (c) 2019 Western Digital Corporation or its affiliates.
+ */
+
+#include <asm/sbi.h>
+#include <linux/sched.h>
+
+unsigned long sbi_firmware_version;
+
+struct sbiret riscv_sbi_ecall(int ext, int fid, int arg0, int arg1,
+			     int arg2, int arg3)
+{
+	struct sbiret ret;
+
+	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
+	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
+	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
+	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
+	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
+	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
+	asm volatile ("ecall"
+		      : "+r" (a0), "+r" (a1)
+		      : "r" (a2), "r" (a3), "r" (a6), "r" (a7)
+		      : "memory");
+	ret.error = a0;
+	ret.value = a1;
+
+	return ret;
+}
+
+static struct sbiret sbi_get_spec_version(void)
+{
+	return SBI_CALL_0(SBI_EXT_BASE, SBI_EXT_BASE_GET_SPEC_VERSION);
+}
+
+void riscv_sbi_init(void)
+{
+	struct sbiret ret;
+
+	/* legacy SBI version*/
+	sbi_firmware_version = 0x1;
+	ret = sbi_get_spec_version();
+	if (!ret.error)
+		sbi_firmware_version = ret.value;
+	pr_info("SBI version implemented in firmware [%lu:%lu]\n",
+		riscv_sbi_major_version(), riscv_sbi_minor_version());
+}
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index a990a6cb184f..4c324fd398c8 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -21,6 +21,7 @@
 #include <asm/sections.h>
 #include <asm/pgtable.h>
 #include <asm/smp.h>
+#include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/thread_info.h>
 
@@ -70,6 +71,7 @@ void __init setup_arch(char **cmdline_p)
 	swiotlb_init(1);
 #endif
 
+	riscv_sbi_init();
 #ifdef CONFIG_SMP
 	setup_smp();
 #endif
-- 
2.21.0

