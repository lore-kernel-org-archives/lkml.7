Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B04C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A0821530
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="hvOUJDaV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iSHTMVXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfGLDho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 23:37:44 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50575 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729467AbfGLDhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:37:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7DEF8221B6;
        Thu, 11 Jul 2019 23:37:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jul 2019 23:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=dffcCV/HTGPbH
        G4a1USO9iem8eItTEWWhc5RSmq1hAI=; b=hvOUJDaVw0E64wvrHZXP1Oes8M/Fc
        RWnfW0PU0RGjOCCcKtXjhH/sw2Dn13C+j4QO8441uGf4whyBHjDMAKEWN9dFXKEg
        hei+yYCk7xmjZZBTfQowq6AVzp2VjFDvEIAnWUc5r+ALtfLWW7hbVMVtd/uDvAeK
        hrdEeDohrhBEdacYfD5RooOQj6g0XX1cLswOSqLx8LIReIBatfumsqWHj1vX6iqg
        bmNDVIu6ckUNRb9o1K0GJVp+J7C1Oz/IbKp4pTdBSbgKszKPSrK+ZmJ0EiLdBVMA
        VWujdfhMLOHJOqPEh5XRZuQxv2T2gMpth1BnDebYCNOaBojm5NmAHON6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=dffcCV/HTGPbHG4a1USO9iem8eItTEWWhc5RSmq1hAI=; b=iSHTMVXU
        mxV3vmRFRmVVW+mit5S5ZMXNozoqSQWJcublB6670A9pjyweeXDBZbqkqeUFNZPX
        eyJHXGl+t+RpztWiGfpSQub/BVtKD/55DKFgPwhBzUCJwEXcHrNSIx/NSyTkvtJr
        UxVESKXOZ5utwVkEQh7Luhr1d16d9tbmhsq2s6g05Lqd5PFqv+fdygQReH0PKFsL
        M8VIbkBg5rdLXhP+pCaScFMbUF6/Z9RpZCVBDdLwwFjSW69iuzlUKlvHGmpTBMtm
        Vyf3tKLOX8bavFOPWYF9u3xzV0Hn4puLy9uHB3KylNUyBFGTPcqrqjXxklWHbYCx
        4cgIXtTiol9zMg==
X-ME-Sender: <xms:ggAoXaGyefVf42dXhHEOtBxgoSN6aycfHZr92g4z7pxQBUPew1MFmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeelgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtvddrkedurddukedrfedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgep
    td
X-ME-Proxy: <xmx:ggAoXWC6ZgShKWOurnS3nvIiJVjIknyj_BY69a-iCWxzewPPwyPZSg>
    <xmx:ggAoXc1kMekmbsBEoRlxOszKa5zqTL-YSbGEyxbr-GNhFugkv7g3Bw>
    <xmx:ggAoXbO7iRegCKzyPLiAhLh2wreM1z15yRzETjDCyMljg4m2GwQ2vw>
    <xmx:ggAoXdUEevS5f6CffUvq58wmgzNzadHCRaxWf-1u1EYK460jZVXcsQ>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 921D9380084;
        Thu, 11 Jul 2019 23:37:35 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        ryanchen.aspeed@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Enable first MMC slot on AST2500 EVB
Date:   Fri, 12 Jul 2019 13:07:26 +0930
Message-Id: <20190712033726.25237-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712033726.25237-1-andrew@aj.id.au>
References: <20190712033726.25237-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabled for testing purposes.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
In v2:

* Leave sdhci1 disabled

 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 556ed469830c..5279b1040c37 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -94,6 +94,17 @@
 	};
 };
 
+&sdc {
+	status = "okay";
+};
+
+&sdhci0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sd1_default>;
+};
+
 /*
  * Enable port A as device (via the virtual hub) and port B as
  * host by default on the eval board. This can be easily changed
-- 
2.20.1

