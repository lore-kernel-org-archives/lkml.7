Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77684C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B212186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ssZ3nbw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfCONnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:43:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38932 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfCONmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:42:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id p8so9649609wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyS/YZPD5p3AVqB/Q5owFZpxvtTyLZqFLYc5jnuRxaY=;
        b=ssZ3nbw778qWn4FjK6qocnt1XtcEE3TUaUChdc6yDsnleU0nPOe1OhSFw5FErs1yTC
         /Ms1Mbfj1LsNnrrM24MQ770VXASbGxtuSHTajx9gcZQnyAXhpNdNVjx+FSGBsHRPt9+x
         Txdx3sDyBbwV6qwjw7CzshfAYYSSPHyx/yaPF5u5HwHVZozbtUqyGAyCwoDt5G9XXCtP
         2hbwDsIZQ9MwYEDCgrW9f7vB/+FB0u6rV8EuMtjmi+jUoyaKA21yHo13V7kHX04YsujD
         EnMcWgg2uu7aIXu2uUYEn150yGdtji3fQVCfabEFBMGdF3icCFnjx2xeFhe5VCrWXCej
         P3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyS/YZPD5p3AVqB/Q5owFZpxvtTyLZqFLYc5jnuRxaY=;
        b=psE2mv0MUpYA2aR1YnthDZoCjnk/E5vS3up64bKItE2GlZffL8MFPxGSS4rIsf801/
         Q3uLBL32jckf5iM5qGr1NnI/ZszHZuCHGG4Fk7iGXSG90EsXfLRweqNx7NFBpcEXkIXz
         0kah6RhUsj0Zj82QIksB3nHqKDMsNYmyq0nZUUOiiWmSwZTP6bGHYaq66qT55ZYF7EPU
         NTI6wnuWSf9LAthDxpgT70/urRJY4MTr1CPG0descpXiHuV5Y30KSKmia/PBBOAsq9uo
         cLXgM5hA8eJ26CR9I32jQ2tfGf1hFgnC1Hpobk/+UlQNwUw8mGlXOnWxOV2vkq0MUjL4
         QgAw==
X-Gm-Message-State: APjAAAXObRqSlaI8ryFuMrpFzFuJENyhk64fwOjhMXVMTr9lJWJ2PAGn
        JJTJlK84p6JH1sqRyA1GI63lEw==
X-Google-Smtp-Source: APXvYqzCvh05ZUHZRuJvmkMSMomtkEKoIBwKANQTpJyxyO9QlAq9SYTYSZT8kYekkd60U0DHWCvlQA==
X-Received: by 2002:adf:f111:: with SMTP id r17mr2594683wro.272.1552657373817;
        Fri, 15 Mar 2019 06:42:53 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id x17sm4616143wrd.95.2019.03.15.06.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 06:42:53 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: meson: g12a: add efuse
Date:   Fri, 15 Mar 2019 14:42:44 +0100
Message-Id: <20190315134244.14141-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315134244.14141-1-jbrunet@baylibre.com>
References: <20190315134244.14141-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the g12a SoC efuse device

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 92ee8c895ba6..dcc821cf35bb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/g12a-clkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -55,6 +56,14 @@
 		};
 	};
 
+	efuse: efuse {
+		compatible = "amlogic,meson-gxbb-efuse";
+		clocks = <&clkc CLKID_EFUSE>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		read-only;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.20.1

