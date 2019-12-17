Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE8AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0AD21582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfLQMq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:46:56 -0500
Received: from olimex.com ([184.105.72.32]:60969 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbfLQMqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:46:52 -0500
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 04:46:45 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Cc:     linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 1/1] drm/sun4i: hdmi: Remove duplicate cleanup calls
Date:   Tue, 17 Dec 2019 14:46:32 +0200
Message-Id: <20191217124632.20820-1-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the HDMI unbinds drm_connector_cleanup() and drm_encoder_cleanup()
are called. This also happens when the connector and the encoder are
destroyed. This double call triggers a NULL pointer exception.

The patch fixes this by removing the cleanup calls in the unbind
function.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index a7c4654445c7..68d4644ac2dc 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -685,8 +685,6 @@ static void sun4i_hdmi_unbind(struct device *dev, struct device *master,
 	struct sun4i_hdmi *hdmi = dev_get_drvdata(dev);
 
 	cec_unregister_adapter(hdmi->cec_adap);
-	drm_connector_cleanup(&hdmi->connector);
-	drm_encoder_cleanup(&hdmi->encoder);
 	i2c_del_adapter(hdmi->i2c);
 	i2c_put_adapter(hdmi->ddc_i2c);
 	clk_disable_unprepare(hdmi->mod_clk);
-- 
2.17.1

