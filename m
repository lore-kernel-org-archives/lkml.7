Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EF2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0908207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Q2c2UOQS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t90LS38w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfLCMD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:03:28 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58657 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726916AbfLCMD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:03:27 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id ED3DF22404;
        Tue,  3 Dec 2019 07:03:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=o4D5c4rNyjnat
        YfDx/2DWrr1tQgV8FEQSr+FfrKj2Yk=; b=Q2c2UOQSdIEdMrE56U2Asu4eJbuuj
        4DtQULkM47rgdF1EognVhmY4y+IxBp/8z3G7AiTlHtENrPvs6yYPwmedWs7GJ7WK
        a2DtAkH26BeK9kO/WVttsvN2j11UNVWakC3mn1xJo06vm7IV5WQoUVFLac9D+Qq4
        Tpp5hVwnAHk301bsAxofMb94jksgCXy8RpfZKyVA61Mh4XPfuO4SC2APhkhBjvkm
        5INa/Is+K5B+33k1QOUX1vZWyUH28oIEudt50Dg0H5Rsz0m4eca4lBqRUv0Mckg7
        AwB0YL7TRGISRSI+vFMrQmoUdSaUDVRGmYXo0J799gvrpJElzvE+HZVRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=o4D5c4rNyjnatYfDx/2DWrr1tQgV8FEQSr+FfrKj2Yk=; b=t90LS38w
        nJDniucsepf8XTD6tgWycpPAxHzvyv3/2HgoyEho6vtO2iw9o+Xb6S2978rh1iTz
        sbqcGVsn0ZKMYXcPtnSximVhe9pSiV3SSt8cQESRcNObo3phd/df9gU6HcrisXXZ
        jIojHdovirwY13YxtVxOXlWB7Pjudym3v2bqr1H536bBheTKf075pjnr8S2coiN7
        HR0kDOoHTI8Snc4FYAtWyErowVnqT6tnDcH7TorzupcLqjhH6yKMpGbJHZS8IXou
        L+WJcNzVqaIQPdSL+SwIVF9znhcMprGKH3pu/InlmkxD3bfebeTh+KXYDPBUvgev
        nxmahpgtABAZsg==
X-ME-Sender: <xms:DU_mXYxW9ogavmuLy5ve8J8EVlmU7rPQjPeQHKJAYbeXlwy6r_SK3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecukfhppeduudekrddvuddurdelvddrudefnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihii
    vgeple
X-ME-Proxy: <xmx:DU_mXXIJGgCu_hfj3MlF4sVTyFHBlx5S3HFNklgh6dZhvhpi2RWDDg>
    <xmx:DU_mXbRRsm4syTOrITF8hykwdaFghvUeoxZfefwMF1qL2V1Qd2c5Kw>
    <xmx:DU_mXdjfGrz1M4zG8w4i95Kor6AuDP17GE3nTe71XYqG0-MMCmGIgA>
    <xmx:DU_mXeFGVb-WwtZ5rEf9onMH0k0Bg96ZRnkVOMq_W6UBsn8zDLUiQQ>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0248830600AA;
        Tue,  3 Dec 2019 07:03:22 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] ARM: dts: aspeed: Add reg hints to syscon children
Date:   Tue,  3 Dec 2019 22:34:12 +1030
Message-Id: <c7a868a37fe6e54804dbfb2cf81f0ae84f46edfa.1575369656.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings:

    arch/arm/boot/dts/aspeed-g5.dtsi:209.28-226.6: Warning (avoid_unnecessary_addr_size): /ahb/apb/syscon@1e6e2000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
    arch/arm/boot/dts/aspeed-g4.dtsi:156.28-172.6: Warning (avoid_unnecessary_addr_size): /ahb/apb/syscon@1e6e2000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 15 +++++++++------
 arch/arm/boot/dts/aspeed-g5.dtsi | 17 ++++++++++-------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index e1d4af06c217..807a0fc20670 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -179,18 +179,21 @@
 				compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1a8>;
 				#address-cells = <1>;
-				#size-cells = <0>;
+				#size-cells = <1>;
+				ranges = <0 0x1e6e2000 0x1000>;
 				#clock-cells = <1>;
 				#reset-cells = <1>;
 
-				pinctrl: pinctrl {
-					compatible = "aspeed,ast2400-pinctrl";
-				};
-
-				p2a: p2a-control {
+				p2a: p2a-control@2c {
+					reg = <0x2c 0x4>;
 					compatible = "aspeed,ast2400-p2a-ctrl";
 					status = "disabled";
 				};
+
+				pinctrl: pinctrl@80 {
+					reg = <0x80 0x18>, <0xa0 0x10>;
+					compatible = "aspeed,ast2400-pinctrl";
+				};
 			};
 
 			rng: hwrng@1e6e2078 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 013d1f98ecf1..57c9e45c9e16 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -217,19 +217,22 @@
 				compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1a8>;
 				#address-cells = <1>;
-				#size-cells = <0>;
+				#size-cells = <1>;
+				ranges = <0 0x1e6e2000 0x1000>;
 				#clock-cells = <1>;
 				#reset-cells = <1>;
 
-				pinctrl: pinctrl {
-					compatible = "aspeed,ast2500-pinctrl";
-					aspeed,external-nodes = <&gfx>, <&lhc>;
-				};
-
-				p2a: p2a-control {
+				p2a: p2a-control@2c {
 					compatible = "aspeed,ast2500-p2a-ctrl";
+					reg = <0x2c 0x4>;
 					status = "disabled";
 				};
+
+				pinctrl: pinctrl@80 {
+					compatible = "aspeed,ast2500-pinctrl";
+					reg = <0x80 0x18>, <0xa0 0x10>;
+					aspeed,external-nodes = <&gfx>, <&lhc>;
+				};
 			};
 
 			rng: hwrng@1e6e2078 {
-- 
git-series 0.9.1
