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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90975C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5697320882
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IiWKGESF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbfISOdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:33:39 -0400
Received: from mout.web.de ([212.227.15.4]:47237 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfISOdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568903607;
        bh=KlVZn4jdldjRZHie3WxJ1mEWUSWaQHuHR7KqEx5FTCI=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=IiWKGESFMor/ZlzngA16YSQUR7ru02g9YzIATlqARt4hWciy9Z7xVMVZ32TTF8dSG
         h3/5LVF0aKN4bSGHD3xyZ3eOgORdsiQwmiqLmrYrYyTA9i85grgehNfw1jhn5d1Vdh
         x/3rf4Nx7HbEQg9tu/c/LOCsA5o18lfGtXCxPJOE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.191.36]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtX9Q-1i3EEk3lwq-010wBx; Thu, 19
 Sep 2019 16:33:27 +0200
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] video: ocfb: Use devm_platform_ioremap_resource() in
 ocfb_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <61b75aa6-ff92-e0ed-53f2-50a95d93d1f6@web.de>
Date:   Thu, 19 Sep 2019 16:33:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HWCoQy7xwCffpBW0QWKAATOSMz1+twSQxpS9BC5xkiG9J68cyZq
 SxMl/SPFZ3Vzy3r0yi3Siq7pHz3n9FB0b2RbKJQRXpXue7dhxTKTlq+p9MVcFSR1hdoDgZQ
 +bSQE9zlugsjsieLXZ89w7u1EoBXJDAuDOqlkh70cQ6MI8wSUmElIDN/BkxYQGHL0kXOq2Q
 NUKQmp121GYhQI9vBTPTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HxDsb8263r0=:oSFR2BWoc5DgIAI8Sdp9Fq
 c/cFKK+Wit8lPcZ0g8mdbkRl7H1uedDHPi/4kyDKv/yKccD+qHtjdlVUn6R/gCRdt4moFATvg
 RcBUf/qfTAxNK7E1L7r5Bmm8HsLpm3FRRG17ys066aA14jzMkYnqcpbcwNk/UU0Jmx/tdjBWS
 vLj1doIcePrnLUE7fCkZCrpIKLkD7/zP7GblHr4WMKZO7D+mj4YjN40OLPrYec6zrzf39EaIu
 ta0DqCDxLZ/tAhpSvT3Ues41RkxpIlWYSotKY7/H6riSWPhTt4jLFqFsn5awwWk76cX8t+518
 HTjRYbW18z+vivUvaqcEqPvrdK4qZiDvWaqkS+c+lGTQiVsqxCQrShFjMbXGMTZef9LAlIyWc
 s97/dB9/SJLifhczA3K2Rf8FB35eTmsOrpmWj8LOnvNgmDVQOLEfTq1rKK+4bTWSEvL0Va1CD
 7TEp9+KI4THbs6ZzFvldRiDkrHjmx0bmuKz3WHKZotpumFtAyLaoWQCsIDbPeUZqL98xnfsKA
 4hBaIam5Ivutpbm4H9yp4/+DZ3THoxe03YgbgDiL12fwlCcQ14eWi0P4iAKEkxoHGhrskA91b
 1JQdWA/t3RXJQJNcBXkIjvdvwUnkoGxPSRbeo+2McYCJiz2JoBRyroVr0AUGgyezkDvcpVtoa
 qHQpQqcAiWCXwwNcqtmR2kpsfHj5UsqPrB4f3S3ieIPZ4AOWohu/eA9JhU1lHhc/KAf7DIYgq
 dpDbA8VkLLtyCEMCGj7qf7gTgVSTxBug5mQ+hi+BBUK/2ROFNCpWxD+t57Wv+RntKMM0sjljt
 LV0dbq/D9xzJT53irzjCI/R/WiOTgO/F0wwcWJpAyTkr2uHZKrmBGLyQHhf7kIvo6xSSTBcPu
 BFTKmXWwWWs30+0yEjQyqHfoeHMED6yl4+TaJ+wvFUsIoRYWalAHcH5BJlHTkPfIA8AgSmCjb
 gSUqQmT69j4fjATcR+/2cm3T/vVtXHCncgSONO32giRyyTNQoA63opzsnQVgyfk9PAS88TB8p
 GioYLPDRr7ScEDnmeDPfGe5yVrt83cWR1Wm1DFwJA3e2CrIl7kIKLvc1Fk4bTD4RV3EtfdSUQ
 ckQjJwE7Q+1xB49sSnB70csWPItMzXZqXwQsiPp+4Apx+0buK9zDdB2oLdruV5cmlwWvvsiI5
 SglczD/K3ZfLSs8avxerAEit6sZE+VsrruewGvqw1G09hAFsUO+golXbzRlBHicmzIh25UjQf
 MTBxioOZAZVst6yCbfumLvae+hvT8BuzPZSwuA70xgATlt+6xfzD9JZ1czaQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 19 Sep 2019 16:26:56 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/video/fbdev/ocfb.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/ocfb.c b/drivers/video/fbdev/ocfb.c
index a970edc2a6f8..be308b4dc91d 100644
=2D-- a/drivers/video/fbdev/ocfb.c
+++ b/drivers/video/fbdev/ocfb.c
@@ -297,7 +297,6 @@ static int ocfb_probe(struct platform_device *pdev)
 {
 	int ret =3D 0;
 	struct ocfb_dev *fbdev;
-	struct resource *res;
 	int fbsize;

 	fbdev =3D devm_kzalloc(&pdev->dev, sizeof(*fbdev), GFP_KERNEL);
@@ -319,13 +318,7 @@ static int ocfb_probe(struct platform_device *pdev)
 	ocfb_init_var(fbdev);
 	ocfb_init_fix(fbdev);

-	/* Request I/O resource */
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "I/O resource request failed\n");
-		return -ENXIO;
-	}
-	fbdev->regs =3D devm_ioremap_resource(&pdev->dev, res);
+	fbdev->regs =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fbdev->regs))
 		return PTR_ERR(fbdev->regs);

=2D-
2.23.0

