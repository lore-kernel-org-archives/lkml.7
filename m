Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59752C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2745624650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A+IWB1dj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLRAsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:48:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42672 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfLRAs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:48:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so161715plk.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HDKxrm8qbiseZpINUS2THSIzKVnfxADUHOX9BkwXa5I=;
        b=A+IWB1djfknbsl81FdVJIHvTstwrlQveoEV3ZRtLIqL9M96weAyc/9CS8rLeLoAC5B
         fYlcX0PYn9ysXTaCLi6fk+98S8+ecs/drDbJW970V1yWKMPUN0ZHPrI9h7ShDvGboCEW
         V1JH6bjwiMHOPolwBAXheY8H6YHmYjYR4TtBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HDKxrm8qbiseZpINUS2THSIzKVnfxADUHOX9BkwXa5I=;
        b=nChd9zLMYyl+C5/iPXaGGm8HhuKXzPlDmmPR71CU1E4DO09KZ84kg0MV1jTDLkWOzl
         SeIG/muz+19C1dUipWBL6DVpMjFzFCLAZ/orxD3oUP4Og9Q9MWT96vwqPtnpZu2l6js+
         jFxvan9kdhFA4UURotXIzx3dbymz8UaLw813HVUyrUyj4N0Ou47IpSxfQjtxO/3qNpDV
         w8PD1tvXzvJzLHbDOD62fEbSWYL5ZCay6WybpGmshbvsapvnxHOpBOc/eKhovDrGNKbe
         Xwsb3F2DfZSTn714DXKbA26PWoACzBOraHYrgINMmZQUEdwWKk44l3xw1XluBNAi41n/
         BdiA==
X-Gm-Message-State: APjAAAWkQiPmIr4b4wzr4X9qjgAkXldVBca/2MSn+aY3Th7zhcZ8fJSs
        zkaBpdiW/JPGZTTZg9atxkJjCA==
X-Google-Smtp-Source: APXvYqwFC+Om/wChNdc7jcBbpixvq5sZ7+7TyGGtLM++d9zcZ8koIF0v49FeOn3pO25lrUxFDV4l9g==
X-Received: by 2002:a17:902:7e49:: with SMTP id a9mr1023302pln.230.1576630108115;
        Tue, 17 Dec 2019 16:48:28 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id v72sm139885pjb.25.2019.12.17.16.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:48:27 -0800 (PST)
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
Subject: [PATCH v2 2/9] drm/bridge: ti-sn65dsi86: zero is never greater than an unsigned int
Date:   Tue, 17 Dec 2019 16:47:34 -0800
Message-Id: <20191217164702.v2.2.Id445d0057bedcb0a190009e0706e9254c2fd48eb@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191218004741.102067-1-dianders@chromium.org>
References: <20191218004741.102067-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we iterate over ti_sn_bridge_dp_rate_lut, there's no reason to
start at index 0 which always contains the value 0.  0 is not a valid
link rate.

This change should have no real effect but is a small cleanup.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Rob Clark <robdclark@gmail.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
---

Changes in v2: None

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 2fb9370a76e6..7b596af265e4 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -458,7 +458,7 @@ static void ti_sn_bridge_set_dp_rate(struct ti_sn_bridge *pdata)
 	/* set DP data rate */
 	dp_rate_mhz = ((bit_rate_mhz / pdata->dsi->lanes) * DP_CLK_FUDGE_NUM) /
 							DP_CLK_FUDGE_DEN;
-	for (i = 0; i < ARRAY_SIZE(ti_sn_bridge_dp_rate_lut) - 1; i++)
+	for (i = 1; i < ARRAY_SIZE(ti_sn_bridge_dp_rate_lut) - 1; i++)
 		if (ti_sn_bridge_dp_rate_lut[i] > dp_rate_mhz)
 			break;
 
-- 
2.24.1.735.g03f4e72817-goog

