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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BED2C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 18:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CF7205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 18:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ZW3oouM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbfIUSVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 14:21:03 -0400
Received: from mout.web.de ([212.227.17.11]:53419 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbfIUSVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 14:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569090026;
        bh=JbHXXipkDs96r6sC02uR3t1qJZ+VGIW8Ril0kxJ0PzY=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=ZW3oouM1CrAGJuOPrNyHS9MFGdNV0IPOac4UxXC3tp9PWb41uLH31nfS8wp0WNLQX
         vZTttsTfsVwNjuDe+nl8HwcAWUqsNAPKIETBhoZmiZvoeEdf3BBzSjsrOchFVbWQ+2
         Zbo7DWPiFgdoHsAmXCHkbFbzw2BJdpTy+omWHXG8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.64.44]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAvGa-1iJPUT36k0-009v4y; Sat, 21
 Sep 2019 20:20:25 +0200
To:     dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Matt Redfearn <matt.redfearn@thinci.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/bridge/synopsys: dsi: Use
 devm_platform_ioremap_resource() in __dw_mipi_dsi_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <e0d7b7d7-3e89-8b3f-04ed-0b14806e66f7@web.de>
Date:   Sat, 21 Sep 2019 20:20:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/X5KSMYfk/y84AhbFArCNipUfcIqSR5iWevq/uIhXNqC3wOtX/m
 GNs5JyUPr25PmxwhO6/pi2z+47h1ZiD01UqE1/gd/idvfZp4svdI/0bTRbewif2ZYOa7q0Z
 mjD5As+bci/qG/FyAlfwbjxdYbIXXfDDKZqMFtCiAXp9OrHeMZZ/SwXfSBXYzZ28Lfakyuz
 QKz8exAhD7iTKsVysQCBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:teElU5MMyxs=:W/i7Ym1W9SHfwEjXpO4QQg
 /MTSSib2zlx2KV96suXxIoWwYpUCs666C8W4IyYtNtros1AhbXmgd3nIc7LfijulzB6RNMR65
 +ihjgSOHcsQg8SVv6IHEM1cevUvc64b2QBzN9kqq5m3Vxdji9+Ct3/TY2fNYqw+2edVsq0di9
 ra6ehb1Kyl4MJzNZ0DIgv/UbcMNMAM0Y/rmrtUDIWi7l4X6SHyC8n6x0exVKdOXZ7e3bOSqWU
 PxYbODMhd3rvT9aBP+Yr5bDkzkhmRY2cG9pZzsuUfn5oQDx44LCLJIkngY1Wx+zr28BpXssKF
 UDEivMCG7cv+DgIQ6UfZsaS4EImAjHFQcCPvtKGH9qhRfKntK2LOEgohfnvrTLtAncnSuxqwn
 jZqBwkFzDm8E5zpqBcP3h6GkkBILJnNk8WnMjg4DksOWA0wJKaJwF9tHiR51IvUxxtpH5MMiC
 GUAyB10jq3x65IukJn/UA2sN4Zy6SDa3DiN5H5OxEeqDfKfNPi5spZj7CNrqIzdYLCfuANjfJ
 qPLnMFj/7LzQJZA48MD4kOTxGCrv1phtfxIbtA/iSFyqJe7+MXx6YEhSaf/UJzZ/OA3PEpJ9i
 Xl09otpZgugMqBFAkimp0BtpTVhfgMqRt4Fzuzgaiw5FJilWsWCIyfSg2dOR+fyLkYP5v1x2q
 BZz3KZX2aUHJgBnU38+8V1mvdwwRJreDyhrQ3d1xYiEQ6mzXtfn27LAeojMrSIP8LRHdjBwpd
 L+D3bQCuGUP0O7+Vv6T6DW1KyhPsL2H3a1yNXQa6LgFkq/OV70iQ1CA2x4BU5JoEf2dne+2Gl
 1379uWnFh2Bv0k5Iirp6fntlfWk7+/WZBOPgThOhvwZV35LxpnIIXg2ZDY6eZ+XnrczuB8pNI
 NZMpWFzUVz/me/7eWy/RGy3xjjZbblCSCh+fiKrRjgfxtaR3aK/n19E6N6RcLL1D6AQ7MVxoJ
 op/47SoTe1LKeg56EOADgTShjwmvL1++9LkN+elzMUD4QE8IDKgu1Di+wHS+OBWYc8+XH/04T
 Rd3t4fueWJyoyr8OhFHthVhMLIX7oEgzzH8CarmG8bsLIwjHU5Iawp4cTkUYyy8C379XM9JNw
 PmULOrExJMV7t0DxF+apR15atBrZx86iLxIPEjIq19/bEqeafcLzPHvZBY8wb2Iah95z+7pEJ
 G16MKEukDvZUhfebtlEAsRdinqC83+1fOKM6MwL8h0d3jPCL6rHKNCCrMj/WlzyByx5gtZyoa
 ISPDYQFOGIsGQ6N8zLZNSawka79dasf9BLjhvGdyvA29tbA40J8U5z+x4Yvw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 20:04:08 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-mipi-dsi.c
index 675442bfc1bd..6ada149af9ef 100644
=2D-- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -981,7 +981,6 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 	struct device *dev =3D &pdev->dev;
 	struct reset_control *apb_rst;
 	struct dw_mipi_dsi *dsi;
-	struct resource *res;
 	int ret;

 	dsi =3D devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
@@ -997,11 +996,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 	}

 	if (!plat_data->base) {
-		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!res)
-			return ERR_PTR(-ENODEV);
-
-		dsi->base =3D devm_ioremap_resource(dev, res);
+		dsi->base =3D devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(dsi->base))
 			return ERR_PTR(-ENODEV);

=2D-
2.23.0

