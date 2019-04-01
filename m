Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC24C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4C62084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mreDX7Z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfDAR7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:59:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37919 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731067AbfDARSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:18:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so4898313pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FwO/jDHDC0Ih7P0JglUjIP9FDc3AOf9qDgJIWXGCK7g=;
        b=mreDX7Z65nkxGWJLVlsYOQBiVbZAl7CTxx2DLguTXxMbsbnzBcm7Fz9mRcq3Z93xaf
         PHtmpl3gh5H9v0CyqJ3YV4PuIoOWx8mBUe/P/Z+7P5BqZkNDlmUnKHq/feULbm1lVLPJ
         WcBNapWip1/O2y6fqpzL3X/jFihRReorI5SKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FwO/jDHDC0Ih7P0JglUjIP9FDc3AOf9qDgJIWXGCK7g=;
        b=PJKGDlyOVIcxXcjWzXjpSOrmg7hMbHStuzxHH4o75Rg4J/O6w6WxtWC0dCcBqsRAS/
         JFK6Y4CJbICIaik3px0PI/q3MfRB9K63VBOQq8StxVJmV1f0H7r7ZpFICsWrehohPsqm
         /TaDvgBs9Ru+CYC3exEiChbXWBSRqEGxGEt1iBAz4tS+keq8z5ALfQBhH70NeMZR8zZY
         ybO4I/kyZyqOHisJ03v4xuy/27HnoYXK9RViU+5pT43oPbhuWT9UlwvYCFmpZbL6YLZd
         FQL2XbvDFiDnLcKykjCRH/5erNlW1qe9HLWMpU4vtfVuH/DQMW/FDEvdqxDMPMwuGRdx
         KUUw==
X-Gm-Message-State: APjAAAXyGNxUXsdaq5OeNdITFtLbU8JCvuoLCZ7dDnJrgOxzS2mqqRUm
        0Mc/LfalINFhlBQEcUNqn48TSQ==
X-Google-Smtp-Source: APXvYqxliGhmmm3S7XUc7qRSL8b+dkWlmU9UvKgIxWWF1EFr0muoV/R9ZUpW3OhnJsCUbAW9URE/+w==
X-Received: by 2002:a62:19c3:: with SMTP id 186mr62668508pfz.172.1554139079862;
        Mon, 01 Apr 2019 10:17:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y12sm31370112pgq.64.2019.04.01.10.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 10:17:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>
Cc:     linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        =?UTF-8?q?Enric=20Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 6/7] ARM: dts: rockchip: Specify rk3288-veyron-chromebook's display timings
Date:   Mon,  1 Apr 2019 10:17:23 -0700
Message-Id: <20190401171724.215780-7-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190401171724.215780-1-dianders@chromium.org>
References: <20190401171724.215780-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's document the display timings that most veyron chromebooks (like
jaq, jerry, mighty, speedy) have been using out in the field.  This
uses the standard blankings but a slightly slower clock rate, thus
getting a refresh rate 58.3 Hz.

NOTE: this won't really do anything except cause DRM to properly
report the refresh rate since vop_crtc_mode_fixup() was rounding the
pixel clock to 74.25 MHz anyway.  Apparently the adjusted rate isn't
exposed to userspace so it's important that the rate we're trying to
achieve is mostly right.

For the downstream kernel change related to this see See
https://crrev.com/c/324558.

NOTE: minnie uses a different panel will be fixed up in a future
patch, so for now we'll just delete the panel timings there.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5:
- It's not just jerry, it's most rk3288 Chromebooks (Heiko)

Changes in v4:
- rk3288-veyron-jerry patch new for v4.

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/rk3288-veyron-minnie.dts      |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index b54746df3661..0b1789b50c21 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -76,6 +76,20 @@
 		power-supply = <&vcc33_lcd>;
 		backlight = <&backlight>;
 
+		panel-timing {
+			clock-frequency = <74250000>;
+			hactive = <1366>;
+			hfront-porch = <136>;
+			hback-porch = <60>;
+			hsync-len = <30>;
+			hsync-active = <0>;
+			vactive = <768>;
+			vfront-porch = <8>;
+			vback-porch = <12>;
+			vsync-len = <12>;
+			vsync-active = <0>;
+		};
+
 		ports {
 			panel_in: port {
 				panel_in_edp: endpoint {
diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index f95d0c5fcf71..ca7512ade222 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -142,6 +142,8 @@
 &panel {
 	compatible = "auo,b101ean01", "simple-panel";
 	power-supply= <&panel_regulator>;
+
+	/delete-node/ panel-timing;
 };
 
 &rk808 {
-- 
2.21.0.392.gf8f6787159e-goog

