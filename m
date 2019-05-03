Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80969C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADC6206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RGP+SCYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfECXsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:48:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43748 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfECXsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:48:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so3418869plp.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PEbVvCDak8dCpI2HnTFwocIiYZvOr0ebCOGSVDXq9U8=;
        b=RGP+SCYMLHEk5WjF+mHki7uJYv5LbeWl/W59ixEjp7SqRFxLYgdyeLFfNsh1I0z0mT
         cb/sCQwX3HTa38w/+UuVb9LXLRoXVIFbivcUH4aHmEsAorf62RmWtD+486wZ5IFXqkCK
         k4ZFTZOefUEJopS0g8GIGZg3EOG6KH+WOcI/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PEbVvCDak8dCpI2HnTFwocIiYZvOr0ebCOGSVDXq9U8=;
        b=OJR8MnxdrUQGyV5aHXAbFf4rvI9ynJwIc29lWprKT+kLZj5Mjj7yi3nTq+Uiv+NiVs
         6kp8fg+Wk6xLyLCc1LWV6xPvTpP4zKC0hOQNjMAfzHOGTNef6nQSojnAQFsR9aCBZiiC
         ZXlUhfNqC3I2GRurY2DGhUt336jnXbHUNcWWlkIiOsvMfoAxSUxRlE7W87UosYWmSPot
         b0I4S6YXU3YA9uI2YfKB5+MhLXEshCesY51PkGePNDn1jOQ6gE9aOGjDC49XLJ/mgkT6
         6gGLz0MrKYMX49dH8d6wyWhiQaVNkvT47+YmG04bb2P7l3xtcQIYc48JyfoN9LLEHTGb
         agCw==
X-Gm-Message-State: APjAAAWEmtsaiMcIhGxTosSNvIuG5OefqwaPuQuCHo+F4PtRqCbrB5Fe
        erNiyrWtwXaXk/vHCHo3+F+X5g==
X-Google-Smtp-Source: APXvYqxeKcjKarf8WpC7SOBVbIuTMoZDl+AyM8KJSHyTbJ15hk1FROhg2a9ECGzoKsHIXJxvHdpNjA==
X-Received: by 2002:a17:902:b703:: with SMTP id d3mr14041484pls.93.1556927303213;
        Fri, 03 May 2019 16:48:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p6sm4231875pfd.122.2019.05.03.16.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 16:48:22 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, briannorris@chromium.org,
        mka@chromium.org, amstan@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: rockchip: Remove bogus 'i2s_clk_out' from rk3288-veyron-mickey
Date:   Fri,  3 May 2019 16:48:14 -0700
Message-Id: <20190503234814.230901-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3288-veyron-mickey device tree overrides the default "i2s" clock
settings to add the clock for "i2s_clk_out".

That clock is only present in the bindings downstream Chrome OS 3.14
tree.  Upstream the i2s port bindings doesn't specify that as a
possible clock.

Let's remove it.

NOTE: for other rk3288-veyron devices this clock is consumed by
'maxim,max98090'.  Presumably if this clock is needed for mickey it'll
need to be consumed by something similar.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron-mickey.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
index e852594417b5..f9c4ece3c0d3 100644
--- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
@@ -142,8 +142,6 @@
 
 &i2s {
 	status = "okay";
-	clock-names = "i2s_hclk", "i2s_clk", "i2s_clk_out";
-	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>, <&cru SCLK_I2S0_OUT>;
 };
 
 &rk808 {
-- 
2.21.0.1020.gf2820cf01a-goog

