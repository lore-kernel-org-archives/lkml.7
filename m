Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFD0C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC37E20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNGO69hQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfDJXQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:16:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39579 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfDJXPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:15:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so4837779wrn.6;
        Wed, 10 Apr 2019 16:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BEpM5Gvyvd4udCA+glYkPWMTJCgvlXeRuBegEu1lKo=;
        b=SNGO69hQE55nUj7jA/Zvn61DSUs+8kjWx3AzLpr8wXajyDAs3FSPM3SF1RyBC5YSMJ
         naL5iOq4NG7jlGFqZzC0mwDLRP9EGisSKsMcSPlzRvgq5SeWUQdIM7ekpA9Cx3K/U1ws
         coWSYoLZgy7EXSayIz8IIbeOwn5Ec0F0tEkA/MB3gIIiSyoTNNf0L4zseV4CHPLqlFvm
         8TPN4lQxo1Aq84fLD/teOn+732IhdGUz0XiyvHzasjiaLOaLdBPPtodWE4lwV/wV5xJ6
         iGP5ApNNQjijSlc/2aPb27sIzo0/Ha2W5koWk/IuNiipw7BWvHBCJ4mPpm47qYmxnY93
         PwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BEpM5Gvyvd4udCA+glYkPWMTJCgvlXeRuBegEu1lKo=;
        b=MaWb/skree0YtI0wWmJBoneGwRVInAC+ZZRBT/D0elpbP25Dd6Q+wkdqkHOWWgKpLS
         jRb0Soqq+3CJscuGZodq0lA/M6yNX7pj5xRFZvG+bwAMLyUR5BBwoCq7azTC2mZaLd7V
         3EbS1poHI7eK0vz4cyRhX4Si5ffkQM/m007RSVDFPeW2vgc91VUxNsFErYyNneKsNMT2
         bk77lCd+S6EVqTDg8M8V9Dh5W6gIYSBCMw2XUGBgup3hysRwi/8u73r8ADhTmerC8XH6
         wangBMLPRTP3Yu2j5EStxemBDcnWZUJ8bAFpzGmGODW6ZFSr0ZK8ubqWSk+peFssbdAE
         87Aw==
X-Gm-Message-State: APjAAAV3xQhAITnr8Qy7mX2ZXVR5s09UpT8B26/mh1Mrek79WpQx3Dv5
        rRSxkAB0vlrXBV+SsWUjs9U=
X-Google-Smtp-Source: APXvYqxmMnOuV9QlB1rJNCq2zuN/qWbxaNtjCYrscjABEvCSyhXiKDR+O/48hfVcxZgt8oAvb7CdIw==
X-Received: by 2002:adf:e602:: with SMTP id p2mr9735994wrm.105.1554938133850;
        Wed, 10 Apr 2019 16:15:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id n6sm8504947wmn.48.2019.04.10.16.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:15:32 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 4/8] arm64: dts: allwinner: Add ARM Mali GPU node for H6
Date:   Thu, 11 Apr 2019 01:25:39 +0200
Message-Id: <20190410232543.13297-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410232543.13297-1-peron.clem@gmail.com>
References: <20190410232543.13297-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mali gpu node to the H6 device-tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 80 ++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index e0dc4a05c1ba..152b2128aadf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -17,6 +17,71 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	gpu_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+
+		opp@756000000 {
+			opp-hz = /bits/ 64 <756000000>;
+			opp-microvolt = <1040000>;
+		};
+		opp@624000000 {
+			opp-hz = /bits/ 64 <624000000>;
+			opp-microvolt = <950000>;
+		};
+		opp@576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-microvolt = <930000>;
+		};
+		opp@540000000 {
+			opp-hz = /bits/ 64 <540000000>;
+			opp-microvolt = <910000>;
+		};
+		opp@504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <890000>;
+		};
+		opp@456000000 {
+			opp-hz = /bits/ 64 <456000000>;
+			opp-microvolt = <870000>;
+		};
+		opp@432000000 {
+			opp-hz = /bits/ 64 <432000000>;
+			opp-microvolt = <860000>;
+		};
+		opp@420000000 {
+			opp-hz = /bits/ 64 <420000000>;
+			opp-microvolt = <850000>;
+		};
+		opp@408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <840000>;
+		};
+		opp@384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt = <830000>;
+		};
+		opp@360000000 {
+			opp-hz = /bits/ 64 <360000000>;
+			opp-microvolt = <820000>;
+		};
+		opp@336000000 {
+			opp-hz = /bits/ 64 <336000000>;
+			opp-microvolt = <810000>;
+		};
+		opp@312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <810000>;
+		};
+		opp@264000000 {
+			opp-hz = /bits/ 64 <264000000>;
+			opp-microvolt = <810000>;
+		};
+		opp@216000000 {
+			opp-hz = /bits/ 64 <216000000>;
+			opp-microvolt = <810000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -157,6 +222,21 @@
 			allwinner,sram = <&ve_sram 1>;
 		};
 
+		gpu: gpu@1800000 {
+			compatible = "allwinner,sun50i-h6-mali",
+				     "arm,mali-t720";
+			reg = <0x01800000 0x4000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu";
+			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
+			clock-names = "core", "bus";
+			resets = <&ccu RST_BUS_GPU>;
+			operating-points-v2 = <&gpu_opp_table>;
+			status = "disabled";
+		};
+
 		syscon: syscon@3000000 {
 			compatible = "allwinner,sun50i-h6-system-control",
 				     "allwinner,sun50i-a64-system-control";
-- 
2.17.1

