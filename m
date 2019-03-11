Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2830DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4D2206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfCKS4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:39 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46113 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbfCKS4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:14 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N94qX-1gxYJ13YMp-0167Yn; Mon, 11 Mar 2019 19:55:57 +0100
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
Subject: [PATCH 40/42] drivers: gpio: zx: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:19 +0100
Message-Id: <1552330521-4276-40-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:YAkTglQbhSJqAuEsdyXD1wZGtSsI9YIhqg0KHmS5lmAjUi7SyYG
 HwiNamhHRGfiKsGDinE3otdMtDtWQBAD0AipAbGo7tcZ+6OWYGTOU+GrFNqPIJ9ZcaSpF65
 jd94NG6oofEQgNdV4JASJVKEvYRLxBOPXhThUCAdKYALqp0eeh/1Lnr78XbjxENv4YEkLNs
 B7OBpE/7XyfIs/j7wR+PQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ScH89ULCJRg=:O76rsyju9sEOg4m+OmNl+Q
 wlVBNYNI9ItKnqk4ImvNroW8ESLURTSdI9XWxSBRftrlUGUogBxKGqxNGFEiRkE2yR2yhap9M
 gDxpPqtED4S0BvBRGu1QBM5CJcxUvfxLEiPAWbrTDSo9f1KYZkCWBCCms2U8Iw8zQjgEGSmER
 uRRczqWvaj3EXmwNMOjnWKC7VE5mQ3UBgtLJbhOv5PhvjMHP/d3wCmleufJqZWAJL0BK2skWD
 CcKfIh3F8UVHEcni/8/A9W7pTscNnQDjaFpsRnNeqKt/jIpwBOeguq0JCAYGT7VZQfYKOsYRf
 2ir7y2MAiQGFQt28fRp9h7AiHapx8X4pbXuqs6DtA91me18awJLTAIfNJy5rDLXOUd4nS0D2M
 kebRnB7JDQ6qHdndwL/1SPOv7/YMY2S2wvW6oSyrzDzEa846rvsK6iKjdKdK4vJh3503K3imV
 +zJU7YMUw2gWvJL9z0JRcvoI0ir4FWDQ1etAPhLZiQTZXS1GJmlni0z4YLyG/wwCunLRT7V68
 y4dJOBRtF8fsPaefYY29PoNnZKmB0F3iqpR9pKKtnu5Nn+W+0nQJuQmzo7JhRXuAmMulLd1Xq
 shc0TnMpCSfI3m3K7KdQ3bJjpmxkjTrIF0TqzQgQcfvYsJvUQENln3CmqnO/IIbOaKwzQfnlW
 DZYDWb1hBd3p5aVpmq9ib53tqvmz7DohvUgvNuqZkO0YDn2nerQTSkKTR72X6KoJkmIPWdODf
 uVpXXGPoRsbkTuekr59YR3jyjyROYw8CY40jbQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-zx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-zx.c b/drivers/gpio/gpio-zx.c
index 5eacad9..fb92755 100644
--- a/drivers/gpio/gpio-zx.c
+++ b/drivers/gpio/gpio-zx.c
@@ -218,15 +218,13 @@ static int zx_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct zx_gpio *chip;
-	struct resource *res;
 	int irq, id, ret;
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	chip->base = devm_ioremap_resource(dev, res);
+	chip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-- 
1.9.1

