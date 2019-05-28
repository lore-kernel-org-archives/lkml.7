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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FAAC04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A14F21019
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwJj4+OY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfE1XCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 19:02:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34468 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE1XCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:02:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id h2so115540pgg.1;
        Tue, 28 May 2019 16:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jGnyRR3m4AUKHhiBC/dTV8rAAismHJ9WvTgbhLm7upM=;
        b=EwJj4+OYvEnyLsIHAHfrCqUTEPuN76PNj1E+QxnDFQj7ZnK40ocbKBogP9K32HpE14
         ZVPzvelwthDxrJUTajrVa25po41p5iiElrgZEuOf+dq1hVo5K/DAR4RjtDaJRhp//tCR
         ItJXBc7ZxB2NYjDIZ1/qigHIrrdXzMOlAoFc1impuySfsWUT4zXR1afj7nYXmefyzb7A
         G5wbfg1I1SgoRzpaxQGvkRzMv4+UDxbS9x/UBOyTiJAzAYNr2dN2nTS7YFtfJsWYDYQy
         IijaO46lrYlBfNjvoWSlgDiuqhQymQDCAwydsVAzyK+LRdL8Ka0ugn9rJpYvSXa1HFf8
         PP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jGnyRR3m4AUKHhiBC/dTV8rAAismHJ9WvTgbhLm7upM=;
        b=pkyQkFYi9FJlHNRYZytgI633P7o/KohkPmgZnNCruVW5RZd+B7VlhZoLMVL+hYulcJ
         N6K/3SGB+0clvIquIGIrZJgfZ9Ez2AaAtruvOc72IacihYqB+My7gHrn6K6XbhipnM3k
         V0OhUuiWUEdHDf1eoSl7ZFmDzyzfMHq7SLX+sL1oWBEH19DqpCbwjghofg65ugD5psXs
         DuhMDeK6k6uR2AILnlR+Rc0TNEvPEyXkgBuGKvHaxDxlb7dq3E1n4ege56ACmGrEsiuo
         tl/viHOp95uZBvO//DHtdYuh4i89owTIeYHJAJYRl50AR3ATHGdRSkw6d7HtLGdLn7+/
         OiZQ==
X-Gm-Message-State: APjAAAW42V5oCKCbBKsD9dV7pk9wCeB1ZsEExCYH8JaUf6vtVAjS+LDm
        TajLgLpxd5eLEfm8+7BAkUs=
X-Google-Smtp-Source: APXvYqwElJnkGtpaWfKSCjWQ2c93XEo9sBmxL0ahodqVjbFOxwxO/EY6kzTU2lYD/iV8pQoLD3SVZg==
X-Received: by 2002:a63:7:: with SMTP id 7mr136754307pga.108.1559084530463;
        Tue, 28 May 2019 16:02:10 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j13sm14369573pfh.13.2019.05.28.16.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 16:02:09 -0700 (PDT)
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
Subject: [PATCH 1/7] ARM: dts: Fix BCM7445 DTC warnings
Date:   Tue, 28 May 2019 16:01:28 -0700
Message-Id: <20190528230134.27007-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528230134.27007-1-f.fainelli@gmail.com>
References: <20190528230134.27007-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a number of unit_address_vs_reg warnings:

  DTC     arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb
arch/arm/boot/dts/bcm7445.dtsi:66.6-225.4: Warning (unit_address_vs_reg): /rdb: node has a reg or ranges property, but no unit name
arch/arm/boot/dts/bcm7445.dtsi:227.21-298.4: Warning (unit_address_vs_reg): /memory_controllers: node has a reg or ranges property, but no unit name
arch/arm/boot/dts/bcm7445-bcm97445svmb.dts:9.9-14.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
arch/arm/boot/dts/bcm7445.dtsi:255.10-275.5: Warning (simple_bus_reg): /memory_controllers/memc@1: simple-bus unit address format error, expected "80000"
arch/arm/boot/dts/bcm7445.dtsi:277.10-297.5: Warning (simple_bus_reg): /memory_controllers/memc@2: simple-bus unit address format error, expected "100000"

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm7445-bcm97445svmb.dts | 2 +-
 arch/arm/boot/dts/bcm7445.dtsi             | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm7445-bcm97445svmb.dts b/arch/arm/boot/dts/bcm7445-bcm97445svmb.dts
index 8006c69a3fdf..8313b7cad542 100644
--- a/arch/arm/boot/dts/bcm7445-bcm97445svmb.dts
+++ b/arch/arm/boot/dts/bcm7445-bcm97445svmb.dts
@@ -6,7 +6,7 @@
 	model = "Broadcom STB (bcm7445), SVMB reference board";
 	compatible = "brcm,bcm7445", "brcm,brcmstb";
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x00 0x00000000 0x00 0x40000000>,
 		      <0x00 0x40000000 0x00 0x40000000>,
diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
index 504a63236a5e..58f67c9b830b 100644
--- a/arch/arm/boot/dts/bcm7445.dtsi
+++ b/arch/arm/boot/dts/bcm7445.dtsi
@@ -63,7 +63,7 @@
 			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(15) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
-	rdb {
+	rdb@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
@@ -224,7 +224,7 @@
 
 	};
 
-	memory_controllers {
+	memory_controllers@f1100000 {
 		compatible = "simple-bus";
 		ranges = <0x0 0x0 0xf1100000 0x200000>;
 		#address-cells = <1>;
@@ -252,7 +252,7 @@
 			};
 		};
 
-		memc@1 {
+		memc@80000 {
 			compatible = "brcm,brcmstb-memc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -274,7 +274,7 @@
 			};
 		};
 
-		memc@2 {
+		memc@100000 {
 			compatible = "brcm,brcmstb-memc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.17.1

