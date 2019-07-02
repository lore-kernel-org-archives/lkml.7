Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12520C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4843218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Io3Emwop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfGCAre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:47:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39808 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfGCAre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:47:34 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so210471pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4i2YSPugXI0nrqp33kMy8Y944Y94lb5ecy4lCGMxEsQ=;
        b=Io3EmwopeQFUFFj8MfEzOz6LKA/W7AncRHgVvChAu8QUpuD2E3VyZqA3FencbnOFjh
         2QFw9FLfiNtoaQSXDSpIrLmj9mPRkqNM1rG/RbcVTya+m+LG3+XUPQhtEIJJBTQunsuR
         e06bOaadoY8m6HPWLWiI4UJBNkFke7GWAqs9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4i2YSPugXI0nrqp33kMy8Y944Y94lb5ecy4lCGMxEsQ=;
        b=UWVs2kNzZEWgmtDytUY2CHDdtqR6I4iubwFQS1Gn99weQtyNYFZC2T2A7T9cGgh5jp
         cf/gKwlObvsebTz0zlRENBlElVg9uFiNIw5GnOH9Cv0zSDdNgTM0gw4VDBBjf1TW8JyJ
         SUG56qX5f3t69pQe8PkZDkUZbGuz2EArhD/c9N43KbCJOmOIbv/X3Y0h6QknlboN/yDz
         34tbcbDdoKf7XLAOmXhcavwVKJijwpQW+jti2ygwvRqusrAzZZP5wSzjRvKt3g/zlZIJ
         nRUEQ8/WhzOH/LID/CI3l3p6NBN7JivEhjgDogBVZRkWGp32WwUfecIrhZVCSQFr6zQ6
         JwaQ==
X-Gm-Message-State: APjAAAWVn3dkOndzoaR0RLLBP47aYzIeaARCPHsXU3VWfKpvf9sYsmZM
        Vorg5aNFnOZe37pr6TF+Zp+ZDd5m4Zw=
X-Google-Smtp-Source: APXvYqy+RvIO2JXddSoisK2cCLcCMjrjCtG7tr4jDoamQP7WMz2EiFnqn53/HRa3MYDHB3+s9NQu5Q==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr39458967plb.30.1562110987634;
        Tue, 02 Jul 2019 16:43:07 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id c26sm167611pfr.172.2019.07.02.16.43.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 16:43:07 -0700 (PDT)
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
Subject: [PATCH v4 4/4] drm/mtk: add panel orientation property
Date:   Tue,  2 Jul 2019 16:42:58 -0700
Message-Id: <20190702234258.136349-5-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190702234258.136349-1-dbasehore@chromium.org>
References: <20190702234258.136349-1-dbasehore@chromium.org>
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
index 4a0b9150a7bb..08ffdc7526dd 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -782,10 +782,18 @@ static int mtk_dsi_create_connector(struct drm_device *drm, struct mtk_dsi *dsi)
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

