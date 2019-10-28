Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891F5C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560072086D
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VqMxvfJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbfJ1MLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:11:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388869AbfJ1MLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QZQBvvgMbo82T4hWjz7g38W0EBZFABL93ZaGAHLWgwI=; b=VqMxvfJuhMPgDwlQHMS9G7g9Gf
        dLgknF54N18o5zQ7uXP2v2XlMyLtIq7vs3aeTXVjfvvhutpUdFiRLnZrPq6rcxCdoSebU9e5ZjIVO
        SBs4ta33DyuDK0qDcV501CsWu/3t3mwoZkAL5h5IlzKDWMeGOFXHMZjR3tz+AZYegR5ZYKcNnO3fu
        Vq4akMSW4WR+sqLrn3GUmPFNzfxLGpkljPs+def8mEzklMB+ObCFwAOFIPBz4Y0+mx4Skac0tQzcY
        0GXMTS3Y7J9+qDKvwm/jKZ4hTuuktiyEhARQgq0mWTnbyybCNO55znGS23MU7pMm3U+f+FRfouCPi
        bl0+gUnQ==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP3rS-0006n9-Ld; Mon, 28 Oct 2019 12:11:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH 06/12] riscv: add support for MMIO access to the timer registers
Date:   Mon, 28 Oct 2019 13:10:37 +0100
Message-Id: <20191028121043.22934-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028121043.22934-1-hch@lst.de>
References: <20191028121043.22934-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running in M-mode we can't use the SBI to set the timer, and
don't have access to the time CSR as that usually is emulated by
M-mode.  Instead provide code that directly accesses the MMIO for
the timer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/sbi.h      |  3 ++-
 arch/riscv/include/asm/timex.h    | 19 +++++++++++++++++--
 drivers/clocksource/timer-riscv.c | 21 +++++++++++++++++----
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 0cb74eccc73f..a4774bafe033 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -95,7 +95,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
 }
 #else /* CONFIG_RISCV_SBI */
-/* stub to for code is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
+/* stubs to for code is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
+void sbi_set_timer(uint64_t stime_value);
 void sbi_remote_fence_i(const unsigned long *hart_mask);
 #endif /* CONFIG_RISCV_SBI */
 #endif /* _ASM_RISCV_SBI_H */
diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index c7ef131b9e4c..e17837d61667 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -7,12 +7,25 @@
 #define _ASM_RISCV_TIMEX_H
 
 #include <asm/csr.h>
+#include <asm/io.h>
 
 typedef unsigned long cycles_t;
 
+extern u64 __iomem *riscv_time_val;
+extern u64 __iomem *riscv_time_cmp;
+
+#ifdef CONFIG_64BIT
+#define mmio_get_cycles()	readq_relaxed(riscv_time_val)
+#else
+#define mmio_get_cycles()	readl_relaxed(riscv_time_val)
+#define mmio_get_cycles_hi()	readl_relaxed(((u32 *)riscv_time_val) + 1)
+#endif
+
 static inline cycles_t get_cycles(void)
 {
-	return csr_read(CSR_TIME);
+	if (IS_ENABLED(CONFIG_RISCV_SBI))
+		return csr_read(CSR_TIME);
+	return mmio_get_cycles();
 }
 #define get_cycles get_cycles
 
@@ -24,7 +37,9 @@ static inline u64 get_cycles64(void)
 #else /* CONFIG_64BIT */
 static inline u32 get_cycles_hi(void)
 {
-	return csr_read(CSR_TIMEH);
+	if (IS_ENABLED(CONFIG_RISCV_SBI))
+		return csr_read(CSR_TIMEH);
+	return mmio_get_cycles_hi();
 }
 
 static inline u64 get_cycles64(void)
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index d083bfb535f6..f3eb0c04401a 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -3,9 +3,9 @@
  * Copyright (C) 2012 Regents of the University of California
  * Copyright (C) 2017 SiFive
  *
- * All RISC-V systems have a timer attached to every hart.  These timers can be
- * read from the "time" and "timeh" CSRs, and can use the SBI to setup
- * events.
+ * All RISC-V systems have a timer attached to every hart.  These timers can
+ * either be read from the "time" and "timeh" CSRs, and can use the SBI to
+ * setup events, or directly accessed using MMIO registers.
  */
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
@@ -13,14 +13,27 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/sched_clock.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/smp.h>
 #include <asm/sbi.h>
 
+u64 __iomem *riscv_time_cmp;
+u64 __iomem *riscv_time_val;
+
+static inline void mmio_set_timer(u64 val)
+{
+	writeq_relaxed(val,
+		riscv_time_cmp + cpuid_to_hartid_map(smp_processor_id()));
+}
+
 static int riscv_clock_next_event(unsigned long delta,
 		struct clock_event_device *ce)
 {
 	csr_set(CSR_IE, IE_TIE);
-	sbi_set_timer(get_cycles64() + delta);
+	if (IS_ENABLED(CONFIG_RISCV_SBI))
+		sbi_set_timer(get_cycles64() + delta);
+	else
+		mmio_set_timer(get_cycles64() + delta);
 	return 0;
 }
 
-- 
2.20.1

