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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC451C282E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC32216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ0SeKUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfE1XCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 19:02:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34480 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfE1XCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:02:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id h2so115729pgg.1;
        Tue, 28 May 2019 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TYxqVL6ya69qBm4d49uLd/seawSvaqtAiTG+XLQaxa8=;
        b=MJ0SeKUfWyrctojOBtc2sUIRaYZjaPr/SfW6rtwAj13+sI6jDqQ8wpcYbyqf8JBgTp
         3K/2kDdfdDdKj8vAFxNjPobsLjXBIbGOgv56DB/ngzeAt00MKfI0WHMaZ2gaBCqKIMxL
         jEfgENpp3+blpCPEks+/TVdmAGZqqdyc57pGju8LIku/a1prFdsYMuygNueazoK0JS1f
         LhZ95SPE67XH8nyKJskl2AV43xc3sm6JzDA0DEHhKyWB2iWDZOOXDMKDLj3ePXCo5qWn
         nUNj1RYlOANAvKcncMGI+gdRrNfRTaxdzDMEIaMEcWhKz7dPKAPFOeey5b9+i1djez+g
         YuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TYxqVL6ya69qBm4d49uLd/seawSvaqtAiTG+XLQaxa8=;
        b=T79QbtorNjXdVKPISEKSouRiqS93P2lLq1yQzuWwHeajLe85+3f2PAva9pTyi3Qz8J
         zq+eOQIqlJ8hBaEYT2n+Zi6jOUym85zDlM22qLI5jCMKq/qW1m7ku0A1SBtr38cICQXA
         4hJm9yjE5MnOktAlE5uIhbyoBReD4i5vLUVkmZ9JKVlGakZRrq+pEnW8LnoHgm8rClMA
         8WgjT4sWC8L+3WxuhrZY5YBUjAmXwC6BUdpCLdAeuC0rd3oNjwT87Xv0xiGYN5AujlfL
         uaqYy52Yn+Fe+EbLECkKE8xTVSwD4PtUrTycbTaVx8Y6It1zuqWe6FjzcvZyRI8fb+2a
         s/Ng==
X-Gm-Message-State: APjAAAVuEJw63WkJju+yDQH/YMm4oqnuQgiw6BoMDp4JGsU2fDf6c4IX
        Zuat9Y893v/Tqis2QDXSHT4=
X-Google-Smtp-Source: APXvYqyO9aGngsIKVqNqsAs0/kG5aaHpoSPbIa3wS0StMA1Ypw++h0bJTbJ1hAlqIYYRutjO6nnBmA==
X-Received: by 2002:a62:cfc4:: with SMTP id b187mr147977844pfg.134.1559084536452;
        Tue, 28 May 2019 16:02:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j13sm14369573pfh.13.2019.05.28.16.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 16:02:15 -0700 (PDT)
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
Subject: [PATCH 5/7] ARM: dts: BCM63xx: Fix DTC W=1 warnings
Date:   Tue, 28 May 2019 16:01:32 -0700
Message-Id: <20190528230134.27007-6-f.fainelli@gmail.com>
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
 arch/arm/boot/dts/bcm63138.dtsi    | 9 +++------
 arch/arm/boot/dts/bcm963138dvt.dts | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
index e6a41e1b27fd..9c0325cf9e22 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -41,9 +41,6 @@
 	};
 
 	clocks {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		/* UBUS peripheral clock */
 		periph_clk: periph_clk {
 			#clock-cells = <0>;
@@ -94,7 +91,7 @@
 			reg = <0x1e000 0x100>;
 		};
 
-		gic: interrupt-controller@1e100 {
+		gic: interrupt-controller@1f000 {
 			compatible = "arm,cortex-a9-gic";
 			reg = <0x1f000 0x1000
 				0x1e100 0x100>;
@@ -125,7 +122,7 @@
 						  IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
-		armpll: armpll {
+		armpll: armpll@20000 {
 			#clock-cells = <0>;
 			compatible = "brcm,bcm63138-armpll";
 			clocks = <&periph_clk>;
@@ -144,7 +141,7 @@
 			#reset-cells = <2>;
 		};
 
-		ahci: sata@8000 {
+		ahci: sata@a000 {
 			compatible = "brcm,bcm63138-ahci", "brcm,sata3-ahci";
 			reg-names = "ahci", "top-ctrl";
 			reg = <0xa000 0x9ac>, <0x8040 0x24>;
diff --git a/arch/arm/boot/dts/bcm963138dvt.dts b/arch/arm/boot/dts/bcm963138dvt.dts
index 8dca97eeaf57..43a5f78acd5e 100644
--- a/arch/arm/boot/dts/bcm963138dvt.dts
+++ b/arch/arm/boot/dts/bcm963138dvt.dts
@@ -16,7 +16,7 @@
 		stdout-path = &serial0;
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x0 0x08000000>;
 	};
 
-- 
2.17.1

