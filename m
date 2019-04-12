Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DC6C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154A62171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jGNInin9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDLKF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:05:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34202 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfDLKFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:05:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so11199853wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvmR6ZC2WBqA56mgWPjb45tpByysg+xqHoPIFiNE7Fk=;
        b=jGNInin92KMDYoznDFiw8loAVyH9c++D/ZSBrY/xSg/L1LcXGyKr1owkBA+OsVtmmo
         t5Rkm1GptUiy2JiW6kV1ImloTSk3DONl9e6DTBkjRdfMSwePL2mIpXehMRDKzQdr8AoX
         WskJj8I821uuoc8p8RjJWR0e/5hHCBmrTh//bJw3D0aqCxfmhFDlNS5iFR85sgEvjKOJ
         L5u4hDGaO8R4gZyS7NQNNk/8ZbOAS2TYOi/1PHlV4kZOztET5/Y8K6RURIgDK1kD32Yl
         TwVotHg0HypKoWbG+SPbqaa6X2OI2Gw8N3ZzdXoy6Pm/sdrEbEZ9pH7pgJkwArJyNxoD
         h2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvmR6ZC2WBqA56mgWPjb45tpByysg+xqHoPIFiNE7Fk=;
        b=lm8g4LpFW8v8SjS+Z7Oc1UxKtInI92kl6JUnqmWbkRpOdMTdlJiS5p3wxhhyCaphdh
         M6i06xyfNbO0pCHT00Hz1YqJ5qdGoAkIP6cO07+8qaX8Pp+vKCF3oaBIoVy6zH2OK2Yw
         ifTkqsIEueLL10tXsmJ21POOdnHEzv5UkzRkmxQXlhnJw85IfYRJ/yKYps27KNxB6gCb
         z1K4uiMmvyNHq3PEvuA0D2f81XU5inzmSqmJQAUN01whYQGnGAaPGWXQUfhxw/LJkEIa
         bewo/wMW7MiTuxoNe2kODZACuMijdHHvyNk5tNtxT1OZGJu8up970VQs4AyRkQ7/R1WF
         Hj+g==
X-Gm-Message-State: APjAAAXX5bOmHqCcdvUEauLVnO/3xtg2VYIsHsUDjYsThytKi76Ew5PY
        +nsWiXh62nx2unmBc0mN40cSH1hTVYMnzG1L
X-Google-Smtp-Source: APXvYqykgrvRBIEJ2DXSga7rKAqseH7dBWIsfKFYhMUw2FKueq46rB12K7ULsVNM50nfWa/ew1wIgQ==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr35812966wrq.242.1555063521422;
        Fri, 12 Apr 2019 03:05:21 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s10sm10545602wmh.0.2019.04.12.03.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 03:05:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: meson-g12a: Add IR nodes
Date:   Fri, 12 Apr 2019 12:05:16 +0200
Message-Id: <20190412100518.24470-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412100518.24470-1-narmstrong@baylibre.com>
References: <20190412100518.24470-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic G12A SoCs uses the exact same IR decoder as previous
families, add the IR node and the pintctrl setting.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 734c5ee60efa..9cb76d325bb7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -559,6 +559,13 @@
 						mux {
 							groups = "pwm_ao_d_e";
 							function = "pwm_ao_d";
+						};
+					};
+
+					remote_input_ao_pins: remote-input-ao {
+						mux {
+							groups = "remote_ao_input";
+							function = "remote_ao_input";
 							bias-disable;
 						};
 					};
@@ -623,6 +630,13 @@
 				status = "disabled";
 			};
 
+			ir: ir@8000 {
+				compatible = "amlogic,meson-gxbb-ir";
+				reg = <0x0 0x8000 0x0 0x20>;
+				interrupts = <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+			};
+
 			saradc: adc@9000 {
 				compatible = "amlogic,meson-g12a-saradc",
 					     "amlogic,meson-saradc";
-- 
2.21.0

