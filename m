Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D2EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354622084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vZEN+DW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfCKJ4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:56:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55207 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfCKJ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:56:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so3723207wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWYrpJ4u6j7Px4ea6cF8sUAOQBRW0gQe+bRpxndR0M0=;
        b=vZEN+DW+EXX4Ss4jOWBxKRGsmJsRS3b0NxgmxxYR2he3u43Mq0iNladnMjAVmFVhU+
         boB8tXLCW3K8zYq6mSi6OBdmKCZSoqf53YjGkFPeiN+S6F1nucUTEE700M0echqH8QHF
         03rUfua/RjZONQJFHF7xfB7CLwRhBww48hzZHmRlaaC5Gy5FLMefiSIKs1s1hNRrxCg9
         LWfSqNAUrjv+GITY1dUB+6KURJDiltqVeSMEDOSnOwSQsDEBl19aM1Hu9PiJR2nevI4f
         xWiPEjj8hLRNr0Sp5UWH0G6YgEbSZBrmEMTawPXgmiBWyNEZVjsnin52SLp5o6ztrCSh
         jfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWYrpJ4u6j7Px4ea6cF8sUAOQBRW0gQe+bRpxndR0M0=;
        b=rqnfAljV6YJsUAnZChvm5lpmg5ADmGTxRjEGiVSVGXQ92QEViYVEplG6+KcJgxQ5nt
         QPFECY7EXtzerRRvYHU8bOqdlEYGHBKhArWr4uHCq5RQwJQQmuSAYAkwZnxpT9DSm+jV
         fvKzEiIgrseObCoDvSEmFjHYbRD1WXCRQyG6CiAieg5qfBhUOLaIs11vYbPINXWeoR99
         T3H/dMbLTmtNqDqz7j8x8DdfLZKFk8pvWYYagC/WzwD00XXmI6dHPULlGSuZqEFNHvqf
         pLOTiRLJR58zrKB1oxLcBAqNBmhSCX4L1wOEe1jADnvE++qxm4lQZA8W7I3PBGmirztK
         CXeQ==
X-Gm-Message-State: APjAAAUIF+gnUGpaYCNjcxGtkujv50ntVgdDlZClHOUTM7BrG4iej70j
        2cpgIBqwB0vo7M1eNFaEIuISH1qVs5NOWw==
X-Google-Smtp-Source: APXvYqzo0P9itClJMbIJLsoCZUD7VcIW3axRTvJ/oWmFsJHAvXCPOXkPLoZ8g9tUf+Hh2E3mWOs3yQ==
X-Received: by 2002:a1c:a74a:: with SMTP id q71mr17349119wme.45.1552298181499;
        Mon, 11 Mar 2019 02:56:21 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e12sm4764737wrs.91.2019.03.11.02.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 02:56:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 06/11] arm64: dts: meson-g12a-x96-max: add regulators
Date:   Mon, 11 Mar 2019 10:56:08 +0100
Message-Id: <20190311095613.11371-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311095613.11371-1-narmstrong@baylibre.com>
References: <20190311095613.11371-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume La Roque <glaroque@baylibre.com>

Add system regulators for the X96 Max Set-Top-Box.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 0edbd00b358f..21e5de48613e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -21,6 +21,71 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
+
+	flash_1v8: regulator-flash_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "FLASH_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	main_12v: regulator-main_12v {
+		compatible = "regulator-fixed";
+		regulator-name = "12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+	};
+
+	vcc_1v8: regulator-vcc_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+		/* FIXME: actually controlled by VDDCPU_B_EN */
+	};
+
+	vcc_5v: regulator-vcc_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&main_12v>;
+
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+	};
+
+	vddao_1v8: regulator-vddao_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&main_12v>;
+		regulator-always-on;
+	};
 };
 
 &uart_AO {
-- 
2.20.1

