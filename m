Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3292C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B7A21882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="BLYEDFxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbfKFRBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:01:10 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:8706 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732366AbfKFRBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573059665;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=TU8xWeq3Fq2kfoIu2yX7EJClpaSQfLxdKJkoXF7JaIQ=;
        b=BLYEDFxY+0GewL9OgXVbdi/izAcs9dRUruJ7sazPH1P+xGLvxsMZITCYdZIjdLihxL
        askVtjkQhNf6FO5xfbpe2k4ylpbXKkMn68XO0We3hAcyj9lFOZinlOSbEVVn/g9k3wvj
        XArWl1z4+ed0wgdXqa7yOkhLPN4xQUMag4NN8huD1C6lzX46cTJP6Oku2FwFGTEy1G3e
        OARzCeLK7XJqjoYBQa2JLWkUMK1eL54X+FKcYzu5R7ib96K8GcfMfsTBLxeWizQr1FLP
        8dpomG9PaOpWxbzi8hnpmehfyNRWo/EuGVnzpzPzy5ps8F5F9wtfzQrdyddvsq8gyqGj
        PNJQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8PvtBNfIQ=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA6H14hLu
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 6 Nov 2019 18:01:04 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 4/7] drm/mcde: dsi: Delay start of video stream generator
Date:   Wed,  6 Nov 2019 17:58:32 +0100
Message-Id: <20191106165835.2863-5-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106165835.2863-1-stephan@gerhold.net>
References: <20191106165835.2863-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initialization order for DSI video mode is important - if we
enable the video stream generator (VSG) before the MCDE DSI formatter
starts sending pixel data, it will immediately run into an error and
disable itself again.

Avoid this problem by delaying the activation of the VSG
until the MCDE DSI formatter is properly set up and running
(i.e. when mcde_dsi_bridge_enable() is called).

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/gpu/drm/mcde/mcde_dsi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index c7956c92b51b..4710f23b2966 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -583,11 +583,6 @@ static void mcde_dsi_setup_video_mode(struct mcde_dsi *d,
 	val |= DSI_VID_MODE_STS_CTL_ERR_MISSING_VSYNC;
 	val |= DSI_VID_MODE_STS_CTL_ERR_MISSING_DATA;
 	writel(val, d->regs + DSI_VID_MODE_STS_CTL);
-
-	/* Enable video mode */
-	val = readl(d->regs + DSI_MCTL_MAIN_DATA_CTL);
-	val |= DSI_MCTL_MAIN_DATA_CTL_VID_EN;
-	writel(val, d->regs + DSI_MCTL_MAIN_DATA_CTL);
 }
 
 static void mcde_dsi_start(struct mcde_dsi *d)
@@ -699,6 +694,14 @@ static void mcde_dsi_start(struct mcde_dsi *d)
 static void mcde_dsi_bridge_enable(struct drm_bridge *bridge)
 {
 	struct mcde_dsi *d = bridge_to_mcde_dsi(bridge);
+	u32 val;
+
+	if (d->mdsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
+		/* Enable video mode */
+		val = readl(d->regs + DSI_MCTL_MAIN_DATA_CTL);
+		val |= DSI_MCTL_MAIN_DATA_CTL_VID_EN;
+		writel(val, d->regs + DSI_MCTL_MAIN_DATA_CTL);
+	}
 
 	dev_info(d->dev, "enable DSI master\n");
 };
-- 
2.23.0

