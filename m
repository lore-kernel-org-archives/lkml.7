Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35399C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C9E2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ORxh0Pgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfKZDUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 22:20:44 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55210 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfKZDUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574738439; x=1606274439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=To4UIdEWfy/4aSaabY3lPOtWDDQiV9C4pZsiIDGmpak=;
  b=ORxh0PgwGyWGxkRRNU5dee0l9URMViSYhhBf8vWqUT0Lfc4XaTNlk6ui
   S0vcOSI4+tPa3SmWQIzWR4+f4TuifHUgRvoztY2FFZUPwu/pDS1xK8UqB
   lA+Y7Er+h75zaRdUgD18OOXAjV/S2xdJ5laVCNfZ7ju0mvClsMtWpfb84
   Dlrs3NkjyRBOM6ceF0TsZBt+I3PCBPLICKIUiV8K9F0JwX0DRouvDWK5d
   3iHM3S9mEQXgOIGUESpk9Tj1r6ic9srSUnPb3rzrtBxU3zJp+pT/tYU3b
   rIvAdUQNQyNcnOZaFsFx+Eq2mVYeEbl2EETTJnIbl3t8eME82imWlqa5R
   Q==;
IronPort-SDR: ublbC2Gq/mQeYghCz6vVE3Dg21Gmc5xgigAOJ733g56CWR9o2F4+ry22c5OJit+RxjhccRm/EY
 SH5Iby2MrmEmOY1p8+4hXIyjU/8yySOFSfseeeFdd+WVRTcbpSLv1c3ZF6t5SB/a83BD6VmEyS
 kr75sKvE1Z11sLgLRq7v/s73UM9oxu+RfnC4s7k/EPQGlLt67dclXgSEP7wDV1GjZ6RY1JeQYn
 2QtVfgmPEoYfRrvwJg1Q2PvxgIQf/rWKMawsl9bsNpEWhFUvDtz0gmQdYhgCb6AhIG0A6jw7Zz
 19k=
X-IronPort-AV: E=Sophos;i="5.69,244,1571673600"; 
   d="scan'208";a="124761543"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2019 11:20:39 +0800
IronPort-SDR: BRAJ3FGVHiVgSTM2404+uqYThukZPRPiZOhJcTb+ATzfMPND+6c3Zw2IcNXES2eNMdwQ4Sk22c
 k7gD1I5CabmuNRerItHLnhNPlrUHxHr/YvFWX2Ys8AioRUHuvASDvVgy3UqZpChC02aP12oc08
 Kzgc5P/axVDIZ0x7zjTjmMAdZ+VmRWp1t3frQiaxKMVXAZ8CLBCputwumiBsNJfmr9b8bhORtA
 qZohCY/RVZXKynk9q7bMzKSASe4g1U2aJz/6YxmPn48nTz4wJnmR57EFQb2eo4TL+kOjDWNuZ9
 fAT0TNc3yBBEB6w3wlNqCGhG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 19:15:18 -0800
IronPort-SDR: Fkv99QB11wZ1APtzQTXCM03YC8yXUlGaDci1bD9IrRETYysK8DDF9lu/Bam4h/0HnW+VEkSYwx
 59SoXClpcFCNL2u+4G9OSJ7ixtg0BZ7geINYD1q650T8jSuNFu64SJAlehxBNnQvpZAerCLNAa
 vwr3KTMkhCUE9FqGhYZFMcthTjjYflATK0f35FPlIDgilXN+sX7731bhxhJq7/UDHnQfhgFIFT
 2QAEURrc/wkYwIqrPb+EJ+q96BPzt3TcsSf0385pM2tFNIu3PKqKqebS2hJwtpbC+gggj6rCku
 Bno=
WDCIronportException: Internal
Received: from usa003951.ad.shared (HELO yoda.hgst.com) ([10.86.50.226])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2019 19:20:38 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 3/4] RISC-V: Introduce a new config for SBI v0.1
Date:   Mon, 25 Nov 2019 19:20:32 -0800
Message-Id: <20191126032033.14825-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126032033.14825-1-atish.patra@wdc.com>
References: <20191126032033.14825-1-atish.patra@wdc.com>
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
index 8b36269fa515..8574de1074c4 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -8,6 +8,14 @@
 unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
 EXPORT_SYMBOL(sbi_spec_version);
 
+void (*__sbi_set_timer)(uint64_t stime);
+int (*__sbi_send_ipi)(const unsigned long *hart_mask);
+int (*__sbi_rfence)(unsigned long extid, unsigned long fid,
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
 
+static inline void __sbi_set_timer_dummy_warn(uint64_t stime_value)
+{
+	pr_warn("Timer extension is not available in SBI v%lu.%lu\n",
+		sbi_major_version(), sbi_minor_version());
+}
+
+static inline int __sbi_send_ipi_dummy_warn(const unsigned long *hart_mask)
+{
+	pr_warn("IPI extension is not available in SBI v%lu.%lu\n",
+		sbi_major_version(), sbi_minor_version());
+	return 0;
+}
+
+static inline int __sbi_rfence_dummy_warn(unsigned long extid,
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
 
@@ -254,8 +353,15 @@ int __init sbi_init(void)
 
 	pr_info("SBI specification v%lu.%lu detected\n",
 		sbi_major_version(), sbi_minor_version());
-	if (!sbi_spec_is_0_1())
+
+	if (sbi_spec_is_0_1()) {
+		__sbi_set_timer = __sbi_set_timer_v01;
+		__sbi_send_ipi	= __sbi_send_ipi_v01;
+		__sbi_rfence	= __sbi_rfence_v01;
+	} else {
 		pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
 			sbi_get_firmware_id(), sbi_get_firmware_version());
+	}
+
 	return 0;
 }
-- 
2.23.0

