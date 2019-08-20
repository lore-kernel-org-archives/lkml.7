Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392C9C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF9922CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MsWPu6jF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfHTIln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:41:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35368 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbfHTIlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:41:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so1878348wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jE5m0TfqElnaXCkHBFVwFbXc+R1MiIYDmSAYCCl3YU4=;
        b=MsWPu6jFBtdd3leXvljR+mIFouGHkKizVhM8iGdY2lNx+9fBmeUAh5kwBxAy3psYXD
         eeZn/5cjiwstKXDAQa92bAYcvYQCHFf18N2M/Txqe/D4sKuiTYCcgAZUtKaSowmsKaPt
         mdVUi9N1+X4Bw+OSzcfc47lWHTtLHpqJH51wVdWfwpcZabcoDhkWzAhae7/d+B2R+bYh
         o3xGHXuJA58v4Rqd1CMi26soJy6n3bV8vfnYZXwvcSuU1Gl42OmbDRfYO+bARdnDAi8W
         TslFqrIQDT1Jfw/forC72E95oxJ5jC1DERORG4AU1pMNuB/EG66TBPnhAMV+1l4pvgZ9
         R1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jE5m0TfqElnaXCkHBFVwFbXc+R1MiIYDmSAYCCl3YU4=;
        b=lZ0JvEP5LePlzArgjEdlB15O5CHOLBSZP6nwsTBorBHWop28Q7T6YU+5+eomLHU24T
         91Vpg3ZnYzK09/v+O5PzsdjY8OhYyHrq1pvy0U3WfzoAwsOaUFfUbh1/k3xz3onCa0Lg
         1T28eLKjeOj7kAd+fKcEZXH3bR9g7i4KxcLbYZ089aBjgCsjd5voFbpbfmb8953j8e+v
         7TwcgN2DJPCfbSMh0mlF9f2nSs8zhcdfmsxBECouzasb99Ndm3b2DxUah1UoolKYkIEz
         SR0fyNnAGBToNZl7LgObCp21M0fl32HpHbMdVeQ7Qxt9G4Rkw3nKbxIsJywugC2jLRte
         pMVA==
X-Gm-Message-State: APjAAAXFmh31cnLG6ljL/yEYoBaUQsbtJ6CsQSNaVXnjou4YLnwj3Mpu
        Lgzg+hz+wPaoGcsbmOnlreSDhR4FakiOFw==
X-Google-Smtp-Source: APXvYqxz2QfYRtKrzranf4cVovpcdQcEZHLRNe8Ltpfp2/9EWb41HLsZFmalHz+UQINsNt8K92A/kQ==
X-Received: by 2002:a7b:c8cb:: with SMTP id f11mr24737137wml.138.1566290479876;
        Tue, 20 Aug 2019 01:41:19 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g2sm34275648wru.27.2019.08.20.01.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:41:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 06/11] drm/meson: dw-hdmi: stop enforcing input_bus_format
Date:   Tue, 20 Aug 2019 10:41:04 +0200
Message-Id: <20190820084109.24616-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820084109.24616-1-narmstrong@baylibre.com>
References: <20190820084109.24616-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow using formats from negociation, stop enforcing input_bus_format
in the private dw-plat-data struct.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 9a99d3920610..fb09592eba3e 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -975,7 +975,6 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	dw_plat_data->phy_ops = &meson_dw_hdmi_phy_ops;
 	dw_plat_data->phy_name = "meson_dw_hdmi_phy";
 	dw_plat_data->phy_data = meson_dw_hdmi;
-	dw_plat_data->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
 	dw_plat_data->input_bus_encoding = V4L2_YCBCR_ENC_709;
 
 	platform_set_drvdata(pdev, meson_dw_hdmi);
-- 
2.22.0

