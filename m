Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D663C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D428206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J5dDv2C/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfC1RSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:18:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44414 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfC1RSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:18:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so5528677pfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ZYljoQT7r56q7Tny0+lw7nyShUHc+6HtAil+X2f22M=;
        b=J5dDv2C/IsLvgq0R2c6mRd3DgFJ9/x4/bzXxI6HTiLrcHnyT7WCjrgXxS6s3mqvYQn
         QZMfUOIVvTwRoEtSVUam5mPFkkOnU3QKQ2bm3wp8C3IWyh9Ll+JYAWuYPpXBDhvZJ6WE
         Tj3fJyqF0R8fe60H59+emYcXytDsYfGJvjZ5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ZYljoQT7r56q7Tny0+lw7nyShUHc+6HtAil+X2f22M=;
        b=d1NPbk+Z7t2Vwr5UkM7QZqzVOg/5FGauprzycsg3h5GNKY1hnWN2qAarZvR8Fzgxuy
         rWfr1BKKyksTdhfXap+8ChDzqZh0iGl7z+skbyKKZ0187K6VNeVQ75lzULvuIGFjThJM
         hKkGKoq4+kWy5hqAM6ULTAPtfWsQvf7D2KGuiCP+euFrdrLVLgl/p819y6o7iJGD0L8K
         oTuEshKYEEiyDbazlrym0P/mXx7+32R7ZltcV+Z5QtE8MmAtaGm/ia64lsEnvGFpHlW0
         8TaJKKkJFQZoU/JBHWW0fKzcbF8h4HykWLwEEGCgkPlW8SwTjEfp3VL6OT4aCGbX2doj
         473A==
X-Gm-Message-State: APjAAAWAQbgA0hj7V54UYiyLzdzYKsH6Uk5ha5qkLskkSJid+Z+ttQ8W
        ka8eTZmqHvFqIu4agOvLgy2S2Q==
X-Google-Smtp-Source: APXvYqxf6fx61pSdlisSBsdNvqz/BSOMo3J7lRV4ilP3yWjGujrBqUv+XHcmnYlnp/902LC3MvQrNA==
X-Received: by 2002:a62:6c43:: with SMTP id h64mr42413296pfc.123.1553793482086;
        Thu, 28 Mar 2019 10:18:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r10sm31699414pfn.188.2019.03.28.10.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:18:01 -0700 (PDT)
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
Subject: [PATCH v4 6/7] ARM: dts: rockchip: Specify rk3288-veyron-jerry's display timings
Date:   Thu, 28 Mar 2019 10:17:09 -0700
Message-Id: <20190328171710.31949-7-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190328171710.31949-1-dianders@chromium.org>
References: <20190328171710.31949-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's document the display timings that jerry has been using out in
the field.  This uses the standard blankings but a slightly slower
clock rate, thus getting a refresh rate 58.3 Hz.

NOTE: this won't really do anything except cause DRM to properly
report the refresh rate since vop_crtc_mode_fixup() was rounding the
pixel clock to 74.25 MHz anyway.  Apparently the adjusted rate isn't
exposed to userspace so it's important that the rate we're trying to
achieve is mostly right.

For the downstream kernel change related to this see See
https://crrev.com/c/324558.

NOTE: minnie will be fixed up in a future patch, so for now we'll just
delete the panel timings there.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

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

