Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09822C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5CC21871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="LS1TvWbi";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="LS1TvWbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfC2PVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:21:42 -0400
Received: from node.akkea.ca ([192.155.83.177]:58976 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbfC2PVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:21:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id F1E0D4E204E;
        Fri, 29 Mar 2019 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553872900; bh=jfpSgeIMUuEBpCNvttjmAJv6RYfuU/dhphRVCNtitJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LS1TvWbiq75tWuawZOTAkjr+VhjjPvRMGrwhKPxwlCc4e51uLbdRX+Ot7yiEnhm+I
         NH1XHUGXFRdxAcNrx3fbf9F6uUTeF3FI93huuSUc4Ajf5NQ2vhwefcqkTe35LstK81
         dJASH2J+e852I4pwvTKoo6wTFitYF/30rJSWN6jM=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vcCuJ4UxZZtL; Fri, 29 Mar 2019 15:21:40 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id E867C4E204D;
        Fri, 29 Mar 2019 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553872900; bh=jfpSgeIMUuEBpCNvttjmAJv6RYfuU/dhphRVCNtitJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LS1TvWbiq75tWuawZOTAkjr+VhjjPvRMGrwhKPxwlCc4e51uLbdRX+Ot7yiEnhm+I
         NH1XHUGXFRdxAcNrx3fbf9F6uUTeF3FI93huuSUc4Ajf5NQ2vhwefcqkTe35LstK81
         dJASH2J+e852I4pwvTKoo6wTFitYF/30rJSWN6jM=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
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
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: imx8mq: Fix the fsl,imx8mq-sdma compatible string
Date:   Fri, 29 Mar 2019 08:21:28 -0700
Message-Id: <20190329152130.18411-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329152130.18411-1-angus@akkea.ca>
References: <20190328133828.20999-1-angus@akkea.ca>
 <20190329152130.18411-1-angus@akkea.ca>
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
index 81d5ce1b1ec1..06158625f24f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -720,7 +720,7 @@
 			};
 
 			sdma1: sdma@30bd0000 {
-				compatible = "fsl, imx8mq-sdma","fsl,imx7d-sdma";
+				compatible = "fsl,imx8mq-sdma","fsl,imx7d-sdma";
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
-- 
2.17.1

