Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E91CC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BAA2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="I2EvWM35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfFNJXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:23:18 -0400
Received: from mout.web.de ([212.227.17.12]:42991 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfFNJXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560504172;
        bh=SpHQ3JrOfhzaQWP30ANX8/kssmYUbD+lEDsns4CrNWw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I2EvWM35gKnBnKmheBgq1jp/Ag+XzAy1ytbP/i7R/wzX4eIeY8pEpCK4SPTUKuiAD
         h0pVXtzq9Af4rhZNaMtl5vnggAHHS+6F/2TeE+qJf8j838e0bOdrd75SY32nWm+/PR
         C7CQ6L5aAf8C/mvui/03xvLCNx7me0aKykAZXOrw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.126.132]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYf78-1i5sJl3FUA-00VPjw; Fri, 14
 Jun 2019 11:22:51 +0200
Subject: [PATCH] drivers: Inline code in devm_platform_ioremap_resource() from
 two functions
To:     Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
 <alpine.DEB.2.21.1906081925090.2543@hadrien>
 <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
 <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <032e347f-e575-c89c-fa62-473d52232735@web.de>
Date:   Fri, 14 Jun 2019 11:22:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oZZikr5812fm7qJo1EfkL7bt2J1oCpuqPgZapj83jUV/9DsNYsv
 0WUda4yE5NBVVkeDvjjHM/yj31jOesCycrxo6ktCIvL/R++Yo/ExkmczJqqTn5Lir/wlLKz
 wsTHFsB/DMeZuPDjabwLZVefP72Udt+ag+lQvrU3Lz0nNLrNMEWsIxGhLaCG/apPMhgP6K2
 +17hw5Y5hHKkX0GFgW5Qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dvvfi8LZ7AI=:/YZipzaeArtGwaFfdAJZrk
 YKr0OxA4swcWy+/Yd5hu2nxVAjoW3ve1vOELQV6xw9zer9QtjMBZGfTQpJLj5Bq1/ykJOVVVm
 hpqndrozTlu1FgdcpuhvYtxwLJ0kbHSmNfGJrkyzl/CuWSDPlLQbciNkldME9hXG9RIT4uAcD
 dxf0lUpDmZPuwQfwGG1Taz5TXO3ymQLn+o1T9WSEH2ouINVsjoTyHvOIDU/iH6nAqQ4HPuYcg
 ptYNmllSM3gHHVa0RVgEqUHy4jYEeCEsBmBuJ2qnkVHAIaBVDyZZAQh3+gO+yP3ddB6N63gZG
 hVS0c26eCT9KX3B7kuzxW19dIRY+YeOOv5h4/x0CXIWzfYz5o1ycuyEz3P5aC9fryZPGyNpOa
 QwRTJtZoykybi8Hz+D+sC4GlkXKBubmoJ1k4xRnGMBPD/unNCcws4Qxemq6GH0t5RReBEZ2Eg
 qkJ/3kPhtjGP+2zwnKIS3MGcMb2EkYQeEuRou3fjQdrRXPqabqtBby3fFKmE60WlmdDEzEbbM
 Bfk1q0zDUV9wltiOiycTgDMrKPS5Vw91yo1D/8xI3UX9q81kjY47NOX+ybZFm9cJAQNSuikkq
 OuKMYi4KKN7im3QSCFxPoOKDUdilvMw9cn0Hn5gciPJAB039jYu6j6/Dt1/pPirm5ibCjiF1a
 T9KJ04HeoHvqM7qGtXBnpZVjGFxJAqvGuj/iNwlwhizJaYuYX0J0el603yA8FKY4OFHAzFfFp
 vnWgYQBjBUf4lKNnwgwjQSO44ex607ayICDFF6WfrACbe/s8Apd7xdTe4MFcECJpfdUyDcX4k
 fB2oi0lLrNQ14iLXmSb7UZJsBWi6e2ZspUlgKWKdoSWGKZkgwMm7klVIbUdIDyij29XkM+9UR
 uQfDU/hJBQMFGEizptpN0D2zqHDQPZd94jsQL/rFffDpPGT7XFOIpDUN4KEzIO9FTNgZJeGQP
 Zkx0HrpZZIvS24eI4YiyHgD2xJUWcfJwcxenlD+iTCSBOfN4HmODD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 14 Jun 2019 11:05:33 +0200

Two function calls were combined in this function implementation.
Inline corresponding code so that extra error checks can be avoided here.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/base/platform.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4d1729853d1a..baadca72f949 100644
=2D-- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -80,8 +80,8 @@ struct resource *platform_get_resource(struct platform_d=
evice *dev,
 EXPORT_SYMBOL_GPL(platform_get_resource);

 /**
- * devm_platform_ioremap_resource - call devm_ioremap_resource() for a pl=
atform
- *				    device
+ * devm_platform_ioremap_resource
+ * Achieve devm_ioremap_resource() functionality for a platform device
  *
  * @pdev: platform device to use both for memory resource lookup as well =
as
  *        resource management
@@ -91,10 +91,39 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
 void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev=
,
 					     unsigned int index)
 {
-	struct resource *res;
+	u32 i;

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, index);
-	return devm_ioremap_resource(&pdev->dev, res);
+	for (i =3D 0; i < pdev->num_resources; i++) {
+		struct resource *res =3D &pdev->resource[i];
+
+		if (resource_type(res) =3D=3D IORESOURCE_MEM && index-- =3D=3D 0) {
+			struct device *dev =3D &pdev->dev;
+			resource_size_t size =3D resource_size(res);
+			void __iomem *dest;
+
+			if (!devm_request_mem_region(dev,
+						     res->start,
+						     size,
+						     dev_name(dev))) {
+				dev_err(dev,
+					"can't request region for resource %pR\n",
+					res);
+				return IOMEM_ERR_PTR(-EBUSY);
+			}
+
+			dest =3D devm_ioremap(dev, res->start, size);
+			if (!dest) {
+				dev_err(dev,
+					"ioremap failed for resource %pR\n",
+					res);
+				devm_release_mem_region(dev, res->start, size);
+				dest =3D IOMEM_ERR_PTR(-ENOMEM);
+			}
+
+			return dest;
+		}
+	}
+	return IOMEM_ERR_PTR(-EINVAL);
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
 #endif /* CONFIG_HAS_IOMEM */
=2D-
2.22.0

