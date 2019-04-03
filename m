Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E8FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4376C2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="Op6myLgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDCN1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:27:00 -0400
Received: from de-deferred2.bosch-org.com ([139.15.180.217]:46532 "EHLO
        de-deferred2.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfDCNZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:25:44 -0400
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by fe0vms0193.rbdmz01.com (Postfix) with ESMTPS id 44Z65h0k8vz1s1;
        Wed,  3 Apr 2019 15:15:52 +0200 (CEST)
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 44Z65f32sNz4f3kZ4;
        Wed,  3 Apr 2019 15:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=in.bosch.com;
        s=2015-01-21; t=1554297350;
        bh=5JmXTCA8402bhLcSZ4Bm03a+Df0e1eFcN7hmyjl8vSI=; l=10;
        h=From:From:Reply-To:Sender;
        b=Op6myLgVUAzrSJMoEUG0D5+DvuGhwI5MTkDjm2q8dehDOiV5/f61aNuIHtydvYswV
         /ylYlFs/81u1nYJqPCQxspSyTwXZDgzwKr15qajDwFS/5JMomqzKr8ZhpdHx6vLo4g
         fhTcp+rlmJTE+heIJbPFh/VOWOC/Kd2oTouSaA28=
Received: from si0vm2083.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 44Z65f2Zjxz1Ck;
        Wed,  3 Apr 2019 15:15:50 +0200 (CEST)
X-AuditID: 0a3aad17-5bfff70000001fa9-2f-5ca4b206dc34
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm2083.rbesz01.com (SMG Outbound) with SMTP id D9.36.08105.602B4AC5; Wed,  3 Apr 2019 15:15:50 +0200 (CEST)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 44Z65d6zB2zVv5;
        Wed,  3 Apr 2019 15:15:49 +0200 (CEST)
Received: from localhost.localdomain (10.47.103.88) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 3 Apr 2019
 15:15:48 +0200
From:   <VenkataRajesh.Kalakodima@in.bosch.com>
To:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
        Tsutomu Muroya <muroya@ksk.co.jp>,
        Steve Longerbeam <steve_longerbeam@mentor.com>
Subject: [PATCH 2/8] drm: Add DU CMM support boot and clk changes
Date:   Wed, 3 Apr 2019 18:44:38 +0530
Message-ID: <1554297284-14009-3-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.103.88]
X-Brightmail-Tracker: H4sIAAAAAAAAA21Sb0wbZRzue9c/16Y3joPSn6Uj5rJlcWZbN1QuaszUmDR+mJC4JTNNXFlv
        bbUFctciTF0QjIkwg5VNaSUUJtkmZmw0w9HJAqs1my3BwRYZ6MBMlkykDDDdYCziHYW1H/z2
        e58/v+d9n7wETg+qDISzzMPxZVYXo9TINc+f2bhNGeqwmKaGFWwwOqRgbyTvKdnFln6MnT86
        oWCvX2xRsj1/zWLsj6MDOHvqzAl8N2Hu7FjEzZMNVzDzD8laZL4/6JOb/wkVFCve0rxo41zO
        So7f8dIBjeOOv6Qi+QWqmuzLq0EL3npEEEA9A0NXPqxHaoKmmjG4P6qrRxpx7kNwLvC7KnWY
        QXC9/TgmqZTUNujv7l4lcqlvETTMXsCkA07FEERiiVVVDvUyfJyow6VZTm2Cc40jSmkmqb0Q
        n7mBpBmoAhgb+nRVo6b2QfDqlDJ1j70QXFxQpPTZ8LN/Si7NOAVw+e5dPHXtJyHcrvwcUYEM
        VSBD1YawTqQTnKZK9y4TW7idL+WEw6ad2w+Wu0Mo1bW+F5369VAEUQRitGTTlx0WWmGtFKrd
        EfQsgTE68rkjIrShtNxW7bAKjrd5r4sTGANpvPa6hc55DAveUrdTEJzlZREEBM7kkoONbRaa
        tFmrD3N8ecoWQfmEnNGTduINC03ZrR7uXY6r4Ph19gWCYIDM7RYDs3nOzlUdcro86zSzkUQy
        mYzOy2QyYzFCHUGFhFbMxqQVpFBhdQtO+5r9iZSdXkfT1hgqMujJYslDSazDW/Y41WAkZXda
        LbQug0g7p9FNJPaWQ74nmbXiN07nAZkvVZS9BqZNuzpED9VAQ7+vBM431iFo7U0iGLn4AINo
        4hscJppGcWg52aUQsYAKloa7VPBo7LwaJse+V4P/WK8GPrlVq4W56DUtLB+PkRAfv7wBVv4M
        Z8HSpeEsaO38joLm5AoF841tNFydukTD6bk4DX//9lEO3A4M6GBiOqSH2XBPPtSO9OWLW04a
        4d9fokYIxZaM0vqCabFLTOyS9QalLj1Wz/90uYamH2eoQWcf7Gnbuvvr2nce1um7Dow2JQbw
        zaeP7A/tMy2ftdF/bCqaWJkpeLqwJOuVN+c/8PvYRw9teT9tTvSwhN83fqt4vwOxy6724FO6
        5aKvFi54su+RUVd4C1l1s+bo/PsjzTQfvx2use/47NhCe3xysGF8+jXZHvLViGpO8G3hDg73
        MHLBYd25FecF63/G7S6TXwQAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>

