Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87D1C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68FF2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CcUYJwRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfFKEEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 00:04:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32820 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389620AbfFKEEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:04:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so5661517pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 21:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8dK47yPhynvSehskkuhR0uoKpp2uUP0x/D6+OPbrUg=;
        b=CcUYJwRYFPcbjY4eu0n/t203Kb6yWjUPmTkt3aooyO0UUZofpy4cpboC6TwF076Ios
         ZWILIMTCOWl4KnH2TWGccw1JJqig6+YYtxMUTrG3nlZqucwadYAgNXi6pGreSG31TIXb
         RJFX+AUwh7s4gdYWU+Ew7z54dQtjsrzL7NH6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8dK47yPhynvSehskkuhR0uoKpp2uUP0x/D6+OPbrUg=;
        b=pAyoYoCfsVZb1Jxg6hgzCIoR5C+Q05h9wgCopkje6hO5KGxcZ2ABzgbZ1weHxXL5eN
         QI6BekDWny3341NmvA16xNrvGKEWpDyStelJXyV2u5IMHWwvA3EHpvyn0rmpqL3E6hVK
         ZmNj4SxSMlFySD28eDwXeBwn99YLlRLZtRVfv/fem7B/N34+G/Whq1MAe3aSxuSMqBho
         jZNu2P44HflOIEyW4xHi4zX1VB/5YU3Zjc8aDxWxHt2vqmdDECCWBVYbHS/w8/xGbjBw
         gZ7AWrT1ZrkSO2KKXZPOj3wxr/OF9fCDYaQXHWkJGwnbXJnfUCm0cvnVfAn3GkHNJijS
         kuAA==
X-Gm-Message-State: APjAAAWkg9/BPsFcmeaMmNAkg9c6ZcJeda+u2LdapntZbq6GDiWvJPA6
        pmFdTm8SkK7dMc3vagtciSXVxLbwYNA=
X-Google-Smtp-Source: APXvYqzfYIuckJzyOvuDvYV3JLxaoW5r0AK9O0deBBd8fMs6LODhYT7Aj2K7vKmQFzwpcjHKS1s46A==
X-Received: by 2002:aa7:804c:: with SMTP id y12mr76278547pfm.94.1560225841344;
        Mon, 10 Jun 2019 21:04:01 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id y133sm13301185pfb.28.2019.06.10.21.04.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 21:04:00 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 5/5] drm/mtk: add panel orientation property
Date:   Mon, 10 Jun 2019 21:03:50 -0700
Message-Id: <20190611040350.90064-6-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190611040350.90064-1-dbasehore@chromium.org>
References: <20190611040350.90064-1-dbasehore@chromium.org>
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

