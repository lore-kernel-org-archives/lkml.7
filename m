Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A5CC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026C022BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="M+KYS3fI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KPnevW2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfGZFkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:40:06 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57869 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfGZFkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:40:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5774A22316;
        Fri, 26 Jul 2019 01:40:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 01:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=VAmBJkwQa1nYT
        pHvlFa8arKTnGNAQUEikNjCfoiyH7k=; b=M+KYS3fIgpccxDg6Bt8b417HA/8Pa
        ViI/Pj8uR70BP4qQdmk4CWNSeTi2+Mir125FcJXOubW3H+wSacsMByWLSWY+lv52
        eaMQplbbdVNJlu7CovN0d4DM40ypBfxr3ei6cLjoQsU+83PJ0kN3IUcEexO4tD2E
        4Ma6MZ2xNzxjnnb1VyFJF9i25V4qa+juWAdF/5Au4oWyq7tMmoJOrDM3sR5OzvKm
        DTwkhzSjm8aWW+mlYtqgqMbHEP98b9ugm7jKu4y7Cv25lM3H+thEqpEnFIn/L+xc
        1d5tnlJC4HJXNNbDuZk+aCuO2VTSHdc6O/2XaYt5qz7baZqjYrdn2k+ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=VAmBJkwQa1nYTpHvlFa8arKTnGNAQUEikNjCfoiyH7k=; b=KPnevW2V
        15OyMrFxm/AWEprcvIdfXTegs2XLJiRD8SbodqUrNvN2jMMy158zHhfnhE5OPql4
        YbZn9Y1i33yWWm81SA9xwbxsnM5Ckkks5WE/o5bzEl+JC+Enq/nTJU8cvmQJuL9w
        yQyxfVao/F1RXKo7UGhiiCMSKD8bFqpd51hENGDXp36FagtWCiMsd3sQmN9No5Uy
        OZbCKPADFXOQDy1AnaRc7cCJ8KtC6oxtfH+xg9uDsq6J0i/tlo5o5oWvoP0d99jb
        59hdjcWt+cnD8MxwkV6gS2KsRhfqYqwTLPCYsQamq1lUwyMwxXmPDnWGf9HISMbi
        wEpTOqicHUjc8g==
X-ME-Sender: <xms:NZI6Xesl5S-e6ZI7uh9yHfozUDtEmLupzewlhplTvWd9AEldPBoS1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughrvgif
    ucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtddvrd
    ekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:NZI6Xfwz8cSWL501sAtmmtbyDGvvMlVHjnZjsnIb_nhDybMaRMqKeQ>
    <xmx:NZI6XciTthIgiUfCNGVrm1kk_d25ZhzKM-UFFMrDk9m2LdQqqY6BSw>
    <xmx:NZI6XbA7doWG1_bHK1UYKoE-RMa97OE4Wa-IZlteBtpmqWtiX0iQgw>
    <xmx:NZI6XU3b05Szt3ND7HdHAufRZqdUJYv-fhN3nnUR3Ww3D31VW9hLbA>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 22F61380084;
        Fri, 26 Jul 2019 01:40:01 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan M Schaeckeler <sschaeck@cisco.com>
Subject: [PATCH 01/17] ARM: dts: aspeed-g5: Move EDAC node to APB
Date:   Fri, 26 Jul 2019 15:09:43 +0930
Message-Id: <20190726053959.2003-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the register interface was not attached to any internal bus,
which is not correct - it lives on the APB.

Cc: Stefan M Schaeckeler <sschaeck@cisco.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 5b1ca265c2ce..7723afc7c249 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -47,13 +47,6 @@
 		reg = <0x80000000 0>;
 	};
 
-	edac: sdram@1e6e0000 {
-		compatible = "aspeed,ast2500-sdram-edac";
-		reg = <0x1e6e0000 0x174>;
-		interrupts = <0>;
-		status = "disabled";
-	};
-
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -206,6 +199,13 @@
 			#size-cells = <1>;
 			ranges;
 
+			edac: sdram@1e6e0000 {
+				compatible = "aspeed,ast2500-sdram-edac";
+				reg = <0x1e6e0000 0x174>;
+				interrupts = <0>;
+				status = "disabled";
+			};
+
 			syscon: syscon@1e6e2000 {
 				compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1a8>;
-- 
2.20.1

