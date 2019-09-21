Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7F7C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B9620820
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UKDOi1Tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfIURu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 13:50:56 -0400
Received: from mout.web.de ([212.227.17.12]:36665 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfIURu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569088248;
        bh=01KhcEVaovNKmDRrNUSUWrG8wAUPK/XdKwsrTNvk9ms=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=UKDOi1Tpf/HhZEQ0L5SXzwOHi95W7PbtOLyqDSZB4pPzhlbIHvZqeCF6dORMUSTfU
         koBA3263OTcdakvhfqihKVfVaGv1sEbjUmtIfovINY8KyTINBN/sYfDkSpoxeU7WN0
         hs97EMWtAo2kKyjHyee/6iQ0B2RYkkPXQB7OgZDE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.64.44]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGRZc-1iOung2DfU-00DCpg; Sat, 21
 Sep 2019 19:50:48 +0200
To:     dri-devel@lists.freedesktop.org,
        Brian Starkey <brian.starkey@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/komeda: Use devm_platform_ioremap_resource() in
 komeda_dev_create()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <64a6ea39-3e4b-2ebe-74f7-98720e581e3e@web.de>
Date:   Sat, 21 Sep 2019 19:50:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2k8y4xw3Rgii+T8PbvI0l1DR68+jfybpTh5FEijYJB5QA/bos8d
 KmNtOmDSHS+KBdrwFvMy+GHZkqcOnMhJG5PbdWxN/ctyAWf5m5b86PVQLDOaWf4/GOeOs0Y
 sFl+eNcvece36uDfAAxFAiHW5+YNGBb4rGASUMrBUZz+GUL17Ugw8aCpqd79VT80lSHv4pa
 PVyZ6wFB0f4ulJEtZXZJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F8BFKyOmTXE=:SZ+WPYuykf61gJqSMPeAcp
 g+lJF5ChYf+0Xs7CZwmi+HAtMflXZS6ynzBLC+CZsWK3sfrLPKKyhm+H9HBwz6rj/NW/WFrf6
 NOGaQK+ANKCkc09PgPxTnnM4n8YHwulIyg5TyiNYyMwFaQ3COGOi+xLjzP2TamhJ9dxtc33vK
 RCdoGKWJKrN5R95aLH8YyNDdSHhtTwMn+LJeWsAFsUBxU7dE/xe8CRsMBJoWrO3LNMKMVviRl
 M7RoWWgumiQJjak/Ag76vWOnw8TVYG1dvGOFZMq5suo2R65OqqryfDy7bPZDOaGAUFquxgyRP
 afk7BKwqayPTMQqDFCsfG7mlwUr6+DngvKjw3wC4qVW7DU3SsDimgoWfgDPbaWtwYi0bA7XCi
 xjXV4DfyVRMUU9iZrRiCEIYWnldT4uel/pBcs5jYcYczIu6FkmqXgQealCbpu78i77Zmivqao
 EwU7DmmOXg0i0lyQEecKe8qBuuMhgi+Hk9/MOKo81e17MgyAFrjtufB5N/JlOCcevgryn89Ig
 YQQsjQPdSFJ106ZPfuGfuvOMhchdvNw01HuHqMzQJ9BVdvqYg0WWEr7MP/4hXkFrAs94JwFVs
 024YfmcXel11NKnkIYa0lv2snNE72JYDwDA9EpmJz5HtFwFXlS1dAHbcTlD9sYMK9ckmb1imN
 QwbwgqtJzLxUGRe/i1L+u2Hn34RPpoHkEPhgGJ1M+rnvAms3ozsqhIt448NnrXWjddp/KjKzo
 HFwTQipGjshvaXfrkkup0FRV3nohqra241Tc9ylpCSdMIn+OqHR30BdGw62u/cqK/CzZT7/Ly
 odyFlRTvYQZhiBI889E4jIbYkA3MSVc62hIeA1v2oruN0LeAG/3tTme3j6pXnZsxe3wn31GQ/
 dJqWbmBxdHTbxeiIPkV0giVjLX27GcA73axCANkkaE7IrYSqNhLnw0okADCmiBRiNUBhogufp
 fjGl98v70Tg83uxW0uXaCStnVxHkOTSbIOuHBtK89LNva2PbafO+b70Y1sAvawfbNy56uL0pW
 dz+kbb5r0xbTaxHXnj44xaujvCIIZyYNSsK/ut9VLp+EaI6r4cnQbAGdwfrLHOKkKYhkiycml
 oLUgAsnwxbRVtorXX6NXw3iT4Jlv6yE2IyFPQzkRz0Y+4TRoIxMPWoJ5+WBj77VIH+DTpqYDO
 V0lxPfXpxhLGW1zmNwWouw7fprQ/q/y/jWqZHanhPF4+nspMSfLiGl5K3SbgUVQZEOcObUYIx
 NwMLPsmls2XSvpiEzGpOv0659fXEylFeiUt4JvMIT5btllcdUgwN6lyBbeX8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 19:43:51 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_dev.c
index ca64a129c594..a387d923962e 100644
=2D-- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -172,19 +172,12 @@ struct komeda_dev *komeda_dev_create(struct device *=
dev)
 	struct platform_device *pdev =3D to_platform_device(dev);
 	const struct komeda_product_data *product;
 	struct komeda_dev *mdev;
-	struct resource *io_res;
 	int err =3D 0;

 	product =3D of_device_get_match_data(dev);
 	if (!product)
 		return ERR_PTR(-ENODEV);

-	io_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!io_res) {
-		DRM_ERROR("No registers defined.\n");
-		return ERR_PTR(-ENODEV);
-	}
-
 	mdev =3D devm_kzalloc(dev, sizeof(*mdev), GFP_KERNEL);
 	if (!mdev)
 		return ERR_PTR(-ENOMEM);
@@ -192,7 +185,7 @@ struct komeda_dev *komeda_dev_create(struct device *de=
v)
 	mutex_init(&mdev->lock);

 	mdev->dev =3D dev;
-	mdev->reg_base =3D devm_ioremap_resource(dev, io_res);
+	mdev->reg_base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdev->reg_base)) {
 		DRM_ERROR("Map register space failed.\n");
 		err =3D PTR_ERR(mdev->reg_base);
=2D-
2.23.0

