Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A6CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1643D22311
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JpI+SdPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfKTL3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:29:31 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:53906 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729157AbfKTL32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:29:28 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C4281C2EC6;
        Wed, 20 Nov 2019 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1574249367; bh=xZuiw9xcWz5xaSLQT61O3wtX7ReJt+MIEb7btLMma1A=;
        h=From:To:Cc:Subject:Date:From;
        b=JpI+SdPewEQsTsLKOKZhfiREdC0oEbtTpa5I6VATJE5tzhnQRul7fUNUfJ/bvOqdo
         ivJa2vsGMeGJElfD8+Dq0G2NaCp7jV4rGIgfTK6LGfpc8JoFE//qJs46PaagrpCJ1V
         FnXnrzV942haXg3KRAsDJQu/aGwhdow6YJA0WgLLxlFqF3TW2pD9aD85RFq4/+UGI1
         3RTxwtFOXI+V+U8RxeUjMKpfjtqYDPoiHyTkmlM1PkB4UeyHlWu4ribFFqQl+mONpZ
         Q/pD+CoPFgR1xaLz3mVxgJOIcJUuBDyTxzNmV8k5tZZVCIdEOK1FXYB6h6gbRk8son
         Dp7QggbVyOqnA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id AE626A0057;
        Wed, 20 Nov 2019 11:29:24 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 1/2] ARC: [plat-axs10x]: use pgu pll instead of fixed clock
Date:   Wed, 20 Nov 2019 14:29:22 +0300
Message-Id: <20191120112923.431-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PLL driver instead of fixed-clock for PGU pixel clock.
That allows us to support wider range of graphic modes.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * add missing input_clk node to AXS101. No changes for AXS103 /
   AXS103 SMP.

 arch/arc/boot/dts/axc001.dtsi    |  6 ++++++
 arch/arc/boot/dts/axs10x_mb.dtsi | 11 ++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arc/boot/dts/axc001.dtsi b/arch/arc/boot/dts/axc001.dtsi
index 6ec1fcdfc0d7..79ec27c043c1 100644
--- a/arch/arc/boot/dts/axc001.dtsi
+++ b/arch/arc/boot/dts/axc001.dtsi
@@ -28,6 +28,12 @@
 			clock-frequency = <750000000>;
 		};
 
+		input_clk: input-clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <33333333>;
+		};
+
 		core_intc: arc700-intc@cpu {
 			compatible = "snps,arc700-intc";
 			interrupt-controller;
diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
index 08bcfed6b80f..f9a5c9ddcae7 100644
--- a/arch/arc/boot/dts/axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -61,12 +61,13 @@
 				clock-frequency = <25000000>;
 				#clock-cells = <0>;
 			};
+		};
 
-			pguclk: pguclk {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <74250000>;
-			};
+		pguclk: pguclk@10080 {
+			compatible = "snps,axs10x-pgu-pll-clock";
+			reg = <0x10080 0x10>, <0x110 0x10>;
+			#clock-cells = <0>;
+			clocks = <&input_clk>;
 		};
 
 		gmac: ethernet@18000 {
-- 
2.21.0

