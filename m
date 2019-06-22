Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89DFC4646C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 03:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD0B2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 03:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="niGTS4FI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfFVDlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 23:41:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36841 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfFVDlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 23:41:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so4538494pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 20:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4i2YSPugXI0nrqp33kMy8Y944Y94lb5ecy4lCGMxEsQ=;
        b=niGTS4FI/C687+sa3kKLIMPE58L7G7E5nctX9I6CtYN8GELqO1dmYNy3W+bytP3lM2
         7jJLiBQxNMTmWuycDio83VjqRBYXENo40QGJV77eJIpEvs05teclhe/XR8ex/VpLgaDx
         lNQopJYpNYfOR+08BHj2q1c/NuSF1p8+Ua8Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4i2YSPugXI0nrqp33kMy8Y944Y94lb5ecy4lCGMxEsQ=;
        b=H3UkNvq8OnnmDGJZq/JUBgTipsh0Hs9wfqtmULoPcfv8lzG5MZV3lJyuRVEq3ZNjOw
         8UhpD8nSTO/52pLJHDuzufiufX1KqW5nv9LSFUEx7Ip/K3efr0XIk/Ptubp0bQfwzpw7
         VU3WSPpBggvOmaFXcz2O+Kb8aOOtKhK2xk+0hMfyBSOTz5e8TDffCWQAjj9g4fqpBiMp
         8DC+sLioJq2VxLh3mOBNqe67gFIyOz+Q7Gj3K0KIsP04umBBkeQ9t5YY6tNFrvwcajwG
         MPVtokzbRax9p5ShTIiFC1BoLUbfjWHF+uy+UMOZ1fxDE0oF8rdNwJAyNBs3v0kkSIWO
         awAw==
X-Gm-Message-State: APjAAAUHZTS//ukLyTF9vYDsZAvoZAq+S9HJPL2pnCNMoPlC10griWqe
        IZAfZ682ZD7HgHB+mOyXjr+E2pY916s=
X-Google-Smtp-Source: APXvYqzslQDI58gAtC55+8w+gQS8zY9PascQUVg5lYBeYsEo3d9ImRfo5a3yRY89wZxYrkoWlqCAMQ==
X-Received: by 2002:a17:90b:d8f:: with SMTP id bg15mr10778249pjb.65.1561174875712;
        Fri, 21 Jun 2019 20:41:15 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id u128sm4756688pfu.26.2019.06.21.20.41.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 20:41:15 -0700 (PDT)
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
Date:   Fri, 21 Jun 2019 20:41:05 -0700
Message-Id: <20190622034105.188454-5-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190622034105.188454-1-dbasehore@chromium.org>
References: <20190622034105.188454-1-dbasehore@chromium.org>
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

