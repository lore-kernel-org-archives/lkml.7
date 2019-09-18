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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44109C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093A021920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="f8vjlKb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfIRL1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:27:01 -0400
Received: from mout.web.de ([212.227.15.3]:43057 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfIRL1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568806004;
        bh=ccPGSznJXqKALFiMkzuktevQiVyS3c/9JLO26vPrRTE=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=f8vjlKb5UdWOWZCWAFWz6DnJ0TcKRdWJ6cwH2ww/UPoq2Rn/VWPiO+dgZqY5QDS72
         9alz06bpVdRPlVpG6FMiq1XrZD+n1cVPwEWvLNZ54/nc+Nx533XNZ/GKuJG36LnbiM
         exa7KG3wRoLAvQ2jwLsHDiai8D7lHSivaZQqYMoI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.2.101]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXBh7-1ignvV1UCT-00WBqW; Wed, 18
 Sep 2019 13:26:44 +0200
To:     kernel-janitors@vger.kernel.org,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Wood <scottwood@freescale.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] memory/fsl-corenet-cf: Use devm_platform_ioremap_resource()
 in ccf_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Message-ID: <d4e42383-a462-f5d8-4277-c20775c7352c@web.de>
Date:   Wed, 18 Sep 2019 13:26:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U8FML0Y8m9kGfUF3l0IMwGNyg+wp/ZQuNFAEcYB0/9UQWMnEjKM
 SEw4zv/WzZ6HlgSgaUR64JXZvYCfWxjPsH4zgQ4sRpokw8ZyTTfDCVO9mptG2UkHAz3BMG/
 AEts8avb5zuOaJgzFRw/zUwXsLK3WGMzdDUwpUZEdwPfCYkyTXSf8ZMScV5wdS8iEdoXvKM
 Bm4qZSQoh9LMaMwybJwyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xcjnxRHllCE=:g6i9lumiytyAsetFRlWlTw
 kDAXevm154bTwESuLjX1NTyyhYLfgc5qboJShTGO6h4WMWZU+N/DvWxM9ZB80N00AA40PLclQ
 83Smol+mAXddOjhxlKx6mRWbZVY3jH1HJXdjZB9201dMziM4UnmCK8sXsF79MDo+pTJLnrXx3
 6z4P06QBxaw/pZmtorf0g4gM9OmCh2TQ83459tqIxGOVuy82m2KWNmTRPkiLRWLN0l76EaPfy
 y/Q5a7GW8dw3YAd8ARhM0izJkS6yKliJj01oNj787ovdYLjLhtTPKtnVtkxqD1643g4KzNKA6
 qv/ask7Pes5xhNJaGeGbwnK9yqHMX4CMkKCCPk6oEJ5IwCZ6G4l54FXcwkfueloc+W7RHI1tJ
 TFq11L5C6K7A14zvdQ8W+qniHUXtEUXvomAFZadQhX/OoS1T1y7RgNOyf6sJL7w9MZk2jP/zZ
 cLdFqgD5EQ0RsZ+Yx8NaY01xcMrBKl5zmdd+qfjCwjoaYVSqLKBQcZ0kwBaxEigJ9QhOyYAhj
 Ibkt+IOAN3dufxQb7qjoxESCx9TbsHKancIXTirFso5uXkCZ2o0+VAnzLrOX23sRg6u8PnSX/
 /iBZ7E1G0YvfYEP/+JxipR84gznreWgZ4JTG1FTACSexAIrZF4wMrwKOorOvF+25GVbk2a9oI
 VrXhHIpJk5xAQmkaCY+4sn7Qn8SU/yUaFti0YQ62P7NtlBL6nh0YDEMV5NSzJRnxR166fUBSD
 EcEWH5CYyNG+2cpu6+0B79AyReN+fEIUW132/vveT2ULSuG2qfjNpvgaTLFOF6yP3SbISgmU5
 tbjQo2Wy0A4YRmLFm8NI/X5LNy6zJ0a8ZvM2Ail/GHOZVIiUaSYnBi/QOzZhFLTSZKcsYodXq
 DYG+ne8+b7u03Yr5A9SJaziURSYfk0jmypE4f1j2ZRa1Whvnj3DAmwKhjfJ3rCojucK8omS1V
 BTP2RKJhOe6B7Jk7j923OvPTOBS7PWJiha4CbmUJw18JC4Mih/UsVG2Q5wpEtNfkHDa2OjPCl
 m1/pHkrJsd1ywoqzMyWjLGBzaUqXVGb3Mp68fMcgm1ZLKO7DMgF2zkIzC4F9D56CQwnS3Lxk6
 g5LPoMuB7KsaY8sBn8Gp0fpv25VIOU0Y8w6e9F3kSew3EEbDeKImkQAqltxEjZ8KqLRlCDMMH
 FQXpIsaS93dUowj1b9w+uZP/G8616MVxtAvk/qvmiYIC9Q/C58KsebFW/MfdJMoNk0S6a9MBW
 vTHZashMiHoy54zTzjCSeNCRK8LQ2qq3sI6tRTvuop0ncv8Xxo+v5fdMFNnA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2019 13:14:46 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/memory/fsl-corenet-cf.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/memory/fsl-corenet-cf.c b/drivers/memory/fsl-corenet-=
cf.c
index 0b0ed72016da..f2fdc3c82ff7 100644
=2D-- a/drivers/memory/fsl-corenet-cf.c
+++ b/drivers/memory/fsl-corenet-cf.c
@@ -172,7 +172,6 @@ static irqreturn_t ccf_irq(int irq, void *dev_id)
 static int ccf_probe(struct platform_device *pdev)
 {
 	struct ccf_private *ccf;
-	struct resource *r;
 	const struct of_device_id *match;
 	u32 errinten;
 	int ret, irq;
@@ -185,13 +184,7 @@ static int ccf_probe(struct platform_device *pdev)
 	if (!ccf)
 		return -ENOMEM;

-	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
-		return -ENXIO;
-	}
-
-	ccf->regs =3D devm_ioremap_resource(&pdev->dev, r);
+	ccf->regs =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ccf->regs)) {
 		dev_err(&pdev->dev, "%s: can't map mem resource\n", __func__);
 		return PTR_ERR(ccf->regs);
=2D-
2.23.0

