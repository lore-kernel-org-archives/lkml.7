Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDB6C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2803D2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LoYp4Hfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfDLMwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:52:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33938 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbfDLMv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:51:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id r186so403182wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2XgHdka99JxAH5bHt7QNVLYXwa4NYXicHBYGQh/K/U=;
        b=LoYp4HfsTJ5FffilToBeq3hf38rheo1/X2SZYNC8RiUZL8PK2c0mOJmHVO8WRJWkG7
         9EAjSSQy74qy8kNTNCnt+CuLOeEW/pPXOMN5n62xB1jw13CIsRU6qDbN1AZ2cA7M0L+6
         7X5KJqZpKJIu408rWW2j8viRuP/UDOJo7mHIn3SQHUo2J/brKcceEChlaTe5SDyx5/+s
         9cBMjfMOYMh/g35TNOl7qlB7QVadE2uhABLgY690wECOobMkVdHHxg9wTMCBcWTBsW39
         t8s5VLeFhEn+QT0oodLAIdnYQXMmi4SDOzmyQUGnB0dQ0ZL748fAPGIf+dNvIo0+6J5Y
         T75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2XgHdka99JxAH5bHt7QNVLYXwa4NYXicHBYGQh/K/U=;
        b=RbT8GeVn8IfgKNLONTa+GeRYWp/t8Yjn+iukuoW4lDNeKjdBwUqgwbcdIdyXRXSKDQ
         vD4a6xqVqB7A4i2vytlGRuJ34wiM+knJGn0RK9hEIlPAa4K1QsvXC4LNgyifBOSZ1pCY
         +M87TO8AvYKM+NaV3EgqC1w9aIaPgoSBaaSCYa1EWDdEIaLm0x4jKgSQ9tmYIr+P3GVE
         O+zVOnGlgUFvRDUuRL4N3Ojbli6jtG3IwhKsTJ2Chj57mI8jf9zX0ZPiigO1f2NrB1E0
         fTHsZp/zgKfRMV4phMYeEB5QdVY/ntPWZ8khwH5BKWyjseAkedKy4JBmc4NZeZMBHeCp
         bEOA==
X-Gm-Message-State: APjAAAX6yCpfE5BEdYXeE9VD/UV3boBOwBMmHWg0i2wczk6FUpOS27ri
        wvylZn9Q7S9z335YzIZuktnPCg==
X-Google-Smtp-Source: APXvYqwZNcVmfesEvsS9kQo3zK1W6pR/gwgB05Ni/jHWLnfkJTuuNFJxxSjEkDSckQYCiwGH1YsKBA==
X-Received: by 2002:a7b:c5ce:: with SMTP id n14mr11375013wmk.18.1555073517956;
        Fri, 12 Apr 2019 05:51:57 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id b3sm42049702wrx.57.2019.04.12.05.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 05:51:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 7/7] arm64: dts: meson: g12a: add spdifin
Date:   Fri, 12 Apr 2019 14:51:36 +0200
Message-Id: <20190412125136.28232-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412125136.28232-1-jbrunet@baylibre.com>
References: <20190412125136.28232-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the spdif input device of the g12a SoC

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index ab46b2b0fb86..41419ff74be7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -427,6 +427,19 @@
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

