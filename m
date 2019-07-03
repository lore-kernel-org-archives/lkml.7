Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B658C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F769218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KoFbuYFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfGCXCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 19:02:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41560 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfGCXCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 19:02:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id q4so1931047pgj.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 16:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vxC6cpJeD3A10tWWsNE37FjIALjzLREnlwwa6KDygFo=;
        b=KoFbuYFaOMgz+CA9HtkLNTvAr+pabLlsPrLFWh8/CDrvglaCWGGLw4Pnxd6skHFk9D
         q3Vow7aYTiXXFCeiDRL8qO677+a7piMs8y1uZhje39FRkVgbfJ0BDZ+RweMNQAxf5gWi
         dXTZ2iVaBDwYMJGt3iTUEcM1C9Zfdf2BI1S3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxC6cpJeD3A10tWWsNE37FjIALjzLREnlwwa6KDygFo=;
        b=l8Ym0uIO7PmQHAfL2B1ESghx6+h26d1cQrQ6P4gtOSaS4HE3Opuk7q9Oh26w7IcpvP
         h5LmYHoDWSBJtkahhYXWuzVS0WIqR1vEUle2Lga1ePDGZ0Owz1WpGYHASuOo3ETK25Uo
         W1PSBudXO9oGsb12iG7+6f8hr5RbFkHJkEyfRqCQLyo2QfMU2CpmnsdTSFbsntoTk2os
         nzA+K6OsvryMToLsn3O2bwpoKNbjBj+yk+gfYVcOy5U00fUwoZ6kvx99AVenW/nEkKqY
         NQP92glkC1BPv5q/yV9mR5LSta89Fyt0VaG89fK2KfkAK5qLGGX+QRdIVaCL6pp/t3/B
         uVWA==
X-Gm-Message-State: APjAAAVyFWMOQob8HKgk8D2t/Ecp4i21ZOvAI14iqJ1P+o2bq7nBBRAP
        zo/aLK6XUKs4Rar+ldbXDmCFg140NjU=
X-Google-Smtp-Source: APXvYqyG7F1sqItbURwJvHhS/2DarvFHk2VbgTA5dTpR7guaFyZ6mbPUxyay/cbBh1DPeX4KcfiwJA==
X-Received: by 2002:a17:90a:cf8f:: with SMTP id i15mr14955387pju.110.1562194939953;
        Wed, 03 Jul 2019 16:02:19 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id t8sm4245171pfq.31.2019.07.03.16.02.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 16:02:19 -0700 (PDT)
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
Subject: [PATCH v5 4/4] drm/mtk: add panel orientation property
Date:   Wed,  3 Jul 2019 16:02:10 -0700
Message-Id: <20190703230210.85342-5-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190703230210.85342-1-dbasehore@chromium.org>
References: <20190703230210.85342-1-dbasehore@chromium.org>
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

