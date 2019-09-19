Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766DFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E0421927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="k6Yx1GPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390865AbfISPBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:01:43 -0400
Received: from mout.web.de ([212.227.15.4]:41845 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388350AbfISPBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568905268;
        bh=u2ovSWunxy9woIqBvZsHHuYvMbTrtREDqeUgpPJUF+Q=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=k6Yx1GPosRG5DH4dGC24VKIBHqJ9oV7UJjavEdRO9oq00replubxs7LFvDVuheqvr
         CNRRZrUNzsIpesEmE8IywRevk/KoPJrKsDkOMTdYfJSRj4QQaVs6g7iNylbg8h5PUR
         cBAjg2WO4ztYJ/ob/1ZU1cadrf7s8nHu0JIK1n5A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.191.36]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8hhT-1hwrLz2DVj-00wFZO; Thu, 19
 Sep 2019 17:01:08 +0200
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Mack <daniel@zonque.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] video: pxafb: Use devm_platform_ioremap_resource() in
 pxafb_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a1b804b1-43c2-327a-d6d1-df49aebec680@web.de>
Date:   Thu, 19 Sep 2019 17:01:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GrKDkEUMXLoBldX1avxLfVJzh5A9CLC6e6YKXbC8kO+UVNS6N5F
 dyesIWm1P8pt1HihyBzR8SS+eY2PERRnhMkL4VV0XKIqGe+HFZGwtmfFvuktbP6pi/7nEOm
 MUXbuJ0VeVmZhrzrKkmk1hv5evmQnhE7QRbHYYLiyMaEXsvI91Sd6bXgCMcB4+LyKlWsS7h
 IiTHKiM1JYwiNd0fZWHoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B8nBfBYkohA=:oRm+2mcW0XSB725MmbvJws
 Q0q/udRo19sSg24j0CXCEufY7FDLq3wkJnSEyMyq0xgQMjhpI+T2RzJGKJDBiqnlZ/jmjvpa4
 QsziN78u7/3S3bydWNtpyyudUUGv9RA3c2c4aIi62qM3bh8vj9/o/r2xLrLlV7TmzABEkKlc2
 d1l3tqJFLZJ0x4pvgVH05VJ0ZrSIlTUCrKWOW3UCwq9f/oFCl8dOTvkeG4M14klNg6z6Pcy5C
 BeU07A7HQAmKDN5EbGu+OUF3sAnvfxad7OLM9nMjV5tX63MXiuSeAI8tQSFE8Dp9/JmExi+PW
 zU3iUQYTAcTZM/jmQgsxZYw+fvofkscd01MGhV7xNOlw97J/0BUeJ/IgrQNC8RJwI6yeG9mcZ
 cdl2A0RM4Xtue883N9ZzD4HZLOT0PwuyUiSLldG2MRQnpOrVqVxb47Jr1dWYfT6k96EducUCu
 z1m9j2TV+gtGe9EgIlconbITPRiHUWBIDIoN5RNWTN5vWRZVlqeLZojI5AP4pH2xBGEuKm4Jd
 jvjz90AbRsb9SWdOtgV3LXNJoulz1QD9yDfR1DJDLktWA54MGdpYDh8iLYIkAp+O3yrjCGU19
 hfl1lAMv32xGkhsEova5aFPDf7/ZJOkHeHbc4DhbrpxBSVfC6P7JofQbt+DenHtMOkW+gsR5C
 WoiMz5sZGXlDYwTM8/kOPk+RZeq83BHBv76jT2abatL1y8MkNGlyUjTLc1yOfuX2zDOPJNoJJ
 6hK9UUFPDPUj3hO/6VPvaI6+wPstYWQAO3+bspQZ+gT+dRPZs1W+zWTndMdUNE+BJMRy/sMRR
 JdGUNW9qQlELKx7r5YON4AdfofuRUDqqDJhbm1fh7+5s/e+RelH1LgJode8e6q7z9RtTrxwUV
 YVeitXO72xKJt+wY944aM0LjW+jJ/Cv8WgxQv375DffX/8dwd2D2PfgGQvafQkv2F1MlObFMe
 yMys5pVUDf30OSnmhZwRWHzifXWhkAiU1+0KZbuqrSV2ECuM2m8rxEbsVQeu3uex62FyqEez9
 +OeS8WEm/gXQ1rHb1+ZVy181CeVNPcAelRn2KOXmKmp3Hun/Jim05hBVrBuB4aY1x4bzkhYTN
 wvRA2uhgo+KdrbAN3keae+dJ/s/UqTIpUGOLLzOWXB48jtLAFUXVPwG/+bsRb05Se4AgfjQpN
 867sE1Gc1TEnLePPkLkRlGxiMlFrENtieFPD2+FnRBZBDVb2PstG1m7HHvE1jyuNSQnDN6rKd
 BdpxBuiOcz5lx0qiYppU7zYfg29wAuo9RlFznOisNQ680y9FjfhCmUPvMLIU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 19 Sep 2019 16:51:38 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/video/fbdev/pxafb.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index f70c9f79622e..237f8f436fdb 100644
=2D-- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2237,7 +2237,6 @@ static int pxafb_probe(struct platform_device *dev)
 {
 	struct pxafb_info *fbi;
 	struct pxafb_mach_info *inf, *pdata;
-	struct resource *r;
 	int i, irq, ret;

 	dev_dbg(&dev->dev, "pxafb_probe\n");
@@ -2303,14 +2302,7 @@ static int pxafb_probe(struct platform_device *dev)
 		fbi->lcd_supply =3D NULL;
 	}

-	r =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (r =3D=3D NULL) {
-		dev_err(&dev->dev, "no I/O memory resource defined\n");
-		ret =3D -ENODEV;
-		goto failed;
-	}
-
-	fbi->mmio_base =3D devm_ioremap_resource(&dev->dev, r);
+	fbi->mmio_base =3D devm_platform_ioremap_resource(dev, 0);
 	if (IS_ERR(fbi->mmio_base)) {
 		dev_err(&dev->dev, "failed to get I/O memory\n");
 		ret =3D -EBUSY;
=2D-
2.23.0

