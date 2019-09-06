Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A9AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C246120842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rpYiN1us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393170AbfIFQxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:53:20 -0400
Received: from mout.web.de ([217.72.192.78]:60833 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732540AbfIFQxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567788751;
        bh=mhqeZ+7z5Q7wNBVobBZgdDABit9PMa8Nwp21IFODusQ=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=rpYiN1usWNrY4/w/5ktFx9QtR/NOK0DFJYDwRNtXs9YU9LXK6HaxPEufO0JbAHBJ1
         RuqmF+F56Gq+NSti8zz9I2JA2q4FstasbFZRe4U1m9+xr6pOtFvtkoIhydOlq1P17D
         Pcl17+geyvQpDPj15Dzn7Xrny2td6ksqLiPnLQk8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.58.4]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LshSX-1iHVpu1po9-012E1h; Fri, 06
 Sep 2019 18:52:31 +0200
To:     dri-devel@lists.freedesktop.org,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matteo Croce <mcroce@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] omapdrm/dss: Use PTR_ERR_OR_ZERO() in four functions
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        zhong jiang <zhongjiang@huawei.com>
Message-ID: <66cd9e01-1f86-efb2-56c0-29a80dc47596@web.de>
Date:   Fri, 6 Sep 2019 18:52:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zoVdOeaJSGaW++jfJyhGx6/hqxUplFpCG+bhKbYCVhpZQd7WXu0
 eYoj4d5J2w3xHsvROBo5Fo6LF43LGbhGWKZ+j7ik/z4uJ45jOKcZRHnbJvgcKh7OxNr+plu
 KpKxA3CKaMLbHa+DEGMIJgP0p6GFfZPVN6WScvZOg4jVBUlsDdgKq3ZOeuTliSzjoumNIqx
 h0wbPP36tiWguRAyO7mwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UJCkLI6QvNQ=:JH70WEsV2mZ3UiaM7SiOEN
 +Hf9vymivIMlXexsE8UneopbXxf4qPndWS1z4z8KsXKzUqZwvrRTY7q3lfCUVhfzacI2UWMJ0
 thnHwARMtyZKLziZ+U5wZg11a106FW3XiRAoB+COUjQFTH4K8BVNVAQPo3KCNrC3mLNso1Cyz
 sBYb3Ygtgz5LMjfHeYkbGoDpCCc5xhnRI/Az2P7Wg/9X6zN5u5Mawi4Btg3heeVNojBPRF/bw
 N40vdQ2CR3NIw5qpf066R/PTXx6+Za3fx7Ys71Wv2Fw2D1FJhzSaOA2Ndxh3iyKcnJruiGNqn
 Vfw/+88/tCDuzw2Hf+624f62ywCDGfrEExnpY58OhHlfaof45QpNWhY9besyUDtrFu4otBc1W
 9kufR61PAFrURVz3Db44j8XKAD1Qxg+WteWRNMLLS0cTMOFjTzAxgFtBBKl2IOWLyA5LLKfYy
 H1yNsXM+gS3qcbiEj/g5YT6UjDZM/5eBYuBbxkVhrnbXlH3ZUoa2DD0nMG4DY1Zbzg8sbH0WN
 a+RNWkIDsltOoqJhewxI6b16pQyJJoLvkFDaRO9OcCkxYbJd2GcTyX531fOB5H2PLovL6GDCS
 +fgrEV+o6uf0kdcLyr6WPZS2Stx5OVXmY0ZPPMra8Plw4V/mKqYyXK6pYMLJZBmfhm7XRJkHY
 qwx5jbdpeoLtvQBD+Tl8Ex4eN8nWEhCeIT94h6mrykuxoWK/9KHMNQytEjTrnBGttG8A8a6Z/
 6EOFVcklt8YxpQYejCIiaCzHXburH7ijMHCyh3iu1/2wqpH3jxb23VlD0XZIV2Di6KHlTgSXw
 TKU60YMTs/Ndezmi7GlEVpULUwHLhwZRgc/+34/+eCYwugh5rLLgPKivyYqI1dKoAPBh45qCL
 GROHI+ylsz9fEfXRNmXj7ua9b+u9lxIW0sy+XJ/bkIWZJkP7iHGCL+cTE64Jj2VdbLxuianoS
 /hCswN1bY0AZtmxeeSgs+VuVfnv3ijppf9biNaIJU4Kx3iuSJapIIjaVJirLrQFJd06bRCtU4
 3XsUyPGDiB8+Wm5nhNwd44mniNqaFqC9VJ7DzPbJjrEzn227Ef8CAPTzPXWXmw9iE3fPU92/K
 eslB6RkTQ/A5m3CNCxqbaRMlQAUy4oA9wO3ES7BoHO0SlQNGt+MN1OiT8jqqT5fF3TJbr4pBa
 6JYTkv8VCu9llxehxGQr6+OgZC1MaJjeoSZZoEWONZov8hEhwTp6+y1SInPBXfBkhwX9PLhRs
 V3IvFjgCB9FJCVp7J
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 6 Sep 2019 18:40:48 +0200

Simplify these function implementations by using a known function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/omapdrm/dss/hdmi4.c      | 6 +-----
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c | 4 +---
 drivers/gpu/drm/omapdrm/dss/hdmi5_core.c | 4 +---
 drivers/gpu/drm/omapdrm/dss/hdmi_phy.c   | 4 +---
 4 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm=
/dss/hdmi4.c
index 0f557fad4513..b1a8d4bfbe48 100644
=2D-- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -586,11 +586,7 @@ static int hdmi_audio_register(struct omap_hdmi *hdmi=
)
 	hdmi->audio_pdev =3D platform_device_register_data(
 		&hdmi->pdev->dev, "omap-hdmi-audio", PLATFORM_DEVID_AUTO,
 		&pdata, sizeof(pdata));
-
-	if (IS_ERR(hdmi->audio_pdev))
-		return PTR_ERR(hdmi->audio_pdev);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(hdmi->audio_pdev);
 }

 /* ----------------------------------------------------------------------=
-------
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c b/drivers/gpu/drm/om=
apdrm/dss/hdmi4_core.c
index 5d5d5588ebc1..0775109133b5 100644
=2D-- a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
@@ -923,8 +923,6 @@ int hdmi4_core_init(struct platform_device *pdev, stru=
ct hdmi_core_data *core)

 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
 	core->base =3D devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(core->base))
-		return PTR_ERR(core->base);

-	return 0;
+	return PTR_ERR_OR_ZERO(core->base);
 }
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c b/drivers/gpu/drm/om=
apdrm/dss/hdmi5_core.c
index 7400fb99d453..655cf2048809 100644
=2D-- a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
@@ -899,8 +899,6 @@ int hdmi5_core_init(struct platform_device *pdev, stru=
ct hdmi_core_data *core)

 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
 	core->base =3D devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(core->base))
-		return PTR_ERR(core->base);

-	return 0;
+	return PTR_ERR_OR_ZERO(core->base);
 }
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c b/drivers/gpu/drm/omap=
drm/dss/hdmi_phy.c
index 00bbf24488c1..bbc02d5aa8fb 100644
=2D-- a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
@@ -191,8 +191,6 @@ int hdmi_phy_init(struct platform_device *pdev, struct=
 hdmi_phy_data *phy,

 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
 	phy->base =3D devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(phy->base))
-		return PTR_ERR(phy->base);

-	return 0;
+	return PTR_ERR_OR_ZERO(phy->base);
 }
=2D-
2.23.0

