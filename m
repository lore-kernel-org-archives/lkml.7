Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D53C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA50520857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="be1CiYfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfCSPx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:53:56 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:63825 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSPx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:53:56 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x2JFqgQx020669;
        Wed, 20 Mar 2019 00:52:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x2JFqgQx020669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553010763;
        bh=A2+cO3hRpKwBj1MVA+O6aHySKEo9Y616LGE3nKQruds=;
        h=From:To:Cc:Subject:Date:From;
        b=be1CiYfJOkj8Tohd/jh1ApcDdoJIfcJ6QVf7S8jPrKkG0dSjCkYXynbioJcKpIbBi
         OiWyXYK48s/RAKrnsmg1dxxbW8uzKm4aYwJOEu5hGbrx3mcBoDHIE7pKQF5Uo9WCFq
         vyGTLFvImudNOAd7BcGLIBlGixIy6uAgL6rY2M1MbHhTBUI3KZThV525aHMUjnEMhb
         TyMfr0vD7h/zhN6njygXs+DYqmIQxpBNgarjADUMrvXwNdSg2UupOiPn+nExmraxZx
         VxgwSldlC33ZmWOGgfDkjE0CxAp6cu7r1SqHk588RYQ0xxE2nNeFNJfj1zdeXh7Csg
         6fdEKlbVzR5zQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-kernel@vger.kernel.org, Yufen Wang <wangyufen@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH] ARM: fix out-of-bound access to ipi_types[]
Date:   Wed, 20 Mar 2019 00:52:25 +0900
Message-Id: <1553010745-26585-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a
"non-secure" SGI"), IPI_CPU_BACKTRACE is assigned to SGI7.

raise_nmi() passes IPI_CPU_BACKTRACE (=7) into smp_cross_call(),
but it is above the array bound of ipi_types[].

Increase NR_IPI, and add the entry to ipi_types[].

This fixes the following GCC warning:

  CC      arch/arm/kernel/smp.o
arch/arm/kernel/smp.c: In function 'raise_nmi':
arch/arm/kernel/smp.c:522:2: warning: array subscript 7 is above array bounds of 'const char *[7]' [-Warray-bounds]
  trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/include/asm/hardirq.h | 2 +-
 arch/arm/kernel/smp.c          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index cba23ea..c7e3a71 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -6,7 +6,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	7
+#define NR_IPI	8
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index facd424..8046f9b 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -515,6 +515,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 	S(IPI_COMPLETION, "completion interrupts"),
+	S(IPI_CPU_BACKTRACE, "Backtrace interrupts"),
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-- 
2.7.4

