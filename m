Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C2BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D706721741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aF3/aaFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfDJSaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:30:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37010 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfDJSaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:30:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so1990922pfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hN+1FI2g2HxypiUQWbJNuFbyAbTL5bcAyXISI3fTIKg=;
        b=aF3/aaFNYbZ13B+W+xr2dIWfQQ4Pj62FvWaqCO3m2V+ok+JDaKoAFD0VZJzICwMjwp
         7GaZG23XYp05LeeskjtX7+ZJkLUujJsltWjtgkzyCKuhBioym2TXO1OEaC9Cvs7c32Rw
         /CAAfsjFp+RWGz7iN7X+Jvlrx2wyqKFH+r9vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hN+1FI2g2HxypiUQWbJNuFbyAbTL5bcAyXISI3fTIKg=;
        b=Cx+PxFtcvJio1jZXKwGkh5ldz8ixuxMhDzOiFLlDL/wZ70BBUmJiPAsjCdcEjVl082
         O+tDRD2Xe9+RJ239rAWJ4rP3o3gWbmlTpFoVrRVqz52KsV5WQaPFPSJb+F0akSZ0QuwE
         Y0C+J4VlaophF6BI9U0t88HLQ4w1OqIN4Mhdtaoqkm9YCsIloa2NldDM9fyokqM4ftF2
         +kxteWNE6d9sgSQNe9AgDpydIl8hFUxr6JUyrxdmHiz+LyKIm0xqWTZC5IKxj+zPd3QK
         k8/x74l0wwjfKY0rEvGIFP8ioAhCI2bueEDpmqKAwJ0YRAAQxqKcsuMBzIPtG9XbPxmi
         zZQA==
X-Gm-Message-State: APjAAAU8HqON1vzob/ESDobI6q44d2YUsxXf/vK2sTO3RB5ejSF7yLU4
        jbhKERL7IoC1+t4pWVuJJ16Suw==
X-Google-Smtp-Source: APXvYqwiWLgq9xxEYPIDFqGYjYx2sCkZNTDpNESNE25WjQAoupbNVGwoNkrTUC7ERK0N/dZmWsNduA==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr42805106pgp.197.1554921019810;
        Wed, 10 Apr 2019 11:30:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id z21sm50938603pfn.139.2019.04.10.11.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 11:30:19 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ARM: dts: rockchip: Remove unnecessary setting of UART0 SCLK rate on veyron
Date:   Wed, 10 Apr 2019 11:30:10 -0700
Message-Id: <20190410183010.21307-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some veyron devices have a Bluetooth controller connected on UART0.
The UART needs to operate at a high speed, however setting the clock
rate at initialization has no practical effect. During initialization
user space adjusts the UART baudrate multiple times, which ends up
changing the SCLK rate. After a successful initiatalization the clk
is running at the desired speed (48MHz).

Remove the unnecessary clock rate configuration from the DT.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm/boot/dts/rk3288-veyron.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 0bc2409f6903..97e980383e25 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -378,10 +378,6 @@
 &uart0 {
 	status = "okay";
 
-	/* We need to go faster than 24MHz, so adjust clock parents / rates */
-	assigned-clocks = <&cru SCLK_UART0>;
-	assigned-clock-rates = <48000000>;
-
 	/* Pins don't include flow control by default; add that in */
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
-- 
2.21.0.392.gf8f6787159e-goog

