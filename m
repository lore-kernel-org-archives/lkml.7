Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455B6C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17244208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfJJUtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:49:31 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:49:31 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M4384-1iIfNB2MVs-0001v8; Thu, 10 Oct 2019 22:49:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 26/36] ARM: s3c: bast: avoid irq_desc array usage
Date:   Thu, 10 Oct 2019 22:30:10 +0200
Message-Id: <20191010203043.1241612-26-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wHjpWj5ZU3LsTJEShbn6OIxxBJLNZ6bxgFqjSskTwAPhMhycOBQ
 zKGRravzyP5344Fi58tfwlJ0a/J2oSdtvQedzmSKzig/5K7I3mD7RJOw7etEuUeXsi5FujS
 Q6eBl2YRK4cMFIDyK5PmFNLy3BcKqcQhCAicUiwU4niAlE9XHqaM+NSq5uBy6+DBQUsoDSS
 wPs6E+FLc98tt/2ohXJkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2BwSOkcaa5U=:FaBTcKC8FkOGwluHd57eCZ
 6kznSKLyXayamvx1d+QnhVPhUiTCg7shvUXniM4JYmmnboJ8v/Bxuy7VnkfP+Xe8TEJ8QkatD
 SnPTfWpzSzzxVoTOLb2SYTbwYzFY1eDXmtKwJeX/JaQxGWWQPeRPEwRTMfGyYPEcPC5CKiBXn
 VLEfI/lZYGEKqbUrlc2DJ9/xTPq0uwUlJfhFoffJfNu+zTVjzuQQ8UODovE7Y3v2qRK2LgYnd
 sqtkLlHg73tM4qyOJ9TV1q+I8b5aglfG4gj+EreFw5WSJuXUNkLq03manPvcIUZiDHA/my5ic
 RGSdDfmuGE4PuPlP/r5MZuw0xVwgpl/BfVZQy+ypCehGaU+wCOpk+Kvr+y9BFELSefilctwqX
 HVEaEbbu9kmM2LnKOt/a4BiGIUmE9JgNQszW/W9mBsEFvTAa2BHj7PbfpBS7etjM/KTmGzakX
 xumtw8IQCSy//t8TUIPlSOSptEx3ebOrpQThSTKLd+ZcqA8Si5ZTF1qSV5gAwTQ9UeE9Yndg9
 Gt/6vSA9qG4QmrXITlUHd0f6d/jMr3AwmBZ1NgcKufu0BLldzPWoXtC5seXsyHa+OAPx2e5ks
 cxO5AIw3o+/McG75t3UCBjdgG0xsTU5Zx23A6Cnr38YJhbjGPBDI254NqeF1wdmN76FckaTFG
 aOnxybQh1wPka3AwPAVNiXcTqo7mYC7M0H2vG/tXkWieaXYYjMOSyHwlx83ZGo9LY34YLZyhi
 oyaoV/vedy7Mnd5p750f+HZg3r/gDbIjV/U5uV+MyaDcBJFq8sgvb6Z0i1OldXc/PIgEK25Pw
 6bojOwOpWFqk+XkVLsuVyQP+jHxD1+J2lKRnkolW4n2v7DJCN4B98FJaLCefmx+Ak6pPxT7J0
 /3B6K1uS27i9BZnfyYqA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we move to sparse irqs, the irq_desc[] array is no
longer accessible, so replace the two uses in bast-irq.c.
The first one can use irq_to_desc(), the second one seems
completely unneeded as we already have a pointer to the
correct descriptor.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/bast-irq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/bast-irq.c b/arch/arm/mach-s3c24xx/bast-irq.c
index 4cec084ae443..b3083ee3ab33 100644
--- a/arch/arm/mach-s3c24xx/bast-irq.c
+++ b/arch/arm/mach-s3c24xx/bast-irq.c
@@ -63,7 +63,7 @@ bast_pc104_mask(struct irq_data *data)
 static void
 bast_pc104_maskack(struct irq_data *data)
 {
-	struct irq_desc *desc = irq_desc + BAST_IRQ_ISA;
+	struct irq_desc *desc = irq_to_desc(BAST_IRQ_ISA);
 
 	bast_pc104_mask(data);
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
@@ -95,8 +95,6 @@ static void bast_irq_pc104_demux(struct irq_desc *desc)
 
 	if (unlikely(stat == 0)) {
 		/* ack if we get an irq with nothing (ie, startup) */
-
-		desc = irq_desc + BAST_IRQ_ISA;
 		desc->irq_data.chip->irq_ack(&desc->irq_data);
 	} else {
 		/* handle the IRQ */
-- 
2.20.0

