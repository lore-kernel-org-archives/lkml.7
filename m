Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C1FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D147620811
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfCXVWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:22:05 -0400
Received: from mailoutvs2.siol.net ([185.57.226.193]:50934 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726743AbfCXVWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:22:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id C74B95218CB;
        Sun, 24 Mar 2019 22:22:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OphCv9lmrBZi; Sun, 24 Mar 2019 22:22:00 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 6BE535218D3;
        Sun, 24 Mar 2019 22:22:00 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id B13E85218CB;
        Sun, 24 Mar 2019 22:21:57 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, wens@csie.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] drm/bridge/synopsys: dw-hdmi: Add an option to suppress loading CEC driver
Date:   Sun, 24 Mar 2019 22:21:42 +0100
Message-Id: <20190324212144.3652-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190324212144.3652-1-jernej.skrabec@siol.net>
References: <20190324212144.3652-1-jernej.skrabec@siol.net>
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
DW HDMI CEC driver would be loaded, it wouldn't work anyway and only
cause a confusion with multiple /dev entries.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
 include/drm/bridge/dw_hdmi.h              | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/=
bridge/synopsys/dw-hdmi.c
index a63e5f0dae56..fdda26f8b056 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2634,7 +2634,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		hdmi->audio =3D platform_device_register_full(&pdevinfo);
 	}
=20
-	if (config0 & HDMI_CONFIG0_CEC) {
+	if (!plat_data->is_cec_unusable && (config0 & HDMI_CONFIG0_CEC)) {
 		cec.hdmi =3D hdmi;
 		cec.ops =3D &dw_hdmi_cec_ops;
 		cec.irq =3D irq;
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 66e70770cce5..764b8bcfa62c 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -144,6 +144,8 @@ struct dw_hdmi_plat_data {
 	int (*configure_phy)(struct dw_hdmi *hdmi,
 			     const struct dw_hdmi_plat_data *pdata,
 			     unsigned long mpixelclock);
+
+	unsigned int is_cec_unusable : 1;
 };
=20
 struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
--=20
2.21.0

