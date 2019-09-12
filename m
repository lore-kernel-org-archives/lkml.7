Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFF3C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBDE20830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="KiF7jdV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbfILNW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:22:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46613 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731283AbfILNW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:22:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Tfb303vKz9txv7;
        Thu, 12 Sep 2019 15:22:55 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=KiF7jdV2; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3l9hidgtpDqN; Thu, 12 Sep 2019 15:22:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Tfb265vvz9txv6;
        Thu, 12 Sep 2019 15:22:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568294574; bh=GWQvbjCjgyL+nAOZxJ2VN1zz+9BZT/jEtfKDn8v4Dp0=;
        h=From:Subject:To:Cc:Date:From;
        b=KiF7jdV2ipOuWwvY7Wt9aFx1d7OAGmhXmUORNCcxTXSnCXjYHJ/uSqb6famBvVFKg
         SDWv/GSNcmQeHwX0Y25MBZ1Iu/XzI1eYJsLRMGRcGp4Ns1m0jvnsuMMLDZNlLhN1OK
         Bo56jpmm70Dc4WZNp99O/GNhf7pxT2NDDtLu8bPI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 59C008B933;
        Thu, 12 Sep 2019 15:22:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zQArg0OTCtUj; Thu, 12 Sep 2019 15:22:56 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D99268B921;
        Thu, 12 Sep 2019 15:22:55 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4AFF06B736; Thu, 12 Sep 2019 13:22:55 +0000 (UTC)
Message-Id: <c27168ef054f3a52edcf0ff91652700d53b3e32d.1568294563.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: add __init to cpm1 init functions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 12 Sep 2019 13:22:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions cpm1_clk_setup(), cpm1_set_pin(), cpm_pic_init() and
mpc8xx_pic_init() are only called from __init functions, so mark
them __init as well.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/cpm1.c | 10 +++++-----
 arch/powerpc/platforms/8xx/pic.c  |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
index 8b8c30dad87f..5a47b3ead01a 100644
--- a/arch/powerpc/platforms/8xx/cpm1.c
+++ b/arch/powerpc/platforms/8xx/cpm1.c
@@ -130,7 +130,7 @@ static const struct irq_domain_ops cpm_pic_host_ops = {
 	.map = cpm_pic_host_map,
 };
 
-unsigned int cpm_pic_init(void)
+unsigned int __init cpm_pic_init(void)
 {
 	struct device_node *np = NULL;
 	struct resource res;
@@ -312,7 +312,7 @@ struct cpm_ioport32e {
 	__be32 dir, par, sor, odr, dat;
 };
 
-static void cpm1_set_pin32(int port, int pin, int flags)
+static void __init cpm1_set_pin32(int port, int pin, int flags)
 {
 	struct cpm_ioport32e __iomem *iop;
 	pin = 1 << (31 - pin);
@@ -354,7 +354,7 @@ static void cpm1_set_pin32(int port, int pin, int flags)
 	}
 }
 
-static void cpm1_set_pin16(int port, int pin, int flags)
+static void __init cpm1_set_pin16(int port, int pin, int flags)
 {
 	struct cpm_ioport16 __iomem *iop =
 		(struct cpm_ioport16 __iomem *)&mpc8xx_immr->im_ioport;
@@ -392,7 +392,7 @@ static void cpm1_set_pin16(int port, int pin, int flags)
 	}
 }
 
-void cpm1_set_pin(enum cpm_port port, int pin, int flags)
+void __init cpm1_set_pin(enum cpm_port port, int pin, int flags)
 {
 	if (port == CPM_PORTB || port == CPM_PORTE)
 		cpm1_set_pin32(port, pin, flags);
@@ -400,7 +400,7 @@ void cpm1_set_pin(enum cpm_port port, int pin, int flags)
 		cpm1_set_pin16(port, pin, flags);
 }
 
-int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
+int __init cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
 {
 	int shift;
 	int i, bits = 0;
diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
index e9617d35fd1f..f2ba837249d6 100644
--- a/arch/powerpc/platforms/8xx/pic.c
+++ b/arch/powerpc/platforms/8xx/pic.c
@@ -125,7 +125,7 @@ static const struct irq_domain_ops mpc8xx_pic_host_ops = {
 	.xlate = mpc8xx_pic_host_xlate,
 };
 
-int mpc8xx_pic_init(void)
+int __init mpc8xx_pic_init(void)
 {
 	struct resource res;
 	struct device_node *np;
-- 
2.13.3

