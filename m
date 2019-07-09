Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA67C73C60
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA1320693
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hgBbzEAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfGIW6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 18:58:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46963 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfGIW6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 18:58:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id c73so70982pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 15:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vxC6cpJeD3A10tWWsNE37FjIALjzLREnlwwa6KDygFo=;
        b=hgBbzEABxs7OXnFPXxgw+hBQbbosBbo3oIFVVUgack6wrAgD9EpA6j8IAnhPv/nmsg
         HxQtZQgSRAJ8j0VZ/P1GhFATwxMZrprisR1ZbqbxyGz1yw0FWE+j+Wn6tPvNW0oBsgaV
         TMI/Q62D/gi+qE7S4rjIAyrABuWOpGp/YcvbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxC6cpJeD3A10tWWsNE37FjIALjzLREnlwwa6KDygFo=;
        b=Df3/jp7Ec0N7SkX7BZ8pyPa4k/4t+RL04ZRlPkt/zX/T7ea5otBaMw/iMCQU63530K
         vVKeq0f0du0zCp4AMz8gOwhVdIgxqn68NszKE82lHR32X6Hi33yYUQU1oDlvB+DyhC0k
         08CzKlQHZCRSpRBDu0qwosqpm0Q/Ry08SW5cC4fzOIbA89FSXZJ8OJdm86RC21OyBnI7
         FdVTd0jdk9X7TerV56VM5JAiX+W20OWwOjI0QGvMxcPRXyEKm9TJtqBHbxdIHSx/ZczM
         ePmtpoJcZESH9IxJ7EkQrjcm+OlUtYTrPXF0ow3ZUk3lO6EzP1KRXb2dxlDr46Aq0w1g
         sdZA==
X-Gm-Message-State: APjAAAVTDa9EgRHoaJW7qPB7OiAm1/OWE9DvUZNm4yHwbuM+TG5cV/Oi
        Jr3w+SwY4Bwcl88ydro5iAFQ3vE5bFc=
X-Google-Smtp-Source: APXvYqzEJUghZ7BR1gJ+atCuB5+tVeanvCWxZCyfJoN8hz0hJTeLI9RJdRfEe2CX2edCyU0wh4hH1w==
X-Received: by 2002:a17:90a:37e9:: with SMTP id v96mr2817103pjb.10.1562713130418;
        Tue, 09 Jul 2019 15:58:50 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id 201sm152939pfz.24.2019.07.09.15.58.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 15:58:49 -0700 (PDT)
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
Subject: [PATCH v6 4/4] drm/mtk: add panel orientation property
Date:   Tue,  9 Jul 2019 15:58:40 -0700
Message-Id: <20190709225840.144038-5-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190709225840.144038-1-dbasehore@chromium.org>
References: <20190709225840.144038-1-dbasehore@chromium.org>
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
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b91c4616644a..2920458ae2fb 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -790,10 +790,18 @@ static int mtk_dsi_create_connector(struct drm_device *drm, struct mtk_dsi *dsi)
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
2.22.0.410.gd8fdbe21b5-goog

