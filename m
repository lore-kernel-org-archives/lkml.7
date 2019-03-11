Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5702C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B615F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfCKS5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:57:23 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:43941 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbfCKS4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:05 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MfqCF-1gay1U2fSz-00gIfX; Mon, 11 Mar 2019 19:55:49 +0100
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
Subject: [PATCH 31/42] drivers: gpio: stp-xway: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:10 +0100
Message-Id: <1552330521-4276-31-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:CsvzZnm46WK4n9R0bYTcR5/FI2O7Ra/ineu3763wIZ1J5bgpoR6
 mqji+OsGcgKaN0Ki0XQyHNxDqVJMkhbXkQpLFDIKxq9Cx7KrSvWLmQcIwOvg6ecI6CDvX+i
 DuFupJL2+6hTvDKtKnjkYfXxXGTLtkkIfdnUc0aS1j+ugJYZsFP9BwU27BpRtwAAM3Ko9Op
 TsMSIFnOcV2u4EfVNNPVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zYW9C9o+NHQ=:gdxSfDKYhOpiWSS/CocjVg
 UN2H+w2YoD9yKqCzSfpu3plMHDzoeTfnWEjoWxRkdUrCnU+Ytq44rcUQ47c/OVR/bAmSIVxCz
 Slz5RWE0C8ojwnDy+zxoekj5q7RcCevlF2LW6mAp0aJvCz+l4ST8ywk35fyZKayUQ0MGX7V4w
 EVs2A0SGjT0KSfTCo+YlsFzxKDbxiQ7oEUjf3/MrnOfJOTBr9i4H7oWYjCdcqt6pOlhI5LWRe
 XZLv8P8AdG2+mfyIjl41/HSU7l67WX2+/5coIVuKupjjFPjZQsq9CkZ53WdmfcnrkJCcXasOd
 guUaakgBOwXO/XjglHQId3+H1ep8yCW22d5wLWMt7VUvGTn/2opbnTig4Laj6C0EY3NMZsnRP
 J2bwzkyu2vtZLTyfJU2gggTNcWTB9zv1foZuuJIW/3iudwEl2kkrCJesDC17N/jiGV9qAB3eF
 E/SMFtP17JdFuuYE8DNn8XtQ0yj5S6fXx8RupyidjSWXsZZnT5XBtBpxvM8calxvbkIfqYenh
 DwsMe/Siew/fs+lfEK/uy3ys+TOcEZurS7HojK1WyMk4ltDdi4FzMweDytMDzKpya8L8oJ6d9
 lBS1caJ0FUAMWq1icSCazxqctvvcK6Mjg3EgXvEfajl7Y0i06wEN6dGorFj/oOgYQ7hR5KoIa
 B5rQwdXMhhfSKAZEeINECEfwmEN+fnX7NdIufqXqsOVWcvMEfi7d2+Tqa/GvwkX19CXXQz9hs
 ZnGIZXJetPX6r8hLn2uksXMAJafvLFiiFBtkXQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-stp-xway.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-stp-xway.c b/drivers/gpio/gpio-stp-xway.c
index 1997208..8a319d5 100644
--- a/drivers/gpio/gpio-stp-xway.c
+++ b/drivers/gpio/gpio-stp-xway.c
@@ -210,7 +210,6 @@ static int xway_stp_hw_init(struct xway_stp *chip)
 
 static int xway_stp_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	u32 shadow, groups, dsl, phy;
 	struct xway_stp *chip;
 	struct clk *clk;
@@ -220,8 +219,7 @@ static int xway_stp_probe(struct platform_device *pdev)
 	if (!chip)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	chip->virt = devm_ioremap_resource(&pdev->dev, res);
+	chip->virt = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->virt))
 		return PTR_ERR(chip->virt);
 
-- 
1.9.1

