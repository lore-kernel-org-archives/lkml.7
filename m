Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42973C00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 01:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030BF21734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 01:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DGylNAeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgADB2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 20:28:48 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45432 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgADB2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 20:28:47 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so43145721ioi.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 17:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bWg/c6iA97v6B47byrT70FImUW3Ul6QAIc+rwRJT/OQ=;
        b=DGylNAeGolb940YItbiF0WjP6HQRAiy8Qt1AQFiOKqKP0rqj+fwofzVopfuuQhrX8t
         nxFSxA83DvvvTUdqC/LkIipFAwUvOUFOn2xE0syIhQ79C4xyuMt48ilIt7iBTOHPIiZV
         NtmbddY4rM6Dt3/Lf+BX7cpzvjjdpqxuXwQSa11ffMc3DgajPmfiJCnu0CbfQWfnYdiO
         s9RpqFBoschdvt/7OPhAOlZFePmqsNINX4s4LUnvbs6bOZBdzp+jDk9AUg1LhQBV2q3o
         DCZ2+yvgeZu9E99IuW6AfNDqXIN6nqcGv6Jh1w1jKQUdK+SbxwBLnnljrUWoc4QkiLPk
         TZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bWg/c6iA97v6B47byrT70FImUW3Ul6QAIc+rwRJT/OQ=;
        b=fjBMksUJWSeD7Uo2qoUmjpN8FhFJR/ULuc30PZaneOrYgFDNtwkXMrFiSONSNQKlEl
         ER56gKHIYbs2RsNTGfIVPU1LLe7fCs7ayxBwTxvxmr/L8YSPsUquL4+16pk9uDEfgY00
         08IVwOK5/HSexfZS/aND7XRaRzHpiv18Vld6hyk3BP/ipGw1DTT2BpTM37FY0LH4syZl
         c/2R86HxX46b83oqMmLwCDTbDjZPWkwg0zD6ZonJpJTd8LU7iTIeoDQwbrUab7jEfb8a
         c2TMeSeKfHZ1+kJP/l+d51c2OtT+u4VF2aaL9IdVwaXKpO65EGDgjTMjCn5HF/bP5JoS
         6xnQ==
X-Gm-Message-State: APjAAAUi9ovQD3eH5SosljUjRjH6Sv0/r6KbxQAxJtIr9q73iEEe9/Ce
        QYuokG6mzcf1FF4vmrD/QPuQJQ==
X-Google-Smtp-Source: APXvYqxuG1jD6XtqASTj/6Pokx6/krwRshKhNCR9F5TP012pZ92GX/I5bwp23IUXU+m2O50QOisbTw==
X-Received: by 2002:a5e:8f41:: with SMTP id x1mr64046750iop.113.1578101326790;
        Fri, 03 Jan 2020 17:28:46 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id p5sm21304395ilg.69.2020.01.03.17.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 17:28:46 -0800 (PST)
Date:   Fri, 3 Jan 2020 17:28:44 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Olof Johansson <olof@lixom.net>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        jason@lakedaemon.net, maz@kernel.org, damien.lemoal@wdc.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] riscv: change CSR M/S defines to use "X" for prefix
In-Reply-To: <20191218170603.58256-1-olof@lixom.net>
Message-ID: <alpine.DEB.2.21.9999.2001031723310.283180@viisi.sifive.com>
References: <20191218170603.58256-1-olof@lixom.net>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019, Olof Johansson wrote:

