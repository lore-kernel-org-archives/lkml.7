Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7070CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3A6214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jcOMNoQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfJ0QXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:23:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38276 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfJ0QXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:23:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id v9so7381734wrq.5;
        Sun, 27 Oct 2019 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ryY1C6V/Fnndw45BEkZbgWqU1CO6K4z5Y17d3HMNBz4=;
        b=jcOMNoQZGE9P0d7ffCbmKdcF2AySd4aXs7mnjS66WOxzthrRtgWPSkR4yREp3Dhjus
         b2F3R9ITtpURe2IPC5wwadQlQyvuKJrFrk3yBzUZ1+/l6WiYQ2uV76nVGWuFrBkvPtXU
         ur8ioS5ptyCrLH6LXPMyoI6NmrqHQvEWML9l5VQcjGN/r9vBImUZVVq01cN5dsvE5BeT
         2A+wXJje9nr3TzcAhZjfbBwmlClZ7Qe4krqF06Ux+refnB98YpCI95RGgdkm2nog97M7
         K881kAGJNyLP9Ataz2iPfbnCepVvnGOEMDtyMNOe3PxBcE+q4iMFVzjSQe4wkxrQ/y7o
         0lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ryY1C6V/Fnndw45BEkZbgWqU1CO6K4z5Y17d3HMNBz4=;
        b=sqroOMyJxLva5YXyo/bgys3J9RWt1/5HFzZnvX5GrdCFqFOkxVj3ITvOPOe07eUbGu
         k9ehvSotZGcrJ3/vigzDW2DeM+F9UzwOTGdFOOcDinBQ0sWj+CfowFrgAma8YYAnkG/5
         qe4PQ2VmGPRt4T2BUNIsraA/WauG0ubhvR5hcSn7RjkmEuoLK3QObvWtejGjfI8vgf/W
         GcnLgeKIKEfLdysS71qtmON+GJ0w7J3Kgn3WDb9q7m/LJ5FeIS28EEClqTGuRLJTs0ge
         wlN91/Yv4+5ZFhbX7tZ/U1q/GzIC3Uu9eui/m33dYgNIUn+hJRnziZAlO7zKkQHjvh/w
         iMJw==
X-Gm-Message-State: APjAAAWiG5XHnWM3NnG+D6ygPf9DkHpoEA3SFMViP0kBvmnYVpd+GZsD
        8c6CI/0xvm0OQPT8G5dg/L0=
X-Google-Smtp-Source: APXvYqzJzVDuGRmFzkWeOr3NTHwTi62Xi6QJDu+uSXbftVSyV4pNzDeuETaGgy0zSi4H/2tKNFxJFg==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr11506053wrv.113.1572193426246;
        Sun, 27 Oct 2019 09:23:46 -0700 (PDT)
Received: from localhost.localdomain (p200300F133D01300428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33d0:1300:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id 1sm8243299wrr.16.2019.10.27.09.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 09:23:45 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 5/5] ARM: dts: meson8b: add the DDR clock controller
Date:   Sun, 27 Oct 2019 17:23:28 +0100
Message-Id: <20191027162328.1177402-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com>
References: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DDR clock controller and pass it's DDR_CLKID_DDR_PLL to the main
(HHI) clock controller as "ddr_clk". The "ddr_clk" is used as one of the
inputs for the audio clock muxes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 1934666ff60f..8ac8bdfaf58f 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -4,6 +4,7 @@
  * Author: Carlo Caione <carlo@endlessm.com>
  */
 
+#include <dt-bindings/clock/meson8-ddr-clkc.h>
 #include <dt-bindings/clock/meson8b-clkc.h>
 #include <dt-bindings/gpio/meson8b-gpio.h>
 #include <dt-bindings/reset/amlogic,meson8b-reset.h>
@@ -172,6 +173,14 @@
 		#size-cells = <1>;
 		ranges = <0x0 0xc8000000 0x8000>;
 
+		ddr_clkc: clock-controller@400 {
+			compatible = "amlogic,meson8b-ddr-clkc";
+			reg = <0x400 0x20>;
+			clocks = <&xtal>;
+			clock-names = "xtal";
+			#clock-cells = <1>;
+		};
+
 		dmcbus: bus@6000 {
 			compatible = "simple-bus";
 			reg = <0x6000 0x400>;
@@ -434,8 +443,8 @@
 &hhi {
 	clkc: clock-controller {
 		compatible = "amlogic,meson8-clkc";
-		clocks = <&xtal>;
-		clock-names = "xtal";
+		clocks = <&xtal>, <&ddr_clkc DDR_CLKID_DDR_PLL>;
+		clock-names = "xtal", "ddr_pll";
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
-- 
2.23.0

