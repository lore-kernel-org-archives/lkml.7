Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6823BC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242872075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BIjQ6zH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKZTFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:05:39 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:62441 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfKZTF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574795131; x=1606331131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IyuuQKX2x4AZ7fDlm/EikZWZtC8AHNah2RduTzZv7oY=;
  b=BIjQ6zH2G0w5lDr1xRHFUfn6SLryaQz3d4v3Fj8682y8bDqPCZkFb09+
   g7VSJxqvJbi/A3OBADi2xp42MdGapjwR7oyTbTd8K2kMOS8aNH8A3bHjj
   VL9bseh3Eif2pui7gGc5aa2PN9zfTBL881PidHC8iKV2HX8KPkJ+eFOwA
   vPfHodouzhtelRi/4ob3AR+HW/K9u8VGhnZFvV4uOZJpL9ZHVbwyGc1oy
   fJiMsNNaNh9wLf/2ieBGMwk5kZErsxETQx9y+RNZceWkaAhV6G6xK+WDe
   LE+reWmiScOiuiVO/aJ2d+59N0yBqslKeJxE3k1Nzy7WCWfkeCBgIaEjw
   g==;
IronPort-SDR: iu3Xiz5kvIp6GtaNFzJBSw1AS/El0Mv7KGsgX1+ACbt3PKI8uAvFBtjyayYPYC9qyyvxX5ElL1
 MrZs1QljnhxpO6cLzy+qhMe9z9NFALcMQgY6V6+yt2NtkaL1WWiYBmlOUIiEnP1ARu2QZRdAAl
 RnmqWdikULNOD8PplBjKj9OM9U1JSYFgrRxgl7YJmIr0SE3hH27jhBsJqRrJ735iZ8oxNedJxP
 vDrbn2I5bvmI2srYajQdTp+rCDrbqmvo1nFG4vnDxMh3vvC4ebksP/zX6JalHxcUVLBKuOSU4O
 Tag=
X-IronPort-AV: E=Sophos;i="5.69,246,1571673600"; 
   d="scan'208";a="128481934"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2019 03:05:30 +0800
IronPort-SDR: R1aGs8F/R4pIqP10aGa85lPwVUBY0zyXGDWLUIlkPzRH1ukTyhG4phmZeQqByc0kDWAlcibkE7
 bjZK/BBAmuknqDygd8ez87LBXIz6vUwt1eansUSJMNzWltCyALWHq8H7qyJP2zEy/grPgROvB9
 VJNo8josT/DrQjQYFPXx2ZiZDcV8oKGp0JhDEA5I/OjzE1B0blTviWCrlxsbkrPFffmRrFOo83
 HRS4qIrFzsVJpUoaX1kSv8qVO2aHgi6FamQCoxnCA+hXovk6xTIZT5/X+fXmpJb3+Mp/EXfTR0
 E/TzMNaW+eNNJxa9L9wOYT+R
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 11:00:07 -0800
IronPort-SDR: IEiFUbY4ZdPKUePaDinsGOTtv69F0oBMJEb0LNoF59utgX5vLMwnQX+8wgVflRi0fovcCsYj6Q
 agzuoQnjXHOEj+UciJNZIzF1DXp4pxHQHTJWA1y88dE4EkeXJAioV4qJiQhfCmxSpFhxH+D7yh
 LNBS9xxdxYFOqndUvyhq6ZAyxeK02E6MY8eo1jj/nYXrOX9JDdGBEgCDF3xD+wvOYPdO4UY+uj
 jEhJclBQN1LU/N/yyrCTQL7kKAPPD2QTlltAMxc6T2Rd+HCNVu4BNq43Uxn1aBqkuCdXMsBeV3
 qt0=
WDCIronportException: Internal
Received: from usa003951.ad.shared (HELO yoda.hgst.com) ([10.86.50.226])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Nov 2019 11:05:30 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 3/4] RISC-V: Introduce a new config for SBI v0.1
Date:   Tue, 26 Nov 2019 11:05:02 -0800
Message-Id: <20191126190503.19303-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126190503.19303-1-atish.patra@wdc.com>
References: <20191126190503.19303-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have SBI v0.2 which is more scalable and extendable to handle
future needs for RISC-V supervisor interfaces.

Introduce a new config and move all SBI v0.1 code under that config.
This allows to implement the new replacement SBI extensions cleanly
and remove v0.1 extensions easily in future. Currently, the config
is enabled by default. Once all M-mode software with v0.1 are no
longer in use, this config option and all relevant code can be easily
removed.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/Kconfig           |   6 ++
 arch/riscv/include/asm/sbi.h |   2 +
 arch/riscv/kernel/sbi.c      | 154 +++++++++++++++++++++++++++++------
 3 files changed, 138 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ca3b5541ae93..15c020d6837b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -304,6 +304,12 @@ config SECCOMP
 	  and the task is only allowed to execute a few safe syscalls
 	  defined by each seccomp mode.
 
