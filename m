Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A394FFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3FA21D7F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239202;
	bh=QZ2jyt3SRLfbIIjDA/HUNbUH1RX8jRWFn0badbzU2h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rzNuRgdOjjL8ZOnyzyU8me4nj/g0m3Svu0mf4FLQaiT1FKa3VTvEgbFkh1icTQdB8
	 LFs1IwzbXXo67CmRV6cO6SFPJzJ7P5m55MbgXNm9RCwXurwf4eKtd4Sm71g9y0sUHa
	 hwvqY461Syr1Zf1baufu0mnQZBxeS6BNpiCvbXPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfKHSxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:53:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732214AbfKHSxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:53:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CFBC218AE;
        Fri,  8 Nov 2019 18:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239193;
        bh=QZ2jyt3SRLfbIIjDA/HUNbUH1RX8jRWFn0badbzU2h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4rPfC0tsH8OI3ga81lEAfXn1ETWjxH+CxvUxHebOVjOMzeAUUnoOCL/jG/AeMa5q
         v3cCoVPDKTlM1Xk4uZq8IrVIHuHR3QIQzElTpm1WKQ5zKIAk32i7q16NQRgYTurm5B
         4cUA9RcrIJlA6c1QA+ENMfhGyuIOyz5J1hBuP1so=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4.4 30/75] ARM: Move system register accessors to asm/cp15.h
Date:   Fri,  8 Nov 2019 19:49:47 +0100
Message-Id: <20191108174738.619206816@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
References: <20191108174708.135680837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

Commit 4f2546384150e78cad8045e59a9587fabcd9f9fe upstream.

Headers linux/irqchip/arm-gic.v3.h and arch/arm/include/asm/kvm_hyp.h
are included in virt/kvm/arm/hyp/vgic-v3-sr.c and both define macros
called __ACCESS_CP15 and __ACCESS_CP15_64 which obviously creates a
conflict. These macros were introduced independently for GIC and KVM
and, in fact, do the same thing.

As an option we could add prefixes to KVM and GIC version of macros so
they won't clash, but it'd introduce code duplication.  Alternatively,
we could keep macro in, say, GIC header and include it in KVM one (or
vice versa), but such dependency would not look nicer.

So we follow arm64 way (it handles this via sysreg.h) and move only
single set of macros to asm/cp15.h

Cc: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/arch_gicv3.h |   27 +++++++++++----------------
 arch/arm/include/asm/cp15.h       |   15 +++++++++++++++
 2 files changed, 26 insertions(+), 16 deletions(-)

--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -22,9 +22,7 @@
 
 #include <linux/io.h>
 #include <asm/barrier.h>
-
-#define __ACCESS_CP15(CRn, Op1, CRm, Op2)	p15, Op1, %0, CRn, CRm, Op2
-#define __ACCESS_CP15_64(Op1, CRm)		p15, Op1, %Q0, %R0, CRm
+#include <asm/cp15.h>
 
 #define ICC_EOIR1			__ACCESS_CP15(c12, 0, c12, 1)
 #define ICC_DIR				__ACCESS_CP15(c12, 0, c11, 1)
@@ -102,58 +100,55 @@
 
 static inline void gic_write_eoir(u32 irq)
 {
-	asm volatile("mcr " __stringify(ICC_EOIR1) : : "r" (irq));
+	write_sysreg(irq, ICC_EOIR1);
 	isb();
 }
 
 static inline void gic_write_dir(u32 val)
 {
-	asm volatile("mcr " __stringify(ICC_DIR) : : "r" (val));
+	write_sysreg(val, ICC_DIR);
 	isb();
 }
 
 static inline u32 gic_read_iar(void)
 {
-	u32 irqstat;
+	u32 irqstat = read_sysreg(ICC_IAR1);
 
-	asm volatile("mrc " __stringify(ICC_IAR1) : "=r" (irqstat));
 	dsb(sy);
+
 	return irqstat;
 }
 
 static inline void gic_write_pmr(u32 val)
 {
-	asm volatile("mcr " __stringify(ICC_PMR) : : "r" (val));
+	write_sysreg(val, ICC_PMR);
 }
 
 static inline void gic_write_ctlr(u32 val)
 {
-	asm volatile("mcr " __stringify(ICC_CTLR) : : "r" (val));
+	write_sysreg(val, ICC_CTLR);
 	isb();
 }
 
 static inline void gic_write_grpen1(u32 val)
 {
-	asm volatile("mcr " __stringify(ICC_IGRPEN1) : : "r" (val));
+	write_sysreg(val, ICC_IGRPEN1);
 	isb();
 }
 
 static inline void gic_write_sgi1r(u64 val)
 {
-	asm volatile("mcrr " __stringify(ICC_SGI1R) : : "r" (val));
+	write_sysreg(val, ICC_SGI1R);
 }
 
 static inline u32 gic_read_sre(void)
 {
-	u32 val;
-
-	asm volatile("mrc " __stringify(ICC_SRE) : "=r" (val));
-	return val;
+	return read_sysreg(ICC_SRE);
 }
 
 static inline void gic_write_sre(u32 val)
 {
-	asm volatile("mcr " __stringify(ICC_SRE) : : "r" (val));
+	write_sysreg(val, ICC_SRE);
 	isb();
 }
 
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -49,6 +49,21 @@
 
 #ifdef CONFIG_CPU_CP15
 
+#define __ACCESS_CP15(CRn, Op1, CRm, Op2)	\
+	"mrc", "mcr", __stringify(p15, Op1, %0, CRn, CRm, Op2), u32
+#define __ACCESS_CP15_64(Op1, CRm)		\
+	"mrrc", "mcrr", __stringify(p15, Op1, %Q0, %R0, CRm), u64
+
+#define __read_sysreg(r, w, c, t) ({				\
+	t __val;						\
+	asm volatile(r " " c : "=r" (__val));			\
+	__val;							\
+})
+#define read_sysreg(...)		__read_sysreg(__VA_ARGS__)
+
+#define __write_sysreg(v, r, w, c, t)	asm volatile(w " " c : : "r" ((t)(v)))
+#define write_sysreg(v, ...)		__write_sysreg(v, __VA_ARGS__)
+
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
 static inline unsigned long get_cr(void)


