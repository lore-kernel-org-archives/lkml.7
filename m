Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A815CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD6D21835
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IWzkIwFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLRAsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:48:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44906 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfLRAsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:48:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so242904pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HdCS8WPWMq5NhE2qOG5oGSoq/xhaDa7hE5ig0oDHXKQ=;
        b=IWzkIwFn/N2qemF7XknGGB63xEuypwoPe7OQCDpzbY720oDjcNo/L8sFGnfm4pYy8u
         NjrgByC4PZqz++rdn/3Fht2IF8XDWlRD4rGxKzS0ImYbL8KvCLteAPepLnbCXT21nBGX
         BW/ic5IYdr01m83xtjR9858CmwD63j4BBjQ3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HdCS8WPWMq5NhE2qOG5oGSoq/xhaDa7hE5ig0oDHXKQ=;
        b=fkhoAvvBL25G8/39VVT59EwJMTCfU9rMqw3T3DEQpbiLQT9HQ53FNaLtCrDLgN9xLq
         bTSjRosICGjfUc+JXyIyrqIZ87SWp/+HAUOKHtr14/YTRknbZK94Csnt4GyxB0KZ+27Z
         bwXsKK0bRnA6QwYvyeVSEhCaaLP3Blt6un2U3BjwSMbqxYGNxhy1jgUfqe6S599BD3qC
         Uvue2MyR/KpAw1a/1zXczojXHClGWHhFrf3u1xZBlvT+ZdJltBlgF4B/RJ2eH3wBX7k+
         wkN0QOw3ahlZYBQyh+snvOw5XSfr1y8v+bVESt88O8bCbt4G8A6s346DYkXolF3Gjto+
         KdcQ==
X-Gm-Message-State: APjAAAXsx5lPolFB+dkjWF3TA5JxwWD7TR0GZi7mO0l+oDixwSXL8mZk
        kZ/QkP98aSXf/VXHbDPOHoUt3A==
X-Google-Smtp-Source: APXvYqz/L5SG9C+m5GHf3yf2c+EACxBFqLOJj6lb0gDRKFwT2goEQNvhE4pWBxQP0mNa0BW7WB2I8A==
X-Received: by 2002:a65:50c6:: with SMTP id s6mr252796pgp.365.1576630110806;
        Tue, 17 Dec 2019 16:48:30 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id v72sm139885pjb.25.2019.12.17.16.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:48:30 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, seanpaul@chromium.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 4/9] drm/bridge: ti-sn65dsi86: Config number of DP lanes Mo' Betta
Date:   Tue, 17 Dec 2019 16:47:36 -0800
Message-Id: <20191217164702.v2.4.If3e2d0493e7b6e8b510ea90d8724ff760379b3ba@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191218004741.102067-1-dianders@chromium.org>
References: <20191218004741.102067-1-dianders@chromium.org>
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
Tested-by: Rob Clark <robdclark@gmail.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
---

Changes in v2: None

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