+config RISCV_SBI_V01
+	bool "SBI v0.1 support"
+	default y
+	help
+	  This config allows kernel to use SBI v0.1 APIs. This will be
+	  deprecated in future once legacy M-mode software are no longer in use.
 endmenu
 
 menu "Boot options"
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 906438322932..cc82ae63f8e0 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -10,6 +10,7 @@
 
 #ifdef CONFIG_RISCV_SBI
 enum sbi_ext_id {
+#ifdef CONFIG_RISCV_SBI_V01
 	SBI_EXT_0_1_SET_TIMER = 0x0,
 	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
 	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
@@ -19,6 +20,7 @@ enum sbi_ext_id {
 	SBI_EXT_0_1_REMOTE_SFENCE_VMA = 0x6,
 	SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
 	SBI_EXT_0_1_SHUTDOWN = 0x8,
+#endif
 	SBI_EXT_BASE = 0x10,
 };
 
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index a47e23c3a2e1..ee710bfe0b0e 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -8,6 +8,14 @@
 unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
 EXPORT_SYMBOL(sbi_spec_version);
 
+static void (*__sbi_set_timer)(uint64_t stime);
+static int (*__sbi_send_ipi)(const unsigned long *hart_mask);
+static int (*__sbi_rfence)(unsigned long extid, unsigned long fid,
+		  const unsigned long *hart_mask,
+		  unsigned long hbase, unsigned long start,
+		  unsigned long size, unsigned long arg4,
+		  unsigned long arg5);
+
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
 			unsigned long arg3, unsigned long arg4,
@@ -52,6 +60,32 @@ static int sbi_err_map_linux_errno(int err)
 	};
 }
 
+static void __sbi_set_timer_dummy_warn(uint64_t stime_value)
+{
+	pr_warn("Timer extension is not available in SBI v%lu.%lu\n",
+		sbi_major_version(), sbi_minor_version());
+}
+
+static int __sbi_send_ipi_dummy_warn(const unsigned long *hart_mask)
+{
+	pr_warn("IPI extension is not available in SBI v%lu.%lu\n",
+		sbi_major_version(), sbi_minor_version());
+	return 0;
+}
+
+static int __sbi_rfence_dummy_warn(unsigned long extid,
+			     unsigned long fid,
+			     const unsigned long *hart_mask,
+			     unsigned long hbase, unsigned long start,
+			     unsigned long size, unsigned long arg4,
+			     unsigned long arg5)
+{
+	pr_warn("remote fence extension is not available in SBI v%lu.%lu\n",
+		sbi_major_version(), sbi_minor_version());
+	return 0;
+}
+
+#ifdef CONFIG_RISCV_SBI_V01
 /**
  * sbi_console_putchar() - Writes given character to the console device.
  * @ch: The data to be written to the console.
@@ -80,41 +114,106 @@ int sbi_console_getchar(void)
 EXPORT_SYMBOL(sbi_console_getchar);
 
 /**
- * sbi_set_timer() - Program the timer for next timer event.
- * @stime_value: The value after which next timer event should fire.
+ * sbi_shutdown() - Remove all the harts from executing supervisor code.
  *
  * Return: None
  */
-void sbi_set_timer(uint64_t stime_value)
+void sbi_shutdown(void)
 {
-#if __riscv_xlen == 32
-	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value,
-			  stime_value >> 32, 0, 0, 0, 0);
-#else
-	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value, 0, 0, 0, 0, 0);
-#endif
+	sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
 }
 EXPORT_SYMBOL(sbi_set_timer);
 
 /**
- * sbi_shutdown() - Remove all the harts from executing supervisor code.
+ * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
  *
  * Return: None
  */
-void sbi_shutdown(void)
+void sbi_clear_ipi(void)
 {
-	sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
+	sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
 }
 EXPORT_SYMBOL(sbi_shutdown);
 
 /**
- * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
+ * sbi_set_timer_v01() - Program the timer for next timer event.
+ * @stime_value: The value after which next timer event should fire.
  *
  * Return: None
  */
