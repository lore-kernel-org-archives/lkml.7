Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB3EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1068020650
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ffJzGMuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfKLO0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:26:40 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49652 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfKLO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:26:38 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACEQWBd090825;
        Tue, 12 Nov 2019 08:26:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573568792;
        bh=gpv+haEFzzKdzy9mhyYEcsJmcwqJdZynv2MIZuwV8kA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ffJzGMukJRIBh55FUrs/B+aUsWIiBuaDmy8oH9zgDQodOVDLFCWzR35hRoYjfVhEn
         7h0MXEDqCNU+z3Y+saVvh0Q2O0vktYpu88Ul2kFXVafYbv1P2n8K2mUQxSgkzLtgMC
         3cTtDI/V9UdgCOg8RbOTTIZH9wHeGMmAf6Ygc/j4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACEQWMA014358
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:26:32 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:26:14 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:26:14 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACEQUtu040290;
        Tue, 12 Nov 2019 08:26:31 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: [Patch v2 1/3] ARM: dts: am43xx: add support for clkout1 clock
Date:   Tue, 12 Nov 2019 08:29:27 -0600
Message-ID: <20191112142929.23058-2-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112142929.23058-1-bparrot@ti.com>
References: <20191112142929.23058-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

clkout1 clock node and its generation tree was missing. Add this based
on the data on TRM and PRCM functional spec.

commit 664ae1ab2536 ("ARM: dts: am43xx: add clkctrl nodes") effectively
reverted this commit 8010f13a40d3 ("ARM: dts: am43xx: add support for
clkout1 clock") which is needed for the ov2659 camera sensor clock
definition hence it is being re-applied here.

Note that because of the current dts node name dependency for mapping to
clock domain, we must still use "clkout1-*ck" naming instead of generic
"clock@" naming for the node. And because of this, it's probably best to
apply the dts node addition together along with the other clock changes.

Fixes: 664ae1ab2536 ("ARM: dts: am43xx: add clkctrl nodes")
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Benoit Parrot <bparrot@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi | 54 ++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index 091356f2a8c1..c726cd8dbdf1 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -704,6 +704,60 @@
 		ti,bit-shift = <8>;
 		reg = <0x2a48>;
 	};
+
+	clkout1_osc_div_ck: clkout1-osc-div-ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&sys_clkin_ck>;
+		ti,bit-shift = <20>;
+		ti,max-div = <4>;
+		reg = <0x4100>;
+	};
+
+	clkout1_src2_mux_ck: clkout1-src2-mux-ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&clk_rc32k_ck>, <&sysclk_div>, <&dpll_ddr_m2_ck>,
+			 <&dpll_per_m2_ck>, <&dpll_disp_m2_ck>,
+			 <&dpll_mpu_m2_ck>;
+		reg = <0x4100>;
+	};
+
+	clkout1_src2_pre_div_ck: clkout1-src2-pre-div-ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&clkout1_src2_mux_ck>;
+		ti,bit-shift = <4>;
+		ti,max-div = <8>;
+		reg = <0x4100>;
+	};
+
+	clkout1_src2_post_div_ck: clkout1-src2-post-div-ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&clkout1_src2_pre_div_ck>;
+		ti,bit-shift = <8>;
+		ti,max-div = <32>;
+		ti,index-power-of-two;
+		reg = <0x4100>;
+	};
+
+	clkout1_mux_ck: clkout1-mux-ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&clkout1_osc_div_ck>, <&clk_rc32k_ck>,
+			 <&clkout1_src2_post_div_ck>, <&dpll_extdev_m2_ck>;
+		ti,bit-shift = <16>;
+		reg = <0x4100>;
+	};
+
+	clkout1_ck: clkout1-ck {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&clkout1_mux_ck>;
+		ti,bit-shift = <23>;
+		reg = <0x4100>;
+	};
 };
 
 &prcm {
-- 
2.17.1

