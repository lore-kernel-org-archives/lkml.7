Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA22C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B48221873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nr+iq52c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfCTUOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:14:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40868 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCTUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:14:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so2710670pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R9mRVBVpqgmAWPhOAEz/MUywcQ/1qLve3BZ5OFUwu8E=;
        b=nr+iq52cGOe1HqV06J3stWIhVEcybhyAcnYnPWwyp5GodQUYKhqg0v5o6llNj2x3iA
         tONv3aMlfRAMiJ2dEUOrLoznLh82JDnREQlZ0f6LkMJL/oXS7+n7aOZPa3IUVDxlEFvg
         OY1GY8Aka8miO7rVY/Bp2tPCQL+tAJnMqCn90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R9mRVBVpqgmAWPhOAEz/MUywcQ/1qLve3BZ5OFUwu8E=;
        b=GMSfM+/164JNEvfTQUci/8i+yZnM9uozNzJVRBOsVT8NNatm1Vsn2BURTDgy6Z0bC+
         ayV9DgBt4vMn6SVwOXqzQljKZPMyqXH2hzaOqHgnvo+yjdhgXg0/E3ser6yJXvmHjBKd
         sbwldC13EItQ9lOoH4z1337v03UpuXHOR5pe/SCKriTj4pywVytlQyVEViA978re8sJM
         2968H8r31+Mf0GQldkhNKGX4xX9amV/F3LsFEEMgoKlvIO+ocY1FnoTtizfTmmzxbDxS
         tYOMkbhl1rqPlUDDXA9bWBmRCwuhx2BOmWPTTqxwK01WI5IY2mGmQjvoSs7ZKblDn3jI
         SXSQ==
X-Gm-Message-State: APjAAAWlort4B+V7JMqmO73cezuQApz8bh20+DQk9ZrP2kUkNb8X8Jno
        s0iZ//S9UXpUrCRTmRBbZWCUCw==
X-Google-Smtp-Source: APXvYqy3fFk2jA8S/fUrP+0RVXK5fXzb1BZz987v6npRkeUHmzgnEVF9SCaR1gMSrNMXI4s3p5dFrA==
X-Received: by 2002:a65:4341:: with SMTP id k1mr9127032pgq.175.1553112875006;
        Wed, 20 Mar 2019 13:14:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id z77sm6220388pfi.155.2019.03.20.13.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:14:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] ARM: dts: rockchip: Remove #address/#size-cells from rk3288-veyron gpio-keys
Date:   Wed, 20 Mar 2019 13:14:02 -0700
Message-Id: <20190320201402.114309-4-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190320201402.114309-1-dianders@chromium.org>
References: <20190320201402.114309-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are pointless.  As dtc points out:
  Warning (avoid_unnecessary_addr_size):
  /gpio-keys:
  unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Let's remove them.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 0bc2409f6903..192dbc089ade 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -25,8 +25,6 @@
 
 	gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key_l>;
-- 
2.21.0.225.g810b269d1ac-goog

