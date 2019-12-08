Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E55C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 18:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCEF205ED
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 18:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HtyNtbPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLHSFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 13:05:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34269 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfLHSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 13:05:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so13507928wrr.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 10:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0XKcjck8Slbhi+L1r11b0VN49r+cr19/9Vv0kqVx+o=;
        b=HtyNtbPN7Ttbygqr0BrZZ9yArlU2yvhY7/YuojoZyM2ftyokwrnpg3pFtsTCDqoWU5
         xP9B0pVsToNNHY9+yVx8D6NM1XyyE0/WlJA4aWYTxZ0i477Y4jgFUGxi/8m17nGQ5djt
         gvhvPyCIas3P82Q/L4u9N4dxcxNU4lRxXz3mPlDLLkQnUQwmkp2obGIC1rrfFbS8aKu1
         P3Nz50kKbKiHuJlvX9BKTCJDH2yYK2JSN2tjLSXNs6He4vXsKoz8IldyuDHTAGZ0cqr5
         V9HK+0oHAL7keu0LNd7y1HnXw/Bnxd2bwYwrSvw7JqfM5jrqjjqLCPNnileR+IQ/tsQF
         aOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0XKcjck8Slbhi+L1r11b0VN49r+cr19/9Vv0kqVx+o=;
        b=eNDGWsd4jex3QPJDMgpnamPLM/PphHebtZA2IzIAF6nOCo2BttyFoMpUjuUovwTgWO
         kDEfMEhKztjhZQiJajR2YHXtB7kdJq6i1Yliyyd1KViiPW8ndjFnftF7AUat9qRWyzwE
         cceuhydlpqzK7dcXbzFkvuLD6Xa7Wnt2Du9CY/K4S5qqa6Fmvl/UQE8XQssUzsdMJJep
         hX7UhPd5mPbys2HO1l1wxNnYdiAtQTONmol0HfsQDWQla7eriJFi9wqQEEQyTNQhsEDK
         MJWKCunX++F9aUC6fR/HnpIMYLNfzVSk8V5GMndxnIgr6V4Uwp1xUpIef3TNpub490zK
         APsg==
X-Gm-Message-State: APjAAAVfYY+fHQCNlCnqY+bNq/HY2scnp3E5cVWo/wOriSG7yGNDiQjq
        vFssQnP58fdp5lWhOc5/XMnWV+Ay
X-Google-Smtp-Source: APXvYqyToRxC7RZxSQuc4P+1emXKkW61mgRhwMHankrbHkqOII7xGvEXJVr1E7GLcxhl3+MwE0Tkow==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr9143995wrv.368.1575828344729;
        Sun, 08 Dec 2019 10:05:44 -0800 (PST)
Received: from localhost.localdomain (p200300F1371AD700428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371a:d700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id a64sm11797687wmc.18.2019.12.08.10.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 10:05:44 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] ARM: dts: meson8b: add the DDR clock controller
Date:   Sun,  8 Dec 2019 19:05:25 +0100
Message-Id: <20191208180525.1076152-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191208180525.1076152-1-martin.blumenstingl@googlemail.com>
References: <20191208180525.1076152-1-martin.blumenstingl@googlemail.com>
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
@@ -172,6 +173,14 @@ mmcbus: bus@c8000000 {
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
@@ -434,8 +443,8 @@ &gpio_intc {
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
2.24.0

