Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B930AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9A72084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfDATPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:15:33 -0400
Received: from mailoutvs56.siol.net ([185.57.226.247]:37839 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbfDATPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:15:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id D4873521529;
        Mon,  1 Apr 2019 21:15:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HlbkJBj15cao; Mon,  1 Apr 2019 21:15:28 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 78F1B52065A;
        Mon,  1 Apr 2019 21:15:28 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 05EB2520886;
        Mon,  1 Apr 2019 21:15:24 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, wens@csie.org,
        narmstrong@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] drm/bridge/synopsys: dw-hdmi: Add an option to suppress loading CEC driver
Date:   Mon,  1 Apr 2019 21:15:12 +0200
Message-Id: <20190401191513.23159-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401191513.23159-1-jernej.skrabec@siol.net>
References: <20190401191513.23159-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DW HDMI controller on some Allwinner SoCs has support for CEC, but due
to additional logic put between CEC controller and pins, it doesn't work
correctly, at least not with a lot of instrusive changes. Fortunately,
it's still possible to bitbang protocol.

For such cases, add a platform option to suppress loading CEC driver. If
DW HDMI CEC driver would be loaded, it wouldn't work anyway and would onl=
y
cause a confusion with multiple /dev entries.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
 include/drm/bridge/dw_hdmi.h              | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/=
bridge/synopsys/dw-hdmi.c
index db761329a1e3..d2b0aa8d964c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2660,7 +2660,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		hdmi->audio =3D platform_device_register_full(&pdevinfo);
 	}
=20
-	if (config0 & HDMI_CONFIG0_CEC) {
+	if (!plat_data->disable_cec && (config0 & HDMI_CONFIG0_CEC)) {
 		cec.hdmi =3D hdmi;
 		cec.ops =3D &dw_hdmi_cec_ops;
 		cec.irq =3D irq;
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 66e70770cce5..c03bea3a1a36 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -144,6 +144,8 @@ struct dw_hdmi_plat_data {
 	int (*configure_phy)(struct dw_hdmi *hdmi,
 			     const struct dw_hdmi_plat_data *pdata,
 			     unsigned long mpixelclock);
+
+	unsigned int disable_cec : 1;
 };
=20
 struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
--=20
2.21.0

