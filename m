Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BC8C16A69
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A43621479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5tgs8yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfEVHVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:21:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41144 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbfEVHVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:21:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so850082pgp.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 00:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kHSgRkcaDJjRSdqELdkMhZEbAHoVQntlFI0IvZxHj3E=;
        b=k5tgs8yggvJF5OSHf7bQhIAln+SBF+Tg3xuz4GJO96CgvDj/1RGgOW1SGICp1U1leY
         1HUBAfYy3otMIAtn7gD9kuKxovYH1YP+Ej56K5w7v57kbmW7lQUeYiecQUwsvUQJhy+e
         vlHsaaHlgB1qW+xeCwctGWMp0Al27Oy6dUQsQxCkcOYWvZdqbf1C7LndUuwSbc3nGbss
         N5BAzrRoQ/kJMylK/VsARNBUqZovu01oHYx4sAahMyfEOoVOrvGD2EvvngsIXXj/Gper
         mr4sduB4o1fhwrFiDj23V7VZaUAMo1h9xDRuO+9Qf3MJB/YVgRjZhcl9xTpEfZYh56kF
         o7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kHSgRkcaDJjRSdqELdkMhZEbAHoVQntlFI0IvZxHj3E=;
        b=ie4kOe+fGCqAb6aPeOQNijDBDMrrLAxAQCb81WpXoTXQExMHqi8vDXQ+4F57/E0tdH
         wZ3+b9aO+k9PGTFV0WigYnET5Ufigeg8LE0xyuW6BEfoCyuwHFaF6UHRSzEEZ2+ZU+qV
         48AgL/uzeXhAd6AELcjcRy3DREckMHgLcElhJGu3okKgvBMXMBU7DjwYTNZjnYtyFSmC
         wehciXwm1rt4eDc/Du3YtqzUminiW63ffjVBGkADlMFQqU8VrMaN0880P+lgj53HbIgN
         qhUPW3h9RIw8TkIk69H6mSEWzfkZEsTTqPV+FvjmY45qKCJ8yBoZD82l0+ZAXOdrHh3M
         LIrw==
X-Gm-Message-State: APjAAAUvriExW3bJT+kUf3aI1vit5wkz81cJ/UPaqgK6HzJkTomhJSLP
        qoUxlb4mGuNCTkUGjT0xtta90v+/OWc=
X-Google-Smtp-Source: APXvYqwY/1cQhdKm4eoDKJUfcXRp7vhDSoXaJFpJ1OsO2RNViu3fuL+yZi8dla0AvbG8t2ACUvyyrw==
X-Received: by 2002:a63:4a4f:: with SMTP id j15mr87678043pgl.338.1558509673946;
        Wed, 22 May 2019 00:21:13 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t5sm25307204pgn.80.2019.05.22.00.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 00:21:12 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: vf610-zii-dev: Add QSPI node
Date:   Wed, 22 May 2019 00:20:52 -0700
Message-Id: <20190522072052.2829-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522072052.2829-1-andrew.smirnov@gmail.com>
References: <20190522072052.2829-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both rev C and rev B of the board come with two QSPI-NOR chips
attached to the SoC. Add DT code describing all of this.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v1]:

  - Small spelling fixes in comment block
  
[v1] lore.kernel.org/r/20190513035909.30460-2-andrew.smirnov@gmail.com

 arch/arm/boot/dts/vf610-zii-dev.dtsi | 48 ++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index 1f2e65ae2bd6..a1b4ccee2a10 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -177,6 +177,36 @@
 	status = "okay";
 };
 
+&qspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi0>;
+	status = "okay";
+
+	/*
+	 * Attached MT25QL02 can go up to 90Mhz in DTR and 166 in STR
+	 * modes, so, spi-max-frequency is limited to 90MHz
+	 */
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <90000000>;
+		spi-rx-bus-width = <4>;
+		reg = <0>;
+		m25p,fast-read;
+	};
+
+	flash@2 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <90000000>;
+		spi-rx-bus-width = <4>;
+		reg = <2>;
+		m25p,fast-read;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart0>;
@@ -360,12 +390,18 @@
 
 	pinctrl_qspi0: qspi0grp {
 		fsl,pins = <
-			VF610_PAD_PTD7__QSPI0_B_QSCK	0x31c3
-			VF610_PAD_PTD8__QSPI0_B_CS0	0x31ff
-			VF610_PAD_PTD9__QSPI0_B_DATA3	0x31c3
-			VF610_PAD_PTD10__QSPI0_B_DATA2	0x31c3
-			VF610_PAD_PTD11__QSPI0_B_DATA1	0x31c3
-			VF610_PAD_PTD12__QSPI0_B_DATA0	0x31c3
+			VF610_PAD_PTD0__QSPI0_A_QSCK	0x38c2
+			VF610_PAD_PTD1__QSPI0_A_CS0	0x38c2
+			VF610_PAD_PTD2__QSPI0_A_DATA3	0x38c3
+			VF610_PAD_PTD3__QSPI0_A_DATA2	0x38c3
+			VF610_PAD_PTD4__QSPI0_A_DATA1	0x38c3
+			VF610_PAD_PTD5__QSPI0_A_DATA0	0x38c3
+			VF610_PAD_PTD7__QSPI0_B_QSCK	0x38c2
+			VF610_PAD_PTD8__QSPI0_B_CS0	0x38c2
+			VF610_PAD_PTD9__QSPI0_B_DATA3	0x38c3
+			VF610_PAD_PTD10__QSPI0_B_DATA2	0x38c3
+			VF610_PAD_PTD11__QSPI0_B_DATA1	0x38c3
+			VF610_PAD_PTD12__QSPI0_B_DATA0	0x38c3
 		>;
 	};
 
-- 
2.21.0

