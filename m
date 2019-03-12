Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5F5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3B0205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413077;
	bh=rfLubpBGkHP459YD1kXTPbDoBsF3CoE0KmT1jrPDZA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IzeWPJ41m7Jm2kL1/vXQT7om+ZHNn2je6Bh/Zo3sBUF9wEHn1d8toF4CJxIKBTDRt
	 CyWOR3x9TtMIS/WIT8iJNYdcfgLbdMVhbeUzhRxkzL4meNyHrNtaKQTuaMK6/bFOq1
	 +W/2/8rI//wQGiDMUEVaDGJoniogNN+6ifzPxMco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfCLRvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728429AbfCLROh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:37 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B78EC2183F;
        Tue, 12 Mar 2019 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410876;
        bh=rfLubpBGkHP459YD1kXTPbDoBsF3CoE0KmT1jrPDZA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHOQIHulmVzagcOKLuhqwfDF9dMLACeJCcV/nupjf6VHn+8t49GtcyFmeoWulRn7d
         TdwVjlozi6kszagmgvYiDCIU2Hg43yYiQ2p4EenL1lovahrnPj0GDo65iT1q+7S9Za
         ceKW1IhjLq3ormWgkN7BFGnzrCA/bt5zutUJMXKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/149] ARM: OMAP: dts: N950/N9: fix onenand timings
Date:   Tue, 12 Mar 2019 10:08:00 -0700
Message-Id: <20190312170354.906623847@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



