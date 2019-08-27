Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7EAC41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9292121883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MTLfRB14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbfH0IOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:14:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55225 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfH0IOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:14:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so2051024wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vESqQdKKmtjJu0iF9bZQdLNZv1Sk8fyWyDEwOtz2JiU=;
        b=MTLfRB14y+Jjwbv24sKyqUJ2bNmWeIKurBYz/VL9f2aDLLCwuvDlny5d9hxfbjVCkw
         97dN0mB0D2XtfkKwbZ7DxuA//5S+FnGHZD0dHBsS6aXhepStpMj8+RQetHiWvhNJRNxK
         Xgwby2bxMPoETHjhng1TYYPoW1gceWkfmrFbsqIRIh/eQak0m+8d65qSMWj23WF3A7X2
         PTrkIW92lGHMd6NGkfxkHR4EpkhT5Lm7QLAfB51Qs0Pyq275LyepBiOteR3Ec9O58lSV
         dQ6lV/nk3DqPUUQeSt+LTtawdfDTkZDkbTsxamymatQZH6XIXtLDsbxjGPR1f9ZE713l
         yBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vESqQdKKmtjJu0iF9bZQdLNZv1Sk8fyWyDEwOtz2JiU=;
        b=ayvvqBHe/kJJRRoX1L34bjgLHn7/jLoy6kK6frZnsFaQyCATpZtZtJZcfw8kkSM4Bj
         XSCTGI/tLuS1QrKg63L8CSlVQZeAyKXP/jEMlpUYLKGN4I4M2zwktlDKI467VYs/vDc8
         BdN2Xi8/HPmznbN0ILef6cdUgCMonKrH+Lm0c/HR4Y/LjPT0/mmYngym4GJSqkFXucxR
         kIB9lRyal6E3bCk1AFUm3WiOr0BQo+5EXwmsr3qYPwbbY5sGtjrEDfCByymgvKgSayQ4
         YVzrZzn32SWkGuLfzm6ABvQessHv38HudN4v0SYdgp83U7G6NPxgv5dqQKVJxUJblndd
         2wtg==
X-Gm-Message-State: APjAAAUmgbjcTfVVDW/e2IKDm9qHhUv/gIiwvLZDn/NRcTmdCB9v0VW8
        B9/k6Kn381wDcxNQV+8Eqzjyvw==
X-Google-Smtp-Source: APXvYqxTGusXca11jahXo+oITqWlzpLMh6fmhYKtqYvBOkcJ/84U7plQRFYWEGH2K3ihPVh6YMaQ4g==
X-Received: by 2002:a7b:cd17:: with SMTP id f23mr27433268wmj.177.1566893671411;
        Tue, 27 Aug 2019 01:14:31 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f18sm11911792wrx.85.2019.08.27.01.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 01:14:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 4/8] drm/meson: dw-hdmi: stop enforcing input_bus_format
Date:   Tue, 27 Aug 2019 10:14:21 +0200
Message-Id: <20190827081425.15011-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827081425.15011-1-narmstrong@baylibre.com>
References: <20190827081425.15011-1-narmstrong@baylibre.com>
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
index 333583ef3ab9..9ae24cc5faa2 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -1007,7 +1007,6 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	dw_plat_data->phy_ops = &meson_dw_hdmi_phy_ops;
 	dw_plat_data->phy_name = "meson_dw_hdmi_phy";
 	dw_plat_data->phy_data = meson_dw_hdmi;
-	dw_plat_data->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
 	dw_plat_data->input_bus_encoding = V4L2_YCBCR_ENC_709;
 
 	platform_set_drvdata(pdev, meson_dw_hdmi);
-- 
2.22.0

