Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E04C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EC421479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0LCy7Hgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfEJQuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:50:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33953 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfEJQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:49:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so8682373wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TYrasecq3jc5SZnbZyshnJpWQT7LH8WGclGzzSNZ9tw=;
        b=0LCy7HgiRFhJTPdSqVAy9EaF9UxWwcbZZxT3Vz1z7I9GsqwZsM4JHbOS7Z45l98M0P
         EPpLkH3mrVYZVR2Xmw/wSjwMLF/kI5uPrrEp/WbaJaSoRtYsfkLgtVjh9/i+XZQa4QRJ
         PdkHnAJfTyQ3fwB87gIepiUqJV79rlCG+Ulu/+y1+rfI7HkP8GnzsUqZdAVmfTWYq96k
         nHTbLplyrmUQOjYLxjMcsAY6q3RVzoKUNRBPOIeyu+TKpA8O5pkjjBuemVzGiSWyRkMU
         0xZ2szPEf9UQk6UlGbaOC1edX02Siry30v/nPuCfOtOutFO5JM2tr+TLtw5q5ZKa1HzR
         9DJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TYrasecq3jc5SZnbZyshnJpWQT7LH8WGclGzzSNZ9tw=;
        b=YknG1vT8jTRikcxLDho0a/RH/PddU33XJ6BQA9HpCAgB+yyE7tUTrlJFT0sTJ0ipOZ
         gN6ZH7/83aaDvXcV0ndGo6KSb+3mPRDVFkljowvDkTJAGJVmoaasMrHizRBtX3evIhyF
         yIhD+QZuPGKj3leFIw6I0+8l4GCHWVFA4/2pMA5UMQP2gh+uHK69+Ttz/cgQQcnfNjuQ
         X+khkmHFdWLZ6PN8iqrfPGWDYmlfa4eT17lSFs+b67iZ1NMIoye8gJ+m+ZPov4EWkgLq
         aRivJ350itQ/50q9HgPdMp6KF98SLsSfDHwyhDVh+UXJFdlMGfPxbTqRYwHbQbY9cNp0
         MhKg==
X-Gm-Message-State: APjAAAVXEJXqBuIEO7Xzv+or0snm/7O857dvOEYhYr/nF3ICrHPtkdVz
        T/82XO1w3SfFnAutNI3i+UnYlihhA9o=
X-Google-Smtp-Source: APXvYqxpdF9tqU6dkco+yKgRpO42/D9hSwEZQEkXEt4ynHGrSAVlze7WRq3hAlxik/PhaSnw/Yo1BA==
X-Received: by 2002:adf:f701:: with SMTP id r1mr9066096wrp.130.1557506988408;
        Fri, 10 May 2019 09:49:48 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id q26sm5114308wmq.25.2019.05.10.09.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 09:49:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/5] arm64: dts: meson: g12a: add mdio multiplexer
Date:   Fri, 10 May 2019 18:49:38 +0200
Message-Id: <20190510164940.13496-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510164940.13496-1-jbrunet@baylibre.com>
References: <20190510164940.13496-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the g12a mdio multiplexer which allows to connect to either
an external phy through the SoC pins or the internal 10/100 phy

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index fe0f73730525..6e9587aafb5d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -460,6 +460,38 @@
 				assigned-clock-rates = <100000000>;
 				#phy-cells = <1>;
 			};
+
+			eth_phy: mdio-multiplexer@4c000 {
+				compatible = "amlogic,g12a-mdio-mux";
+				reg = <0x0 0x4c000 0x0 0xa4>;
+				clocks = <&clkc CLKID_ETH_PHY>,
+					 <&xtal>,
+					 <&clkc CLKID_MPLL_5OM>;
+				clock-names = "pclk", "clkin0", "clkin1";
+				mdio-parent-bus = <&mdio0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ext_mdio: mdio@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				int_mdio: mdio@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					internal_ephy: ethernet_phy@8 {
+						compatible = "ethernet-phy-id0180.3301",
+							     "ethernet-phy-ieee802.3-c22";
+						interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+						reg = <8>;
+						max-speed = <100>;
+					};
+				};
+			};
 		};
 
 		aobus: bus@ff800000 {
-- 
2.20.1

