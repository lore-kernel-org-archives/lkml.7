Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFBEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A337C20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfDBNtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:49:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42217 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731189AbfDBNtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:49:11 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mgr@pengutronix.de>)
        id 1hBJmn-0007VP-Js; Tue, 02 Apr 2019 15:49:09 +0200
Received: from mgr by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <mgr@pengutronix.de>)
        id 1hBJmm-0001DG-P1; Tue, 02 Apr 2019 15:49:08 +0200
From:   Michael Grzeschik <m.grzeschik@pengutronix.de>
To:     p.zabel@pengutronix.de, airlied@linux.ie,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        dri-devel@lists.freedesktop.org, rafael@kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/3] ipuv3-crtc: add remove action for devres data
Date:   Tue,  2 Apr 2019 15:49:02 +0200
Message-Id: <20190402134904.588-2-m.grzeschik@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402134904.588-1-m.grzeschik@pengutronix.de>
References: <0687f68004b28ed3a364b06a9eb64e2e@agner.ch>
 <20190402134904.588-1-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The destroy function in drm_mode_config_cleanup will remove the objects
in ipu-drm-core by calling its destroy functions if the bind function
fails. The drm_crtc is also part of the devres allocated ipu_crtc
object. The ipu_crtc object will already be cleaned up if the bind for
the crtc fails. This leads drm_crtc_cleanup try to clean already freed
memory.

We fix this issue by adding the devres action ipu_crtc_remove_head which
will remove its head from the objects in ipu-drm-core which then never
calls its destroy function anymore.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/gpu/drm/imx/ipuv3-crtc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
index ec3602ebbc1cd..fa1ee33a43d77 100644
--- a/drivers/gpu/drm/imx/ipuv3-crtc.c
+++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
@@ -429,6 +429,14 @@ static int ipu_crtc_init(struct ipu_crtc *ipu_crtc,
 	return ret;
 }
 
+static void ipu_crtc_remove_head(void *data)
+{
+	struct ipu_crtc *ipu_crtc = data;
+	struct drm_crtc *crtc = &ipu_crtc->base;
+
+	list_del(&crtc->head);
+}
+
 static int ipu_drm_bind(struct device *dev, struct device *master, void *data)
 {
 	struct ipu_client_platformdata *pdata = dev->platform_data;
@@ -440,6 +448,10 @@ static int ipu_drm_bind(struct device *dev, struct device *master, void *data)
 	if (!ipu_crtc)
 		return -ENOMEM;
 
+	ret = devm_add_action(dev, ipu_crtc_remove_head, ipu_crtc);
+	if (ret)
+		return ret;
+
 	ipu_crtc->dev = dev;
 
 	ret = ipu_crtc_init(ipu_crtc, pdata, drm);
-- 
2.20.1

