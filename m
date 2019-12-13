Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A865C00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E184C24125
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fz4y2Ke4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfLMXqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:46:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38227 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfLMXqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:46:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so2291865pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 15:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hBWP2/QJL0y05bggOLUlEYkrP/w5ugSFmgOaMEwZL50=;
        b=Fz4y2Ke44kCSsjzp+a34ad3A68+TnKJKWD4UJoHpxQ3EPHdetc8nwEGtkef+RvhiQT
         /0RpPlwnBBSL4CMm358u9SBm7lHGQl+OPgpswKiTIrkQQO3ejRMFLLZCGR76bDdIHMq+
         tXv1nyQTQ+fkJCAZYl2Ety2Fv61bHqb15i3aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hBWP2/QJL0y05bggOLUlEYkrP/w5ugSFmgOaMEwZL50=;
        b=cMIAmUiH2wXgsqLLAEQ8dOuHWH0kI+MQ5FxW+0grz/OPRLjZeKeKfPE27Wd4a6Tum6
         tl0OfrYyNMMN/IY6DIHCmWeYss50OIExeC5s87AFiHuurUGAnUH3sSqHg+52cnCorLDu
         AJ0r0pmKgPWXLFXqNwjgTHXjE5JjDIwKX40QrzZ6/NvDFplww0+NZNcf32XcPfPMLdSR
         +KLk7bFmX/W2DC2+Nv+eTSexeTX6rX42VfZT6eojyQoDqS5DytZMg8/qlj2OYXFb0atZ
         vbyxJB4dlu/KaAJy+ZhKYxxT31g1m6RMxLVSewliekEAqDqJzZ/a2RlyYgxOxjmM5AU5
         FIrg==
X-Gm-Message-State: APjAAAXCrBJxohOsCzvusaTpi9X2eBhstV+Uvdz2mF21U6uWuTNILty+
        45rRMFN2vl7TBQ8Jqu5FNBTSpw==
X-Google-Smtp-Source: APXvYqw1TNBWKyOrLHCw7vDkyzfBgewAvNgShojcv9sMhHxdOwVu4YowVmdOkduBPxrqAMLThPoXNQ==
X-Received: by 2002:a63:9d85:: with SMTP id i127mr2328536pgd.186.1576280768713;
        Fri, 13 Dec 2019 15:46:08 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id z19sm12282905pfn.49.2019.12.13.15.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:46:08 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        seanpaul@chromium.org, bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 4/9] drm/bridge: ti-sn65dsi86: Config number of DP lanes Mo' Betta
Date:   Fri, 13 Dec 2019 15:45:25 -0800
Message-Id: <20191213154448.4.If3e2d0493e7b6e8b510ea90d8724ff760379b3ba@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191213234530.145963-1-dianders@chromium.org>
References: <20191213234530.145963-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver used to say that the value to program into bridge register
0x93 was dp_lanes - 1.  Looking at the datasheet for the bridge, this
is wrong.  The data sheet says:
* 1 = 1 lane
* 2 = 2 lanes
* 3 = 4 lanes

A more proper way to express this encoding is min(dp_lanes, 3).

At the moment this change has zero effect because we've hardcoded the
number of DP lanes to 4.  ...and (4 - 1) == min(4, 3).  How fortunate!
...but soon we'll stop hardcoding the number of lanes.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index ab644baaf90c..d55d19759796 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -523,7 +523,7 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 			   CHA_DSI_LANES_MASK, val);
 
 	/* DP lane config */
-	val = DP_NUM_LANES(pdata->dp_lanes - 1);
+	val = DP_NUM_LANES(min(pdata->dp_lanes, 3));
 	regmap_update_bits(pdata->regmap, SN_SSC_CONFIG_REG, DP_NUM_LANES_MASK,
 			   val);
 
-- 
2.24.1.735.g03f4e72817-goog

