Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C8EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E5A20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfCKS6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:58:33 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbfCKSz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:58 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MWBGG-1hZuOf44R0-00Xbca; Mon, 11 Mar 2019 19:55:40 +0100
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
Subject: [PATCH 19/42] drivers: gpio: mb86s7x: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:58 +0100
Message-Id: <1552330521-4276-19-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:2zcKGunF3nBDqWBrDrcBPztnsUbKWVqVLWOPyE43qsattX2HHxB
 9yrLAXKJuGb3E0xJqOzZEzvN9F1egzs/rQIuAu97HxRS1ypr0pprwBYPbkhTNwjOwuSZcjy
 dDiS8YFbEKnnRd3ok2Y8PpAkxre13ii4OHUzihWR5DakLeRQM/F2R8PsVIOEpdEMZ0kEtyf
 RmMSbkHiLXLcVd9M+f05w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q6rHwbNAX/I=:dxzBXgirF+9WI9nDDMxuwK
 mzP4/nMvm1NGqMzuOt3SIc1bRb9wgL60ROco+iKB280KmQmQEshpL+MPGJTHoQCKDy5Thrd8g
 DLtbjRL7sdheb1aATVUpfbSJv52pT17iA96191jCVrWwBL6uR4+t3mF5wa5UwhAKnlfs4fggW
 TNxcTBqNs0vaXDsx+4Yasa/97UccZB8BzpvYDM5aptCDBCkpszT607V4AYjp7+LJT/GCk9wI/
 /aQgztWJ60rgqKMSyHyrc3dXYcL+tIX2iuM3n25ycl0ezAkA1EaAYoaqzJOGwEPR7VZSUDXC6
 zjzyxfzVyoEMEDkixcQpPaHnr6LzFHivRidvKpl/3UG3y/5m3XSck3N4zl0axVI8ylFWAbRea
 SpFg3Q/SIG3X95fQaazw0bCTU8TjoYgKlmU0nzRQt5jUuqco2mtlM8ohHV7EzeVQJCFbzb1+o
 wLydR3PVuS4fRNVhvW5JVeKHjxPtYjCuf+7pqTJfyTiaQIHP9o2gIAJRZ3ZvdlsucWX2NgCM+
 WVPrCuu0iYVqJ+WPLvksWpq7fiNPIf1AOk/1gzc+05AmIj2fa1h3+DHPpQ1bO/Q8bOUAKTG0K
 ZcHXoKWoFmR4T4LnuGRFVg8sOHC8sIYjRU8kQYPvOVCJUsxwhhzVjIEpyBKIdlrwn7veXHnNi
 Q9a2EkHOriujL3zlJY+tRQWzEDRkheQjkEmSinipAsmC0vuiq2P5mJeXURTFaO7cPdB/vO9Hz
 70oNDFns1hqf0557aRKLSDWxRZf/DZXaBlLiCg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-mb86s7x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mb86s7x.c b/drivers/gpio/gpio-mb86s7x.c
index 3134c0d..9308081 100644
--- a/drivers/gpio/gpio-mb86s7x.c
+++ b/drivers/gpio/gpio-mb86s7x.c
@@ -146,7 +146,6 @@ static void mb86s70_gpio_set(struct gpio_chip *gc, unsigned gpio, int value)
 static int mb86s70_gpio_probe(struct platform_device *pdev)
 {
 	struct mb86s70_gpio_chip *gchip;
-	struct resource *res;
 	int ret;
 
 	gchip = devm_kzalloc(&pdev->dev, sizeof(*gchip), GFP_KERNEL);
@@ -155,8 +154,7 @@ static int mb86s70_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gchip);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gchip->base = devm_ioremap_resource(&pdev->dev, res);
+	gchip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gchip->base))
 		return PTR_ERR(gchip->base);
 
-- 
1.9.1

