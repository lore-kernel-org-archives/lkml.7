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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABB5C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2DA216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpbbByeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfE1XCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 19:02:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35044 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfE1XCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:02:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so263113pfd.2;
        Tue, 28 May 2019 16:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JrcPDuAFrT0kBFAkL3W3QNhPSv5oCk1/oSUkr2l2aQg=;
        b=RpbbByeIQSuxpCpW000iv9NexBvHSPXVbUWRIQdw2/m8q/ohtNGBYflUZgy9ZKltGA
         aJSEwHEHHHgjoysC5gacLMJuTuRqIM3kZZFLq8UaXX9DYIxIUygYz7nmd4G6/WE5YADe
         ylYnDLrhjaUSft+KuqT8j5xq24UcbqpVnSzI4aIHDqs6IJ5RGp52k+b/+riPV03IWFB2
         2TjW89G4Io95py93GZie6KCOhZEQRE4NpbOIkq4qR29uYmlQYE77HDCbnijLTX5pFBU8
         rrBmscbnXEhYI03D8sLzy3gNo9DGooJcoCVB0Z0NuuT5CeKBdhLI6TPLnRew3v730qPH
         QenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JrcPDuAFrT0kBFAkL3W3QNhPSv5oCk1/oSUkr2l2aQg=;
        b=V+vqdvIrCsnJ7JepgtF9AHRMDezlwfYl+ohxkXQzaug0EtQdvdQGC75Kh1Owf8QBJd
         4a6zHlYQJAH5OGUlp+S4V+XR7/ADXboZsbNGaIhY9VmgFTpuLJ7H8uDHjOaOfmbX/++Y
         S8dBeyPwo9hySoDsMI+Kd6UAwqu/MdpbNgRJE4yzIT4WqOdgG9MbAuS6XqW6ZoQWXoTK
         NsoEYC+uWlvJM8PIgjLHhmiytOG5Fd4Z60zHm1cLbX+qKg4iZZoLYvOQgdDw6U05BhS7
         ZPh4pz+s0NXMtpV4TVh2ysegdx8lCUNtIqt+ZxPZjjqaV5UeDjKN/iShN93cRSdP0M1G
         vwqA==
X-Gm-Message-State: APjAAAXL6sxTmHOV0I1htfqqUQczjQ+YqaxBsGraxcjH1VBV0asiv90C
        Jb0qywb9KMvm2Tee0cGoiAg=
X-Google-Smtp-Source: APXvYqzmyQ4N+ykhgfKclIyz83roWdW3COf/TLcBCRdQQyOr7Y0HBhdCu30wnl7INN8Tcu0LC9OpkA==
X-Received: by 2002:a63:2ad2:: with SMTP id q201mr131357493pgq.94.1559084539511;
        Tue, 28 May 2019 16:02:19 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j13sm14369573pfh.13.2019.05.28.16.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 16:02:18 -0700 (PDT)
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
Subject: [PATCH 7/7] ARM: dts: NSP: Fix the bulk of W=1 DTC warnings
Date:   Tue, 28 May 2019 16:01:34 -0700
Message-Id: <20190528230134.27007-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528230134.27007-1-f.fainelli@gmail.com>
References: <20190528230134.27007-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the bulk of the unit_address_vs_reg warnings and unnecessary
\#address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi     | 9 +++------
 arch/arm/boot/dts/bcm958522er.dts  | 2 +-
 arch/arm/boot/dts/bcm958525er.dts  | 2 +-
 arch/arm/boot/dts/bcm958525xmc.dts | 2 +-
 arch/arm/boot/dts/bcm958622hr.dts  | 2 +-
 arch/arm/boot/dts/bcm958623hr.dts  | 2 +-
 arch/arm/boot/dts/bcm958625hr.dts  | 2 +-
 arch/arm/boot/dts/bcm958625k.dts   | 2 +-
 arch/arm/boot/dts/bcm988312hr.dts  | 2 +-
 9 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 6925b30c2253..da6d70f09ef1 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -77,7 +77,7 @@
 		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
-	mpcore {
+	mpcore@19000000 {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x19000000 0x00023000>;
 		#address-cells = <1>;
@@ -122,7 +122,7 @@
 			      <0x20100 0x100>;
 		};
 
-		L2: l2-cache {
+		L2: l2-cache@22000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x22000 0x1000>;
 			cache-unified;
@@ -166,7 +166,7 @@
 		};
 	};
 
-	axi {
+	axi@18000000 {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x18000000 0x0011c40c>;
 		#address-cells = <1>;
@@ -415,9 +415,6 @@
 					  "imp_sleep_timer_p5",
 					  "imp_sleep_timer_p7",
 					  "imp_sleep_timer_p8";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
 			status = "disabled";
 
 			/* ports are defined in board DTS */
diff --git a/arch/arm/boot/dts/bcm958522er.dts b/arch/arm/boot/dts/bcm958522er.dts
index 21479b4ce823..8c388eb8a08f 100644
--- a/arch/arm/boot/dts/bcm958522er.dts
+++ b/arch/arm/boot/dts/bcm958522er.dts
@@ -43,7 +43,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm958525er.dts b/arch/arm/boot/dts/bcm958525er.dts
index cda3d790965b..c339771bb22e 100644
--- a/arch/arm/boot/dts/bcm958525er.dts
+++ b/arch/arm/boot/dts/bcm958525er.dts
@@ -43,7 +43,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index f86649812b59..1c72ec8288de 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -43,7 +43,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index df60602b054d..96a021cebd97 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -43,7 +43,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index 3893e7af343a..b2c7f21d471e 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -43,7 +43,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index cf226b02141f..a2c9de35ddfb 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -43,7 +43,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index 10b3d512bb33..3fcca12d83c2 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -42,7 +42,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index e39db14d805e..edd0f630e025 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -43,7 +43,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x80000000>;
 	};
-- 
2.17.1

