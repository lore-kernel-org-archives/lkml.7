Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10E5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EB121871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NEknN+An"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfJHTum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 15:50:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42004 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbfJHTum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:50:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id q12so11393883pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m4uzQSP3Au83CY4u9n7jhItUEp/vcRKY4n5Lv4fKXM4=;
        b=NEknN+AncK8N4y3dBTFRjlKwCZTSN45tB2R19Wdue51byzRgFK6nM32RciwiCAIrZZ
         xFqf5RC0mQTk3lG5OYT8jlQFtxEBNHC9dp5Dhh2m3Q9+oWws25Vy7E6OKTWyvUj2aAbJ
         H6ONAOSSaHWDlCR1ES2lfPvBhbkhjW1I+N6Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m4uzQSP3Au83CY4u9n7jhItUEp/vcRKY4n5Lv4fKXM4=;
        b=B2WJMSH1X9CAHRgf5U+7F2VgyMnRpHLgeUKtlAZJyik2nlbDIgrJHteQMzN5KnVqoS
         Yd87N1M22WJXhhDpUZ/bvNOyhIX9knhFrF9M4IexJHxSpeTJf6eh2V6/Rj8oe0bwGGMr
         uVOpJaaIJ6FILn4Ki02D+CD1w/BN3s3F/V1L4KkqDZVI1wjqTxzbfX+7pr/8Tj5szW73
         N+kJar5ZFcWpV1bQ6sIUrzyzojN5nvHA1eV2QQb//r0EZCG49IjHBMptZHrv4bSjSzZU
         CMsaSRUAPn+WNAGl80Ep0YdkdnTot33Et8GYkbz97HnsznqVvNGOhYLFoTWMTXLW08eY
         B0ng==
X-Gm-Message-State: APjAAAXcJgIdJHx6WHHkUXnUlClmvmarVGCmSdNoFaw9eiTunx5xTSAi
        vwMUF3z46GKQT1/KJAePDpJzTA==
X-Google-Smtp-Source: APXvYqzF88Vn4VUDh5dsiErTZYveKRuzhv1DkFqI04BEQC732nyRt5k8P/3eBe/8j0xqwAB7yvXHCw==
X-Received: by 2002:a17:90a:730a:: with SMTP id m10mr6682606pjk.80.1570564239809;
        Tue, 08 Oct 2019 12:50:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 30sm13313pjk.25.2019.10.08.12.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 12:50:39 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: rockchip: Fix override mode for rk3399-kevin panel
Date:   Tue,  8 Oct 2019 12:49:54 -0700
Message-Id: <20191008124949.1.I674acd441997dd0690c86c9003743aacda1cf5dd@changeid>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I re-posted Sean's original commit to add the override mode for
the kevin panel, for some reason I didn't notice that the pixel clock
wasn't quite right.  Looking at /sys/kernel/debug/clk/clk_summary on
downstream kernels it can be seen that the VOP clock is supposed to be
266,666,667 Hz achieved by dividing the 800 MHz PLL by 3.

Looking at history, it seems that even Sean's first patch [1] had this
funny clock rate.  I'm not sure where it came from since the commit
message specifically mentioned 26666 kHz and the Chrome OS tree [2]
can be seen to request 266667 kHz.

In any case, let's fix it up.  This together with my patch [3] to do
the proper rounding when setting the clock rate makes the VOP clock
more proper as seen in /sys/kernel/debug/clk/clk_summary.

[1] https://lore.kernel.org/r/20180206165626.37692-4-seanpaul@chromium.org
[2] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/gpu/drm/panel/panel-simple.c#1172
[3] https://lkml.kernel.org/r/20191003114726.v2.1.Ib233b3e706cf6317858384264d5b0ed35657456e@changeid

Fixes: 84ebd2da6d04 ("arm64: dts: rockchip: Specify override mode for kevin panel")
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index e152b0ca0290..b8066868a3fe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -44,7 +44,7 @@
 		power-supply = <&pp3300_disp>;
 
 		panel-timing {
-			clock-frequency = <266604720>;
+			clock-frequency = <266666667>;
 			hactive = <2400>;
 			hfront-porch = <48>;
 			hback-porch = <84>;
-- 
2.23.0.581.g78d2f28ef7-goog

