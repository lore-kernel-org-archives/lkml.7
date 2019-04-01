Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0BCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB1D206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eBBUS132"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfDARSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:18:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46199 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731279AbfDARR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:17:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so4800583pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+AmmzLpPuFAi2VfTCy3FGaIq62ToFSCjB0vDQGXh5jI=;
        b=eBBUS132qAEAeeyD4XiRW5YP1rww5Lg7gYGB+oO7KS3ovyzwyTAPsd/h/x4GhBW8KP
         OP83v8dKgY6b7HdwPPONQ1UYQin9i5p+Ck7+45RqSRc7CDVw3W5yQL8vCpAMTCe+vPDd
         Z3Hv9W3nk/2/TCKJbxNAHJ9HNKv7dR4vyMEqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+AmmzLpPuFAi2VfTCy3FGaIq62ToFSCjB0vDQGXh5jI=;
        b=UHVfAjce8WAH2ds7FKCqtCDfvCq1+PyMiStOBhJTMQLuRk5WNob/yd+l2/WwEP6evq
         lhJVWmWaearAKcV0GP5PBzO0jI5ydqe4p369Q7QaQUHtQ82qHMyNZaoFVLXYIjWhG5+c
         mfN6duaKpdKkmVHw0iEn1Znyi/ZiOTgW/tCpIjmmnnn9af+gRtAEGLJAF6mMOU4KdTuT
         UOWqFitkGTZLJgzFqtY3I2bScF3cXzYlOSvFzOc5KdjrRYHtyNj9bE/a3AqLdaPnqj3c
         +v92gMbfCvNO4kd7E20hf1sjF3FC8PnTOXUd3qG8MauctWXY7DtzJm4VYW4Nh01i40oV
         ffWA==
X-Gm-Message-State: APjAAAWPl3Lz9Uv7IBV37+30YGUx9G4uRiANrakOd+wGJKAAMERO4TKk
        PBuuCkJv/T3VLDa9V7Af2DTkow==
X-Google-Smtp-Source: APXvYqwyiWBFZw15HVw5xaJZLX3TCLYZ5TaRziMtPFmNwUJOtKUj6mfNqpf7cxkIZjBhV3IxoVIxVg==
X-Received: by 2002:a17:902:2de4:: with SMTP id p91mr8321570plb.191.1554139076325;
        Mon, 01 Apr 2019 10:17:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y12sm31370112pgq.64.2019.04.01.10.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 10:17:55 -0700 (PDT)
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
        Doug Anderson <dianders@chromium.org>,
        Eric Anholt <eric@anholt.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 3/7] arm64: dts: rockchip: Specify override mode for kevin panel
Date:   Mon,  1 Apr 2019 10:17:20 -0700
Message-Id: <20190401171724.215780-4-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190401171724.215780-1-dianders@chromium.org>
References: <20190401171724.215780-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

This patch adds an override mode for kevin devices. The mode increases
both back porches to allow a pixel clock of 26666kHz as opposed to the
'typical' value of 252750kHz. This is needed to avoid interference with
the touch digitizer on these laptops.

Cc: Doug Anderson <dianders@chromium.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Stéphane Marchesin <marcheu@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5: None
Changes in v4:
- Rebase to top of Heiko's tree
- Converted changelog to after-the-cut for non-DRM change.

Changes in v3:
- Unwrap the timing from display-timings and rename panel-timing (Rob)

Changes in v2:
- Wrap the timing in display-timings node to match binding (Rob/Thierry)

 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 15e254a77391..454f4149585f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -43,6 +43,20 @@
 		backlight = <&backlight>;
 		power-supply = <&pp3300_disp>;
 
+		panel-timing {
+			clock-frequency = <266604720>;
+			hactive = <2400>;
+			hfront-porch = <48>;
+			hback-porch = <84>;
+			hsync-len = <32>;
+			hsync-active = <0>;
+			vactive = <1600>;
+			vfront-porch = <3>;
+			vback-porch = <120>;
+			vsync-len = <10>;
+			vsync-active = <0>;
+		};
+
 		port {
 			panel_in_edp: endpoint {
 				remote-endpoint = <&edp_out_panel>;
-- 
2.21.0.392.gf8f6787159e-goog

