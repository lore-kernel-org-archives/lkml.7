Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD48C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3D82087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfCKS5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:57:50 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57531 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfCKS4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:04 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N0nOF-1gpL6s0x3l-00wjcp; Mon, 11 Mar 2019 19:55:47 +0100
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
Subject: [PATCH 28/42] drivers: gpio: spear-spics: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:07 +0100
Message-Id: <1552330521-4276-28-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:nnAv8tSDTCc6037wuL7sOL+nRE4QV4yOkf71WBFVHNK47bLHkR4
 XCH4UUSbtIDIinVbITbxPXaqBH6G6BvLewGbKnSuOpXsOGu7rc2L0KWeDX1S1+1YzdDoWBu
 sPBYYBh9+kLxOIxebXrxI2fXHL+RUMVlMYrYOb3L6ZFi0Jq6k6mJ90mSc/XbCCX2xI5dhdC
 MHK1TcggSoyv6zhGWU0gA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ssrqC31gRc8=:2Jd7QaSBR0y52ROoEpLu+1
 yR922hGWwzywZFB2bOPuvDNT4lvy7yszUB8DducxPtWpG8wZ3cr3zbCUxasyO4OI1j8f1Np31
 n1wSa0B51kfnlOoU8ZK4LPYGmLVB3er3FRsS+zsSvrdEs8q0zAyd5XRQrChIiwC3BCmZArFuR
 dd/gy6C5yNl2YJ8b4wFEgbbZLw9OxxJBwV+PSifd0KE8uWs0bbMCQ55WAseb+0yoKnCUKU+9S
 /AHuE4d6xTa3dXZ9go6ZGp00Q+E1JIySHz8zXfqh4XVaVhtwTYRoeEDbV+C28unNETp8c34RQ
 vVhgcRUyESH9+SJDvLuEHihe82NaAGFwFQ48ty/GfX11KDEjmQz1EqMX7WlbwwjkLsBxYYg1F
 +FgCPsFauOj93QFZZYW4+rnlWU0juOnKykXT8DAtasRNVeQpUIyhdIEO5y3utph2ISeQpJnwI
 IpyYx+cLioAWTGP0LxqebS+bGvuBG31Jg1IihRiooMvIKXMK17b8lSig7KXTtp93LU3JmqIgo
 XA9EYVNN+ZhJ503J9KITN0nQtW3UJquxbohz7VcJCkzxdq69aODjY6pxEaO6PTrvJJhbYnwd+
 FoInsUoWSqoL3V5d/Vv8FZKesWhgTgvAHyRwGkkaL3TFzR3ewD6+PWDT2xqUcJUH70psheoCG
 9rhWe06VRHTrAXbepb8jmdPXXWrcj5cyEZtdIUSybw0z8i4PUL2rJhAM00poNeHiM2MAbaPl7
 +eXxEnufxz91zZC/FmaPrHj3reVFPKtM7DiGaQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-spear-spics.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-spear-spics.c b/drivers/gpio/gpio-spear-spics.c
index ee3039f..6eca531 100644
--- a/drivers/gpio/gpio-spear-spics.c
+++ b/drivers/gpio/gpio-spear-spics.c
@@ -122,15 +122,13 @@ static int spics_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct spear_spics *spics;
-	struct resource *res;
 	int ret;
 
 	spics = devm_kzalloc(&pdev->dev, sizeof(*spics), GFP_KERNEL);
 	if (!spics)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	spics->base = devm_ioremap_resource(&pdev->dev, res);
+	spics->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(spics->base))
 		return PTR_ERR(spics->base);
 
-- 
1.9.1

