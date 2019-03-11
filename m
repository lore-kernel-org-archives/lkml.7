Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2856C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEB520643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfCKS6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:58:01 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:35997 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbfCKS4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:04 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McHQA-1gVAje1jzQ-00chda; Mon, 11 Mar 2019 19:55:46 +0100
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
Subject: [PATCH 27/42] drivers: gpio: rcar: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:06 +0100
Message-Id: <1552330521-4276-27-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:YhOiBtIVmpqN0tX8N4E3k87N7AkekEIKSp7nDfPJrrbzzTUeGzC
 099kEj0F6JTmyrTSQZOfQkPdwOJX+k8c6sk7QzppOt6tdzWP1ds+c4djDjITKSPbnF3ZLwi
 i0ZUuCMe9kq4PnT3UpXKImvUyUslgg8Kp4eYPQRN6+8PkfmYu+MYZztDui/5VMSa17sUaRN
 E75CYytYAFcCFtKXne5Ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ypaxc9K2jiA=:qV82M3koWIenNG98cN1zMQ
 V6LUAgJUb9bb+kNzeAJ20U752PzKLviuv8oP9+wH26Jc/GLl7jND6W/UbaTejeyz0IbWsT47P
 5Fg6H1UAW3FKZiWHyC/LiEkXX1MBlaAe6D7nkUN0hrlG1s5nPAy5JZScrM61Vg0HEXJggtFHS
 q6C6Ph4RzLAQ8TaQrnxsJ6Gl/99cPqJNcJtMiy9c+6ns5E7k35Tv+wlCO7iHqphVcK47O/Um5
 jvZqTgWIW7TAprgRJPS4ec/jgjOgOVFKGj+XT53/w/QwqtCnXal9WoNcmvGYQRGID6cYbWwbb
 xNDHSaam377j3Vp4VkEiqPDA0e4+BAYNg+CAlHrb+5VPuL16g1tUl/iuLaqZH3Zee7l+gd/Zf
 uLlGBGmoDnHcgk6JhYvHApd3GdW5Jv+NHvqVqlZJlni2mjyCZlV37jjhLklIahpQf6CrOcqeM
 w/Nt1EJyj247uMgXEDiqBP6YnX4QIyvJ1O66Oy0dsvdTX9DbejegACsm7k1BE/+ztehHgrHM0
 /fHfsfTLHirY956OUwMs1mmX0VlkGkWkGMrmwMDLIx9EdGox01OXQUPnQbVguATHh69oWulS7
 2bfOGHTeUh9QcCpLO0KtN3tfIQKoIJMrTFLSDn+axIA7SSKw0f2wC68AYdq/Z0kWqelx3KBwR
 0pEIXDFtGnvy6wRF6U187ItpJzIHPEdJDQN+Q4Bgpmg21gZfjW4lBRslkvg5lwz9xcQGCAEhu
 9fNnwXirB5LmkXk5d/ef6iqBi7mdFxOtHlt0Iw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-rcar.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index df4419e..187984d 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -430,7 +430,7 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
 static int gpio_rcar_probe(struct platform_device *pdev)
 {
 	struct gpio_rcar_priv *p;
-	struct resource *io, *irq;
+	struct resource *irq;
 	struct gpio_chip *gpio_chip;
 	struct irq_chip *irq_chip;
 	struct device *dev = &pdev->dev;
@@ -461,8 +461,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	p->base = devm_ioremap_resource(dev, io);
+	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base)) {
 		ret = PTR_ERR(p->base);
 		goto err0;
-- 
1.9.1

