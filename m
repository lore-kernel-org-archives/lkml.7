Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DEEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D24220717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fDwnwLMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLRPqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:46:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37599 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfLRPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:46:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so2427319wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 07:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HS90VjGTEgPLwoS07O26nuJB7gxxS9CD1cnSI1IU66I=;
        b=fDwnwLMtw3uOHsVJkA+Sxz35a/DRK14VjnfBHoxmw+sub14JCsrV3biDAx5fbrQ30n
         bzbtOHe5126TPWkHhYQKOWlwX38XHenTKd7WCgPbXfmj2geKxFlou39QgO5VHTLUbA9e
         70Si2uXmHxGHZEC9XAZZT04cy2SjuOAJrJfQb+gR3/LeMRF8RLdd7lJUNeiiPwqIYaS0
         GQ3e3jiqyoH3xcO12avGq3Yt5/6OemFDqKKrxovlc2roINAJetJ0o6urhqLfpX/oBSup
         4TF6u8afr1873ygcxCRYuey9XoBBSa25fpoijdK8HNqoXDcBjYGX8S2wgzYNT5Rikw4n
         RYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HS90VjGTEgPLwoS07O26nuJB7gxxS9CD1cnSI1IU66I=;
        b=Vu3MWGXug/sssX5w+qT30YjKJ26DLoWCaEXk383Rnmvioo34SCmbcZ7yl8DD05MEXv
         BvTTqSqHRQEYR6uH4oEVGFCL5UVDfZaWgc7OfZR5Xpej6yaGYrnPiXRaITthD1qWrkF3
         ZTGCxXP0e5YQxFd7O/lBghk3qsRTrZGeptJcYNNW/lX/Tsp9TQICB7kt2Ie3NAV1NEwE
         qOxt4lLJSVoRlMYdEpksTYVWQ1oxm3FvfVfoNBgTv02jgXEvZ6m7zWz7SMiAB2u/gM8B
         4VuO9UmCAysGxf6DoADcOCjVCXWL47uEsL+IeIw0INAxEfaNzsnEJcJeN+pby9UJlN5E
         fwDA==
X-Gm-Message-State: APjAAAW2fsEpcjg1g7E13G7cBcjfHAVouD0VQhG+8/DJR2IC18chBK+n
        H58Ut4/nb+kMFYK/jhLQX98+Ig==
X-Google-Smtp-Source: APXvYqzMxHZU54rjVdvdQilWUCjDI7zSWqhv9fM1JYbrPdMsusPqlZYyBJj6ngYbYwqGl/RqMDtDfw==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr4119475wmb.150.1576684004437;
        Wed, 18 Dec 2019 07:46:44 -0800 (PST)
Received: from bender.baylibre.local (lfbn-nic-1-505-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id x1sm2891492wru.50.2019.12.18.07.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 07:46:43 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/10] drm/bridge: synopsys: dw-hdmi: allow ycbcr420 modes for >= 0x200a
Date:   Wed, 18 Dec 2019 16:46:31 +0100
Message-Id: <20191218154637.17509-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191218154637.17509-1-narmstrong@baylibre.com>
References: <20191218154637.17509-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the DW-HDMI Controller supports the HDMI2.0 modes, enable support
for these modes in the connector if the platform supports them.
We limit these modes to DW-HDMI IP version >= 0x200a which
are designed to support HDMI2.0 display modes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
 include/drm/bridge/dw_hdmi.h              | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 8c1f7e5e6698..bb87b87c752e 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3189,6 +3189,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	hdmi->bridge.of_node = pdev->dev.of_node;
 #endif
 
+	if (hdmi->version >= 0x200a)
+		hdmi->connector.ycbcr_420_allowed =
+			hdmi->plat_data->ycbcr_420_allowed;
+	else
+		hdmi->connector.ycbcr_420_allowed = false;
+
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.parent = dev;
 	pdevinfo.id = PLATFORM_DEVID_AUTO;
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index fbf3812c4326..19e30cdd35bf 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -127,6 +127,7 @@ struct dw_hdmi_plat_data {
 	unsigned long input_bus_format;
 	unsigned long input_bus_encoding;
 	bool use_drm_infoframe;
+	bool ycbcr_420_allowed;
 
 	/* Vendor PHY support */
 	const struct dw_hdmi_phy_ops *phy_ops;
-- 
2.22.0

