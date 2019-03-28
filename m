Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1CEC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D87621773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="nGVqDTfX";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="T0Gs8Rl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfC1NjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:39:12 -0400
Received: from node.akkea.ca ([192.155.83.177]:39824 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfC1NjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:39:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 49FBD4E2051;
        Thu, 28 Mar 2019 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553780343; bh=0ht/ubDI0nlqyRA7MbFe6QjOX1K1hnOqkJjhd15vAUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nGVqDTfXb3VHXG36JeIvAe9ZfqC7jC3/bTc4LbqVQUt9ZITfau6bhBZC77Kkv18gs
         QgR6S1qjgoDQE+O61ayjczRPonc9cD19HiUS6lCKDY+N8GkAdWEyKVyXdWWyPCQHKK
         8j2hBS+1u5XnPaUmJ4c1PwqYTYkd6BOnuPOJN000=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M94Z29IBhm_T; Thu, 28 Mar 2019 13:39:02 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 431074E204B;
        Thu, 28 Mar 2019 13:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553780342; bh=0ht/ubDI0nlqyRA7MbFe6QjOX1K1hnOqkJjhd15vAUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=T0Gs8Rl4bRLvXvxpkeMo8Z+aWxnSBTd47NyS1DBxpTrZke0wlwXaJ+M6nM5yWyIgr
         npk2fjqKxryldQ/6f5SEIFnjfQM8ggbpJvv8lvzIpKK2KtzJLn6gt8C4qCzrqjIcJ6
         chjkSL5IVj1OyA4r+j5/U/vIG93ZohsTs/7M9dTk=
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
Subject: [PATCH 4/4] arm64: dts: imx8mq: Change ahb clock for imx8mq
Date:   Thu, 28 Mar 2019 06:38:28 -0700
Message-Id: <20190328133828.20999-5-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190328133828.20999-1-angus@akkea.ca>
References: <20190328133828.20999-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set ahb clock on sdma1 to get rid of "Timeout waiting for CH0"
on the imx8mq.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 07099f82965e..cd0f9eed9e9c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -724,7 +724,7 @@
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
-					 <&clk IMX8MQ_CLK_SDMA1_ROOT>;
+					 <&clk IMX8MQ_CLK_AHB>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
-- 
2.17.1

