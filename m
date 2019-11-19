Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD0BC43141
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F16621783
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141586;
	bh=NflRRV0uqucVxYoCTUuHIRCHF+FW37oV9OaJflefziU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hIZpvefBGtazeOxXxhR3sHSrIxiMs4xTkNTYdPQ6/B77riRy9+Fu9qb1V2SeW50Lg
	 2rKHr/F5cC72ZTKo40T0snaOPSSFugj6Je1S3HDQO5DC/SYI4cbwZy8bHyIvQSTTMc
	 zYhAVcZh7euPoR/oW4jeON+bwRBWAWGv2xI3Mxvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfKSFdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:33:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbfKSFdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:33:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5546421783;
        Tue, 19 Nov 2019 05:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141580;
        bh=NflRRV0uqucVxYoCTUuHIRCHF+FW37oV9OaJflefziU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjFnvUr/WtrQ99NmsfsmPwbth+Stp83stQ8xVGe8qAc/aJCwHrzdSfzr47Lcvd80C
         gisOUkCBrJVP5gqLObQwaO7YgrZPeKxO+UULmt2u+BcOhr+FkhN7OccA1NWBRxYZAD
         HZg79rSlXPPX0E61+Wd6zo0GZgeuxdsbtWQl0UxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 209/422] arm64: dts: broadcom: Fix I2C and SPI bus warnings
Date:   Tue, 19 Nov 2019 06:16:46 +0100
Message-Id: <20191119051412.136267401@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 7cdbe45da1a189e744e6801aebb462ee47235580 ]

dtc has new checks for I2C and SPI buses. Fix the warnings in node names
and unit-addresses.

arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dtb: Warning (i2c_bus_reg): /hsls/i2c@e0000/pcf8574@20: I2C bus unit address format error, expected "27"
arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dtb: Warning (i2c_bus_reg): /hsls/i2c@e0000/pcf8574@20: I2C bus unit address format error, expected "27"
arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dtb: Warning (spi_bus_bridge): /hsls/ssp@180000: node name for SPI buses should be 'spi'
arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dtb: Warning (spi_bus_bridge): /hsls/ssp@190000: node name for SPI buses should be 'spi'

Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi          | 4 ++--
 arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi | 2 +-
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi       | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 1a406a76c86a2..ea854f689fda8 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -639,7 +639,7 @@
 			status = "disabled";
 		};
 
-		ssp0: ssp@66180000 {
+		ssp0: spi@66180000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x66180000 0x1000>;
 			interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
@@ -650,7 +650,7 @@
 			status = "disabled";
 		};
 
-		ssp1: ssp@66190000 {
+		ssp1: spi@66190000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x66190000 0x1000>;
 			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
index bc299c3d90683..a9b92e52d50e8 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
@@ -138,7 +138,7 @@
 &i2c1 {
 	status = "okay";
 
-	pcf8574: pcf8574@20 {
+	pcf8574: pcf8574@27 {
 		compatible = "nxp,pcf8574a";
 		gpio-controller;
 		#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 84101ea1fd2cb..ff714fcbac68d 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -520,7 +520,7 @@
 			status = "disabled";
 		};
 
-		ssp0: ssp@180000 {
+		ssp0: spi@180000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x00180000 0x1000>;
 			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
@@ -532,7 +532,7 @@
 			status = "disabled";
 		};
 
-		ssp1: ssp@190000 {
+		ssp1: spi@190000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x00190000 0x1000>;
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.20.1



