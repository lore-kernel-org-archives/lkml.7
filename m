Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5EAFA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 05:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845062067B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 05:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2KerGRia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406310AbfJQFGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 01:06:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53592 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394756AbfJQFGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 01:06:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so1032287wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 22:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pg/p3AMzyR1Wsfbjwo4TUDBEOFDuNcbzBHUL3mVG5Co=;
        b=2KerGRiawXAcoyU5jZdb0jN3uqQDas6YiYGKblTYiUv++5sGE29UBHO37R2wOlCCtZ
         jm1ojMM6n32rM3pie09wLOogX4O0RXkPAqYFEDq6Uwk7xGsNnKtXMEbEaJPyciOPDJND
         tYsluIbhk8k8oFJfwp/k559K1UhuRvKzW2iAXiMW2xfoTimq2EmUZkDpv5jcd/ESQBsI
         dyxBBN/Xzn6VbtVb8JwD6msoz9CztW1MENjN5mqpPYYGyNE7MtrEQplHxhir+wpTzWFx
         ZM60i8qRFCWqArLQvGrg6FS4WWepa6fq1oHCZUmUVEJ3eV01qR5DvKFbf+i+LKU1gQOx
         qSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pg/p3AMzyR1Wsfbjwo4TUDBEOFDuNcbzBHUL3mVG5Co=;
        b=LbFrY2sYpbF6M7PzehyEwW0RLi8ijfIIIC4FcvNk3nHdV4y1MaAuVeYMRlLnSgOaIb
         TW+rqG62lNnNuhx6/UsESa+12g7wEm76oYL0KCSzKX36aUXeOkJNgvpPdiC0Ui4kLSNb
         5wdGefvmKlKm6kXyKn1jI611sw9l+/3WHdli/HHvfjW6W933TMoJ8fgqjmdeI3Cnno69
         w9430BjCNOZoyXN6zceI28NgwMPaW7tWAKL1+ZQ5UJ+JFpzBkhDMD5XuOc2DHDeksZtS
         R8fCIgZsBhrpO5W0LzvUI5OjeyU0ByGqAnZV57PlmziCM2k/nXXRrsShQ6vZJH3Jtfgv
         JO1g==
X-Gm-Message-State: APjAAAVryq9meYuLAOtMmr42DCB5HnBPvpR/Cb0ldtz/6z3r1er3OOW5
        5pj+lNJyUhOEelpsNvHw+dBKbRLTmzI=
X-Google-Smtp-Source: APXvYqwsyi5V+5cR6/K2hgajkrfncw2TMPjLW5hIO9IlryAJhwY0DliIR8XdvOONvx2HmfA/ssyQXg==
X-Received: by 2002:a7b:ce89:: with SMTP id q9mr1071924wmj.2.1571288806246;
        Wed, 16 Oct 2019 22:06:46 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id b5sm1010762wmj.18.2019.10.16.22.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 22:06:45 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        khilman@baylibre.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 4/4] ARM64: dts: amlogic: adds crypto hardware node
Date:   Thu, 17 Oct 2019 05:06:26 +0000
Message-Id: <1571288786-34601-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571288786-34601-1-git-send-email-clabbe@baylibre.com>
References: <1571288786-34601-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the GXL crypto hardware node for all GXL SoCs.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 49ff0a7d0210..ed33d8efaf62 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -36,6 +36,16 @@
 				phys = <&usb3_phy>, <&usb2_phy0>, <&usb2_phy1>;
 			};
 		};
+
+		crypto: crypto@c883e000 {
+			compatible = "amlogic,gxl-crypto";
+			reg = <0x0 0xc883e000 0x0 0x36>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clkc CLKID_BLKMV>;
+			clock-names = "blkmv";
+			status = "okay";
+		};
 	};
 };
 
-- 
2.21.0