-void sbi_clear_ipi(void)
+static void __sbi_set_timer_v01(uint64_t stime_value)
 {
-	sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
+#if __riscv_xlen == 32
+	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value,
+		  stime_value >> 32, 0, 0, 0, 0);
+#else
+	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value, 0, 0, 0, 0, 0);
+#endif
+}
+
+static int __sbi_send_ipi_v01(const unsigned long *hart_mask)
+{
+	sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
+		  0, 0, 0, 0, 0);
+	return 0;
+}
+
+static int __sbi_rfence_v01(unsigned long ext, unsigned long fid,
+			     const unsigned long *hart_mask,
+			     unsigned long hbase, unsigned long start,
+			     unsigned long size, unsigned long arg4,
+			     unsigned long arg5)
+{
+	switch (ext) {
+	case SBI_EXT_0_1_REMOTE_FENCE_I:
+		sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
+			  (unsigned long)hart_mask, 0, 0, 0, 0, 0);
+		break;
+	case SBI_EXT_0_1_REMOTE_SFENCE_VMA:
+		sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
+			  (unsigned long)hart_mask, start, size,
+			  0, 0, 0);
+		break;
+	case SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID:
+		sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
+			  (unsigned long)hart_mask, start, size,
+			  arg4, 0, 0);
+		break;
+	default:
+		pr_err("extid [%lu]not supported in SBI v0.1\n", ext);
+	}
+
+	return 0;
+}
+#else
+static void __sbi_set_timer_v01(uint64_t stime_value)
+{
+	__sbi_set_timer_dummy_warn(0);
+}
+static int __sbi_send_ipi_v01(const unsigned long *hart_mask)
+{
+	return __sbi_send_ipi_dummy_warn(NULL);
+}
+static int __sbi_rfence_v01(unsigned long ext, unsigned long fid,
+			     const unsigned long *hart_mask,
+			     unsigned long hbase, unsigned long start,
+			     unsigned long size, unsigned long arg4,
+			     unsigned long arg5)
+{
+	return __sbi_rfence_dummy_warn(0, 0, 0, 0, 0, 0, 0, 0);
+
+}
+#endif /* CONFIG_RISCV_SBI_V01 */
+
+/**
+ * sbi_set_timer() - Program the timer for next timer event.
+ * @stime_value: The value after which next timer event should fire.
+ *
+ * Return: None
+ */
+void sbi_set_timer(uint64_t stime_value)
+{
+	__sbi_set_timer(stime_value);
 }
 
 /**
@@ -125,11 +224,11 @@ void sbi_clear_ipi(void)
  */
 void sbi_send_ipi(const unsigned long *hart_mask)
 {
-	sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
-			0, 0, 0, 0, 0);
+	__sbi_send_ipi(hart_mask);
 }
 EXPORT_SYMBOL(sbi_send_ipi);
 
+
 /**
  * sbi_remote_fence_i() - Execute FENCE.I instruction on given remote harts.
  * @hart_mask: A cpu mask containing all the target harts.
@@ -138,8 +237,8 @@ EXPORT_SYMBOL(sbi_send_ipi);
  */
 void sbi_remote_fence_i(const unsigned long *hart_mask)
 {
-	sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0, (unsigned long)hart_mask,
-			0, 0, 0, 0, 0);
+	__sbi_rfence(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
+		     hart_mask, 0, 0, 0, 0, 0);
 }
 EXPORT_SYMBOL(sbi_remote_fence_i);
 
@@ -156,8 +255,8 @@ void sbi_remote_sfence_vma(const unsigned long *hart_mask,
 					 unsigned long start,
 					 unsigned long size)
 {
-	sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
-			(unsigned long)hart_mask, start, size, 0, 0, 0);
+	__sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
+		     hart_mask, 0, start, size, 0, 0);
 }
 EXPORT_SYMBOL(sbi_remote_sfence_vma);
 
@@ -177,8 +276,8 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 					      unsigned long size,
 					      unsigned long asid)
 {
-	sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
-			(unsigned long)hart_mask, start, size, asid, 0, 0);
+	__sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
+		     hart_mask, 0, start, size, asid, 0);
 }
 EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
 
@@ -253,8 +352,15 @@ int __init sbi_init(void)
 
 	pr_info("SBI specification v%lu.%lu detected\n",
 		sbi_major_version(), sbi_minor_version());
-	if (!sbi_spec_is_0_1())
+
+	if (!sbi_spec_is_0_1()) {
 		pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
 			sbi_get_firmware_id(), sbi_get_firmware_version());
+	}
+
+	__sbi_set_timer = __sbi_set_timer_v01;
+	__sbi_send_ipi	= __sbi_send_ipi_v01;
+	__sbi_rfence	= __sbi_rfence_v01;
+
 	return 0;
 }
-- 
2.23.0

