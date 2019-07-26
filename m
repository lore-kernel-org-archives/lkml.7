Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86597C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2E922BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="M3HqskOp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQ50PelC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfGZFkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:40:33 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39889 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfGZFkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:40:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D42AB22131;
        Fri, 26 Jul 2019 01:40:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 01:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Sz5g0+Dl2yQ1i
        F6zWdflObP+DugVbiRkNpKSed5kVRQ=; b=M3HqskOp669nEECYO+2mMlQLHS0at
        8mGJjd3E2rx1RXUnz/ZLOuzO92TnBRsgC3WgySQKfv/6lHfLU0iasmyer4dTphQZ
        fGjlkdWRXQnpE984mAYs7xMXjP8AAyMIzrNthugvem1RsxJ5YeHlpyic7QxJ68Jd
        Ku6DCBLYkx6V76YAxx85uxhaLc4ZNngG/D4kfN1FTe5ZrLBE601qCRyWqITNLvFz
        S58npquHNCDphz+3rEHhVqDuzpS38JU8VitVtLVkHu6RB/W8GeFP6x3oU+3MSGIf
        RefH5rBlcOmozt74qe+dsHjn0w9ekDT+i5++Ik0CwP8M7bSWRCttlOBkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Sz5g0+Dl2yQ1iF6zWdflObP+DugVbiRkNpKSed5kVRQ=; b=gQ50PelC
        FRIo7RxYhk8WqEpbdthcrQczqKm4kC3tMoi+dbpoFksjNul329FMbymPdBmrHYqP
        DgEdGk2fEBU60OS7IZxKmGnRUh+L1bt549fMcMZx/DXNR9VIQftJKrjXNFUnUVrL
        zm17dRtqSMtcGOjD1HwD56reRFKp8b+L53nRq/nMRFcxpr7wgaFuRHFztRXdPmkO
        TgX07EbViZ0mUa1IQ9uHpIj1w+r65YOG1lEbFJ8QW/g4oGeA/RmOjEBz970Rmiet
        nXyDwcB1uHNap9LKXTQRWPqHjE2ZEs1JPIaEFNM1qKRjahi/+1eHk/o+Sa3x2Til
        K0GoxSklQIIz8g==
X-ME-Sender: <xms:TpI6XRONu7akzQ89w22D7UhdiCVFTo-CKmTtCW7ZUGK0_rQ6gLqa1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtvddrkedurddukedrfedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgep
    je
X-ME-Proxy: <xmx:TpI6XWtvaP5vkzUO0x0DgE_ZXPurQ9HOUQHpkU57bmlCF-lhX9dGRw>
    <xmx:TpI6XdItkjrYbTUkJ4XEt7t_GlhXDfe2_vOORuLIS-hQOkVvbNTLNg>
    <xmx:TpI6XVPf_psBKf-WqiMAixAfjlFg4AjFuHxo_ZLhAx_6kNzKeNe0Gw>
    <xmx:TpI6XWC_C2q7edRFFvq41OnZO4cBMZesLTnbsvqP1tuS19jzN7T4iA>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id D9D43380076;
        Fri, 26 Jul 2019 01:40:27 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/17] ARM: dts: aspeed: Cleanup lpc-ctrl and snoop regs
Date:   Fri, 26 Jul 2019 15:09:50 +0930
Message-Id: <20190726053959.2003-9-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

    arch/arm/boot/dts/aspeed-g5.dtsi:409.27-414.8: Warning (unique_unit_address): /ahb/apb/lpc@1e789000/lpc-host@80/lpc-ctrl@0: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/lpc-host@80/lpc-snoop@0)

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 6 +++---
 arch/arm/boot/dts/aspeed-g5.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index dd4b0b15afcf..ed78020f6269 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -296,14 +296,14 @@
 
 					lpc_ctrl: lpc-ctrl@0 {
 						compatible = "aspeed,ast2400-lpc-ctrl";
-						reg = <0x0 0x80>;
+						reg = <0x0 0x10>;
 						clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 						status = "disabled";
 					};
 
-					lpc_snoop: lpc-snoop@0 {
+					lpc_snoop: lpc-snoop@10 {
 						compatible = "aspeed,ast2400-lpc-snoop";
-						reg = <0x0 0x80>;
+						reg = <0x10 0x8>;
 						interrupts = <8>;
 						status = "disabled";
 					};
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 3b4af88f9b80..a8a593dd2240 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -408,14 +408,14 @@
 
 					lpc_ctrl: lpc-ctrl@0 {
 						compatible = "aspeed,ast2500-lpc-ctrl";
-						reg = <0x0 0x80>;
+						reg = <0x0 0x10>;
 						clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 						status = "disabled";
 					};
 
-					lpc_snoop: lpc-snoop@0 {
+					lpc_snoop: lpc-snoop@10 {
 						compatible = "aspeed,ast2500-lpc-snoop";
-						reg = <0x0 0x80>;
+						reg = <0x10 0x8>;
 						interrupts = <8>;
 						status = "disabled";
 					};
-- 
2.20.1

