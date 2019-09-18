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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDA4C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D88F21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UTcwYRCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfIRLsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:48:52 -0400
Received: from mout.web.de ([212.227.15.3]:41157 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfIRLsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568807329;
        bh=p1sodnQQNFGB+IFUcKDOaPnHqgy6zKaWm7jiny+0/Fc=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=UTcwYRCO05FmGASoOhKPjfVW+qwngQP9k20mLLAS1T1qsQ6eyfA0G+7KObbvBBd+I
         hsvy77tNbUuFrF5nEimXxoeoN8IDsfpg4vM8MusBjjUMs7+T+ySruZSQKN2uGrrHSw
         4zCUmRLN6XyvzxkQDEyEXSQGNB0vvGp0PKrrkQxU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.2.101]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrbHJ-1i5Z5J3SyD-013Pcx; Wed, 18
 Sep 2019 13:48:48 +0200
To:     kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] mfd: ipaq-micro: Use devm_platform_ioremap_resource() in
 micro_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d9990bcc-2daa-67ad-4de5-7a849668d038@web.de>
Date:   Wed, 18 Sep 2019 13:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EPloDjtzgZyFtbAiu2eDmpbVUU6aj0TjVRuDz8gFz84FXyKfp0T
 AWSlsu96HcXxe2xlyMxrN6OO4euIuGjd3LHMgbTCdPiQKZLYmT6PyTkGyQCa8Y2Es4Sd6pG
 Whx/NOnGMiqdLlNsKnoXMquMkFKycooQMWD3GHFeKMrLvybKNZ47dOk7KI9v8Z7SrbAMc0y
 W5/DnGGcw+oARb0vs4ADw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AUsuCzp4Pro=:4L9AEWJX0QSFDTq59WD/P2
 6ewyZUy9wrMnbmxoWv1vaAYjDNx2k1KP4YUuGaxp/LtoZmQEap6YugsRf46i7U/CmVAjbhWom
 N4F946d99qxzkmO9hsDJXynXT77GJTUtBvWEnLfqmHeP9WtOw1DPIanAbCy8KzcVxOXaBGjQQ
 46F41MTYCrNF3dwCyy66RnJwPSAtYzYxi0HGCYR/C46OhudayMn7Eq9cLEK2TAsh21N6BRhZ0
 Q7EpvkVrqxB75C4bfyC+3lN9TtyCiilr4eIwtft+PmEhC/NEZQupaxmB42qiuk6DyipcYXKAZ
 CGgZMYpY0c54zV8RA72DJ+87wAAEgZfhE3X8W1hfIvAh4N4YwNDf4hecjmGwK5yo25oGHBhvr
 LgpK2LB+rneyMAWIEneQ5FoZj0A5SRTIdlfM4dyeeRh7yinWd3duXB9O++j5JYXCvXnh+9o4M
 OMfkWs1sQ6tAzzhnBYkxQsN7h/cDNwthkBIfPLL7C23ZFPSpTJFoWVqCjqmfLeIjkyI99pBqL
 bgo27iXcrZtbgceTYh9vEuahCzB/89vxKpj0QDVdjyHT5ljnrfEluwYFCBcPbFRvgO0h7VzvZ
 5oXCvYX9OtbVhhb0VdPXKdYmKdZlmFgy5QgC53ykNiClv1hgDXpSXA2ti07EYrPA5oWwoIAa/
 /zD3lTjz4+MGum3nbZIcjbg2eehF3hAl70nOaf5sUsC+xeihvTM6tRbLz5u4fyvzJxJrifZrP
 Ok3NDVCfid5FjC7Oc0epmqJfGnjxyJu//+clxRNa/wnWUrGN5aByGRSUv66dm5YeBlUin4ucP
 zF8U61MNKc3vdFktS3KiRE4b90vwmkQ5ydxOd+I6k3bv+sJ5lgLFiapshaP1HF58yDwkfR2L5
 CEd58gzSJxKvy76r76ourNU62BzI5+PnoEhNdkICuwdfJ8F/TfYqhQe+X9s0AD6M9fjkPjDDy
 aVoHn3m2wl/s1P1xKG9IbN5T2ThDOrtyOjeL/MM5m4Y38TvpQ07hnwzRYETpEBGsdtyWa4LDO
 2/OU4vcAqad3YqnmJOHTXiZ6vAi2bFVBxSEL/oMtdYs+wmmVq+sJe8IAXL0RXxPK59q7ODgBp
 Zujf0M5BCDHq6AMlfVCIUX3eSwf+EksuDrtf/71dE4Gr/ZPAOnL5RmRlS4FsS/LeJnD1BrAzh
 l6YUmbaGjS0G94zu6fazQSJ+YraCiqCPCSnBz4VQwXImKs61hIGx8mc6uM3j4WG5BLRKgszoB
 QrAMxFS8XUpc1yC7Cs2l2B29PeqpA5Zcj+/3a44m7tzvRnAGMcRnS96PKvDw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2019 13:40:30 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mfd/ipaq-micro.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index a1d9be82734d..e92eeeb67a98 100644
=2D-- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -396,11 +396,7 @@ static int __init micro_probe(struct platform_device =
*pdev)
 	if (IS_ERR(micro->base))
 		return PTR_ERR(micro->base);

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res)
-		return -EINVAL;
-
-	micro->sdlc =3D devm_ioremap_resource(&pdev->dev, res);
+	micro->sdlc =3D devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(micro->sdlc))
 		return PTR_ERR(micro->sdlc);

=2D-
2.23.0

