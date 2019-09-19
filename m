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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1BEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CC221907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rzPV+WDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389977AbfISPjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:39:24 -0400
Received: from mout.web.de ([212.227.15.4]:55565 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389863AbfISPjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568907490;
        bh=IvBezhGQNiVEUo9qyo82nKP7FH2Z2z0jWTFLjJm5VIk=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=rzPV+WDKiUFdwpv148DBXjvKT8eHCnpSQwH5BvvB3mL8xIIauPW68PNGJ2Y/Gdt9R
         2Vverci+osFi/62rbFEEdLspPboV/qokX4u2+gQzTP0gKF8t+0K2JTTctKCX6vdjk8
         Q2kynhJ9JaFQ975Tzc46sORW8FUPxgR9OITHDvwQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.191.36]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Le8Ca-1hs8MA0yNw-00pveZ; Thu, 19
 Sep 2019 17:38:10 +0200
To:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Takashi Iwai <tiwai@suse.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ASoC: xlnx: Use devm_platform_ioremap_resource() in
 xlnx_formatter_pcm_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <8f7cf483-6ab3-d00f-5606-863e9f5b31fc@web.de>
Date:   Thu, 19 Sep 2019 17:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MQDQt/fh9Ra2BCCpPad/vocCOHbSct9IWDxnRW4ip1FQecY3c5G
 ccw3osppvm8ukIOgtk1IsOLOfiBvK4ocu9o5OitLNLbckVKcUb8Zno6i8GcsXVhFuyupYua
 ra4WHQN6EtawAJmwTK7oYCJolti+/sqJRciMQIws6PJMA2gu/AknFQj/+gJEomO3J/2MtI/
 VF+n4kOIxj1FP7ukngS6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kcb0vyePgeQ=:SQL3/RfT/YiXK+gG8Bv1Gp
 chNnGaBiNDF8+vw2QoU/MfWhWzcP/57HYt8+0ZxqH3q8Zkuvx4o362zOm2z9RddMnvxKWb8sj
 x6l5+DiqFZ/Yx30UAKUc7z4VBgqPEBS72Xc2Pgin3MYtzq0dL+VRnNAmIzejbscIBegP6MrMq
 UenW6NGHuKyGzlteU9PrOl4U+hbvvfm0DhCL4skhAztfjFLggVaRVIXFpOs+wZYCy6rBRxshI
 sCnjmrvHGrh9fJ+lPBwymnAIompVHzKkIyKkwe7Ty4jJ/DvP6xQ4JWnGsOXWBd8Mx0xUA6M3c
 jrK/hoUb5QZDIPzThNg+Oy4uslxjGEfhsBD0jhMkdmJJ4Xm4UtgZdG74akRdOFgZM8pOUnvko
 tiiVi15poaSiM8nfHmWHPQp26EguRXYuxlSRmuBQdMt7umbM9U7pbGMHTxUyYcl1tagVtCHqM
 XnpBTMvFS2RXuyzUbDuQNtZNzjDdGN2lGqkxA76aBLjUA12reaQrx7ROruhfO9iOh1GvWoVFu
 w4sChcNJ+mVtQ4SJpuRBd+sLBElLUO8kmCqru2RiDRcyMxF6O2sFR3OnQ9CC7m7KUMILD9IOq
 2gLx0ceQTp6Bk4uIPxN00zfIookS2opDfZ8qwQvCMFyh2uR40aFofzyrhv4d/x4I5aqKP4LWM
 a8h/ZNKKQwmnnwBqQwVYk1iK6JFdGC/V+G6Y3inM9BmA0nxverZbPwZgKjR0i7+UFPPraE53X
 9cMOdwE9Ca+YESwBplIGHC+Ui7ELhfZF5ka+gvhBY7d7Xo91azw5a9f2wvuxe9WvTskfu7c/f
 qIU5i5e6UUWQmC9ZR03at6HFInSTjOhm/MR+24vC4Cx/v/nZWsEJQ+4zo+pLYG/rPPnNX87f5
 24dnCsOjjpHRqS2oWWIYuuU2ZorUJEmu3YTBqY4TmeOhiAzwU6R17RvI4x53DZFpV1mbo+8he
 CpAJozXWtxPBhjxdvAYBr5qe9n/tnXyPtNAXY72IpK0XxqO+Ko9Q5oIC6ANytksafcqPblEaq
 iQ4rTOL1b4TFrRrsbUUxlDxmOYnTxrAbvNKHztcLs8wRAzoiEy5nQoLPDf/9y6h0c+w3n5fbl
 n5hVCUMqvWhUzHmzNLm5JIG966truZ13ikSszfPmaSq52SAxPjigbKqaERXZMQc390PNAHzA+
 U7LS09l4AuYa1fTWIBiWsydCM4cs1/NOiK/PsXiKwNnR2A7GgaT55u8XLiBn1r5yWunqVUTZc
 Rbgtsayl0WjqoA+znbcG0qTEC/iXBqkTN/6HztWCoIcT5FsQ48ntX4jakVAc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 19 Sep 2019 17:27:57 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 sound/soc/xilinx/xlnx_formatter_pcm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx=
_formatter_pcm.c
index 48970efe7838..fb652e73abeb 100644
=2D-- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -564,7 +564,6 @@ static int xlnx_formatter_pcm_probe(struct platform_de=
vice *pdev)
 	int ret;
 	u32 val;
 	struct xlnx_pcm_drv_data *aud_drv_data;
-	struct resource *res;
 	struct device *dev =3D &pdev->dev;

 	aud_drv_data =3D devm_kzalloc(dev, sizeof(*aud_drv_data), GFP_KERNEL);
@@ -584,13 +583,7 @@ static int xlnx_formatter_pcm_probe(struct platform_d=
evice *pdev)
 		return ret;
 	}

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "audio formatter node:addr to resource failed\n");
-		ret =3D -ENXIO;
-		goto clk_err;
-	}
-	aud_drv_data->mmio =3D devm_ioremap_resource(dev, res);
+	aud_drv_data->mmio =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(aud_drv_data->mmio)) {
 		dev_err(dev, "audio formatter ioremap failed\n");
 		ret =3D PTR_ERR(aud_drv_data->mmio);
=2D-
2.23.0

