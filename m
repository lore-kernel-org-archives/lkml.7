Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F29C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C752173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f8RsE3S/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390910AbfFKAXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 20:23:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46714 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390825AbfFKAXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:23:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so6219998pfy.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 17:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8dK47yPhynvSehskkuhR0uoKpp2uUP0x/D6+OPbrUg=;
        b=f8RsE3S/kfdDH6v5icBqkYxG44gp7sMpthCwyaqeVVv/htgQ5HpcDI6Wv0iU/zWNcb
         oatVGJ4axZtIjvktwE9gYtDNHp4sChejjwJoasvq2NwX71M8H6s0JQby/OGPhBngYau6
         PLZre9cxMKoOn5+neuim6KE3BHgm+44DhuGtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8dK47yPhynvSehskkuhR0uoKpp2uUP0x/D6+OPbrUg=;
        b=FOZVgj3p5TuvX3rEk+X3f4yfqfg4csM4uUfw668n1aFEzf2qOEQU9SLCYB6g09kjSW
         pKWmrCPIezFDf7I0rvPIfNhB0/TF9zSxiUUbm3st7oMTrlODbnjBpdI3B2qcdzruHOwR
         T+97wO7uKc0Mmd1oDu3Tzpat+S0r8jPYtGaGbTsKtMV2HPFYYuKFUV9dt1GdzXGxUfsG
         QWHUw0xWU1Ik1MqRJqs0G6EBQwAsSzcNvmQ6sxTewkaIBSXft1iWdrjwYM6qQg9zOrHZ
         +9BPQlyWvW9xtis2Se4Qbl3zwp8CVbKRHO7MEe1oQ4fhDJfZ7RR3e3WnlPX7t2cYt5BI
         XOBw==
X-Gm-Message-State: APjAAAVbhr/H4aDb+UkngT9d1I5dbuHhGP/Y6qHQUfd0Ut5AS7LDFTIm
        JjyTSLEA8TJv3iXvKehi/2D09wAd5m8=
X-Google-Smtp-Source: APXvYqxgskg5maq+JeiMbuvV7nLdRyi6nn4eQ55SV9Rs1d3bhqZcPjSw0Twk7BzvTbHKQzN5RyBSvg==
X-Received: by 2002:a63:8249:: with SMTP id w70mr15859377pgd.33.1560212590903;
        Mon, 10 Jun 2019 17:23:10 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id t4sm540317pjq.19.2019.06.10.17.23.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 17:23:10 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        thierry.reding@gmail.com, sam@ravnborg.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, ck.hu@mediatek.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 5/5] drm/mtk: add panel orientation property
Date:   Mon, 10 Jun 2019 17:22:56 -0700
Message-Id: <20190611002256.186969-6-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190611002256.186969-1-dbasehore@chromium.org>
References: <20190611002256.186969-1-dbasehore@chromium.org>
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
2.22.0.rc2.383.gf4fbbf30c2-goog

