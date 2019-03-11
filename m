Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9A3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6392087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfCKSzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:55:54 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54119 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfCKSzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:47 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MdNLi-1gU5Kb2PsO-00ZPqw; Mon, 11 Mar 2019 19:55:29 +0100
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
Subject: [PATCH 06/42] drivers: gpio: cadence: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:45 +0100
Message-Id: <1552330521-4276-6-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:TnlavtKLYBbVciSWQoxfOstD/w0zfiP9JUgwX94RYLzv+rlDm94
 qAXzof8+TL87PcPvRaeNieXbS8Bt/jzNUNhhPtD5YMPWuV1q8QITUQ0zpGJ0w65qawII58m
 Um4ytRH7CzElFwnXBM3NH6IvsEL6+UFNEzleevNKDa950pwI7rw5ewCjLkIDOFjZYfVo8AG
 cklk8KWtf/BsFfVHrXlnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3KoZQwJFwEU=:lZo5SPJBWGZyYVrPLAtXs1
 fgHGIatG5Ah/QvA0YNlLe1yGgiggb+z3aguZ/lcXPdY6+vUNaKznKr5fWBJx44FyMJM3hWdkS
 rQPSgB/LlLVKjfmyZ5IbC4JiaoKmir7Ppqog85VxmXrpWdHNwJmX1myoNVJEMC/2ydp09KgIT
 joATTuRlxk2SxdmUENujUvj/7zQBC6VMmviikuzo5pEtGFZZv4WVPCZ++30FN2E607vX2sB/+
 YPgZa78yK1bH9UwLHIv1ZI+1U/ICm/kQ1i4dk57Jy/PjiWay2XZN6oiXHe/kiYbYwiXvILCt1
 a8A/gFDwNhxVYr8aakmnWiTNNSu21OPFAhA9Voe2zRP+YP5fQ7LwdgyR9JUtt5wKO6o9DRwXJ
 6UflC9tGVSrlW2SotWKu78fSIc9jizAUcBVzBXcxqSUxNgWOTkkRD2h2QFd/KEUA+h3mA/45X
 WKy/OHAqNPa3y8ywYoBz6h4aGQpDIPEOtPQ/xxnG9VVknHNkP8gkziMfryZ/JML6wSre4wEEp
 GCvL2ntFNdl27gkxptcxG4Uuzc60FZU93NsYy94Tc0fPBqTjd8osRnw/b7EeltexnRP8Z+V8K
 DLN3VGnbLsTpcx49YOw1OP3ivKXbkJvbbSPCQA3iLpV6O4hsn5/syjT7BtXqJB5AOLXMD8TF8
 ygB0bowwgBg9W7O3FksVqsnKZf+xEHcthT1zYaxIApeEvTd/F2wkm97FC34J+RC2j84jTzwTk
 +vG11zDRhUlR3borGbD08LMJiw7scAJ6h0jRmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-cadence.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-cadence.c b/drivers/gpio/gpio-cadence.c
index aec8d5d..712ae21 100644
--- a/drivers/gpio/gpio-cadence.c
+++ b/drivers/gpio/gpio-cadence.c
@@ -148,7 +148,6 @@ static void cdns_gpio_irq_handler(struct irq_desc *desc)
 static int cdns_gpio_probe(struct platform_device *pdev)
 {
 	struct cdns_gpio_chip *cgpio;
-	struct resource *res;
 	int ret, irq;
 	u32 dir_prev;
 	u32 num_gpios = 32;
@@ -157,8 +156,7 @@ static int cdns_gpio_probe(struct platform_device *pdev)
 	if (!cgpio)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	cgpio->regs = devm_ioremap_resource(&pdev->dev, res);
+	cgpio->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(cgpio->regs))
 		return PTR_ERR(cgpio->regs);
 
-- 
1.9.1

