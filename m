Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E60BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0072080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h0wYyVMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEBWy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 18:54:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47032 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfEBWy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:54:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi2so1693213plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 15:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+ZPNiv5B5kytob2vOwdU5pZyvzNXPIUr8ZUKGFUcOY=;
        b=h0wYyVMluUVAdv1NwQOAAhlwteWpgYwW8HXhS8VG32Z7Lf9yxA4NuF5+A0czBvZzKv
         lJVcxHPaPYIKXirJmLKL7liFbEaF4geinpGCsaSD7+tuUJ31PO4yA9oJQyZ+bTMX2yqH
         davXBEyebjxtzyIeeIKbXwcoU9AzTCZef7yaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+ZPNiv5B5kytob2vOwdU5pZyvzNXPIUr8ZUKGFUcOY=;
        b=jDCw76J4sv7yeLWg60ZKjCP1CDr7Xxxw8Ed6UUU5nGzemhCiHDk/fOTVXtYeTIQN2N
         XfpLCjGhcLISAJGup8XWVY2HAayEoiORdZ/HqtFm4BBSlb0K6r/AxZO7FQaIe0WWLfqS
         fODr2D8tnLBEMQ9kbLIEsK6AI9Emfu0g//IPvsH8jJveWvnfMfph274YrrcILZw8sTzJ
         DeeUElzYbUBFa4f8RkQiKFbhb9TbwmVooMHWQfoENccVHRtNee/z1H8lRYYKVPpEQNoV
         HpqQPBPRfL5vbAuZL1MLeywLh8KUrEPe+aFkM7rhZFxOrSYevvtsbsq12yVGfUKd9LtT
         ry9g==
X-Gm-Message-State: APjAAAXo21UfwbyxVZOse0J2e5A8mnaLVEeQWKYctXHiJKoZY8/Ul+IE
        h6J6P0iEa5/726nrs4Yd2Hf6Vg==
X-Google-Smtp-Source: APXvYqzd5mafem3up8aafRaHi3Cdrlk1qdlgUPk4BmPnowawJNQiWJT3C7hEk3PNUfbliN1Sz4ERKQ==
X-Received: by 2002:a17:902:8545:: with SMTP id d5mr6351215plo.198.1556837667556;
        Thu, 02 May 2019 15:54:27 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id v15sm264736pff.105.2019.05.02.15.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 15:54:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] ARM: dts: rockchip: Add unwedge pinctrl entries for dw_hdmi on rk3288
Date:   Thu,  2 May 2019 15:53:35 -0700
Message-Id: <20190502225336.206885-4-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190502225336.206885-1-dianders@chromium.org>
References: <20190502225336.206885-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the "unwedge" pinctrl entries introduced by a recent dw_hdmi
change that can unwedge the dw_hdmi i2c bus in some cases.  It's
expected that any boards using this would add:

  pinctrl-names = "default", "unwedge";
  pinctrl-0 = <&hdmi_ddc>;
  pinctrl-1 = <&hdmi_ddc_unwedge>;

Note that this isn't added by default because some boards may choose
to mux i2c5 for their DDC bus (if that is more tested for them).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 74c9517c4f92..eebc04fa1e4d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1545,6 +1545,15 @@
 				rockchip,pins = <7 RK_PC3 2 &pcfg_pull_none>,
 						<7 RK_PC4 2 &pcfg_pull_none>;
 			};
+
+			hdmi_ddc_unwedge: hdmi-ddc-unwedge {
+				rockchip,pins = <7 RK_PC3 RK_FUNC_GPIO &pcfg_output_low>,
+						<7 RK_PC4 2 &pcfg_pull_none>;
+			};
+		};
+
+		pcfg_output_low: pcfg-output-low {
+			output-low;
 		};
 
 		pcfg_pull_up: pcfg-pull-up {
-- 
2.21.0.1020.gf2820cf01a-goog

