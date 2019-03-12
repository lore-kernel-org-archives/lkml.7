Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E79C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420C5214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414022;
	bh=kYlsunY5tQ4nkTwein9GdMUEdiWp3hH7AX1mi9inHfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IpBSca73jE7UxMNuc0CvVK2iia6vO3P6Zhz2w4DJEPjbk4iMlt5RwlFotyj1tfe6k
	 2Ei/kyPrwSC6B+ex8ZvS1A3r8h2WGq3N6VTbzqxgvxYyKdEiES4fYvMPLJXOMNbMrD
	 vui9zTZppg06ahJb/H1pk9yI7CcSL6Po46dMwUI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfCLSHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbfCLRMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:25 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23B2217F9;
        Tue, 12 Mar 2019 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410745;
        bh=kYlsunY5tQ4nkTwein9GdMUEdiWp3hH7AX1mi9inHfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mrdJxil3tHxXszfuhzsaZVvysqNknJ3i9wVOZZDbXVEmJRbNNLMZJ+JDxG6RcFPp7
         lfU5UvkbFmdTrmg1SwBfjjAmxX/jziDg7wpRuF8QzYDaXm8VCe+pmY9bqGrxDf9Dlw
         dhiUv457cQnnnXhuSBPjk7QrfEfgS84yFnAgNmtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 071/171] ARM: OMAP: dts: N950/N9: fix onenand timings
Date:   Tue, 12 Mar 2019 10:07:31 -0700
Message-Id: <20190312170354.261901374@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 0d9b85317529..e142e6c70a59 100644
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



