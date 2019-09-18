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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F54C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7803821927
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lCk+t36s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbfIRSmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:42:12 -0400
Received: from mout.web.de ([212.227.15.4]:40133 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729636AbfIRSmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568832129;
        bh=lDlYjeBm80exHFWGEP4aO48C9a1ZKb/ahMHgS37pzLo=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=lCk+t36sbLbfMwzDiYWIp6r57mDdOlmCvY1vObM3/K9hIcp+sQWEmV22+0VBtufGE
         j47nDW9+u5Jxp4xSV8Ur7BjTJ7h6rJzy2PBxv+XzItI/KuoB+MYhXRbqxSXrAT1H4r
         bJ0xJOT7f9jMt0V+VqBiRcTgmhJEU/88Fvj5WXpA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.2.101]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfYTr-1iYUFm0cRv-00P6xa; Wed, 18
 Sep 2019 20:42:09 +0200
To:     kernel-janitors@vger.kernel.org,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] soc: ixp4xx: qmgr: Use devm_platform_ioremap_resource() in
 ixp4xx_qmgr_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e70a4035-dae9-db3d-4cf0-0e3bb718a949@web.de>
Date:   Wed, 18 Sep 2019 20:42:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eMbHFaq/JEjEHIfX/+lwnqcsPT3m5hppaHUyn9o87G0MFMzb73N
 pF2b1PbWu1D0g3U/doMHs1RJklGVsh1SZwv5/MyomXeCmupPUrF6TPFcIRiOmi1jIsUfaQs
 8DccnD74shs86gFRBTGm9qjS5g4XZVY5vgfXD/J/ubeC5Wb5m20+eHzgJsoWSMFlBWVzsPy
 gMFp6uPIeGqaKgBAdVdjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DBa1tN66XBc=:db861qfrY4u3l4nEz8Lm9E
 nh0FxChGPFBzNxYiEcfVQbCiRuGT0AsQYfMaZm5Aj6prJDAJEKhYn+itUv/4+Wqip34WtYN3V
 pC7Pzo4ppGaY2RmNL+Yhiqt0OYvxfTW22b2G/4h13dfGTZ2Y4jl2mxazUhTuPT8e5SSWgGrJo
 CcmOeWyh6rmXzVgVbkMETCNstJLSrrfYp4C/Ntr3HfV0N5E7wvv0ryXIW59mfeZRGlUx3bT18
 xUFzn7GwGpRVu6mxPiQJ891/4mWgUSixXUz9MOxVdwaTtZV8qy2rmFJdPp0Qw/o3TAsRGgEiX
 xrX/9XfYCjlNknSq+c4EyhiSX8dQaJb0ihRwp5j3/Rfhz8Dnz+3hNmJAWQaaknSMICyigo2Bh
 2AR4dE+1MkFGb5epQTKtXfGjq954/BRnRxed7fxbOiutTg21u7JP+Hfl++VsISh7geHpRnjmJ
 TV0Wo4EVeFLvnl3Lq2qZWVPFN539lt9O1sazpdxNaMeemODl0ZlGn/ljrHQDRhMxV6IyD3t5q
 8+5SrJsNqd6PO26G+WpGRYgQ9HfjvAZnh/JScfxrfuM+difuW6sUZNjh/88kQt68z7YQHSORG
 J6jUb3mK+6rxr8CIbq5enSFXFrCGs2RQ0m5awKN9d/Ss6Ykr9L/sKeFgjOOoo8EsKv7k0f/uc
 0Qneiqxo3vawD7YDu2PsutqQmIw7KD3oCMRqGWws6t/QzcgBcQL8L40/f98+rYVYXiu3238Rx
 yzL1ObKlpIXud7FxFESFNfdkkrX6yp+gm2fTT9TXlqIjqi6WmfMsXzRVGuuMaQW4Ffjinu8yq
 5XPGyctwvvqVVfe5EjWS+21Z2dP+Nbk2Wph3r0lBh/85SroWQ/jSmF8ei9swEbkiWcr4UuQpt
 VNPU85hvn8B53VIG8uzTuJtQ+EaCuFYFVCCD9RCylywHjgTYYxXk5JnmcI7ZAxRNzBPGmu1Kb
 Xn3ueC3ywwrbN7WkExjZHWqJvgCkA6P5yTk/zHotU+L3PJqol8nSI0HEo+zoBj0ZZrO9uidsI
 js4/RFgGIV/gImyCgv/r5sX/T7cPk8kZpXh6xZvf5qWCg+okCMeGvuQp0DcA9TtD9ixSj8l4V
 NlRKpXlaShPwZfD7Ep5E9xI/Wux6Wns61kEL/h5gC4WMpg8RJW/ylSk6TonsH5K3Qz5mDjbVa
 LrIA0U/WCW8JjvOKhgIZLrIZwjpcUzeJS9AzDtPaoHMHyI0cvhuPpHBe1+w/X/CJ/a3pLnlD0
 x4RCy/zISVQeVGfUBYQ5LqJNPSIz4dJvlDmSOwzwWM3vFz8jmhUX6dlL0QJQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2019 20:33:27 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/soc/ixp4xx/ixp4xx-qmgr.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-=
qmgr.c
index 8c968382cea7..520babbd9037 100644
=2D-- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -375,13 +375,9 @@ static int ixp4xx_qmgr_probe(struct platform_device *=
pdev)
 	int i, err;
 	irq_handler_t handler1, handler2;
 	struct device *dev =3D &pdev->dev;
-	struct resource *res;
 	int irq1, irq2;

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-	qmgr_regs =3D devm_ioremap_resource(dev, res);
+	qmgr_regs =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(qmgr_regs))
 		return PTR_ERR(qmgr_regs);

=2D-
2.23.0