This is the out-of-tree patch for DU CMM driver support from
Yocto release v3.4.0.

Link: https://github.com/renesas-rcar/du_cmm/commit/2d8ea2b667ad4616aa639c54ecc11f7c4b58959d.patch

Following is from the patch description:

    du_cmm: Release for Yocto v3.4.0

    This patch made the following correspondence.

      - Corresponds to kernel v 4.14.
      - Double buffer only is supported.
      - Fix CLU / LUT update timing.
      - Add CMM Channel occupation mode.
      - Fix Close process.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Tsutomu Muroya <muroya@ksk.co.jp>
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

      - Resolved checkpatch errors
      - Resolved merge conflicts according to latest version
      - In patch included boot and clock files from base patch

Signed-off-by: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
---
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    |   5 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   5 +
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts |   5 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  29 +++++-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |   6 +-
 .../arm64/boot/dts/renesas/r8a7796-salvator-xs.dts |   4 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  25 ++++-
 .../arm64/boot/dts/renesas/r8a77965-salvator-x.dts |   7 +-
 .../boot/dts/renesas/r8a77965-salvator-xs.dts      |   7 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |  27 +++++-
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |   4 +
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |   3 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c            | 106 ++++++++++++++++++++-
 13 files changed, 217 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
index 6b5fa91..45c1f8a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
@@ -41,11 +41,16 @@
 		 <&cpg CPG_MOD 722>,
 		 <&cpg CPG_MOD 721>,
 		 <&cpg CPG_MOD 727>,
+		 <&cpg CPG_MOD 711>,
+		 <&cpg CPG_MOD 710>,
+		 <&cpg CPG_MOD 709>,
+		 <&cpg CPG_MOD 708>,
 		 <&versaclock5 1>,
 		 <&x21_clk>,
 		 <&x22_clk>,
 		 <&versaclock5 2>;
 	clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0",
+		      "cmm.0", "cmm.1", "cmm.2", "cmm.3",
 		      "dclkin.0", "dclkin.1", "dclkin.2", "dclkin.3";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 446822f..67b64e7 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -41,11 +41,16 @@
 		 <&cpg CPG_MOD 722>,
 		 <&cpg CPG_MOD 721>,
 		 <&cpg CPG_MOD 727>,
+		 <&cpg CPG_MOD 711>,
+		 <&cpg CPG_MOD 710>,
+		 <&cpg CPG_MOD 709>,
+		 <&cpg CPG_MOD 708>,
 		 <&versaclock5 1>,
 		 <&x21_clk>,
 		 <&x22_clk>,
 		 <&versaclock5 2>;
 	clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0",
+		      "cmm.0", "cmm.1", "cmm.2", "cmm.3",
 		      "dclkin.0", "dclkin.1", "dclkin.2", "dclkin.3";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
