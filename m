Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BA6C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A74F21920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ADS5F3cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389446AbfIIIkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:40:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46099 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389418AbfIIIkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:40:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so8688459pfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 01:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TNGg1bT4M83XgP2RC5fcRc5TAwrl2wtEuXkFfZHHUo0=;
        b=ADS5F3cs90nPD8bSvzEWy/mb+K5U1guRgyF+b9L4vilM7Om3shihnqQDQmspQFACA3
         QyM7CGKF0CfDIwhQvXfQYyGn1ZIvtb9KwPuzjyejVlGYSOyo03KFiEL08MGmm9qC9Vtu
         D4Yhuea7WOLZ3PtvVj45RuMW55RKJ41Fq8kKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TNGg1bT4M83XgP2RC5fcRc5TAwrl2wtEuXkFfZHHUo0=;
        b=f0JL/gYKn5gThlMX+Ye1ijCchfINbLqHta7dvsX+hihF/tuE7/ciDsnjALQQlOqFTI
         lqqjKS7RNaMjAW5k0qKGwGLecoUfhkF25O827cFVLPA+r4xsamDWwVUTZmtS3q1vWPM7
         XdDC44xPQr1yVcmzZFbqzLxDUFYwINO6XyPyu92IPzpwfmQAV5o55q2mKOfykxS0aClK
         yPnBz+HdH26VSpd36M859p57ioiM7n3TBY92hWkdGH+C0dJ63JxxdcoCo0Vv8PpmnTN+
         iGRQmXyMEdYZAYmHxJMWiObPbMsfwOfXlD6+aA0neOu6pCoPX/Ky0082cCE2N1in2DdF
         SoUw==
X-Gm-Message-State: APjAAAVtSHp9yWWSkTHtIdB4iw1WKwhjsJ7ONmBgvQSDxaPp+DrJeHGJ
        WS1wjU85+myhBpHAOwPJteLZig==
X-Google-Smtp-Source: APXvYqxVxkiMU1OnCxUqU9U/Z9h7kM90tIaooxzLYGix97nAkELbgYSZRV6TyhpuDWeJOwZRgBJ9uw==
X-Received: by 2002:a62:ae0c:: with SMTP id q12mr25243724pff.253.1568018411533;
        Mon, 09 Sep 2019 01:40:11 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r27sm16175346pgn.25.2019.09.09.01.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 01:40:10 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] arm64: dts: Fix gpio to pinmux mapping
Date:   Mon,  9 Sep 2019 14:05:27 +0530
Message-Id: <1568018127-26730-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are total of 151 non-secure gpio (0-150) and four
pins of pinmux (91, 92, 93 and 94) are not mapped to any
gpio pin, hence update same in DT.

Fixes: 8aa428cc1e2e ("arm64: dts: Add pinctrl DT nodes for Stingray SOC")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi | 5 +++--
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi         | 3 +--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
index 8a3a770..56789cc 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
@@ -42,13 +42,14 @@
 
 		pinmux: pinmux@14029c {
 			compatible = "pinctrl-single";
-			reg = <0x0014029c 0x250>;
+			reg = <0x0014029c 0x26c>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <0xf>;
 			pinctrl-single,gpio-range = <
-				&range 0 154 MODE_GPIO
+				&range 0  91 MODE_GPIO
+				&range 95 60 MODE_GPIO
 				>;
 			range: gpio-range {
 				#pinctrl-single,gpio-range-cells = <3>;
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 71e2e34..0098dfd 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -464,8 +464,7 @@
 					<&pinmux 108 16 27>,
 					<&pinmux 135 77 6>,
 					<&pinmux 141 67 4>,
-					<&pinmux 145 149 6>,
-					<&pinmux 151 91 4>;
+					<&pinmux 145 149 6>;
 		};
 
 		i2c1: i2c@e0000 {
-- 
1.9.1

