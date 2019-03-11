Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D9C20883
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfCKS4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:51 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42359 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfCKS4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:11 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MFslN-1hHPVL0DXD-00HRmT; Mon, 11 Mar 2019 19:55:56 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com,
        thierry.reding@gmail.com, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr,
        yamada.masahiro@socionext.com, jun.nie@linaro.org,
        shawnguo@kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 39/42] drivers: gpio: xgene-sb: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:18 +0100
Message-Id: <1552330521-4276-39-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:44hLPQprcZhl19k8eWMXiORgL9JqXdXz5OKfvnKXBBg3KSOeQLX
 q3QOipU+5xI74ah7dd8z+ev8KhyEDG/X4ZhqPBUSD73iyHbLr7LICnLhgVS5qfefo2nk43O
 pzEQCF1yFYJ3YWhErEJP/XgXM75RVHF08wsqbJV/MhtETAghRuFsULBE2/Z+QbmGEMGEIWb
 FASo1Z3lf7Eh0e1PxsVzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wMUU8FVMTmo=:x6mUZFGSjJnbhjJi28xOps
 aReX3rYLTDZ1VIdnBGE9p6ei+RgUnZ1iTg7igjsJsFJQnph3ic1NmaHxUGcDUejlx81jQBoeZ
 qp18tvMSt11QFV7iu9QRKdwO09S7ZeHSmZeawHSPkiiVo48gQ1FrafHoYbdMI3fj4WV2u0QZB
 zTimumLKncGKXba0sfYH3wRihIeirf5w3ZPsWCDHe6TLdJpva4fW2vaTCrg8uMXlYjBkmw/+M
 5/2Ht7NJiP/bYduUK5ixCCOoqtujn82+RYcItNmIj+A6Iv2bH3WlMm8uB8LdkBbLlSqQ4SP+I
 oipTJDroGC7vwSvuTmISWUMD6K0CXlCMZZNlzQ4P1tvQZQNRnMMwrqRWvahYPRmVSpa5iMxhA
 NX3PzQWmFggHFiZDEKu7b53m1LPvVrA6PhlaXgFbDc460+17iECNdTFX5DphiaELh639BgkGh
 /AJiMLcI/NWDHwp4HhZHTyGkCj1eiwdDRiEfXmzZry/gaDVzUmi8UNTxc5balXV2OZBuC9UkD
 kg2CB07R5K/X8Vz/648O98LzywnimJQPSqpH+kvt+ro6SA4uJinG0SvwItk2iEWGvRDGRtDdg
 5xhXEzhKcTvR6Z2LPiyvdcLf8V2OBpwsYAQnQzAUH7JwZbNbgh36dXuYPvU68mGGJd7AlK4zl
 mk9wgtuCdj16ptwEMJmv8HkbBX2Uy8yvkFPgbihcY3cbmsyGAo3lUxyOCRdCRRwe8AaUcdMzj
 PaPDxwfFy8P/KkLu4K48TmawtXL+q9p/1nK8Zw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-xgene-sb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index 2eb76f3..641a051 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -229,7 +229,6 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
 {
 	struct xgene_gpio_sb *priv;
 	int ret;
-	struct resource *res;
 	void __iomem *regs;
 	struct irq_domain *parent_domain = NULL;
 	u32 val32;
@@ -238,8 +237,7 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&pdev->dev, res);
+	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-- 
1.9.1