> Commit a4c3733d32a7 ("riscv: abstract out CSR names for supervisor vs
> machine mode") introduced new non-S/M-specific defines for some of the
> CSRs and fields that differ for when you run the kernel in machine or
> supervisor mode.
> 
> One of those was "IRQ_TIMER" (instead of IRQ_S_TIMER/IRQ_M_MTIMER),
> which was generic enough to cause conflicts with other defines in
> drivers. Since it was in csr.h, it ended up getting pulled in through
> fairly generic include files, etc.
> 
> I looked at just renaming those, but for consistency I chose to rename all
> M/S symbols to using 'X' instead of 'S'/'M' in the identifiers instead,
> which gives them all less generic names.
> 
> This is pretty churny, and I'm sure there'll be opinions on naming, but
> I figured I'd do the busywork of fixing it up instead of just pointing
> out the conflicts.
> 
> Fixes: a4c3733d32a7 ("riscv: abstract out CSR names for supervisor vs machine mode")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Olof Johansson <olof@lixom.net>

Thanks for taking a stab at fixing the issue.  I queued the following 
minimal fix has been queued for v5.5-rc, adding an RV_ prefix to the IRQ_* 
macros.  It may be that we need to do the same thing to the rest of the 
CSRs.  But, based on a quick look, I think we should be OK for the moment.  
Let us know if you have a different point of view.


- Paul

From: Paul Walmsley <paul.walmsley@sifive.com>
Date: Fri, 20 Dec 2019 03:09:49 -0800
Subject: [PATCH] riscv: prefix IRQ_ macro names with an RV_ namespace

"IRQ_TIMER", used in the arch/riscv CSR header file, is a sufficiently
generic macro name that it's used by several source files across the
Linux code base.  Some of these other files ultimately include the
arch/riscv CSR include file, causing collisions.  Fix by prefixing the
RISC-V csr.h IRQ_ macro names with an RV_ prefix.

Fixes: a4c3733d32a72 ("riscv: abstract out CSR names for supervisor vs machine mode")
Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/include/asm/csr.h      | 18 +++++++++---------
 arch/riscv/kernel/irq.c           |  6 +++---
 drivers/irqchip/irq-sifive-plic.c |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 0a62d2d68455..435b65532e29 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -116,9 +116,9 @@
 # define SR_PIE		SR_MPIE
 # define SR_PP		SR_MPP
 
-# define IRQ_SOFT	IRQ_M_SOFT
-# define IRQ_TIMER	IRQ_M_TIMER
-# define IRQ_EXT	IRQ_M_EXT
+# define RV_IRQ_SOFT		IRQ_M_SOFT
+# define RV_IRQ_TIMER	IRQ_M_TIMER
+# define RV_IRQ_EXT		IRQ_M_EXT
 #else /* CONFIG_RISCV_M_MODE */
 # define CSR_STATUS	CSR_SSTATUS
 # define CSR_IE		CSR_SIE
@@ -133,15 +133,15 @@
 # define SR_PIE		SR_SPIE
 # define SR_PP		SR_SPP
 
-# define IRQ_SOFT	IRQ_S_SOFT
-# define IRQ_TIMER	IRQ_S_TIMER
-# define IRQ_EXT	IRQ_S_EXT
+# define RV_IRQ_SOFT		IRQ_S_SOFT
+# define RV_IRQ_TIMER	IRQ_S_TIMER
+# define RV_IRQ_EXT		IRQ_S_EXT
 #endif /* CONFIG_RISCV_M_MODE */
 
 /* IE/IP (Supervisor/Machine Interrupt Enable/Pending) flags */
-#define IE_SIE		(_AC(0x1, UL) << IRQ_SOFT)
-#define IE_TIE		(_AC(0x1, UL) << IRQ_TIMER)
-#define IE_EIE		(_AC(0x1, UL) << IRQ_EXT)
+#define IE_SIE		(_AC(0x1, UL) << RV_IRQ_SOFT)
+#define IE_TIE		(_AC(0x1, UL) << RV_IRQ_TIMER)
+#define IE_EIE		(_AC(0x1, UL) << RV_IRQ_EXT)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 3f07a91d5afb..345c4f2eba13 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -23,11 +23,11 @@ asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
 
 	irq_enter();
 	switch (regs->cause & ~CAUSE_IRQ_FLAG) {
-	case IRQ_TIMER:
+	case RV_IRQ_TIMER:
 		riscv_timer_interrupt();
 		break;
 #ifdef CONFIG_SMP
-	case IRQ_SOFT:
+	case RV_IRQ_SOFT:
 		/*
 		 * We only use software interrupts to pass IPIs, so if a non-SMP
 		 * system gets one, then we don't know what to do.
@@ -35,7 +35,7 @@ asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
 		riscv_software_interrupt();
 		break;
 #endif
-	case IRQ_EXT:
+	case RV_IRQ_EXT:
 		handle_arch_irq(regs);
 		break;
 	default:
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 8df547d2d935..0aca5807a119 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -256,7 +256,7 @@ static int __init plic_init(struct device_node *node,
 		 * Skip contexts other than external interrupts for our
 		 * privilege level.
 		 */
-		if (parent.args[0] != IRQ_EXT)
+		if (parent.args[0] != RV_IRQ_EXT)
 			continue;
 
 		hartid = plic_find_hart_id(parent.np);
-- 
2.24.0

