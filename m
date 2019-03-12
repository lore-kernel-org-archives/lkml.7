Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A11C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF95214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfCLJUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:20:03 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57229 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfCLJTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:19:48 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MmQUL-1gd4713awT-00iUyB; Tue, 12 Mar 2019 10:19:38 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 6/9] drivers: ata: pata_bk3710: use devm_platform_ioremap_resource()
Date:   Tue, 12 Mar 2019 10:19:31 +0100
Message-Id: <1552382374-28789-6-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552382374-28789-1-git-send-email-info@metux.net>
References: <1552382374-28789-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:/S7nW1zmwSP25wmm1HTJPCKKCGDK7iPRj/Bi+7ZpC08tBUcoB9d
 UxbxDveLxyWjAPNDkMoLIe6ZCrAseAmuGhM5CKq7XIra570sZ99EEQcR4mpO0CrQDfw9nz1
 OL6sOEMewBQuqt9vO61Aq99BkhsEQQAEKx1kEW0j1fBsba4vgLsa/Xjac3TdpzpbH0f9q/u
 V2vRobm1IGiCZVBxbycOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jEu0P4p4M9o=:X20ZEtEyfYgIYHEYt8VXjV
 RE9RloHICaHLA3ccyLyEYgbxzRGHA8n1vfdp02x87/lDSPdiA1sfvOybjv7/Eq+/KBjDz4zGn
 2S7HUpdQ9g4J1VPFkcmPdSSc1g3RWZAJPOeZhe6s9M30OjJbR7DaD6T+PtofZOmKqz6sccaea
 Q2a/aIPR/ZAdOuj2FYMFuEnOYSx6cwnlgJmyGFp6Zbw0vnQp6ia/PCnYr0RPmqMIy4GXUvJLs
 E1bLPJJLQ5QUR7XcBAAk7H1IgLv76b0du5Ylj71vdqns6FWd0jOu8woYtlJHq5pvbG3Tjv/ih
 LZP5wW+r9nMBDWg5Ps3S7LQa6rI4szufsvGuvQTnYj0jkV+YuAh85eqk2ffEyW0UItcqhNfji
 cT+GunGJQhq81UxwjnmoiODF9OkcqGMHyGPrrteHllUlr+lWHM/43iEox5X+nXk/1ZHJqRV6a
 L9/l6/BFdnl/yaKaf0J99fbllrc3wF3T8EBczJKT2gGKU3K7RCtgOwAuK9TVywsWKKqmkek4p
 hD2sBXqNf+fBbzGu7ULMLm6gZA8DXyJXLNXcsotwu6Bm13noVB6ZqLOj6hgEzybLHtYuikuQZ
 jgg9Wx2J8HJOfRr4jYa76H4lKUQf8TkmkYD4KbgFoEl49CqVlfZjdSpRsd7VCng3Cr34uMM/7
 YZqIZlRbrEm6agm/1/xan1o/m66UUt/+Yhabpcwb2kiOuQvbUOTsbwaAr7goY0on/s0RK6eBb
 tdGWX+69Sv3/Y0oA9xTmALiI1UAcI4QEDIO+gg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/pata_bk3710.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ata/pata_bk3710.c b/drivers/ata/pata_bk3710.c
index fad95cf..92b036d 100644
--- a/drivers/ata/pata_bk3710.c
+++ b/drivers/ata/pata_bk3710.c
@@ -291,7 +291,6 @@ static void pata_bk3710_chipinit(void __iomem *base)
 static int __init pata_bk3710_probe(struct platform_device *pdev)
 {
 	struct clk *clk;
-	struct resource *mem;
 	struct ata_host *host;
 	struct ata_port *ap;
 	void __iomem *base;
@@ -310,15 +309,13 @@ static int __init pata_bk3710_probe(struct platform_device *pdev)
 	/* NOTE:  round *down* to meet minimum timings; we count in clocks */
 	ideclk_period = 1000000000UL / rate;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		pr_err(DRV_NAME ": failed to get IRQ resource\n");
 		return irq;
 	}
 
-	base = devm_ioremap_resource(&pdev->dev, mem);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
1.9.1

