Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13695C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D865B2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="NJdtoh3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfHOAtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:49:41 -0400
Received: from onstation.org ([52.200.56.107]:44344 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbfHOAtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:49:17 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 26AB63EA22;
        Thu, 15 Aug 2019 00:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1565830156;
        bh=d3q75pXkjIXM1QryEInKZPabWpuCo5QQR2U68bge2+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJdtoh3/ImfhdTmSEd85mj5KPu2ZKI0+UpUzJUTokWtV70S3liqeW3s4dbfky+wr4
         LolisNgSRIh+ji/BEC/+LNt4IZWePqwWkQ0lf99WfPMtT+plnIZnwpj94J+7JjQ06J
         WoLNwQj3TpHlok1OzDecQd2NzU7BUwa+XkPAjiD8=
From:   Brian Masney <masneyb@onstation.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, agross@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com, robdclark@gmail.com,
        sean@poorly.run
Cc:     airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, linus.walleij@linaro.org,
        enric.balletbo@collabora.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 08/11] drm/msm/hdmi: silence -EPROBE_DEFER warning
Date:   Wed, 14 Aug 2019 20:48:51 -0400
Message-Id: <20190815004854.19860-9-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815004854.19860-1-masneyb@onstation.org>
References: <20190815004854.19860-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence a warning message due to an -EPROBE_DEFER error to help cleanup
the system boot log.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index 1697e61f9c2f..8a38d4b95102 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -29,8 +29,12 @@ static int msm_hdmi_phy_resource_init(struct hdmi_phy *phy)
 		reg = devm_regulator_get(dev, cfg->reg_names[i]);
 		if (IS_ERR(reg)) {
 			ret = PTR_ERR(reg);
-			DRM_DEV_ERROR(dev, "failed to get phy regulator: %s (%d)\n",
-				cfg->reg_names[i], ret);
+			if (ret != -EPROBE_DEFER) {
+				DRM_DEV_ERROR(dev,
+					      "failed to get phy regulator: %s (%d)\n",
+					      cfg->reg_names[i], ret);
+			}
+
 			return ret;
 		}
 
-- 
2.21.0

