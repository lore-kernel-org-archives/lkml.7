Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9D5C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E03F22C97
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="U7Eaj6uC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lfmtq3x1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfGZFlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:41:06 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58813 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726614AbfGZFlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:41:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F16222274;
        Fri, 26 Jul 2019 01:41:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 01:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=zLGmFPTIbxQGo
        HnRql1MWWPPC7bOrn4IS16vnsH8Hsw=; b=U7Eaj6uCWVlD8HTbBFikW8DXHin7A
        1LHe2DPkxSbz1M/DeBTJghfG7XqRD1qBn0a56hf64ltEvMJO9Gjf0A6xHA7I44O1
        g2SyMgo+/m3EcfFU44cZA2KDP7J+RaM90aaB2nZdG3uBPnCvDwChUgl9IwtkXj8i
        fiFO4orSVyk3sn3xelojPGbv18xHht9RrccVTuGKnMNoUXMpakalDmJaSpz5UHjX
        pU23S3eOGaHA6rFJpL73hLGvsYQbl4AEcavi+u6+CGVZ/G7nMmnXDFmUrvqDwkdG
        pZLDJV3VEOSc2xJCUFLtbnPIEbl5flVO4GHVDi0vLvLXQGwgFf664Ss0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=zLGmFPTIbxQGoHnRql1MWWPPC7bOrn4IS16vnsH8Hsw=; b=lfmtq3x1
        c/Z1N7Dm2XO9BX0pG6SLAto/CdF+w7y+mMts3HOcb4FdH/sHkmJtgkkSdMWgJQx4
        B66cmiEjHYybmjNS5psrZZucXsWz1qElAQ25GF+IO2gkn2jwH0j0IuX93hTXvEJC
        4CsPYSbR9aDw7SdtBe1ftLgTUQnYk+SjMBbRsx8WN9ZKa5rTmcOEfZTyhqkITavp
        PaqrfNeeNsGoxXUI2AB0PswcXneuCuvuh5ZM2C1ZEJhmfLrgATBoRIBeQnS088nX
        TflZ2zED5bpyZxyGgv4Q1jEsje04TCjV/iRgu4xWG0Ningojcw02QitWvm1X3mDC
        Pk7DKPMWu35Yig==
X-ME-Sender: <xms:b5I6XYzvXDgSEiXFFETuvoP-1aLjJzu5v_BIOpGFZXpYA-Oi7oNGGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeefgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughrvgif
    ucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtddvrd
    ekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruhenucevlhhushhtvghrufhiiigvpeeg
X-ME-Proxy: <xmx:b5I6XdV9iqMFe6_4dGjpAtsu5nMh5VVKjOnQv2xHFKgKpPxhxr1L8A>
    <xmx:b5I6XdTG6PvrwOHkMBPzMmnjGb9AWrqh6sUql9uqDvB0MzyVk-S94A>
    <xmx:b5I6XUNmCdsghKc33feYVu20xPXhVKfxDTwcy6ZIpMn8w8fv-zc2TA>
    <xmx:b5I6XdUMJCoESGzkL_XnYSQQrnpOiG6L2nDGxtbGYKP_CIX7knFTIg>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 31D88380074;
        Fri, 26 Jul 2019 01:40:59 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Haiyue Wang <haiyue.wang@linux.intel.com>
Subject: [RFC PATCH 16/17] ARM: dts: aspeed-g5: Change KCS nodes to v2 binding
Date:   Fri, 26 Jul 2019 15:09:58 +0930
Message-Id: <20190726053959.2003-17-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings:

    arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unit_address_vs_reg): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs1@0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:382.19-387.8: Warning (unit_address_vs_reg): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs2@0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:388.19-393.8: Warning (unit_address_vs_reg): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs3@0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:405.19-410.8: Warning (unit_address_vs_reg): /ahb/apb/lpc@1e789000/lpc-host@80/kcs4@0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unique_unit_address): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs1@0: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs2@0)
    arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unique_unit_address): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs1@0: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs3@0)
    arch/arm/boot/dts/aspeed-g5.dtsi:382.19-387.8: Warning (unique_unit_address): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs2@0: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs3@0)
    arch/arm/boot/dts/aspeed-g5.dtsi:405.19-410.8: Warning (unique_unit_address): /ahb/apb/lpc@1e789000/lpc-host@80/kcs4@0: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/lpc-host@80/lpc-ctrl@0)

Cc: Haiyue Wang <haiyue.wang@linux.intel.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 92c659c50b4c..50ba58dc5093 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -373,22 +373,22 @@
 					#size-cells = <1>;
 					ranges = <0x0 0x0 0x80>;
 
-					kcs1: kcs1@0 {
-						compatible = "aspeed,ast2500-kcs-bmc";
+					kcs1: kcs@24 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x24 0x1>, <0x30 0x1>, <0x3c 0x1>;
 						interrupts = <8>;
-						kcs_chan = <1>;
 						status = "disabled";
 					};
-					kcs2: kcs2@0 {
-						compatible = "aspeed,ast2500-kcs-bmc";
+					kcs2: kcs@28 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x28 0x1>, <0x34 0x1>, <0x40 0x1>;
 						interrupts = <8>;
-						kcs_chan = <2>;
 						status = "disabled";
 					};
-					kcs3: kcs3@0 {
-						compatible = "aspeed,ast2500-kcs-bmc";
+					kcs3: kcs@2c {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x2c 0x1>, <0x38 0x1>, <0x44 0x1>;
 						interrupts = <8>;
-						kcs_chan = <3>;
 						status = "disabled";
 					};
 				};
@@ -402,10 +402,10 @@
 					#size-cells = <1>;
 					ranges = <0x0 0x80 0x1e0>;
 
-					kcs4: kcs4@0 {
-						compatible = "aspeed,ast2500-kcs-bmc";
+					kcs4: kcs@94 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x94 0x1>, <0x98 0x1>, <0x9c 0x1>;
 						interrupts = <8>;
-						kcs_chan = <4>;
 						status = "disabled";
 					};
 
-- 
2.20.1

