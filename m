Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F4DC4360D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963E821D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mZdbN7PU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfIYW6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:58:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35293 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbfIYW6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:58:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id y10so346420plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 15:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a8l1h42oL5P23xHtbf5VYzA5ZkeKmzbH6tKjUBSBl+E=;
        b=mZdbN7PU15gvrkxboOz4EvcivX/ux1fVAqsJCq6EgzispzgwuhEsAlz2ZHeBFsy6AF
         nFJVLzl+LytoIKO4/YdZ1xWZH80l5SKrIIa2WxgJD+p+QXWSPvNvoGV2JOLti0PYNVZd
         IpeblEXMS3gfQeMUmm75yJ/NL7jP6a/9DNtx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a8l1h42oL5P23xHtbf5VYzA5ZkeKmzbH6tKjUBSBl+E=;
        b=tzcIeF7U/PfqhtdD2c4PRMPPznTz9kUou78ZGiXRetg/s8FylcKQnpTFGRdUhaX+fp
         4aNfJ4e/s691rYLI42c/Rg+iiW8sQ/LBVpzm7nORcMEQY4OeDUnntv8FgmRqcbK3yY3a
         5bPgREmAoxTL/t8iZGtP4BtYibd2JDzpTG7zi3n8ghJ2yNSGzY1uFaPYhiZ18xISMZkW
         65q6D/eLztp6wFbNuc724ljmZ8TUF7w3e72KfhP/AHG/lA0isdCbYzhTbQbpC4a8Thy4
         wxMOrDObFbAXp3TD6VxdXdfbsnRQFb01StELUeFZSDX4aQjWxL0BcIily6bfp0Ou0QPh
         c8Sg==
X-Gm-Message-State: APjAAAUzI32YHeBnUAVOQOW/TdcJRCDrLJfHL8f33MTuzb3boFewP7fz
        ROf4bLuZKaLZV26XgRN8WtMyxzEAFDI=
X-Google-Smtp-Source: APXvYqzDNs3vEprSzaoe6gRCguGllX+tDvFlstkCquRzzh0Piq6427vQeaol87qaa+E6o95eLxbqbg==
X-Received: by 2002:a17:902:b68e:: with SMTP id c14mr539964pls.306.1569452325220;
        Wed, 25 Sep 2019 15:58:45 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id j24sm76185pff.71.2019.09.25.15.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 15:58:44 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v8 4/4] drm/mtk: add panel orientation property
Date:   Wed, 25 Sep 2019 15:58:33 -0700
Message-Id: <20190925225833.7310-5-dbasehore@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190925225833.7310-1-dbasehore@chromium.org>
References: <20190925225833.7310-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This inits the panel orientation property for the mediatek dsi driver
if the panel orientation (connector.display_info.panel_orientation) is
not DRM_MODE_PANEL_ORIENTATION_UNKNOWN.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 224afb666881..2936932344eb 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -792,10 +792,18 @@ static int mtk_dsi_create_connector(struct drm_device *drm, struct mtk_dsi *dsi)
 			DRM_ERROR("Failed to attach panel to drm\n");
 			goto err_connector_cleanup;
 		}
+
+		ret = drm_connector_init_panel_orientation_property(&dsi->conn);
+		if (ret) {
+			DRM_ERROR("Failed to init panel orientation\n");
+			goto err_panel_detach;
+		}
 	}
 
 	return 0;
 
+err_panel_detach:
+	drm_panel_detach(dsi->panel);
 err_connector_cleanup:
 	drm_connector_cleanup(&dsi->conn);
 	return ret;
-- 
2.23.0.351.gc4317032e6-goog

