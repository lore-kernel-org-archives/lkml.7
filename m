Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BE8C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DF92171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zy8etsnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfDLNow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:44:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34151 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfDLNoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:44:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id r186so505201wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkvoQ7ZQRviI68t1GQUcpGSIR6wTw9yWovYigsGIRFY=;
        b=zy8etsnzC/31AnsGcdkPZ1o5dFiVel0XakIolc9PFfPpjNrsdxhytGGc+lzXmkc+Nm
         gWZGWfgQHFXhyrOQP3XuwFIPoMYF2YiJrQASb35V5mBL7uDIJp9+8vxmG2Ef6Cb0bNkW
         FSoev2AQzNWTKey04PyOU/dIzHifNa/g+bkjcxHxssJHlOSNn3Eu5APGuz7QyZc0YSQB
         rCsNrjHy9FpnigB3MnOqAcOnwPFIln/XrX4K8/HyN4733m/H13+imXB5YAq1TswocTcV
         t1Uo6eZvEYbmoyv/khiu+gdpIKoBcjSVnts1E+Ftdnu4meNx70lO0TncNg/NDn4bQT3a
         URNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkvoQ7ZQRviI68t1GQUcpGSIR6wTw9yWovYigsGIRFY=;
        b=rKBoP4HseBnfMu3TsK3ImRgsoXdB700f0fC6H3S8oYDy+IFsLXZo3QXebNQjc7OvZ2
         hZhSU2M9QKTa+eeNtr8L+Olhd6tDQTc/yA8U39wcGkCDxmTDGi+ZOM5DM/WBk7orap2+
         5XKV1dD3X9udOcDGxYbgd2qR3ovoByOkwgDuIJTJOMZ+IVNiJinbqaDKUz0VqTXbYrde
         t9ZBvzrPd1z/hxiGH2WbsM+OahuoYzk62OAFtytEIe6Spj2uCVtFD0J8Wl3zyh5kNaA6
         WIgts3pJ4GxrcxUjUH6lKCXvGaBaDExWK2+VhGnGf30uDl23g4ja7pM0RsoKjPb8514v
         TgzA==
X-Gm-Message-State: APjAAAUmqKb1P7UaBvXgTC+ISNRXgyyYjIRkW/dr1i/Voa9//xLBrvA4
        +VF0irmXC5tafkUmLmoiwKrm9A==
X-Google-Smtp-Source: APXvYqxoAjNUqxR97U/CLESa8eahBfhBY6LOC2K/5ekgiWrat/QpzQzuh9MSqom3KbWPQSVFf6r0Tg==
X-Received: by 2002:a1c:7512:: with SMTP id o18mr11685535wmc.68.1555076684397;
        Fri, 12 Apr 2019 06:44:44 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-35-248.w90-86.abo.wanadoo.fr. [90.86.90.248])
        by smtp.gmail.com with ESMTPSA id s18sm9964672wmc.41.2019.04.12.06.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:44:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 2/5] ARM: dts: da850-lego-ev3: enable cpufreq
Date:   Fri, 12 Apr 2019 15:44:34 +0200
Message-Id: <20190412134437.14864-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412134437.14864-1-brgl@bgdev.pl>
References: <20190412134437.14864-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

Add a fixed regulator for the LEGO EV3 board along with board-specific
CPU configuration.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index 66fcadf0ba91..553717f84483 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -125,6 +125,15 @@
 		amp-supply = <&amp>;
 	};
 
+	cvdd: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "cvdd";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	/*
 	 * This is a 5V current limiting regulator that is shared by USB,
 	 * the sensor (input) ports, the motor (output) ports and the A/DC.
@@ -204,6 +213,27 @@
 	clock-frequency = <24000000>;
 };
 
+&cpu {
+	cpu-supply = <&cvdd>;
+};
+
+/* since we have a fixed regulator, we can't run at these points */
+&opp_100 {
+	status = "disabled";
+};
+
+&opp_200 {
+	status = "disabled";
+};
+
+/*
+ * The SoC is actually the 456MHz version, but because of the fixed regulator
+ * This is the fastest we can go.
+ */
+&opp_375 {
+	status = "okay";
+};
+
 &pmx_core {
 	status = "okay";
 
-- 
2.21.0

