Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABC5C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D392C22DCC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XpvQII/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfICJdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:33:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbfICJc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9sHyqczlkwNZ9JEZ9XHreur4PGZS1xltH4Vof5MR/SU=; b=XpvQII/+JtZK+/Kb2l6041Lkk5
        D/0dfTeWpYp7SH2OJSAnWs5wQV5B6g2l849oNfZrSaUPlCuHcz/Ta5ElRLeBvDxGIooNzttPFyNef
        nYHVMV0dUEEZHQ2gORQVNJ2oW2FGYLOrKNYKjkX3p+aRLJ2khqRcfqRPX6UHuvsy3Lmztn94OVjuJ
        29NXmhMLPqwjyHJKvgvDxInHCLRYFISvhN4QXO1e5UBVcDeKpHBW6151APZDyMn+CO0XvipKG2dc2
        KmEP60ZVEYUB0frq8ZCxBWJyyay+pgmHgSM9i2z4SA6vQWuM1nkwreL/9a42bV21D93x6dlChqErl
        i558l38Q==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i55BG-0004Rd-VI; Tue, 03 Sep 2019 09:32:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH 06/20] riscv: don't use the rdtime(h) pseudo-instructions
Date:   Tue,  3 Sep 2019 11:32:25 +0200
Message-Id: <20190903093239.21278-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903093239.21278-1-hch@lst.de>
References: <20190903093239.21278-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we just use the CSRs that these map to directly the code is simpler
and doesn't require extra inline assembly code.  Also fix up the top-level
comment in timer-riscv.c to not talk about the cycle count or mention
details of the clocksource interface, of which this file is just a
consumer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/timex.h    | 44 +++++++++++++++----------------
 drivers/clocksource/timer-riscv.c | 17 +++---------
 2 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index 6a703ec9d796..c7ef131b9e4c 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -6,43 +6,41 @@
 #ifndef _ASM_RISCV_TIMEX_H
 #define _ASM_RISCV_TIMEX_H
 
-#include <asm/param.h>
+#include <asm/csr.h>
 
 typedef unsigned long cycles_t;
 
-static inline cycles_t get_cycles_inline(void)
+static inline cycles_t get_cycles(void)
 {
-	cycles_t n;
-
-	__asm__ __volatile__ (
-		"rdtime %0"
-		: "=r" (n));
-	return n;
+	return csr_read(CSR_TIME);
 }
-#define get_cycles get_cycles_inline
+#define get_cycles get_cycles
 
 #ifdef CONFIG_64BIT
-static inline uint64_t get_cycles64(void)
+static inline u64 get_cycles64(void)
+{
+	return get_cycles();
+}
+#else /* CONFIG_64BIT */
+static inline u32 get_cycles_hi(void)
 {
-        return get_cycles();
+	return csr_read(CSR_TIMEH);
 }
-#else
-static inline uint64_t get_cycles64(void)
+
+static inline u64 get_cycles64(void)
 {
-	u32 lo, hi, tmp;
-	__asm__ __volatile__ (
-		"1:\n"
-		"rdtimeh %0\n"
-		"rdtime %1\n"
-		"rdtimeh %2\n"
-		"bne %0, %2, 1b"
-		: "=&r" (hi), "=&r" (lo), "=&r" (tmp));
+	u32 hi, lo;
+
+	do {
+		hi = get_cycles_hi();
+		lo = get_cycles();
+	} while (hi != get_cycles_hi());
+
 	return ((u64)hi << 32) | lo;
 }
-#endif
+#endif /* CONFIG_64BIT */
 
 #define ARCH_HAS_READ_CURRENT_TIMER
-
 static inline int read_current_timer(unsigned long *timer_val)
 {
 	*timer_val = get_cycles();
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 09e031176bc6..470c7ef02ea4 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -2,6 +2,10 @@
 /*
  * Copyright (C) 2012 Regents of the University of California
  * Copyright (C) 2017 SiFive
+ *
+ * All RISC-V systems have a timer attached to every hart.  These timers can be
+ * read from the "time" and "timeh" CSRs, and can use the SBI to setup
+ * events.
  */
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
@@ -12,19 +16,6 @@
 #include <asm/smp.h>
 #include <asm/sbi.h>
 
-/*
- * All RISC-V systems have a timer attached to every hart.  These timers can be
- * read by the 'rdcycle' pseudo instruction, and can use the SBI to setup
- * events.  In order to abstract the architecture-specific timer reading and
- * setting functions away from the clock event insertion code, we provide
- * function pointers to the clockevent subsystem that perform two basic
- * operations: rdtime() reads the timer on the current CPU, and
- * next_event(delta) sets the next timer event to 'delta' cycles in the future.
- * As the timers are inherently a per-cpu resource, these callbacks perform
- * operations on the current hart.  There is guaranteed to be exactly one timer
- * per hart on all RISC-V systems.
- */
-
 static int riscv_clock_next_event(unsigned long delta,
 		struct clock_event_device *ce)
 {
-- 
2.20.1

