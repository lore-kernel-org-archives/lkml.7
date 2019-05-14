Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0082C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8223A2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zjwI0Sg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfENLPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 07:15:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44486 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfENLP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:15:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id c5so18702246wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZDyT1E6CK5U4vscnJX4HAz7PFMKaDLqJqgBaxE3cbqk=;
        b=zjwI0Sg5tIHprAsQ1cIZ2uDaKlCkoG6ktG8MUAeZCqwXjYDXJAPOMv5ehGnvyKxuNc
         LjMM1e9wKtQgSnzv/kNtJuq6V2PCcdyWpaEt09g9oQBgUlCFiTwhQmCghlr36WQUJBMF
         Xh5lTmGhee6uRp7CnshIKh0BpHLAGzQIB11Umm1D7gqHO8xIEYbU0wd4XSwCFu8LYj8Y
         1cOMpvgNm8bUtnJ59B40ZjuiLQvQkjUSqWTk4UhRcRjSwbPIzDTqKqKmJrDv4psp+YA7
         cduvZ1LxkcI17YIw+6i9pKXvaF3PNBx3Ra+5Dpp4ms4mK0Ds8tMzjixToxkuKxPlvhF0
         SY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZDyT1E6CK5U4vscnJX4HAz7PFMKaDLqJqgBaxE3cbqk=;
        b=oaIPx9h1zotdtQ4i/n+PVnvsFqVr75vrwOiHUX9bhxbrkFEY05aWK5uoWhj2ZYRE+M
         IxyQ3adsv5Y44+1mIQo2tIyu6/zmSTtP9GxwxuTPB6QP5NDSQRVqiclR+XkPmWMQWHxh
         VXrO378OOURLFwW7noGVKLRLyX3eIPfxCUFkpl/PMS4e9iPs6KO9//FnQGxKj/yGQQNd
         ZK5td2fjipm62lUXFAJU3mFWBR9ShDmCpjVUt6soNfBl75rh1EEwTTfZkP5YNGKWOTy9
         MfkFsQV4dOOwsVxAnNqYJfurf45rTjuOp0esKvwCxCVOliuPgB8vpK5w/6z9RzwPBRlN
         iwyA==
X-Gm-Message-State: APjAAAWpTCldkseEp59mVHOfjedrHATJr9PxOov/h/Mma9uNrEnmAE3K
        THeFgw3TtbFzlEQaQ5VIhs+JGQ==
X-Google-Smtp-Source: APXvYqzQAcU7U+wcVxg9MhAh1cKvnRqKieViTrtEFkY7/v8UDTwXcjIA0LvlG42jrQg6541aF+Tbng==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr20830144wrj.249.1557832524299;
        Tue, 14 May 2019 04:15:24 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c130sm7289922wmf.47.2019.05.14.04.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 04:15:23 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] arm64: dts: meson: g12a: add spdifin
Date:   Tue, 14 May 2019 13:15:09 +0200
Message-Id: <20190514111510.23299-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514111510.23299-1-jbrunet@baylibre.com>
References: <20190514111510.23299-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the spdif input device node and the pinctrl definition for
this capture interface g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 37119564274b..d4fc645f0ff3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -807,6 +807,30 @@
 						};
 					};
 
+					spdif_in_a10_pins: spdif-in-a10 {
+						mux {
+							groups = "spdif_in_a10";
+							function = "spdif_in";
+							bias-disable;
+						};
+					};
+
+					spdif_in_a12_pins: spdif-in-a12 {
+						mux {
+							groups = "spdif_in_a12";
+							function = "spdif_in";
+							bias-disable;
+						};
+					};
+
+					spdif_in_h_pins: spdif-in-h {
+						mux {
+							groups = "spdif_in_h";
+							function = "spdif_in";
+							bias-disable;
+						};
+					};
+
 					spdif_out_h_pins: spdif-out-h {
 						mux {
 							groups = "spdif_out_h";
@@ -1510,6 +1534,19 @@
 					status = "disabled";
 				};
 
+				spdifin: audio-controller@400 {
+					compatible = "amlogic,g12a-spdifin",
+						     "amlogic,axg-spdifin";
+					reg = <0x0 0x400 0x0 0x30>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "SPDIFIN";
+					interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
+						 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
+					clock-names = "pclk", "refclk";
+					status = "disabled";
+				};
+
 				spdifout: audio-controller@480 {
 					compatible = "amlogic,g12a-spdifout",
 						     "amlogic,axg-spdifout";
-- 
2.20.1

