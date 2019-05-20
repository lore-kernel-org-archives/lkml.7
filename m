Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1004BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A1020863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CxFoYWn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfETR4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:56:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42503 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfETR4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:56:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id 145so7126560pgg.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtT3QQC/EcCQGVPUxChzIKDFjejylVy5RwDw6h0rP8Y=;
        b=CxFoYWn12E2Wfl/DUay6zYNsj7HkCPiuVskqwVaONHUcKwExrtZmQOUQe3Ey65gpym
         dAOGhlevbrpgGEs202kzU4iLQG4beU2kc1yQsScSMSHPdzEI2Apm3x9wOXfEkc/mhrVz
         YFNNrU0Y11kLRKndmuzqLvU8tkqX4lUaA3LPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtT3QQC/EcCQGVPUxChzIKDFjejylVy5RwDw6h0rP8Y=;
        b=a02c3nvCnu4KBBomYnSh9DU+tljYP4o/+28vhPdseRwm+/5/Wsb6Dkx9d5pOVrWixd
         dFOt7p9TngMUxZUd7HAwxjNqLX96Hbjb9Vnh5VlgJXbBhBgPL+3CszK4pvdH3VujCmD/
         QyhZNadR2BZBr4Zp+ws0WTFRqCn2jvMGKx3uMPS3g5YNw3nS4XQGhA+Hf4xNVs78iiJf
         hkmBc2L23796WsS1xYBoH2iFpClP2PwoKVgMSjZLqiaVf/aNssp5uU/KAUwJt7vp28CF
         BiQJvmbU4j1PBO530beZkP9iGH3XR2RJ+uDTegFLJ6w6opaZPqyGeZdljdQ6FAsARVff
         R/hg==
X-Gm-Message-State: APjAAAXgCmBGfJsBmhO24jcjQ3ORlkVEwf3mcvNCCdqwlSrSldDXJ/fC
        G6qCe2oBcm/ff7LIaI+s9kp0pA==
X-Google-Smtp-Source: APXvYqwliCorEDZCbklnXSYAbGCutGmLbgJZVbkDQsXYpFHd/ACzt+u6KekgF4vh+NU86UtFjG8ebw==
X-Received: by 2002:aa7:9e51:: with SMTP id z17mr81249778pfq.212.1558374976378;
        Mon, 20 May 2019 10:56:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id o2sm16852723pgq.1.2019.05.20.10.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:56:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>, heiko@sntech.de
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        William Wu <william.wu@rock-chips.com>,
        linux-usb@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, zyw@rock-chips.com,
        mka@chromium.org, ryandcase@chromium.org,
        Amelie Delaunay <amelie.delaunay@st.com>, jwerner@chromium.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/3] ARM: dts: rockchip: Allow wakeup from rk3288-veyron's dwc2 USB ports
Date:   Mon, 20 May 2019 10:56:05 -0700
Message-Id: <20190520175605.2405-4-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520175605.2405-1-dianders@chromium.org>
References: <20190520175605.2405-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to be able to wake from USB if a device is plugged in that
wants remote wakeup.  Enable it on both dwc2 controllers.

NOTE: this is added specifically to veyron and not to rk3288 in
general since it's not known whether all rk3288 boards are designed to
support USB wakeup.  It is plausible that some boards could shut down
important rails in S3.

Also note that currently wakeup doesn't seem to happen unless you use
the "deep" suspend mode (where SDRAM is turned off).  Presumably the
shallow suspend mode is gating some sort of clock that's important but
I couldn't easily figure out how to get it working.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3: None
Changes in v2:
- rk3288-veyron dts patch new for v2.

 arch/arm/boot/dts/rk3288-veyron.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 1252522392c7..1d8bfed7830c 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -424,6 +424,7 @@
 
 &usb_host1 {
 	status = "okay";
+	snps,need-phy-for-wake;
 };
 
 &usb_otg {
@@ -432,6 +433,7 @@
 	assigned-clocks = <&cru SCLK_USBPHY480M_SRC>;
 	assigned-clock-parents = <&usbphy0>;
 	dr_mode = "host";
+	snps,need-phy-for-wake;
 };
 
 &vopb {
-- 
2.21.0.1020.gf2820cf01a-goog

