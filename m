Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CB3C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1B621734
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tihjiVu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfE1XC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 19:02:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33168 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE1XCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:02:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id z28so269664pfk.0;
        Tue, 28 May 2019 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DiNorqXWgoDbfgP/oEKyzpDwUhueYSzO5ddWgL3qZc0=;
        b=tihjiVu6azC/bBIP8aC4nnh34lp68t+9yZ67YgfV+qfTeuSQ0Ug/zIefYv1k8dM+N+
         nwggC0P9xHpGBBDMt4ntfXDQVblOA6KVb9YyZ2aPqZf5Lw9j5SwwbqtDIOsT2iJ2vXBl
         JwXGNyjGF5DJiBSs69UK8iy55ek8cUO3ID333MxJzm8KvUI6S9imRH72NNIU4yfPXwFe
         kPzZOcnuyZ1KHsQeO6tjzNCJOh9540seNX9URpAohk9lW1zNLwNoHWGG8/rvdmA4H3UM
         wLrcRT93as7OwQ8Q66IJJXoQb14EJR8a4tAXDF2Q910WXnPfR59JxM6NOln+sp36zNOJ
         5wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DiNorqXWgoDbfgP/oEKyzpDwUhueYSzO5ddWgL3qZc0=;
        b=Jssjs5SjU1mQg9x6WnmpU5tEN/sbmOeHkeT8I53uUUYgQPavZx1M1VUn9bBvpkL8E9
         PLkP8n2VKVdlv2DW4JWdP0cZrJfn4p8i5NV9oXx/5iu061M3FtYdwdzwYg6C+LNhplFf
         No089rhDTOhivUP4k1i6K/iSunkVHRDA4zlP2gkAKx1lWwAqe57AkfXLeq3b6ZhZKRcl
         cU+5uhwJJcBZbHT0s4u6oMaZXqkgFhY/Ia57LoLxGIpmU+8umVfIq2CK/6WfdVNKs0Ey
         pwfhzFBZgtYN+u3YknHOI4my4jeJ+KDNKaoQjkWA8teygOr34YOIk0jsdfy6BUwCRWz3
         VjuA==
X-Gm-Message-State: APjAAAVvG9TOJZNTlRLdJzIHjoW7d0ockxQLy2VqucFtc5m46MwLMmqd
        aqBy0cCR0ABZX7td2gCPwi8=
X-Google-Smtp-Source: APXvYqwUDmK4KFQKcKJs4ycOJWZOGU/ulR86m3hzfITLJW7LiN1cuKIInu67ZZHWBcCmXpIzoD9c3g==
X-Received: by 2002:a17:90a:37c2:: with SMTP id v60mr1569862pjb.24.1559084533477;
        Tue, 28 May 2019 16:02:13 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j13sm14369573pfh.13.2019.05.28.16.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 16:02:12 -0700 (PDT)
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
Subject: [PATCH 3/7] ARM: dts: bcm-mobile: Fix most DTC W=1 warnings
Date:   Tue, 28 May 2019 16:01:30 -0700
Message-Id: <20190528230134.27007-4-f.fainelli@gmail.com>
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
 arch/arm/boot/dts/bcm11351.dtsi        | 12 ++++++------
 arch/arm/boot/dts/bcm21664-garnet.dts  |  2 +-
 arch/arm/boot/dts/bcm21664.dtsi        | 10 +++++-----
 arch/arm/boot/dts/bcm23550-sparrow.dts |  2 +-
 arch/arm/boot/dts/bcm23550.dtsi        |  8 ++++----
 arch/arm/boot/dts/bcm28155-ap.dts      |  2 +-
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index b99c2e579622..6197e7d80e3b 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -100,7 +100,7 @@
 		reg-io-width = <4>;
 	};
 
