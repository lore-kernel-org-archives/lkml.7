Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169DAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D682920652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fqpCQmYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfDPPAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:00:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:35267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbfDPPAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555426750;
        bh=V+zaO1oNND4YPt599ysKBo3HAApCHzDDfia1P8jPJ5Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fqpCQmYRC4IViathwE3LSgtixwoUFESenPT9Wu59Ka/0cIl950PXx7JjRxH62ZNlx
         c8dKpBn0g2pUPdqWznDaw/vbA9oTRR8Hoy3qCMjl33j6gZXUjk2IhiYhVecoYY8KL/
         AuFVnpvNySOamTCbc7EQ6TbUneSlZO6V3CT3ePUk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([185.53.43.193]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MCwbX-1h7qxh0exv-009fzp; Tue, 16 Apr 2019 16:59:10 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, chunhui dai <chunhui.dai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v1 3/4] drm/mediatek: fix boot up for 720 and 480 but 1080
Date:   Tue, 16 Apr 2019 16:58:47 +0200
Message-Id: <20190416145848.11932-4-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416145848.11932-1-frank-w@public-files.de>
References: <20190416145848.11932-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:PiJgWiG+Mo0uMUDwX8rwuLcYg4MxdatLBtp4pICKQlJHr2Nhy2T
 T75TERfqyQkmhcL4Wz6tnIJ5JYuJgNoc+hpit4D33Rh6xcvtyODJUfViYejgx3O1xSGcJXs
 xSIRqq67asWYV61vY+hp+pW1S0LtdVOr9xX9e1c8UrNcMh7lTjoQI9R/jkiIDGRHJ1psbY/
 dE0Pc/BS2OxQt7q8WFNmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gdUGEW4INsw=:dIPi0TF04leMtAK5KC/cBr
 +rpCeJs7tcDAPLKsgOP5r4iP7wJS0brLeb0C8eYtgaoXbkgQvf/UfkAjw1pQ2ruCtgsEJE888
 K11is0HPzpTRUHZqB1dNFN+rHJBeb9xUIEUo4/37vvBr92u5QY8sQegqjI/3RiecAfQm1pXyh
 I8FZ2/wb6GIqEHnYMIcIFvK+YNF7hvFUkXBujBje6h3VX5eNADUZ/P9BdGpq+ES21+5eHUmZj
 ycc5CJEoiY4cxJXwSSEgexcf9nZ2fAVTTbGmuCLV8tyQyJcncCn3tVF64Uyr2UAlnPy9jhavm
 em+qlq/tVl238Y3mdHD+GapQiHmkFbsafYTeSDcP00uAoMXOB4mHnK+8gjB7q3eJOy9+CxiWe
 TG4TMAWsvKZLKOBz/6CDuC7Bt9ST9GqGzmp1WJV1y7cit97GmMq+CTd+i8hdteL2+SsUViS9W
 r+FUP9+Xq/Du/U6NTGOkaPQOck3Z7KGg0gpZ/+4DHU3jbgjRrVgEblDC5YiriakrzLyQAJ+fO
 yxwcawASedZHHHVBidJFOBPnWq5IT/8IHf6K5ZdNrG+XqJ6sUcY1QYyBUG7KmON/eCxKhs2kc
 l5UNSNocuZRxbSkrKqxiaUX/+SqRdvQw/27MOZREVdyHlpuUH4IZ33qhu+SP3yxSMLBF3bFja
 p3aS/qdnr02Jjsohu4Kd8YByB4yUMhdwLF6Y4sNI/AMMDwBsT/Nk9Ck9crtNHsOHsXFQI5ZhA
 pIIOh6qrjLxVjYl8n9RTjeKum/fpTtkA75xpIgeXixkOPZ3XHt6T0YaY0DwBmw2Pvz48VQkCE
 nksMYjkQ+IoTGhxDb1ty11pHb1XixlIHfoZ3sWhbYGQOuZHAITXkPIHrAdZDs5v0HVBxqg3nJ
 XckjoaMvrfPsqHeesZ/WOzqf3DeD4qpboDnws05XjEdL3VmgRaqBHg381QLsXY
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chunhui dai <chunhui.dai@mediatek.com>

- 1080 plg in/out with ng/ok
- support other resolutions like 1280x1024

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 3 +++
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        | 1 +
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/med=
iatek/mtk_hdmi_phy.c
index 5223498502c4..edadb7a700f1 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -184,6 +184,9 @@ static int mtk_hdmi_phy_probe(struct platform_device *=
pdev)
 		return PTR_ERR(phy_provider);
 	}

+	if (hdmi_phy->conf->pll_default_off)
+		hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);
+
 	return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
 				   hdmi_phy->pll);
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/med=
iatek/mtk_hdmi_phy.h
index 2d8b3182470d..f472fdeb63dc 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
@@ -22,6 +22,7 @@ struct mtk_hdmi_phy;
 struct mtk_hdmi_phy_conf {
 	bool tz_disabled;
 	unsigned long flags;
+	bool pll_default_off;
 	const struct clk_ops *hdmi_phy_clk_ops;
 	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
 	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/=
drm/mediatek/mtk_mt2701_hdmi_phy.c
index d3cc4022e988..6fbedacfc1e8 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -239,6 +239,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_=
phy *hdmi_phy)
 struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf =3D {
 	.tz_disabled =3D true,
 	.flags =3D CLK_SET_RATE_GATE,
+	.pll_default_off =3D true,
 	.hdmi_phy_clk_ops =3D &mtk_hdmi_phy_pll_ops,
 	.hdmi_phy_enable_tmds =3D mtk_hdmi_phy_enable_tmds,
 	.hdmi_phy_disable_tmds =3D mtk_hdmi_phy_disable_tmds,
=2D-
2.17.1

