Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D197C2D0DE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 17:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F5D205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 17:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo9vW1+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfLaRvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 12:51:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34551 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaRvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 12:51:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id c127so2157259wme.1;
        Tue, 31 Dec 2019 09:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y0pdQ57Bb9W+I4Zj4BKWjlPJ7whwXX8FpP+BQzBYj1Q=;
        b=Bo9vW1+RA/q7d+lcy1uwYlGUVDGh7sWMCl3rsaOYf1sDQAMuk6Dor0mEajYbtFA8e2
         Lbd49mdoAD9vQrCDZHu0ikN8XtoHeP6cwt/uG+hegNgV7SorWd4VfB1H7ewWI+JzW1lw
         oNBTUyHDUc+I/a8wbzeywYsCL+KEZnyr6qyufNZvc2oNDmfZc6+wt3yTMSLhWAzXPjk+
         siDPPIzlkmVcQaSJxMk8pop2kCRkHVGWgCIrU+TxhPWxa35Mdi7DRM85uwPggVESeGoQ
         ni4b+0X7stuCLXYlmMuvw2PUzNvFydGCmD/Y428nrHxDwRxAk6ChhoohizSRyhjiOtUZ
         lvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y0pdQ57Bb9W+I4Zj4BKWjlPJ7whwXX8FpP+BQzBYj1Q=;
        b=rI5so5J/9EHI0e3hxx0S0WFeugDhtQURzxsw5B4OyGSuTvO9yOIBSKXJbYEliS2DOu
         8yxaMF9fJo4QHOy8DwsTs+BQgD2ZpUA3/YF5WTzaaq3NOSlYCxJT1SpU28fWEXvaD5od
         MC0nU48IStHEqHRpD1pKkiiDQEU8WOaXXRQgkHUFE39Q3pajSYFHReCBYechggoQg0hq
         tGr+NyxXAnRaRRUQ3FBVcZ5+GrdQwaEBke7ber70ohqWlFWONcsZyrxZx/9cQ5gWobvM
         nLt3tHr0pixPBzaS3X1MEryCm3UnDxcvMcgpmHh0DyMZGSeoN+mxfXxXBW9Z0LJcmELK
         4X/w==
X-Gm-Message-State: APjAAAVEx5x3U2ek4R/WeNoAkGXA1evXWyCt0o8ofCitDoSur648gsmr
        shQMQUFKj+ufLIAwvUhLPvc=
X-Google-Smtp-Source: APXvYqyW4ZqDMLcL5CNxS1jGOCZ5Iry7mW4VKEeoQ6xK6eOsjz8+Hs4KoRx/pxnMg6Y0o953owMpSw==
X-Received: by 2002:a1c:e289:: with SMTP id z131mr5110036wmg.18.1577814660590;
        Tue, 31 Dec 2019 09:51:00 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f12sm3137706wmf.28.2019.12.31.09.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 09:51:00 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     robh+dt@kernel.org
Cc:     mark.rutland@arm.com, heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rk3399-hugsun-x99: remove supports-sd and supports-emmc options
Date:   Tue, 31 Dec 2019 18:50:54 +0100
Message-Id: <20191231175054.4929-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entries "supports-sd" and "supports-emmc" are not a valid Linux option
in relation with SD card or eMMC, so remove them.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
index c133e8d64..d69a613fb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
@@ -556,7 +556,6 @@
 &sdmmc {
 	clock-frequency = <150000000>;
 	clock-freq-min-max = <200000 150000000>;
-	supports-sd;
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
@@ -572,7 +571,6 @@
 	bus-width = <8>;
 	mmc-hs400-1_8v;
 	mmc-hs400-enhanced-strobe;
-	supports-emmc;
 	non-removable;
 	keep-power-in-suspend;
 	status = "okay";
-- 
2.11.0

