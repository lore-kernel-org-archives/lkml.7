Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09192C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BE020727
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="a8hCWVsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfKQXGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 18:06:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41514 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfKQXGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 18:06:34 -0500
Received: by mail-io1-f67.google.com with SMTP id r144so16574136iod.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 15:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bBuXfW8UqlhFVT/AiDh5iapwM4kxSA5OKq/WwarocpI=;
        b=a8hCWVszRNuy9G+D8V8KKFZ3o84JZ/+ZoriD6ym4c9e3WfkdcCXyasCW1Wfxrij3BY
         vfbXqBScKt9gwlrGzzTjQOR1G4keSbchvOcdsNElOx1BslZutcvXD+d8hGzap/wwp/Kl
         LUA+Rz6LY1LmwH0HBYMv3TbH9I13SAULkfS9/yaVp5pa8iP7i83Mpcjzac4/nP1PbYAA
         puARQO1Jrl1E3zOW96jf7xVfMLffwtOJ4S/m3MIX06iDJbKQUeVj6QAWcozeeJS0LrOg
         YzRW57nXjpuRE0becsmCdpnGvIDG/Q+FSVbND91DVxvUV5L0bPNS52hx443A5u63Kfum
         MIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bBuXfW8UqlhFVT/AiDh5iapwM4kxSA5OKq/WwarocpI=;
        b=MurmzyRwSffJKI85GqtXqsh6yPwPa4c7MtIV+w65l8cmTWKw+QqA5X59nzCiN0YOyf
         YCsgsLOLcPul94hJmjXXvgHA3miIBxPI6p5AaPhUmrFgy9VDHHx5iqkE59gWoH1BgiYS
         5TSgJ2QIdyFt5WcUK8i79Mvz+V0PXBwlj9iSsh7VeDD2R0o2SGnTABcGNNEWF2LDM2of
         kmr5HTXv6y2Af8KlEHbYe2/wVRcCyoEU3rYxoc6csLdEfAomfjE7GdEePYGUrVc07DcY
         eXLpYU8wEK5ZGU3OjAnnIWDggJ0oZh2E1+B6eBZwdo1KZdDHGhpaCfdc57t8rxbha6Fg
         3Iyw==
X-Gm-Message-State: APjAAAWtI4LufAqMspBf1YSwHUagahP0AFx+1bLwCyX2GH6YxYiQrshf
        HohrhSg6yyGN9HdHTQ/cJDk2bFI420I=
X-Google-Smtp-Source: APXvYqyh8xbm9xHg+rak4VgFX4wXXoBi8CiwPmFBvQkdkRRc4fBiirJHUe2Q9/TNFFohBNldUdyJAA==
X-Received: by 2002:a5d:8855:: with SMTP id t21mr11242232ios.138.1574031992798;
        Sun, 17 Nov 2019 15:06:32 -0800 (PST)
Received: from localhost ([2601:8c4:0:9294:cb6f:4cf:b239:2fee])
        by smtp.gmail.com with ESMTPSA id s11sm3958013ila.44.2019.11.17.15.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 15:06:32 -0800 (PST)
Date:   Sun, 17 Nov 2019 15:06:30 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH 06/12] riscv: add support for MMIO access to the timer
 registers
In-Reply-To: <20191028121043.22934-7-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1911171459330.5296@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de> <20191028121043.22934-7-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Christoph Hellwig wrote:

> When running in M-mode we can't use the SBI to set the timer, and
> don't have access to the time CSR as that usually is emulated by
> M-mode.  Instead provide code that directly accesses the MMIO for
> the timer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks, queued the following for v5.5-rc1.


- Paul

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 28 Oct 2019 13:10:37 +0100
Subject: [PATCH] riscv: add support for MMIO access to the timer registers

When running in M-mode we can't use the SBI to set the timer, and
don't have access to the time CSR as that usually is emulated by
M-mode.  Instead provide code that directly accesses the MMIO for
the timer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
[paul.walmsley@sifive.com: updated to apply; fixed checkpatch
 issue; timex.h now includes asm/mmio.h to resolve header file
 problems]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/include/asm/sbi.h      |  3 ++-
 arch/riscv/include/asm/timex.h    | 19 +++++++++++++++++--
 drivers/clocksource/timer-riscv.c | 23 +++++++++++++++++++----
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 204af718df61..8e14d4819d0f 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -95,7 +95,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
 }
 #else /* CONFIG_RISCV_SBI */
-/* stub for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
+/* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
+void sbi_set_timer(uint64_t stime_value);
 void sbi_remote_fence_i(const unsigned long *hart_mask);
 #endif /* CONFIG_RISCV_SBI */
 #endif /* _ASM_RISCV_SBI_H */
diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index c7ef131b9e4c..bad2a7c2cda5 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -7,12 +7,25 @@
 #define _ASM_RISCV_TIMEX_H
 
 #include <asm/csr.h>
+#include <asm/mmio.h>
 
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
index d083bfb535f6..4e54856ce2a5 100644
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
@@ -13,14 +13,29 @@
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
+	void __iomem *r;
+
+	r = riscv_time_cmp + cpuid_to_hartid_map(smp_processor_id());
+	writeq_relaxed(val, r);
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
2.24.0.rc0

