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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD338C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772D7206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="V5Sq+c4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfIRMvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:51:18 -0400
Received: from mout.web.de ([212.227.15.4]:41939 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbfIRMvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568811033;
        bh=+WNwiFMaUtoRg1qtUawk8yXifdh05q8CsZK/xHuAYvs=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=V5Sq+c4mZ5hs1MKd1QsJbV2YpsvshTWDqAGZMMzF82lR9H4gpOTGgB6OtapEIZCha
         CdpzMH5hVybPW4UpTfOY39rWro7zdbRzCJ0RUEo2PowVg/SzIn9oBWJ+LLA4ZC49fj
         QyOORi8p9JtPrcp4/b/P9jobsCExOmwIcwEWA204=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.2.101]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWirL-1ihL7K2Ckt-00XvqU; Wed, 18
 Sep 2019 14:50:33 +0200
To:     linux-mtd@lists.infradead.org,
        Allison Randal <allison@lohutok.net>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] mtd: st_spi_fsm: Use devm_platform_ioremap_resource() in
 stfsm_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Message-ID: <e1d32aa4-7c82-64e0-b7c4-33c94d9a2769@web.de>
Date:   Wed, 18 Sep 2019 14:50:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BqxkGe90vJASEheSmEFOrRVq5Qgo2ALbZg+pjS0GL9yQayyJC3r
 NJs7O3+WrIHhdemC11+aowrF1vMfEhwH9TVXoEsgBeNEc5O3JKi/cjBDsNepp3i8Ta4k4mu
 37F9ScdXJD/1zunnNL6Nhbu2BdpDkSk+rM9wYDfw367qYu9Z0eYzOjKbrtxWYieIybuTZSs
 A237HI6KS9eG46i1SDDLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:phUl5+idfpk=:Ezg+HJnYP1hEKPWLoTTzzi
 NQBidcUX+tm9yPMzFFDCetRz0UTjuVgKBn4WEDMcQb5kX1T5TTRf2QiuzmHb+HOB77YH33f8T
 RY+pIB1zvTeAzhbK8hXrNSrCgiqOmiNx8q6bzdgL6CuJR4wfBTS6hzoJfukZx2YUoUBkHibWO
 HFcxLZlb4kyw6N96OvVKuyQd3z4p5riy06FV16l2F8OCJzfl9wrT3tE19ms5DAXkCp1mX8CA8
 VN34iK5yGyGLgSSV5V2eWZmc+WRtRFdxVEh2ssK0kT2/zI7OX62WivkElcm8B91Y0V6gxOmDj
 PAWcH/yhvMhnauKWniP4ZkXYXwjxcAfr4H12noog8n2BZdJxNJDYUvq+MvlSCyO0yrsCBEuPw
 lNWVX0GhrNoHRgiLKTdhXzHn5JiKxIyrO1+rAh8mPyfLSQAy/Iyj8QqAqxZ9MiSym7BePdMGI
 HEoZ5oKygKqqEtlrNqcVN11rCdLYKCWRThuXgOKLeJI2h/uYLr56Pdf0P1NnicN8KvBcWszzc
 c3g6MMPemVCQNEllDdRD11Ehrn7UpMIVHE3b3D297N3erAwClQK038+L5amNFLBZlTV63i4ns
 AmN+QjDOoSZcpmbn8pW5PaxNlZox8NnSJK0Xq4OIMVbu1/+6MEv4FcNhQ7LzPJJPsQhJbyJXx
 /lsrNV8ST4IHNM5X85xoaJs9k49Qmdu7VwzFbLp4VRnp6IbFd9ITAS7sD4mXVEckUupL+z5g5
 DwgxZC3sM9KTUefxarvHB6KWS4Q5t4NeXUkyPSBJ5BHPkXpkRb/Hbkne2mQ2BcK162ZvvV0H3
 na7vs8TRGtI1m16vTZcfEc5NdM/0CMHOFpDfVsGWXFmyUS0IZjPuosOkh6i9Xws+eruXj+7lm
 i+CfjDw1sKwzeDwqivgPtQ+HewoSzgjDtbD97hhuqZhQYyrB8AewFKAg7Z53L9V7LBHatNbQW
 oCZjongnKuy82MhzYI68HZL1qCw49Bb4lsdsZPOjqRrRQ946HR7U/8E5+kP/r34kazUaRKJ91
 kT041dIcSBzYOZnnnrk8PDZPLM6w50KAYpgk1gdFFd/d23WyLfsa4hM1UQ6luDluK0x8/2nWh
 O0BmBRxt8Un9QvoEcfaCTDUohH75zm54smdxxntBonWofvsbIN7UJwd5meeZbCuka4Pk4hRcu
 J6AYaGKiWousUOHCnfCAdru0dFzRQ51AxQTnHywa+Ruw5oto3V25f5c+4OETw3kw2FR/00boy
 e7Vit5xLX4fVi16h9tR9wTL8XpohSIWGZItlsaUn5Yfq5VBPhzzNuBZjnQJg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2019 14:37:34 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mtd/devices/st_spi_fsm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi=
_fsm.c
index f4d1667daaf9..5bd1c44ae529 100644
=2D-- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -2034,13 +2034,7 @@ static int stfsm_probe(struct platform_device *pdev=
)

 	platform_set_drvdata(pdev, fsm);

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Resource not found\n");
-		return -ENODEV;
-	}
-
-	fsm->base =3D devm_ioremap_resource(&pdev->dev, res);
+	fsm->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fsm->base)) {
 		dev_err(&pdev->dev,
 			"Failed to reserve memory region %pR\n", res);
=2D-
2.23.0

