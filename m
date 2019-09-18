Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937DAC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBBE205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EywlomUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfIRM2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:28:46 -0400
Received: from mout.web.de ([212.227.15.4]:37371 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfIRM2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568809719;
        bh=wuV3PsgL4Q/zL6yMThKk604Y/MBD3bAO7nU5CWeKQ60=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=EywlomUJx/ELKGZPyjLtfDPOwmYdJWvYQFeUvliT80p3JPLiY8JMAKde2ycJubQHF
         rlxO5hfMyBOMAcrC2jIT5hP+l6wR6qLHW/1/jW0f5taQAzJf3EMe0yPbYFLHveaVYI
         msDMMmoLKvcLw43San/tSoKHyG7RWjhTC2NweacY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.2.101]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEVQ1-1iQENq1l6H-00FjCz; Wed, 18
 Sep 2019 14:28:39 +0200
To:     linux-mmc@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] mmc: cavium-octeon: Use devm_platform_ioremap_resource() in
 octeon_mmc_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4ad4cdb5-3623-4416-d3d2-b3c048a42139@web.de>
Date:   Wed, 18 Sep 2019 14:28:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S3XUzB7O291lbOL5MJquw8tiEGRFFwcrUS6z1R7+qd/5HJsFiUz
 bMT82XRFhoTLloH98O+YT9gTBkhsnBK23L2BtLk4eC29vzulNr+mh5Tj86SXPDqOACLbaGU
 kynKy6G9zUFakynJ2uYDf6/3Pt1i2u4lDWTmAP2kwZ4Fm8qcfPAWWAC9UCyYpF8xHeYKUjf
 glD8ONAxYc9Zj5ic3rMbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kzIqa/7qGuw=:rIIQAw6p2J2AU+M1JWKsku
 R+i6kpEHoP3Guc4g4iPqwSSb/DfA1Va994myK2BpDtlwUF62CKBCCHvoEzpjKXrozyh0EEgCG
 4IakWmABUaOxx6FJjP2vlvJidk031LkhkGBFuMBbJMw6fqKUmbFJkVjRHIomocuAoxyH/nI5/
 qOmauIHI9Yq5BaUhKC0ec9i0blWkzD+M8VDlVmwNXVH251T1EX+OZiFGKPRS6oascDvjsPlxd
 HraTn+N3t1hHP6fAkMKxDpufzFOTq0o4SsMDl0Utk86Nx75SwbPTwt3rp5K/uyeSPX4xGLC6C
 98Q+zsa5AGjQfq7x7HXEhUdGYz4L85I8wsqwUes0w2qPPVaLpXmA769MToHKqn+d6fp/Ht/By
 N02pmBPTIiQNtvX1+iVcoA/eItEDTTujxDnCGmqPaYFFi6IXGhERaYAQGAM9HtjZcVeu0TAgt
 7qpMELT3CV+KLzEYqNix7NwQAN031CJnZiTClmM/Q2EZxdgmRoZDw0yudJVtwnLM/rPzg5P0u
 n/zlHW/+IjICcTXXA0RPof0alSBF/ASoJT+0Wy04any2XCdaA19zsQ+Z6J3sCU2OB3zMFtYds
 x8VmLMWW4fODfH9oQJk12qBA64c13n9KXvv0na6gsIkfuHMsVNnT0Dn46YEeNGGaEbrOLhRxV
 XEU3OygjG0fs+dBKheAXoKKHNWzH524VBjXDmnLf68fUrVikLWiunzuUBHSKT+V/AYB6wJGay
 Vgy96OQDmoWuKVjT2VL44mPYp4GdvAGiEaD5tEhIbxtgE4XbnZYj0kZz1n5vtyu5d17RffF8H
 JjeK84nuxKZ7RWA3HMyVNWUO18PA2AdoC1WO7ai+9AGxvYSeoJL7er7Fvr1E3sBvOXLO4xZnu
 vcGgMBSQpKrzeMDQDjZISpfB1NHfL+P8noXonH1zUcUxqBpXxBWT1nH5ReVkc+P58m6UEoOgG
 ZgzoMRAGOzwcx7Q9gYTVSWYWtNO5mnXk3za926ccb42UJFmHNRzD5x1JVp5kEQf5RP007Fw0u
 Z6hs2V+f6AjPuZxfXYLdW/oz1TkzhBrw81BOW2Xre1Dzg+m4PNxTuT3peeIivqqis0EG75I3I
 nLNkjKHlEiJ3Q3ZKdOVV6zC1DRKO9ViBd/0FKampVCmd4DbXiCbyuYe/kcexrv4nOL0/yVFRX
 cmLEEWDojtKH4c/MXX3Q7a5vzgfh6DoeuMHCv3wdmvw+UWbKrUJTpWa8NMchtq54wWJWKk5AE
 ICKDl8r42zPhrMnpOakJZza90Xz1wXujsLWRS2iIH+HvbIS4AxgC8vtEXY2A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2019 14:20:34 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mmc/host/cavium-octeon.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-oc=
teon.c
index 22aded1065ae..916746c6c2c7 100644
=2D-- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -148,7 +148,6 @@ static int octeon_mmc_probe(struct platform_device *pd=
ev)
 {
 	struct device_node *cn, *node =3D pdev->dev.of_node;
 	struct cvm_mmc_host *host;
-	struct resource	*res;
 	void __iomem *base;
 	int mmc_irq[9];
 	int i, ret =3D 0;
@@ -205,23 +204,13 @@ static int octeon_mmc_probe(struct platform_device *=
pdev)

 	host->last_slot =3D -1;

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Platform resource[0] is missing\n");
-		return -ENXIO;
-	}
-	base =3D devm_ioremap_resource(&pdev->dev, res);
+	base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 	host->base =3D (void __iomem *)base;
 	host->reg_off =3D 0;

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "Platform resource[1] is missing\n");
-		return -EINVAL;
-	}
-	base =3D devm_ioremap_resource(&pdev->dev, res);
+	base =3D devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 	host->dma_base =3D (void __iomem *)base;
=2D-
2.23.0

