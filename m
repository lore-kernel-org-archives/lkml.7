Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8094FC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5273121019
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRA6tw2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfE1XC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 19:02:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36606 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfE1XCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:02:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id u22so261559pfm.3;
        Tue, 28 May 2019 16:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SeJxePvC4sabxiRHYAabfO1ipBpmHj92mjpgW9k3e3s=;
        b=IRA6tw2I1cstnL3LtM4RRGS2qL9ertV8mv5Uw5LUAQlQ8Zit2XhesSqI4EPtxtceaw
         cmMvvOorT/cz66YR9oBtcLh9DJ/LLqHSOSA0MeYaxFtfwdh9ymlhmdqlZ/NNG3sWGzPY
         0cF4ekr5bkE2gJFcGa4iVB+YADFXl5wnIFQ9XRtXbiyId7AFybqBZxN0bszXTmmIAErq
         lj3/VWtLFo3LlPVld63mQPI+TVGCzebU5RHXp13R0OzFwe01YiqHMYt0VFviS+O9xv3T
         vulDDSQJQApO7poz1PVasIgrxaL9ykCEb45uLxYKw+Qbt41l2mAmtT331UwEbSEumu3K
         nuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SeJxePvC4sabxiRHYAabfO1ipBpmHj92mjpgW9k3e3s=;
        b=ava5LA9xueFSV532JhKdcNYAIQ3MNTsPLyS7BLxQj7FTyKiLq7CQkeyVTuQ7cv6zzZ
         nRqzo0duKEb5QQQBuBcgKumvgtSt+avtojKPderGFhS5Q6aGOTGITh71ot3PY51EiwwZ
         LA09ffF6jXFdwkpXC9KMpYqzw6BHm2Tzu5jBNN2t2j38DIEcJ9yggGLEMA6mv/QZSKHI
         B1cbeJtVcrz3jR0mtt7M1Nf7FnOmKv/QYQ2mAb9oz0CROzDx625z+BnEglRK0q3Wj8OP
         Kp0Skb0ySec4PtuD5XhlDl7pQz4Tzs+8H/FZXB7SLAwEGBSKIuyD2HcZ1WZF8jc9tLCH
         UjCQ==
X-Gm-Message-State: APjAAAXAUNRUnc5G5CL3NpgrrXW+i5mV9lgnJvGc0vHFc3g/Ue+EViZd
        0po7K2OjDT7rIDBEDLjbwEc=
X-Google-Smtp-Source: APXvYqxi9YK6HGk2Gh1uvuFERX3GE48Kp223TejwXLP240IqtsOu+uDEpzZgTxbUhc0z5eH+IFnOqA==
X-Received: by 2002:a17:90a:b388:: with SMTP id e8mr8676659pjr.97.1559084534943;
        Tue, 28 May 2019 16:02:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j13sm14369573pfh.13.2019.05.28.16.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 16:02:14 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/7] ARM: dts: BCM53573: Fix DTC W=1 warnings
Date:   Tue, 28 May 2019 16:01:31 -0700
Message-Id: <20190528230134.27007-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528230134.27007-1-f.fainelli@gmail.com>
References: <20190528230134.27007-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the the unit_address_vs_reg warnings and unnecessary
\#address-cells/#size-cells without "ranges" or child "reg" property
warnings.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts | 4 +---
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts  | 4 +---
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts      | 4 +---
 arch/arm/boot/dts/bcm53573.dtsi               | 2 +-
 arch/arm/boot/dts/bcm947189acdbmr.dts         | 4 +---
 5 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
index eb59508578e4..57ca1cfaecd8 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
@@ -15,7 +15,7 @@
 		bootargs = "earlycon";
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
@@ -38,8 +38,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		restart {
 			label = "Reset";
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
index 4c71f5e95e00..2e1a7e382cb7 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
@@ -15,7 +15,7 @@
 		bootargs = "earlycon";
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
@@ -48,8 +48,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		restart {
 			label = "Reset";
diff --git a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
index 5ad53ea52d0a..049cdfd92706 100644
--- a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
+++ b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
@@ -15,7 +15,7 @@
 		bootargs = "console=ttyS0,115200 earlycon";
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
@@ -58,8 +58,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		rfkill {
 			label = "WiFi";
diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index b29695bd4855..4af8e3293cff 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -32,7 +32,7 @@
 		};
 	};
 
-	mpcore {
+	mpcore@18310000 {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x18310000 0x00008000>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm947189acdbmr.dts b/arch/arm/boot/dts/bcm947189acdbmr.dts
index 4991700ae6b0..b0b8c774a37f 100644
--- a/arch/arm/boot/dts/bcm947189acdbmr.dts
+++ b/arch/arm/boot/dts/bcm947189acdbmr.dts
@@ -17,7 +17,7 @@
 		bootargs = "console=ttyS0,115200 earlycon";
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
@@ -43,8 +43,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		restart {
 			label = "Reset";
-- 
2.17.1

