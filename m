Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C507C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028CA208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfH1Sh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:37:27 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:43079 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727101AbfH1ShX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:37:23 -0400
X-IronPort-AV: E=Sophos;i="5.64,442,1559487600"; 
   d="scan'208";a="24947709"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2019 03:37:21 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.36.196])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0CE244004953;
        Thu, 29 Aug 2019 03:37:17 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, sam@ravnborg.org
Subject: [PATCH v3 7/8] [HACK] arm64: dts: renesas: draak: Enable LVDS
Date:   Wed, 28 Aug 2019 19:36:41 +0100
Message-Id: <1567017402-5895-8-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567017402-5895-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567017402-5895-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable and connect the second LVDS encoder to the second LVDS input of
the THC63LVD1024 for dual-link LVDS operation. This requires changing
the default settings of SW45 and SW47 to OFF and ON respectively.

This patch is based on Laurent's dual-LVDS work:
https://patchwork.kernel.org/patch/10965045/

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
v2->v3:
* new patch

Geert,

no need to review this patch unless they like the idea behind this
series.

Thanks,
Fab

---
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index b38f9d4..38b9c5a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -87,11 +87,20 @@
 
 			port@0 {
 				reg = <0>;
-				thc63lvd1024_in: endpoint {
+				dual-lvds-even-pixels;
+				thc63lvd1024_in0: endpoint {
 					remote-endpoint = <&lvds0_out>;
 				};
 			};
 
+			port@1 {
+				reg = <1>;
+				dual-lvds-odd-pixels;
+				thc63lvd1024_in1: endpoint {
+					remote-endpoint = <&lvds1_out>;
+				};
+			};
+
 			port@2 {
 				reg = <2>;
 				thc63lvd1024_out: endpoint {
@@ -489,7 +498,7 @@
 	ports {
 		port@1 {
 			lvds0_out: endpoint {
-				remote-endpoint = <&thc63lvd1024_in>;
+				remote-endpoint = <&thc63lvd1024_in0>;
 			};
 		};
 	};
@@ -507,6 +516,14 @@
 		 <&x13_clk>,
 		 <&extal_clk>;
 	clock-names = "fck", "dclkin.0", "extal";
+
+	ports {
+		port@1 {
+			lvds1_out: endpoint {
+				remote-endpoint = <&thc63lvd1024_in1>;
+			};
+		};
+	};
 };
 
 &ohci0 {
-- 
2.7.4

