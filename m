Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9367AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634CD206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="bMAL86NR";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="m0LXEG8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfC1NjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:39:04 -0400
Received: from node.akkea.ca ([192.155.83.177]:39736 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfC1NjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:39:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 0DFDD4E2050;
        Thu, 28 Mar 2019 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553780341; bh=dyAuFncXh758Mar867oy2cEp4stxQh1qXf+dwLmK3PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bMAL86NRuEH86j7dcypnjCNSRET8APu79KER6Yi1YECUW66dPbGythkngNN8Txhlt
         O+VxGAcY8GNbj+KkN/RahiV3Tpyo4Il7GhCW+irAv1x10V2MY7S+jbWUsYxVhIiiU6
         lmqZCeuo5t53ygyOS81PsaAnTQHiF4kxfiacZAd4=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LOH2fc5BM6lU; Thu, 28 Mar 2019 13:39:00 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id D15BA4E204D;
        Thu, 28 Mar 2019 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553780340; bh=dyAuFncXh758Mar867oy2cEp4stxQh1qXf+dwLmK3PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=m0LXEG8fKvbdT8iJK2UsA+MNclyj+c6iBsuoctFB7v71A1svviCA8oDc2NuWitakT
         MeJvGVhrZvT5X0zomn7fu06Kc/Ns/1XI2t2e26xcKJcrKlTO/MjBfopFpBNxVWZb+g
         iP0DZc5u9YlldKTI8PWXSuAtpjFCegcvh4OrEbVU=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: imx8mq: Fix the fsl,imx8mq-sdma compatible string
Date:   Thu, 28 Mar 2019 06:38:25 -0700
Message-Id: <20190328133828.20999-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190328133828.20999-1-angus@akkea.ca>
References: <20190328133828.20999-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in the compatible string

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 81d5ce1b1ec1..07099f82965e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -720,7 +720,7 @@
 			};
 
 			sdma1: sdma@30bd0000 {
-				compatible = "fsl, imx8mq-sdma","fsl,imx7d-sdma";
+				compatible = "fsl,mx8mq-sdma","fsl,imx7d-sdma";
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
-- 
2.17.1

