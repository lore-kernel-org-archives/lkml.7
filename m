Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE83C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F69C218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366509;
	bh=7GBN7F6r70R3eIW5++8gc7kApOT9Ro0+zP7htqEmK5o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1xZABfcvKx8ux1JoftBd3ru6bQwm/Y6Oyq6QertgCk2IwtP8MG/8/ynh3qb+i/AOn
	 5jcg21NQaJUXqq7O8TrJ2lxyB2H6o2LppsUwNPFQwmqpf/XoHaxBfOxBmtneotbAPw
	 HsOInG6N2ep3RYKejck0/yqAd1F+6GwUYTJjhke0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbfB1PI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:08:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbfB1PIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A270218AE;
        Thu, 28 Feb 2019 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366495;
        bh=7GBN7F6r70R3eIW5++8gc7kApOT9Ro0+zP7htqEmK5o=;
        h=From:To:Cc:Subject:Date:From;
        b=yUSy9YXd4p/O2xHJjIPDaIVch0G00O6PR4oLz57h8FZH8itZ0FGpxPYYqa1rglmQv
         1sk57GATwjAE5QtKP2JudwgcfKrXOcE7qOZma54hyPsqKIs7vNhydYL1XsA/Jg9r8N
         DbP5G9auWWLNOq1F+XW+Kv9CsaiAxtkpzPuJ+7XQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 01/81] ARM: OMAP: dts: N950/N9: fix onenand timings
Date:   Thu, 28 Feb 2019 10:06:53 -0500
Message-Id: <20190228150813.10256-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>

[ Upstream commit 8443e4843e1c2594bf5664e1d993a1be71d1befb ]

Commit a758f50f10cf ("mtd: onenand: omap2: Configure driver from DT")
started using DT specified timings for GPMC, and as a result the
OneNAND stopped working on N950/N9 as we had wrong values in the DT.
Fix by updating the values to bootloader timings that have been tested
to be working on both Nokia N950 and N9.

Fixes: a758f50f10cf ("mtd: onenand: omap2: Configure driver from DT")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 42 ++++++++++++++++++----------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 0d9b85317529b..e142e6c70a59f 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -370,6 +370,19 @@
 		compatible = "ti,omap2-onenand";
 		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
 
+		/*
+		 * These timings are based on CONFIG_OMAP_GPMC_DEBUG=y reported
+		 * bootloader set values when booted with v4.19 using both N950
+		 * and N9 devices (OneNAND Manufacturer: Samsung):
+		 *
+		 *   gpmc cs0 before gpmc_cs_program_settings:
+		 *   cs0 GPMC_CS_CONFIG1: 0xfd001202
+		 *   cs0 GPMC_CS_CONFIG2: 0x00181800
+		 *   cs0 GPMC_CS_CONFIG3: 0x00030300
+		 *   cs0 GPMC_CS_CONFIG4: 0x18001804
+		 *   cs0 GPMC_CS_CONFIG5: 0x03171d1d
+		 *   cs0 GPMC_CS_CONFIG6: 0x97080000
+		 */
 		gpmc,sync-read;
 		gpmc,sync-write;
 		gpmc,burst-length = <16>;
@@ -379,26 +392,27 @@
 		gpmc,device-width = <2>;
 		gpmc,mux-add-data = <2>;
 		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <87>;
-		gpmc,cs-wr-off-ns = <87>;
+		gpmc,cs-rd-off-ns = <122>;
+		gpmc,cs-wr-off-ns = <122>;
 		gpmc,adv-on-ns = <0>;
-		gpmc,adv-rd-off-ns = <10>;
-		gpmc,adv-wr-off-ns = <10>;
-		gpmc,oe-on-ns = <15>;
-		gpmc,oe-off-ns = <87>;
+		gpmc,adv-rd-off-ns = <15>;
+		gpmc,adv-wr-off-ns = <15>;
+		gpmc,oe-on-ns = <20>;
+		gpmc,oe-off-ns = <122>;
 		gpmc,we-on-ns = <0>;
-		gpmc,we-off-ns = <87>;
-		gpmc,rd-cycle-ns = <112>;
-		gpmc,wr-cycle-ns = <112>;
-		gpmc,access-ns = <81>;
+		gpmc,we-off-ns = <122>;
+		gpmc,rd-cycle-ns = <148>;
+		gpmc,wr-cycle-ns = <148>;
+		gpmc,access-ns = <117>;
 		gpmc,page-burst-access-ns = <15>;
 		gpmc,bus-turnaround-ns = <0>;
 		gpmc,cycle2cycle-delay-ns = <0>;
 		gpmc,wait-monitoring-ns = <0>;
-		gpmc,clk-activation-ns = <5>;
-		gpmc,wr-data-mux-bus-ns = <30>;
-		gpmc,wr-access-ns = <81>;
-		gpmc,sync-clk-ps = <15000>;
+		gpmc,clk-activation-ns = <10>;
+		gpmc,wr-data-mux-bus-ns = <40>;
+		gpmc,wr-access-ns = <117>;
+
+		gpmc,sync-clk-ps = <15000>; /* TBC; Where this value came? */
 
 		/*
 		 * MTD partition table corresponding to Nokia's MeeGo 1.2
-- 
2.19.1