index 8ded64d0..adcacea 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
@@ -41,11 +41,16 @@
 		 <&cpg CPG_MOD 722>,
 		 <&cpg CPG_MOD 721>,
 		 <&cpg CPG_MOD 727>,
+		 <&cpg CPG_MOD 711>,
+		 <&cpg CPG_MOD 710>,
+		 <&cpg CPG_MOD 709>,
+		 <&cpg CPG_MOD 708>,
 		 <&versaclock6 1>,
 		 <&x21_clk>,
 		 <&x22_clk>,
 		 <&versaclock6 2>;
 	clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0",
+		      "cmm.0", "cmm.1", "cmm.2", "cmm.3",
 		      "dclkin.0", "dclkin.1", "dclkin.2", "dclkin.3";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index fb9d08a..aa5fc3c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2783,8 +2783,13 @@
 		du: display@feb00000 {
 			compatible = "renesas,du-r8a7795";
 			reg = <0 0xfeb00000 0 0x80000>,
-			      <0 0xfeb90000 0 0x14>;
-			reg-names = "du", "lvds.0";
+			      <0 0xfeb90000 0 0x14>,
+			      <0 0xfea40000 0 0x00001000>,
+			      <0 0xfea50000 0 0x00001000>,
+			      <0 0xfea60000 0 0x00001000>,
+			      <0 0xfea70000 0 0x00001000>;
+			reg-names = "du", "lvds.0",
+				    "cmm.0", "cmm.1", "cmm.2", "cmm.3";
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
@@ -2793,8 +2798,24 @@
 				 <&cpg CPG_MOD 723>,
 				 <&cpg CPG_MOD 722>,
 				 <&cpg CPG_MOD 721>,
-				 <&cpg CPG_MOD 727>;
-			clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0";
+				 <&cpg CPG_MOD 727>,
+				 <&cpg CPG_MOD 711>,
+				 <&cpg CPG_MOD 710>,
+				 <&cpg CPG_MOD 709>,
+				 <&cpg CPG_MOD 708>;
+			clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0",
+				      "cmm.0", "cmm.1", "cmm.2", "cmm.3";
+			resets = <&cpg 724>,
+				 <&cpg 724>,
+				 <&cpg 722>,
+				 <&cpg 722>,
+				 <&cpg 727>,
+				 <&cpg 711>,
+				 <&cpg 710>,
+				 <&cpg 709>,
+				 <&cpg 708>;
+			reset-names = "du.0", "du.1", "du.2", "du.3", "lvds.0",
+				      "cmm.0", "cmm.1", "cmm.2", "cmm.3";
 			vsps = <&vspd0 0 &vspd1 0 &vspd2 0 &vspd0 1>;
 			status = "disabled";
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index 052d72a..abe24e5 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -30,18 +30,22 @@
 		 <&cpg CPG_MOD 723>,
 		 <&cpg CPG_MOD 722>,
 		 <&cpg CPG_MOD 727>,
+		 <&cpg CPG_MOD 711>,
+		 <&cpg CPG_MOD 710>,
+		 <&cpg CPG_MOD 709>,
 		 <&versaclock5 1>,
 		 <&x21_clk>,
 		 <&versaclock5 2>;
 	clock-names = "du.0", "du.1", "du.2", "lvds.0",
+		      "cmm.0", "cmm.1", "cmm.2",
 		      "dclkin.0", "dclkin.1", "dclkin.2";
+
 };
 
 &sound_card {
 	dais = <&rsnd_port0	/* ak4613 */
 		&rsnd_port1>;	/* HDMI0  */
 };
-
 &hdmi0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
index 8860be6..6c3af11 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
@@ -30,10 +30,14 @@
 		 <&cpg CPG_MOD 723>,
 		 <&cpg CPG_MOD 722>,
 		 <&cpg CPG_MOD 727>,
+		 <&cpg CPG_MOD 711>,
+		 <&cpg CPG_MOD 710>,
+		 <&cpg CPG_MOD 709>,
 		 <&versaclock6 1>,
 		 <&x21_clk>,
 		 <&versaclock6 2>;
 	clock-names = "du.0", "du.1", "du.2", "lvds.0",
