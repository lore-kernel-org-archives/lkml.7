Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0C1C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6183F20717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b1AS6CxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfLRPq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:46:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56195 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLRPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:46:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so2335179wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 07:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=spj22Kg+dWdyjSNSykFKUU/hDbOBLgtGt0g5yBFUVac=;
        b=b1AS6CxX5nI9P5gV5fLOMWoiZOTh5Yc72/xDMj78dPgssSaHOIuMro9cBLupbrf38J
         rcIq5bCgjTB1DQ9VgunE61IWYLlghOS/mVI6myWrU7FS+g7eVlm4STFVP1Y17B/4qsx/
         gAaROAjMzchyX2CPaGs+Z8blB0Qeo7Pb6zpRvaw9mOkO2G8A14CaKwNPu3c9aI40aLd5
         LIrFCGYIf6/l9IIsrbY2ZfuXGJvbT6GHi3LhLPu0ez9wk4uA7bV9u6FCTbtaM0SsePAh
         /iSafvh6DlYtB3B+L+EO9IG/BuHtoEAoYgd2Syc+DGLOPxOfde8OhBXHZhDABSf5Lwv6
         fZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spj22Kg+dWdyjSNSykFKUU/hDbOBLgtGt0g5yBFUVac=;
        b=Y5rWhEp8yOZTsbPQu4qFWkYtrLhqH+UprwoEYZOsdcAnQaUxoaxgpuXZUB1GdXv265
         kdwHgPWTFe1yShVgW1lO/QHfDsz5HYBT4xQ9xTAnvlvReanI7t70tGcwX9Y6jD7kVMeL
         KfbCyB/4h/jlFZ1GVotBAgx0YJvAEmu0lxIrboP3hxxWs3n0L6QcCy75ivqE3SkPyqa9
         /N099DM1VPM5KSXxaURW+8AJjmGfFsnfyQwmlkO7OXrgitUUofVEWNCpOYK1tqiyhHNs
         kd7rBTyaoayOXKeJNfAsInHmDOgFZupfHMnUvCyCrOLciiKZsXNsisN26wCDF8nvTmjX
         12BQ==
X-Gm-Message-State: APjAAAXqCofl9IhVfI9WasBmoxXlilX7vYZa2TNlBOke6uLTAkHJbxFW
        gkn6y40NszFrZ8NWz8zmO9i5PA==
X-Google-Smtp-Source: APXvYqw+pDIQ46qs/l7D3sSMhzpMvSIoK6+jQ8CQGtK8rR4qHoA0VQKD5aEh0qODdimQC3lB1EeJZw==
X-Received: by 2002:a1c:ded6:: with SMTP id v205mr4006272wmg.86.1576684007437;
        Wed, 18 Dec 2019 07:46:47 -0800 (PST)
Received: from bender.baylibre.local (lfbn-nic-1-505-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id x1sm2891492wru.50.2019.12.18.07.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 07:46:46 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] drm/meson: dw-hdmi: stop enforcing input_bus_format
Date:   Wed, 18 Dec 2019 16:46:34 +0100
Message-Id: <20191218154637.17509-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191218154637.17509-1-narmstrong@baylibre.com>
References: <20191218154637.17509-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow using formats from negotiation, stop enforcing input_bus_format
in the private dw-plat-data struct.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 8729575777d5..69926d5d8756 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -1032,7 +1032,6 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	dw_plat_data->phy_ops = &meson_dw_hdmi_phy_ops;
 	dw_plat_data->phy_name = "meson_dw_hdmi_phy";
 	dw_plat_data->phy_data = meson_dw_hdmi;
-	dw_plat_data->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
 	dw_plat_data->input_bus_encoding = V4L2_YCBCR_ENC_709;
 
 	if (dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
-- 
2.22.0

