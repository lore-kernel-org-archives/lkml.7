Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0315C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB0A218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekAuhqdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfCXIdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 04:33:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40006 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfCXIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 04:33:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so4303903pfc.7;
        Sun, 24 Mar 2019 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dq88nNP562Ket7mD5f3s33SSWJorbaOn89O5ht4c0Bo=;
        b=ekAuhqdn4IWcWOg7wz2HS8znjPcoRIiTk4qnfTHf0tjlCp7FMpjS0Dcne2ysMF7OGM
         BmPSmkvApUcKFXUdOL1VzkU2WxEQK/fbskUhJCCfbMWdsi/E4cbXTIEAu/Y/q9/mfSjD
         qPzPZtujuXwLeik+UDXhgUg4I/Rt1qXwkt5qbHzlDI7tcoNE+FCDDBXIUjkN1aqCOjj3
         mskR2xdjpEq4E/ikSSDzS8k/l2jnb7RwyeJMUvhsRY+/BnUksjiqTJ2EVqXO+pyHtEVR
         T8vhEYxnmLKJv9ITZSVqYN2WwG4bwv6r4ZGWwyAOf5Z58VLtlsv/dgD7BrdrXo4odEtw
         nM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dq88nNP562Ket7mD5f3s33SSWJorbaOn89O5ht4c0Bo=;
        b=TevDHZtnyeq/ACjhTpnVISJ160z7iR7APcFLSf6W6IgleKZJ4U8W4oLNxcDjmIbFZO
         OWtUBCYVU2xo4DdYnuWoZwe/w/ON+RTS1sdK6YndYCFCpGiehm15w6KrwxYlwLCaGJwG
         pEcs9hB66311gm2VQfoqw9JkytyQmYQdDhV3ZToXwSJzWxcXwM7JrR+ZtWzDRDTSIsQV
         Pkafjw0dJG+UaAwPIvKmmRtRaZVU589AKgXZ73BwBsBNWs2mjXGSUu6gX15CpFBCsNs+
         tA0EUqqkEe+10RSVDArb2QkzttGPWS5Q24JYBboyLXSPGCy0wW8rGHWbM0AEnXNVRaRT
         40UQ==
X-Gm-Message-State: APjAAAWlFPTGf1p42F8fSmoz9UPCEY6sl0jWo0Ud40G/WZxp563KC80h
        Y0lbDLV46cov9PbpBQJfHfsYLQPK
X-Google-Smtp-Source: APXvYqykcQdcEDvxj80wgvTnISNk9vp0hSYzM0q/A7Dr5QPFp+W4bOOB986XCI8Y67GNkSrVF/+vug==
X-Received: by 2002:a62:168a:: with SMTP id 132mr17938661pfw.155.1553416387843;
        Sun, 24 Mar 2019 01:33:07 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.12])
        by smtp.gmail.com with ESMTPSA id i10sm14629503pgs.26.2019.03.24.01.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:33:06 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1] ARM: dts: exynos: Add proper regulator states for suspend-to-mem for odroid-u3
Date:   Sun, 24 Mar 2019 14:02:56 +0530
Message-Id: <20190324083256.1047-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend-to-mem node to regulator core to be enabled or disabled
during system suspend and also support changing the regulator operating
mode during runtime and when the system enter sleep mode (stand by mode).

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Current patch:

Note: Both microSD and eMMC suspend resume works this changes at my end.

regulator-off-in-suspend:
set the regulator node into suspend state i.e. standby mode during suspend
operation.

Current changes are based on
[0] https://www.kernel.org/doc/Documentation/devicetree/bindings/regulator/max77686.txt

  Regulators which can be turned off during system suspend:
	-LDOn	:	2, 6-8, 10-12, 14-16,
	-BUCKn	:	1-4.
  Use standard regulator bindings for it ('regulator-off-in-suspend').

drop the suspend off binding which are not supported by the driver.

RFC version
[1] https://patchwork.kernel.org/patch/10810909/
These changes had some problem with eMMC not entering into suspend mode.
with some miss configuration in regulator-off-in-suspend mode.

Changes from previos patch.
[2] https://patchwork.kernel.org/patch/10712549/

Set all the non used regulator in suspend-odd state
LD02, LD03, LD05, LD06, LD07, LD011, LD013, LDO14, LD016

BUCK5, BUCK6, BUCK7 and not confirable as per driver max77686-regulator
---
 .../boot/dts/exynos4412-odroid-common.dtsi    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 08d3a0a7b4eb..375156ad5454 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -288,6 +288,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo3_reg: LDO3 {
@@ -317,6 +320,9 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo7_reg: LDO7 {
@@ -324,18 +330,27 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo8_reg: LDO8 {
 				regulator-name = "VDD10_HDMI_1.0V";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo10_reg: LDO10 {
 				regulator-name = "VDDQ_MIPIHSI_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo11_reg: LDO11 {
@@ -343,6 +358,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo12_reg: LDO12 {
@@ -351,6 +369,9 @@
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo13_reg: LDO13 {
@@ -367,6 +388,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo15_reg: LDO15 {
@@ -375,6 +399,9 @@
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo16_reg: LDO16 {
@@ -383,6 +410,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo20_reg: LDO20 {
@@ -421,6 +451,9 @@
 				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck2_reg: BUCK2 {
@@ -437,6 +470,9 @@
 				regulator-max-microvolt = <1050000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck4_reg: BUCK4 {
@@ -444,6 +480,9 @@
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1100000>;
 				regulator-microvolt-offset = <50000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck5_reg: BUCK5 {
-- 
2.21.0

