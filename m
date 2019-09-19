Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B541EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87538208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932551;
	bh=NZ1BsXKgGPlCcAzGWiNt0D1XMpiB4ymc0WgYmkVRm7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iajm8BwmgQYs9cwaBAFa3+tDITwg5XM1ZPkx4xpka3LS8HohU+dZuaUg6xR0L3x0O
	 w2dXY6xvuwhK9C/vDxtk9jz81ucEBaNF9+HaIAO1L9V8P5CoDRy5tgTsVZ1CNTFvCO
	 2cMLfEKPqIsazFNtdbqSLkaQDS9uQiYLTs4mC/24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393217AbfISWH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393166AbfISWHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:07:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ACD7218AF;
        Thu, 19 Sep 2019 22:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930841;
        bh=NZ1BsXKgGPlCcAzGWiNt0D1XMpiB4ymc0WgYmkVRm7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4l0ildYv2wyhTKNr83r/STb9mO9rbUAmP/mJ/e4zAxBSfoAD8F4iTVzK3T2QODyk
         x9Kw15vuK/2GGwdg1ehS8bn5O8STTY42yIddZwdl1Cj24ArOh66IERIEF6pPrBdiFZ
         oBRcznk0APLXQECEMylAWrA8ueFi1ikWB2+jtN1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 033/124] ARM: dts: Fix flags for gpio7
Date:   Fri, 20 Sep 2019 00:02:01 +0200
Message-Id: <20190919214820.228685554@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 2e8647bbe1c8233a20c32fd2648258f2c05c7335 ]

The ti,no-idle-on-init and ti,no-reset-on-init flags need to be at
the interconnect target module level for the modules that have it
defined. Otherwise we get the following warnings:

dts flag should be at module level for ti,no-idle-on-init
dts flag should be at module level for ti,no-reset-on-init

Reviewed-by: Suman Anna <s-anna@ti.com>
Tested-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 2 +-
 arch/arm/boot/dts/dra7-evm.dts                  | 2 +-
 arch/arm/boot/dts/dra7-l4.dtsi                  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index d50de7a6ea6c5..bc76f1705c0f6 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -379,7 +379,7 @@
 	};
 };
 
-&gpio7 {
+&gpio7_target {
 	ti,no-reset-on-init;
 	ti,no-idle-on-init;
 };
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 714e971b912a4..de7f85efaa512 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -498,7 +498,7 @@
 	phy-supply = <&ldousb_reg>;
 };
 
-&gpio7 {
+&gpio7_target {
 	ti,no-reset-on-init;
 	ti,no-idle-on-init;
 };
diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 23faedec08abd..63628e166c0cd 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -1261,7 +1261,7 @@
 			};
 		};
 
-		target-module@51000 {			/* 0x48051000, ap 45 2e.0 */
+		gpio7_target: target-module@51000 {		/* 0x48051000, ap 45 2e.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
 			ti,hwmods = "gpio7";
 			reg = <0x51000 0x4>,
-- 
2.20.1