-	L2: l2-cache {
+	L2: l2-cache@3ff20000 {
 		compatible = "brcm,bcm11351-a2-pl310-cache";
 		reg = <0x3ff20000 0x1000>;
 		cache-unified;
@@ -225,21 +225,21 @@
 		#size-cells = <1>;
 		ranges;
 
-		root_ccu: root_ccu {
+		root_ccu: root_ccu@35001000 {
 			compatible = "brcm,bcm11351-root-ccu";
 			reg = <0x35001000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "frac_1m";
 		};
 
-		hub_ccu: hub_ccu {
+		hub_ccu: hub_ccu@34000000 {
 			compatible = "brcm,bcm11351-hub-ccu";
 			reg = <0x34000000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "tmon_1m";
 		};
 
-		aon_ccu: aon_ccu {
+		aon_ccu: aon_ccu@35002000 {
 			compatible = "brcm,bcm11351-aon-ccu";
 			reg = <0x35002000 0x0f00>;
 			#clock-cells = <1>;
@@ -248,7 +248,7 @@
 					     "pmu_bsc_var";
 		};
 
-		master_ccu: master_ccu {
+		master_ccu: master_ccu@3f001000 {
 			compatible = "brcm,bcm11351-master-ccu";
 			reg = <0x3f001000 0x0f00>;
 			#clock-cells = <1>;
@@ -261,7 +261,7 @@
 					     "hsic2_12m";
 		};
 
-		slave_ccu: slave_ccu {
+		slave_ccu: slave_ccu@3e011000 {
 			compatible = "brcm,bcm11351-slave-ccu";
 			reg = <0x3e011000 0x0f00>;
 			#clock-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm21664-garnet.dts b/arch/arm/boot/dts/bcm21664-garnet.dts
index 8b045cfab64b..be468f4adc37 100644
--- a/arch/arm/boot/dts/bcm21664-garnet.dts
+++ b/arch/arm/boot/dts/bcm21664-garnet.dts
@@ -21,7 +21,7 @@
 	model = "BCM21664 Garnet board";
 	compatible = "brcm,bcm21664-garnet", "brcm,bcm21664";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/bcm21664.dtsi
index 758daa334148..3cf66faf3b56 100644
--- a/arch/arm/boot/dts/bcm21664.dtsi
+++ b/arch/arm/boot/dts/bcm21664.dtsi
@@ -90,7 +90,7 @@
 		reg-io-width = <4>;
 	};
 
-	L2: l2-cache {
+	L2: l2-cache@3ff20000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x3ff20000 0x1000>;
 		cache-unified;
@@ -295,21 +295,21 @@
 			clock-frequency = <156000000>;
 		};
 
-		root_ccu: root_ccu {
+		root_ccu: root_ccu@35001000 {
 			compatible = BCM21664_DT_ROOT_CCU_COMPAT;
 			reg = <0x35001000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "frac_1m";
 		};
 
-		aon_ccu: aon_ccu {
+		aon_ccu: aon_ccu@35002000 {
 			compatible = BCM21664_DT_AON_CCU_COMPAT;
 			reg = <0x35002000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "hub_timer";
 		};
 
-		master_ccu: master_ccu {
+		master_ccu: master_ccu@3f001000 {
 			compatible = BCM21664_DT_MASTER_CCU_COMPAT;
 			reg = <0x3f001000 0x0f00>;
 			#clock-cells = <1>;
@@ -323,7 +323,7 @@
 					     "sdio4_sleep";
 		};
 
-		slave_ccu: slave_ccu {
+		slave_ccu: slave_ccu@3e011000 {
 			compatible = BCM21664_DT_SLAVE_CCU_COMPAT;
 			reg = <0x3e011000 0x0f00>;
 			#clock-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm23550-sparrow.dts b/arch/arm/boot/dts/bcm23550-sparrow.dts
index 1c66b15f3013..ace77709f468 100644
--- a/arch/arm/boot/dts/bcm23550-sparrow.dts
+++ b/arch/arm/boot/dts/bcm23550-sparrow.dts
@@ -45,7 +45,7 @@
 		bootargs = "console=ttyS0,115200n8";
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/bcm23550.dtsi b/arch/arm/boot/dts/bcm23550.dtsi
index 701198f5f498..a36c9b1d23c8 100644
--- a/arch/arm/boot/dts/bcm23550.dtsi
+++ b/arch/arm/boot/dts/bcm23550.dtsi
@@ -371,21 +371,21 @@
 			clock-frequency = <156000000>;
 		};
 
-		root_ccu: root_ccu {
+		root_ccu: root_ccu@35001000 {
 			compatible = BCM21664_DT_ROOT_CCU_COMPAT;
 			reg = <0x35001000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "frac_1m";
 		};
 
-		aon_ccu: aon_ccu {
+		aon_ccu: aon_ccu@35002000 {
 			compatible = BCM21664_DT_AON_CCU_COMPAT;
 			reg = <0x35002000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "hub_timer";
 		};
 
-		slave_ccu: slave_ccu {
+		slave_ccu: slave_ccu@3e011000 {
 			compatible = BCM21664_DT_SLAVE_CCU_COMPAT;
 			reg = <0x3e011000 0x0f00>;
 			#clock-cells = <1>;
@@ -398,7 +398,7 @@
 					     "bsc4";
 		};
 
-		master_ccu: master_ccu {
+		master_ccu: master_ccu@3f001000 {
 			compatible = BCM21664_DT_MASTER_CCU_COMPAT;
 			reg = <0x3f001000 0x0f00>;
 			#clock-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index fbfca83bd28f..ead6e9804dbf 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -21,7 +21,7 @@
 	model = "BCM28155 AP board";
 	compatible = "brcm,bcm28155-ap", "brcm,bcm11351";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
-- 
2.17.1

