Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F119FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B2421773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lf4nxR7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfC1RSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:18:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33504 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfC1RR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:17:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id b12so11949490pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLZp80c5zmxWFSyZnvtSAhGFGjN8GgpaVzXeZauR/As=;
        b=lf4nxR7Uk6SllC3sXaohqZU0wZL8kGjBbH8P55XZQHkEsOa8AbUOCVIx4d4JguH3ma
         fYUqogrV9g5bt5C71Y6/93mYdjA4wfcxM6/cWQl08oaFgVq0Y37HswfGdbaB4rYef3ru
         jkdVvOCtY0ev1MnFjkcXYpSEYRCXXH5wvTF+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLZp80c5zmxWFSyZnvtSAhGFGjN8GgpaVzXeZauR/As=;
        b=SOMtem98DjGgRtoJKixs/ooVq1S/jGe8bmNTvWCPksBvOqi/ch6zqqf9X3X4V2aC8m
         9Vx/dxuqa0c52UHm5f+ZzgzXiymZotnxvtJZQJjNe1rtcgZnwySw4cKg/2G1nfOfALOD
         iMLOBWihe6qRskPILPDiNoePRd50qQWnvC6N6ehdNCb/Ouz4TWw3lBz9e5A4CP8hPnJ+
         Ulxc9z6b3J8A8TnmexFww3+LL005bT+oIfqtaDiO1Og/vq0EplH38KBkGhbV7XV13vjH
         zYi0CmB6tggOAY4+gc91D0mbwfHN8Jzte2L05ixXUONj541Qn/t7B6UlT4nmCSaCpWEl
         spcA==
X-Gm-Message-State: APjAAAUgnOGHW92k41A9MJkDKJVCSQVeLz9lf/IFH+s29h70DUnFTfTc
        AZoVCp/WAvIsnb2UEFSGz92RlA==
X-Google-Smtp-Source: APXvYqx9eJkDT/kFjG4NENDdfGYDqem2sMd4BUAVPj+/+V7ttxHpGj0MWP+qW8V6CsAXc9oqciCyow==
X-Received: by 2002:aa7:82d9:: with SMTP id f25mr42008749pfn.45.1553793478806;
        Thu, 28 Mar 2019 10:17:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r10sm31699414pfn.188.2019.03.28.10.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:17:58 -0700 (PDT)
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
Subject: [PATCH v4 3/7] arm64: dts: rockchip: Specify override mode for kevin panel
Date:   Thu, 28 Mar 2019 10:17:06 -0700
Message-Id: <20190328171710.31949-4-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190328171710.31949-1-dianders@chromium.org>
References: <20190328171710.31949-1-dianders@chromium.org>
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