+		      "cmm.0", "cmm.1", "cmm.2",
 		      "dclkin.0", "dclkin.1", "dclkin.2";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index cbd35c0..729b2b6 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -2438,16 +2438,33 @@
 		du: display@feb00000 {
 			compatible = "renesas,du-r8a7796";
 			reg = <0 0xfeb00000 0 0x70000>,
-			      <0 0xfeb90000 0 0x14>;
-			reg-names = "du", "lvds.0";
+			      <0 0xfeb90000 0 0x14>,
+			      <0 0xfea40000 0 0x00001000>,
+			      <0 0xfea50000 0 0x00001000>,
+			      <0 0xfea60000 0 0x00001000>;
+			reg-names = "du", "lvds.0",
+				    "cmm.0", "cmm.1", "cmm.2";
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 724>,
 				 <&cpg CPG_MOD 723>,
 				 <&cpg CPG_MOD 722>,
-				 <&cpg CPG_MOD 727>;
-			clock-names = "du.0", "du.1", "du.2", "lvds.0";
+				 <&cpg CPG_MOD 727>,
+				 <&cpg CPG_MOD 711>,
+				 <&cpg CPG_MOD 710>,
+				 <&cpg CPG_MOD 709>;
+			clock-names = "du.0", "du.1", "du.2", "lvds.0",
+				      "cmm.0", "cmm.1", "cmm.2";
+			resets = <&cpg 724>,
+				 <&cpg 724>,
+				 <&cpg 722>,
+				 <&cpg 727>,
+				 <&cpg 711>,
+				 <&cpg 710>,
+				 <&cpg 709>;
+			reset-names = "du.0", "du.1", "du.2", "lvds.0",
+				      "cmm.0", "cmm.1", "cmm.2";
 			status = "disabled";
 
 			vsps = <&vspd0 &vspd1 &vspd2>;
diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
index 340a3c7..20992e2 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
@@ -24,10 +24,15 @@
 	clocks = <&cpg CPG_MOD 724>,
 		 <&cpg CPG_MOD 723>,
 		 <&cpg CPG_MOD 721>,
+		 <&cpg CPG_MOD 727>,
+		 <&cpg CPG_MOD 711>,
+		 <&cpg CPG_MOD 710>,
+		 <&cpg CPG_MOD 708>,
 		 <&versaclock5 1>,
 		 <&x21_clk>,
 		 <&versaclock5 2>;
-	clock-names = "du.0", "du.1", "du.3",
+	clock-names = "du.0", "du.1", "du.3", "lvds.0",
+		      "cmm.0", "cmm.1", "cmm.3",
 		      "dclkin.0", "dclkin.1", "dclkin.3";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
index 9de4e3d..eb02075 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
@@ -24,10 +24,15 @@
 	clocks = <&cpg CPG_MOD 724>,
 		 <&cpg CPG_MOD 723>,
 		 <&cpg CPG_MOD 721>,
+		 <&cpg CPG_MOD 727>,
+		 <&cpg CPG_MOD 711>,
+		 <&cpg CPG_MOD 710>,
+		 <&cpg CPG_MOD 708>,
 		 <&versaclock6 1>,
 		 <&x21_clk>,
 		 <&versaclock6 2>;
-	clock-names = "du.0", "du.1", "du.3",
+	clock-names = "du.0", "du.1", "du.3", "lvds.0",
+		      "cmm.0", "cmm.1", "cmm.3",
 		      "dclkin.0", "dclkin.1", "dclkin.3";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 0cd4446..37382b7 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1801,15 +1801,34 @@
 
 		du: display@feb00000 {
 			compatible = "renesas,du-r8a77965";
-			reg = <0 0xfeb00000 0 0x80000>;
-			reg-names = "du";
+			reg = <0 0xfeb00000 0 0x80000>,
+			      <0 0xfeb90000 0 0x14>,
+			      <0 0xfea40000 0 0x00001000>,
+			      <0 0xfea50000 0 0x00001000>,
+			      <0 0xfea70000 0 0x00001000>;
+			reg-names = "du", "lvds.0",
+				    "cmm.0", "cmm.1", "cmm.3";
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 724>,
 				 <&cpg CPG_MOD 723>,
-				 <&cpg CPG_MOD 721>;
-			clock-names = "du.0", "du.1", "du.3";
+				 <&cpg CPG_MOD 721>,
+				 <&cpg CPG_MOD 727>,
+				 <&cpg CPG_MOD 711>,
+				 <&cpg CPG_MOD 710>,
+				 <&cpg CPG_MOD 708>;
+			clock-names = "du.0", "du.1", "du.3", "lvds.0",
+				      "cmm.0", "cmm.1", "cmm.3";
+			resets = <&cpg 724>,
+				 <&cpg 724>,
+				 <&cpg 722>,
+				 <&cpg 727>,
+				 <&cpg 711>,
+				 <&cpg 710>,
+				 <&cpg 708>;
+			reset-names = "du.0", "du.1", "du.3", "lvds.0",
+				      "cmm.0", "cmm.1", "cmm.3";
 			status = "disabled";
 
 			vsps = <&vspd0 0 &vspd1 0 &vspd0 1>;
diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index a85dd50..ba9e595 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -201,6 +201,10 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("ehci0",		 703,	R8A7795_CLK_S3D4),
 	DEF_MOD("hsusb",		 704,	R8A7795_CLK_S3D4),
 	DEF_MOD("hsusb3",		 705,	R8A7795_CLK_S3D4),
+	DEF_MOD("cmm3",			 708,	R8A7795_CLK_S2D1),
+	DEF_MOD("cmm2",			 709,	R8A7795_CLK_S2D1),
+	DEF_MOD("cmm1",			 710,	R8A7795_CLK_S2D1),
+	DEF_MOD("cmm0",			 711,	R8A7795_CLK_S2D1),
 	DEF_MOD("csi21",		 713,	R8A7795_CLK_CSI0), /* ES1.x */
 	DEF_MOD("csi20",		 714,	R8A7795_CLK_CSI0),
 	DEF_MOD("csi41",		 715,	R8A7795_CLK_CSI0),
diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index dfb267a..9f01fda 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -180,6 +180,9 @@ static const struct mssr_mod_clk r8a7796_mod_clks[] __initconst = {
 	DEF_MOD("ehci1",		 702,	R8A7796_CLK_S3D4),
 	DEF_MOD("ehci0",		 703,	R8A7796_CLK_S3D4),
 	DEF_MOD("hsusb",		 704,	R8A7796_CLK_S3D4),
+	DEF_MOD("cmm2",			 709,	R8A7796_CLK_S2D1),
+	DEF_MOD("cmm1",			 710,	R8A7796_CLK_S2D1),
+	DEF_MOD("cmm0",			 711,	R8A7796_CLK_S2D1),
 	DEF_MOD("csi20",		 714,	R8A7796_CLK_CSI0),
 	DEF_MOD("csi40",		 716,	R8A7796_CLK_CSI0),
 	DEF_MOD("du2",			 722,	R8A7796_CLK_S2D1),
diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/renesas/r8a77965-cpg-mssr.c
index 8fae5e9..cac4570 100644
--- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
@@ -123,7 +123,6 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("sys-dmac2",		217,	R8A77965_CLK_S0D3),
 	DEF_MOD("sys-dmac1",		218,	R8A77965_CLK_S0D3),
 	DEF_MOD("sys-dmac0",		219,	R8A77965_CLK_S0D3),
-
 	DEF_MOD("cmt3",			300,	R8A77965_CLK_R),
 	DEF_MOD("cmt2",			301,	R8A77965_CLK_R),
 	DEF_MOD("cmt1",			302,	R8A77965_CLK_R),
@@ -215,6 +214,111 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("i2c1",			930,	R8A77965_CLK_S3D2),
 	DEF_MOD("i2c0",			931,	R8A77965_CLK_S3D2),
 
+	DEF_MOD("3dge",			 112,	R8A77965_CLK_ZG),
+	DEF_MOD("fdp0",			 119,	R8A77965_CLK_S0D1),
+	DEF_MOD("vcplf",		 130,	R8A77965_CLK_S0D2),
+	DEF_MOD("vdpb",			 131,	R8A77965_CLK_S0D2),
+	DEF_MOD("scif5",		 202,	R8A77965_CLK_S3D4),
+	DEF_MOD("scif4",		 203,	R8A77965_CLK_S3D4),
+	DEF_MOD("scif3",		 204,	R8A77965_CLK_S3D4),
+	DEF_MOD("scif1",		 206,	R8A77965_CLK_S3D4),
+	DEF_MOD("scif0",		 207,	R8A77965_CLK_S3D4),
+	DEF_MOD("msiof3",		 208,	R8A77965_CLK_MSO),
+	DEF_MOD("msiof2",		 209,	R8A77965_CLK_MSO),
+	DEF_MOD("msiof1",		 210,	R8A77965_CLK_MSO),
+	DEF_MOD("msiof0",		 211,	R8A77965_CLK_MSO),
+	DEF_MOD("sys-dmac2",		 217,	R8A77965_CLK_S0D3),
+	DEF_MOD("sys-dmac1",		 218,	R8A77965_CLK_S0D3),
+	DEF_MOD("sys-dmac0",		 219,	R8A77965_CLK_S0D3),
+	DEF_MOD("cmt3",			 300,	R8A77965_CLK_R),
+	DEF_MOD("cmt2",			 301,	R8A77965_CLK_R),
+	DEF_MOD("cmt1",			 302,	R8A77965_CLK_R),
+	DEF_MOD("cmt0",			 303,	R8A77965_CLK_R),
+	DEF_MOD("scif2",		 310,	R8A77965_CLK_S3D4),
+	DEF_MOD("sdif3",		 311,	R8A77965_CLK_SD3),
+	DEF_MOD("sdif2",		 312,	R8A77965_CLK_SD2),
+	DEF_MOD("sdif1",		 313,	R8A77965_CLK_SD1),
+	DEF_MOD("sdif0",		 314,	R8A77965_CLK_SD0),
+	DEF_MOD("pcie1",		 318,	R8A77965_CLK_S3D1),
+	DEF_MOD("pcie0",		 319,	R8A77965_CLK_S3D1),
+	DEF_MOD("usb3-if0",		 328,	R8A77965_CLK_S3D1),
+	DEF_MOD("usb-dmac0",		 330,	R8A77965_CLK_S3D1),
+	DEF_MOD("usb-dmac1",		 331,	R8A77965_CLK_S3D1),
+	DEF_MOD("rwdt0",		 402,	R8A77965_CLK_R),
+	DEF_MOD("intc-ex",		 407,	R8A77965_CLK_CP),
+	DEF_MOD("intc-ap",		 408,	R8A77965_CLK_S3D1),
+	DEF_MOD("audmac0",		 502,	R8A77965_CLK_S3D4),
+	DEF_MOD("audmac1",		 501,	R8A77965_CLK_S3D4),
+	DEF_MOD("adsp",			 506,	R8A77965_CLK_S1D1),
+	DEF_MOD("drif7",		 508,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif6",		 509,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif5",		 510,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif4",		 511,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif3",		 512,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif2",		 513,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif1",		 514,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif0",		 515,	R8A77965_CLK_S3D2),
+	DEF_MOD("hscif4",		 516,	R8A77965_CLK_S3D1),
+	DEF_MOD("hscif3",		 517,	R8A77965_CLK_S3D1),
+	DEF_MOD("hscif2",		 518,	R8A77965_CLK_S3D1),
+	DEF_MOD("hscif1",		 519,	R8A77965_CLK_S3D1),
+	DEF_MOD("hscif0",		 520,	R8A77965_CLK_S3D1),
+	DEF_MOD("thermal",		 522,	R8A77965_CLK_CP),
+	DEF_MOD("pwm",			 523,	R8A77965_CLK_S3D4),
+	DEF_MOD("fcpvd1",		 602,	R8A77965_CLK_S0D2),
+	DEF_MOD("fcpvd0",		 603,	R8A77965_CLK_S0D2),
+	DEF_MOD("fcpvb0",		 607,	R8A77965_CLK_S0D1),
+	DEF_MOD("fcpvi0",		 611,	R8A77965_CLK_S0D1),
+	DEF_MOD("fcpf0",		 615,	R8A77965_CLK_S0D1),
+	DEF_MOD("fcpcs",		 619,	R8A77965_CLK_S0D2),
+	DEF_MOD("vspd1",		 622,	R8A77965_CLK_S0D2),
+	DEF_MOD("vspd0",		 623,	R8A77965_CLK_S0D2),
+	DEF_MOD("vspb",			 626,	R8A77965_CLK_S0D1),
+	DEF_MOD("vspi0",		 631,	R8A77965_CLK_S0D1),
+	DEF_MOD("ehci1",		 702,	R8A77965_CLK_S3D4),
+	DEF_MOD("ehci0",		 703,	R8A77965_CLK_S3D4),
+	DEF_MOD("hsusb",		 704,	R8A77965_CLK_S3D4),
+	DEF_MOD("cmm3",			 708,	R8A77965_CLK_S2D1),
+	DEF_MOD("cmm1",			 710,	R8A77965_CLK_S2D1),
+	DEF_MOD("cmm0",			 711,	R8A77965_CLK_S2D1),
+	DEF_MOD("csi20",		 714,	R8A77965_CLK_CSI0),
+	DEF_MOD("csi40",		 716,	R8A77965_CLK_CSI0),
+	DEF_MOD("du3",			 721,	R8A77965_CLK_S2D1),
+	DEF_MOD("du1",			 723,	R8A77965_CLK_S2D1),
+	DEF_MOD("du0",			 724,	R8A77965_CLK_S2D1),
+	DEF_MOD("lvds",			 727,	R8A77965_CLK_S2D1),
+	DEF_MOD("hdmi0",		 729,	R8A77965_CLK_HDMI),
+	DEF_MOD("vin7",			 804,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin6",			 805,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin5",			 806,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin4",			 807,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin3",			 808,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin2",			 809,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin1",			 810,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin0",			 811,	R8A77965_CLK_S0D2),
+	DEF_MOD("etheravb",		 812,	R8A77965_CLK_S0D6),
+	DEF_MOD("sata0",		 815,	R8A77965_CLK_S3D2),
+	DEF_MOD("gpio7",		 905,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio6",		 906,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio5",		 907,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio4",		 908,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio3",		 909,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio2",		 910,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio1",		 911,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio0",		 912,	R8A77965_CLK_S3D4),
+	DEF_MOD("can-fd",		 914,	R8A77965_CLK_S3D2),
+	DEF_MOD("can-if1",		 915,	R8A77965_CLK_S3D4),
+	DEF_MOD("can-if0",		 916,	R8A77965_CLK_S3D4),
+	DEF_MOD("i2c6",			 918,	R8A77965_CLK_S0D6),
+	DEF_MOD("i2c5",			 919,	R8A77965_CLK_S0D6),
+	DEF_MOD("adg",			 922,	R8A77965_CLK_S0D1),
+	DEF_MOD("i2c-dvfs",		 926,	R8A77965_CLK_CP),
+	DEF_MOD("i2c4",			 927,	R8A77965_CLK_S0D6),
+	DEF_MOD("i2c3",			 928,	R8A77965_CLK_S0D6),
+	DEF_MOD("i2c2",			 929,	R8A77965_CLK_S3D2),
+	DEF_MOD("i2c1",			 930,	R8A77965_CLK_S3D2),
+	DEF_MOD("i2c0",			 931,	R8A77965_CLK_S3D2),
+
 	DEF_MOD("ssi-all",		1005,	R8A77965_CLK_S3D4),
 	DEF_MOD("ssi9",			1006,	MOD_CLK_ID(1005)),
 	DEF_MOD("ssi8",			1007,	MOD_CLK_ID(1005)),
-- 
2.7.4

