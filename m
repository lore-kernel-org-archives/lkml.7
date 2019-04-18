Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D77C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193C021850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g+JqrgM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbfDRAPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:15:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43604 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbfDRAPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:15:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so257008plp.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 17:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9dHCbPnlI9BSQxis0+totmB/WamSdFGOvfhVYVfhROQ=;
        b=g+JqrgM6CtbjdujZ4bhx4uBddKF+4SRVyOciP5srObjxxh8KDMl19YmZbkZRq9D6ro
         /oQuSYOpqFTsQE5PzmeCMGPnnB5FLYBf00CWcGLWBi2Ml0xUlmRHTB/JAtskaKWlNo5g
         dQmAwOypdXgrccYfyYUTb/Z2JAOT2ZOBU3IHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dHCbPnlI9BSQxis0+totmB/WamSdFGOvfhVYVfhROQ=;
        b=Ru6Y39GXJb2m1SS1QSjMIAcZRhi7uRmHOOA9xOEKSTWP5+shpQZg9Y6++nkdeCR1wb
         MbNx27TBelBE3RGA+lFeuV/osztPtuypCefJA9/IHnT2o7QLmY6ju1Jdg87WIPkdMmHW
         LywAnM7QV30mxM4i4twnjG5O3+3p4GttzZW+di6O+5Y8vwms2zobWV7B9cKTlNK0xTT5
         oSKL/j9THt0BpYBD9om3efNDTbDnx4f9U1tAC3ULa2yRkIhqFBLG971QHl7p3d4SF+On
         SkRMD7tukm0z0mb6RnnIcqRljxHur9zxHnw0FXrkUFfi97gPANC1LYcj07M3DyT8xwkJ
         fCLw==
X-Gm-Message-State: APjAAAXecuhyEHMNwRDSX1HDPZh+su1542p64FlNSrHRgnZeKRIO1DwY
        3kebEhfjQUscHPpWh1/ootzTXg==
X-Google-Smtp-Source: APXvYqxWk5e1kbmfttQMLubOoAO7jJexKAOokKqYIE8CqxPpp93l2fjdF31N53x3ArHo1fS2mksl/Q==
X-Received: by 2002:a17:902:2aeb:: with SMTP id j98mr25482240plb.38.1555546503259;
        Wed, 17 Apr 2019 17:15:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id q5sm447668pff.97.2019.04.17.17.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 17:15:02 -0700 (PDT)
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
        dinguyen@opensource.altera.com,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/5] ARM: dts: rockchip: Allow wakeup from rk3288-veyron's dwc2 USB ports
Date:   Wed, 17 Apr 2019 17:13:56 -0700
Message-Id: <20190418001356.124334-6-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190418001356.124334-1-dianders@chromium.org>
References: <20190418001356.124334-1-dianders@chromium.org>
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
2.21.0.593.g511ec345e18-goog

