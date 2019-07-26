Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC7AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056A422C7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="j1juVrhh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="13UwN+I1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfGZFkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:40:10 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56315 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbfGZFkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:40:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B08EE22131;
        Fri, 26 Jul 2019 01:40:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 01:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=4kLlrK+bLpUiR
        kTdTMxXoERa1h6aqhA++4P0gBqwURU=; b=j1juVrhhLMckXwlc7/pOFPMZKMA+I
        RioLQDqClV+EzcwgalYLqn3YgxAz+Wf6IRdPvGcOu6/clD3MmJbQoGs/TRXcpsHR
        Jl7HaGkoukusvw4/h6w1SpBVE9V2crg5eVfFui+C+C4CplAU0b7EvbPBPjoJ+cHR
        EjPCQuF2GG7W1593RMXIFN9SzmI9oo37/VLGE8MzYvBTUUHqpVMpb2Thwh1h0Xy5
        mDdx/NihtldJBsVoBOTW5GeQV4rcsmwfQo5I5BJLKtCZ1DqqUFYSjQpbPv8683Ww
        I1YisdHVQTKzcFHQjqfjY4DtUBiucsr+NDMauiP17wHa99rqAtxskWvlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=4kLlrK+bLpUiRkTdTMxXoERa1h6aqhA++4P0gBqwURU=; b=13UwN+I1
        KmI1jM6XaX7KqMcfdklGfiOj4v+3/x0gak05kCI0WAwzFqngjuklcpYRpZoypVrv
        +4FCH9zedZd4jZTrr1cN96W4iWiIoo5VlEaUNRHpocOTmmqA1eiK8y3dxGuhzXSy
        iv4pulMva8nud3NVVL7A/Ep8a+O/gpsymiPuKw5tAkG1LfvD3J/Er0E3CAVcum+j
        xNeE++gs2FaZor+8afpKo+uieD3InFox45iBu5QYX/dFfkbeXUB0yh39/sRC4YEo
        wQC+Zxw1h78qTYGqghtXdRdH1p+L3wreiyW/GKq0xPG4clNkS9PT5UrQUGihStGm
        JFXKTRBtOeuWyQ==
X-ME-Sender: <xms:OJI6XdiRTr2aRt-BDK6qw-7fyBldu8ovlfnUSVmmSkSn3XINxW62Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughrvgif
    ucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtddvrd
    ekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:OJI6Xe_mKIh3JWASLHnuqueI1EB7lh5F-7duD1XI9g9vQEykLQRsHA>
    <xmx:OJI6XYsrIlSYWWVIwYsezpdWoSqeuo7EgxjCKf4jATR6Dep6zEuzQw>
    <xmx:OJI6Xar6DVyzt4w9Xj_SsYqeBM7Gg4IYHJnfKy75z1ZJzTR_MgLxwA>
    <xmx:OJI6XRWrAh_RDQYTk5AzX7F7e9Jiflcyj07o8ygtqzlmMMgytLbk4A>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F1F5380079;
        Fri, 26 Jul 2019 01:40:05 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan M Schaeckeler <sschaeck@cisco.com>
Subject: [PATCH 02/17] ARM: dts: aspeed-g5: Use recommended generic node name for SDMC
Date:   Fri, 26 Jul 2019 15:09:44 +0930
Message-Id: <20190726053959.2003-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EDAC is a sub-function of the SDRAM Memory Controller. Rename the
node to the appropriate generic node name.

Cc: Stefan M Schaeckeler <sschaeck@cisco.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 7723afc7c249..6e5b0c493f16 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -199,7 +199,7 @@
 			#size-cells = <1>;
 			ranges;
 
-			edac: sdram@1e6e0000 {
+			edac: memory-controller@1e6e0000 {
 				compatible = "aspeed,ast2500-sdram-edac";
 				reg = <0x1e6e0000 0x174>;
 				interrupts = <0>;
-- 
2.20.1

