Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA761C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDBD2251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfKTNVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56841 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfKTNVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:33 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPvA-0007GJ-0D; Wed, 20 Nov 2019 14:21:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C199B1C1A21;
        Wed, 20 Nov 2019 14:21:06 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:06 -0000
From:   "tip-bot2 for Ben Dooks (Codethink)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Fix __iomem warning
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191017113341.13778-1-ben.dooks@codethink.co.uk>
References: <20191017113341.13778-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Message-ID: <157425606673.12247.2619370151942633774.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f8af4519dfb6156045173f38cbd528c043fb25e2
Gitweb:        https://git.kernel.org/tip/f8af4519dfb6156045173f38cbd528c043fb25e2
Author:        Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
AuthorDate:    Thu, 17 Oct 2019 12:33:41 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:45 

irqchip/gic-v3: Fix __iomem warning

The __iomem attribute should go before the * in the
prototype. Move to silence the following sparse
warnings:

./arch/arm/include/asm/arch_gicv3.h:340:15: warning: incorrect type in argument 1 (different address spaces)
./arch/arm/include/asm/arch_gicv3.h:340:15:    expected void const volatile [noderef] <asn:2> *addr
./arch/arm/include/asm/arch_gicv3.h:340:15:    got void *
./arch/arm/include/asm/arch_gicv3.h:343:17: warning: incorrect type in argument 2 (different address spaces)
./arch/arm/include/asm/arch_gicv3.h:343:17:    expected void volatile [noderef] <asn:2> *addr
./arch/arm/include/asm/arch_gicv3.h:343:17:    got void *
./arch/arm/include/asm/arch_gicv3.h:350:37: warning: incorrect type in argument 2 (different address spaces)
./arch/arm/include/asm/arch_gicv3.h:350:37:    expected void volatile [noderef] <asn:2> *addr
./arch/arm/include/asm/arch_gicv3.h:350:37:    got void *[noderef] <asn:2> addr
drivers/irqchip/irq-gic-v3-its.c:2832:46: warning: incorrect type in argument 2 (different address spaces)
drivers/irqchip/irq-gic-v3-its.c:2832:46:    expected void *[noderef] <asn:2> addr
drivers/irqchip/irq-gic-v3-its.c:2832:46:    got void [noderef] <asn:2> *
./arch/arm/include/asm/arch_gicv3.h:340:15: warning: incorrect type in argument 1 (different address spaces)
./arch/arm/include/asm/arch_gicv3.h:340:15:    expected void const volatile [noderef] <asn:2> *addr
./arch/arm/include/asm/arch_gicv3.h:340:15:    got void *
./arch/arm/include/asm/arch_gicv3.h:343:17: warning: incorrect type in argument 2 (different address spaces)
./arch/arm/include/asm/arch_gicv3.h:343:17:    expected void volatile [noderef] <asn:2> *addr
./arch/arm/include/asm/arch_gicv3.h:343:17:    got void *
./arch/arm/include/asm/arch_gicv3.h:350:37: warning: incorrect type in argument 2 (different address spaces)
./arch/arm/include/asm/arch_gicv3.h:350:37:    expected void volatile [noderef] <asn:2> *addr
./arch/arm/include/asm/arch_gicv3.h:350:37:    got void *[noderef] <asn:2> addr

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20191017113341.13778-1-ben.dooks@codethink.co.uk
---
 arch/arm/include/asm/arch_gicv3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 0555f14..fa50bb0 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -333,7 +333,7 @@ static inline u64 __gic_readq_nonatomic(const volatile void __iomem *addr)
  * GITS_VPENDBASER - the Valid bit must be cleared before changing
  * anything else.
  */
-static inline void gits_write_vpendbaser(u64 val, void * __iomem addr)
+static inline void gits_write_vpendbaser(u64 val, void __iomem *addr)
 {
 	u32 tmp;
 
