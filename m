Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8595BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E36C20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u2b+USzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCGPNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:13:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51597 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfCGPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:13:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id n19so9599623wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HuUseLa2zmd8/nZS2QxaCguzDudsaF0923rEqJjh/Uc=;
        b=u2b+USzzZuknePxesV1i3XLW46MLNIfHeJ1uXhlCrDlrqh/2zc9re1W6y5bLdK5tCk
         XSECgJ542UTyTJ+2g7K34xukuXRA2IkUjhjX5j5tt8+TPtNtlfb9OpQ2Ac8NBSE78RCs
         mpls+bQlg62oVM/CPKd6Gl9a0XHfSCM2z+NObYE9j9mgh16ESU9+Pu4dYz44nwgkgeIx
         5iJatANpwWW+jJ3fLTPnR+SeAmyrzuBS23rnW/M8IhdSpAHHKEY6HJF/W39aAyAfYssB
         wK/BG2Gmjmz1LksoNbJfGVDKl3t8CZVTljltdlIDTCDkpJU7zMz+HyBpE25taPqeYylr
         HuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuUseLa2zmd8/nZS2QxaCguzDudsaF0923rEqJjh/Uc=;
        b=ucPbTcGOwXHKoHYcFU5yXNDRsOmGc23xVnVaQ/WHz5XlHl7B3rlBEgnBP8u/ndPnI+
         mk/pva3eu7R3oPZ2DBA+ykskYaE6UYApWKDw+T9i57RiyoB9prkdRpzrc6FUAVX/pM6R
         qZXE5JTL8ALjanxn3HcPXSk3Ox5qY30QOZn7jnBl9rKJX9N24UQVzkTkHmxkM6qkq6ME
         TX+VUBI4DxOqousC0HwHxUhKcnOyQJWVJWIfEBy3o1kxknik4+nZgD8c8vt7shD10B0T
         720+wNPtPeLVb9svh/glvnuc8b8fIdMRSGGyXwL68U+qoNL8ktbBxuVTH12oDtepYjbR
         03dw==
X-Gm-Message-State: APjAAAUO9ilNmvkL9k6SCoI+Kjdujuagcea91Mo9sI1VPV1u0/75tOIt
        Cjk5lKMcZh1MKRk7IY6Zw5xEhg==
X-Google-Smtp-Source: APXvYqxHwJOBmWipAe3mwBTFHjRKhGEGOdYqEvoIPUCBtbTTKuLVoot/CGmhDmOGHdpPKiTdJTQ13g==
X-Received: by 2002:a1c:400a:: with SMTP id n10mr5856094wma.56.1551971629333;
        Thu, 07 Mar 2019 07:13:49 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r15sm5756563wrt.37.2019.03.07.07.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 07:13:48 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] arm64: dts: meson: g12a: Add SAR ADC node
Date:   Thu,  7 Mar 2019 16:13:39 +0100
Message-Id: <20190307151342.7381-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307151342.7381-1-narmstrong@baylibre.com>
References: <20190307151342.7381-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the SAR ADC controller node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 50e2cd36e08b..3bcddd412aa1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -278,6 +278,20 @@
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
+
+			saradc: adc@9000 {
+				compatible = "amlogic,meson-g12a-saradc",
+					     "amlogic,meson-saradc";
+				reg = <0x0 0x9000 0x0 0x48>;
+				#io-channel-cells = <1>;
+				interrupts = <GIC_SPI 200 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>,
+					 <&clkc_AO CLKID_AO_SAR_ADC>,
+					 <&clkc_AO CLKID_AO_SAR_ADC_CLK>,
+					 <&clkc_AO CLKID_AO_SAR_ADC_SEL>;
+				clock-names = "clkin", "core", "adc_clk", "adc_sel";
+				status = "disabled";
+			};
 		};
 
 		gic: interrupt-controller@ffc01000 {
-- 
2.20.1

