Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB771C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA8C2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfHTMgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:36:18 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40927 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729965AbfHTMgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:36:00 -0400
Received: from orion.localdomain ([95.117.23.32]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MZk5x-1hn3562KTn-00Wr6k; Tue, 20 Aug 2019 14:35:51 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 6/9] drivers: ata: pata_bk3710: use devm_platform_ioremap_resource()
Date:   Tue, 20 Aug 2019 14:35:45 +0200
Message-Id: <1566304548-19972-6-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566304548-19972-1-git-send-email-info@metux.net>
References: <1566304548-19972-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:2hBSmJV62+8u86tNoFA272pxYClBqiHKGxotWvy/XhYayx1Y/OK
 saJTNeaWvrZH8a1EFkpQx8p4VUzxTAomxyK8/n3PecRs1dZGlXSdFjN+gElbNsVpg/Ja6Yk
 ZeAbca1JaNJHCorW5Nr+k4g1YXLzsYHpkDsyYOlLWF+z0BU6kroO3bURRxmZfEZYPBcNjgg
 mRqsrM4lcvh05JQW+FcZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KMsYP2dbA/k=:XHmq4ec6/xJN39WmCgSXba
 eZ6aftXlVkctcroCRteJUeED3pplyY8SuNb3A3iL4M9GBTAaXJ0BJUj32JlqA+9I/3ZWKMPcn
 TFPI0sQ9ZrVhw6bh2RFdJf86xYtC+CSs+GAwMDMuCDOVTlRxufV6AYTNI95v5DaQGRdHhK+8B
 LxsXr/Zn2ZSI040f60PwPEnhzaf8IqfYj+ptvZxmjTdX4DagDid2ETEkNEzWldAvXPRPCSSXC
 RGB3TFNXmNvyi8VYTQRTjttLsoijREMldkw/wuiWjLBrun4pjLINS4wb/V/YJv2EL2g8qXQll
 z11w84cI2BRArthiJLpYWmCquvzmtr0PEXXK46Tw7bKcdUaCbYwa59jsC9zRlCUnQP6W0eTPd
 MrEBIb/SGkTiJGK5clBaM+0FAz66vbQ3RZP/wastoWoU/PJzdwOPwtGoUU+AhxWs/qZ9wR+3c
 oGEqynCQmwhQvgaK+GRsO9SNii65SDgPsHPFErHSFhjdVLryHht8WoQb/NCP8QkCswEVFjMgH
 PgtNC/fsC6qHWm/2vGcAWWE9ECkCdpR5dePLfcFdSvL3X6tD/b3WaAYh/DKIOgP5H9WBLCXtq
 KYG42QJiZ9RlxnSis75XopehvKPMRPh9ocvHXYOSi5wfUoTTSc/wBkcJOZLgHYM+O2i/R4VUa
 13DByy+Pk/lUGE+mHGIhoTiJoWeVFFvpklxUhq26+InOs5gqO8xvzGN+bqcYiQxGBZYfyaRKd
 AWrJ6cdwgQiew7zj2/V8t7E5TYevNhoFZZZJng==
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

