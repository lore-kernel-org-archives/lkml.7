Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D0BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4732D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jet7qqlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfDPVyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:54:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39928 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbfDPVyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:54:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id a96so10982253pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQcpLLY5KK4GVOCCGHD2Lb4pmJlBo3NKSgPvy82sxxs=;
        b=jet7qqlVkuzSyJBHgzdOZoBdkDRzb97FPPvS6OsfblhPaOgPly4QVhABda+QsNoBQK
         jSX0iOEXcTriDz+NlJkB35upNjg0ZfCLEuDRTmv+qErSFyncQ4yXwxyteneTHds73VxI
         +R8BqVW1892eo6PNlyEr32+pD7W05ojOAxm8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQcpLLY5KK4GVOCCGHD2Lb4pmJlBo3NKSgPvy82sxxs=;
        b=JQ8PiCTUwQe4gAwqDqGtkHYhq9mgHHdHCeHU+YnRXbgzxIhwpaukiTchRaTCwuOBwe
         XFakd2akbPSF0A8r9qUQSMjoP2KeFgQg5i9/izavDn9cpJTGWwxkKCVbwsd6QOdZKQi2
         JHx+gKztIxjBgF4wJpkqzm6e95EBp4OxCA8W8wSjNEmPexxRuPgXMl56OgjZC/muppCU
         nPQUvVbZ9apk2l9g5HnhOiLfxE8ssxnoFLTH2OiZmm3ArOXhFdHxFtIFL6g9MbXEoDkK
         uwmeLGf69fLaFi3fd+fPPcnE7fakG72VBluFGSlm+WrHM5xEneCS3wkO10Ibl6qx32Ir
         45ig==
X-Gm-Message-State: APjAAAU/HK2GjDFDXOf6+3LoA3peRRjlODD3/uje7sGD+sDzi58ESnmc
        wK2bzk8iLTLe2QA4CdwlhkjHIg==
X-Google-Smtp-Source: APXvYqwe5Q3sUUtcLGPdwFIhZi1gZhbtsybtUcA04et5Y4lRysaMcw+0xjOT5eMBQpQRdD8EFX89zg==
X-Received: by 2002:a17:902:e302:: with SMTP id cg2mr81457671plb.285.1555451655465;
        Tue, 16 Apr 2019 14:54:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id b6sm8156770pgt.58.2019.04.16.14.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 14:54:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     amstan@chromium.org, linux-rockchip@lists.infradead.org,
        linux-usb@vger.kernel.org, Randy Li <ayaka@soulik.info>,
        mka@chromium.org, ryandcase@chromium.org, jwerner@chromium.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] ARM: dts: rockchip: Hook resets up to USB PHYs on rk3288.
Date:   Tue, 16 Apr 2019 14:53:50 -0700
Message-Id: <20190416215351.242246-4-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190416215351.242246-1-dianders@chromium.org>
References: <20190416215351.242246-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's hook up the resets to the three USB PHYs on rk3288 as per the
bindings.  This is in preparation for a future patch that will set the
"snps,reset-phy-on-wake" on the host port.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2: None

 arch/arm/boot/dts/rk3288.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 74c9517c4f92..7e70ecf2b95a 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -909,6 +909,8 @@
 				clocks = <&cru SCLK_OTGPHY0>;
 				clock-names = "phyclk";
 				#clock-cells = <0>;
+				resets = <&cru SRST_USBOTG_PHY>;
+				reset-names = "phy-reset";
 			};
 
 			usbphy1: usb-phy@334 {
@@ -917,6 +919,8 @@
 				clocks = <&cru SCLK_OTGPHY1>;
 				clock-names = "phyclk";
 				#clock-cells = <0>;
+				resets = <&cru SRST_USBHOST0_PHY>;
+				reset-names = "phy-reset";
 			};
 
 			usbphy2: usb-phy@348 {
@@ -925,6 +929,8 @@
 				clocks = <&cru SCLK_OTGPHY2>;
 				clock-names = "phyclk";
 				#clock-cells = <0>;
+				resets = <&cru SRST_USBHOST1_PHY>;
+				reset-names = "phy-reset";
 			};
 		};
 	};
-- 
2.21.0.593.g511ec345e18-goog

