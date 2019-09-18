Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133B5C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45EA218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="il0rh9EQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfIRGed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:34:33 -0400
Received: from mout.web.de ([212.227.15.4]:60979 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfIRGec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568788466;
        bh=+u7c7TT9Zf+nAgiI4yUa02U+TxcnNQVi2HJ06bgenYE=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=il0rh9EQKbR4HDNq/CMRuPH+dIqLUwEIbFlN+aUoAZ1mMxMUP2fFC6jWPlOSVmSMi
         ljuNraCBUq5POSNqPdqPu9nUnVXQkgGnY3t1FmkcDHEoB1c0N8xRdF/Y0eBmUNvb65
         AsiEfCQ6wWDizFAmoQSeNnxoLwVva9I9nSV3xM/Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.2.101]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkyXt-1hbxXb2wi5-00ajeq; Wed, 18
 Sep 2019 08:34:26 +0200
To:     linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] sata_gemini: Use devm_platform_ioremap_resource() in
 gemini_sata_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Message-ID: <b17404cd-294f-fe2f-e8a3-2218a0dae14f@web.de>
Date:   Wed, 18 Sep 2019 08:34:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hQsU0CnUuX0BQDrXUB/Q+ew1vCfmaIjy+6y4d9ii/dsw+dTu6q/
 tbKvvfDAnpDX5TAX2AC36/c+Lz2dxp4C9BgZFx6GCz+ucGq+XsH9Kpu+odP4bjzea9sMxzs
 cc0nxuHj5q48QROq/9exqBVgxLs9n6C9INN3YGkphT2h+GNVXE5LEJi341brwvJano/4qzN
 phWf4f/TIV7nHFvgS/t4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qAHPMo4W4BA=:oslW7GY+dmefJZ/sdhFwvj
 xmGkGMKgQuVXpYVhIdQSSlnrNOcj7GBhzwMXYt2kH5JJFp/su5VDgX7bBAwN8cP1l8P6ZXyoy
 MHNdMrQ7BlihrehJZ6YY3r/LlXE0lFIh7pnpPDwQSJAj25K7ALOlr3l9t5pYntBUrSVxn4wMR
 5xLM1KusAQhDxMxZuCzhwCQBEbqNCsZN3zPz+usEeQRDuFLiOXm6/1Wr9KNREHPLmcCiLp8Nn
 oY6ZSs4MeOHP0Osqbf7fEmB+XFW9MzmJ74RqFCEoFYYqq1WdYGf3Mic89eZqO4uVQCBqpaFMi
 Y+/8KEmV+B7tzzVNOzzsGD4ni/P9gfp0T1G87KvEtecu4I9SezZg6LOuhZrtXFDolf7cQmua3
 PkYlJJvTWWG6n69YJknhrPwELUE3lZG/TYJRssnivuDKkB5Jk3KeZwh8K0Z4B9C2ajczmgGDg
 vYmRUKHKJf1Li8HVgD44X49m6IJiOj6Myq+YZdqpmgdOrw6SB+mL8vVI2WDDeAZkOzelyq0EX
 IQSISTgLpzFjOO050nUmO2dcs367qPmljFxQWHRUOVMitlQXdtnS4w0UwjNhSMhZZubDJvZ7v
 8wck3Upx4QOptKdRZ3oQRVkgRmzEdrxIGKxPrnfgYUcMjWkYZduWjSkXGHi+kSJ0bULGxn+YJ
 GTbODcRNUZ9lEQ+yDy1DySttSPIFOKOxCwAS+cZU8Wr+Rs6FNf/z3dd3+PVir+7KbPuO+HaxC
 iQ6+/oTGcCCJIb5N+lU58WG3DHKxUZULo6hE4Opa0/0rjYVR57vmlKdXjLmrM8b1c3HUFQGV+
 o9rs+pv85sRekyj0vUrZUnT1zJNvRtXtUcxW1lJvA8gU+IfNYafAXBdnXUQXVsbYnth9PchZc
 3LMT+luqyBVnkA9UR4VAi34K+CID4Wwfudxdx9lP1KNSqE6yUdFiosAPeiSax4bqME36pYWLo
 /cW0nZ0i7a753po/o39pN3oBH3Vu4cIvqFfuyIxWkPX3OsBAutNLq9bZl5gJrMRPsILVJ1tfJ
 kLWS1CX6STC8Te4ol+vWMJa0yxmPOnz5ynD1b/VKh6RYtkIzu54J3OCSxb4y/7F70U9Hzrolt
 iOedIlnQsrIzJs635JLuOHLZ1h8p1CxLxb8xnZau7V/umcvAaLiWoJfyyWZC901KGEs03tZou
 Pna88XcCLq8jqmbAVJuZUuVQs7AbQ/Aoqo25Gf+OB+9KEEmi+TY5SROMnbgZhJtBYSBvUoTVn
 OV2Id4E7ccfWpfYW4Rma2cYIJWzMB92tWqiSq8/65qXOcKZ8SAsCnnUtp6Js=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2019 08:28:09 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/ata/sata_gemini.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index f793564f3d78..61a34cad90c1 100644
=2D-- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -318,7 +318,6 @@ static int gemini_sata_probe(struct platform_device *p=
dev)
 	struct device_node *np =3D dev->of_node;
 	struct sata_gemini *sg;
 	struct regmap *map;
-	struct resource *res;
 	enum gemini_muxmode muxmode;
 	u32 gmode;
 	u32 gmask;
@@ -328,12 +327,7 @@ static int gemini_sata_probe(struct platform_device *=
pdev)
 	if (!sg)
 		return -ENOMEM;
 	sg->dev =3D dev;
-
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	sg->base =3D devm_ioremap_resource(dev, res);
+	sg->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sg->base))
 		return PTR_ERR(sg->base);

=2D-
2.23.0


