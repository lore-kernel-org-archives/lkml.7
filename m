Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9518C74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10122064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ohoIueS1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z6qjLuOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfGJOPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:15:22 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49009 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbfGJOPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:15:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 42BBD22171;
        Wed, 10 Jul 2019 10:15:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Jul 2019 10:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=/nuJnxVDzRhoS
        VxlYKo/BeplUiN6nooOgbT9w/0IY+k=; b=ohoIueS1t1j0S89EU/3VnCYNiGAQQ
        ThW7HV0YRygHvhObUuMl20MSosAa9SCrs/d2TV514GpoOqpuLzNobHBB4kXV1Kp6
        8QwxT2XoCiBuTIqWR5yGCqzsN+sYYbVe+fQfNFAt9uboZAcSIYJMDqlOeugot1Fb
        3qwP0RJQEbJa5GEjcdiCXyDU+6nwT5ST3qB3fG8x7V1YET7iiOHhUxq6jqqXhlrI
        WXlx5r0j8IQ7rFsizdUm7nQ0z9FwqJ4L+RfGOtDMGPR4CIA0LEgbuC8f3ivxlhm0
        3wdokRDiEfAQ3ZNU6uf3U+kgldOh6SrLdWV0rDDMtjLMfy1kbNUDX1JRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=/nuJnxVDzRhoSVxlYKo/BeplUiN6nooOgbT9w/0IY+k=; b=Z6qjLuOk
        TCzwieLNJe0YVNj4WIPp8WQa0x9Njozlj74mLU/0JW7ry6f5cKc3nvaHyx1h+TRy
        U21p5qBXLAUfF7HoPW/g5cYgfYYIUlecluXW+Y8fPWTJWnEWdYU/eFUOC3OLf0eP
        jdfGFkwozxTOLCKsyehr1em6n0Dtvh3z5l32ZfwZn2ZIHF5ZHQsNsT3Gom5J8GOL
        G72lPq6yktsmrSnsOnRD7Nbfasm2Txu6RBG/Nsg64U6WhVtRzwQmPG0OEDlCGpsC
        tzkH8d0K7YO1887VP19I2S6Z949VC3l2BXMmC7UuHbz+SoiWclinipZhiNz2e47D
        9AToIPTI85DS+Q==
X-ME-Sender: <xms:9_IlXWBLKssUsguJc2GqUPOe86fv4Id8vMSzZ-DCn3sfXnLJWvCTaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepudegrddvrdekhedrvddvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgepfe
X-ME-Proxy: <xmx:9_IlXWDuxIMqVC6KPSXXQxYHn2GpmvLI6CeP_NwJG50hJXhNMax64A>
    <xmx:9_IlXYqQgjQUJ_mmNIQhgBIMUX5gSRrrULhcIjLHMsuZmKeFm-8tzg>
    <xmx:9_IlXZGURF6rMC8o2CRRKhnEVoQTsuhWflcx0TrmttcMCRrLRj0Bhg>
    <xmx:9_IlXRnmIfQ1Nzdx4NvxHjjewlW1k8xASkuU0viHSyu1hbM5bc2Olw>
Received: from localhost.localdomain (ppp14-2-85-22.adl-apt-pir-bras31.tpg.internode.on.net [14.2.85.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id D950A8005B;
        Wed, 10 Jul 2019 10:15:15 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        ryanchen.aspeed@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: aspeed: Enable both MMC slots on AST2500 EVB
Date:   Wed, 10 Jul 2019 23:45:02 +0930
Message-Id: <20190710141503.21026-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710141503.21026-1-andrew@aj.id.au>
References: <20190710141503.21026-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabled for testing purposes.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 556ed469830c..429904e401ee 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -94,6 +94,24 @@
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
+&sdhci1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sd2_default>;
+};
+
 /*
  * Enable port A as device (via the virtual hub) and port B as
  * host by default on the eval board. This can be easily changed
-- 
2.20.1

