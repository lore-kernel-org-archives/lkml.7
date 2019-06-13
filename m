Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C289C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4339020644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443094;
	bh=A6B0aOpUumJgDILwWqICquAEkjGnKFd2qeNglV0Fj48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2r651T48at0HoSLxADXj2tAo0tQs0E9RkQ4QUWSFPyV0ozpPfQkofy8OWpL+xelzw
	 NjQ/6SCezCP/iQRkn+aAzqoB/0RZWtAU4I+YaZD4SDgf0+l7Ajee2pShVCcUk3pouM
	 ZgB1QjKf7j/XqQy0yhtd1bYczJmMSTZ/f/GvOdA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391493AbfFMQYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730985AbfFMIhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:37:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0498C20851;
        Thu, 13 Jun 2019 08:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415020;
        bh=A6B0aOpUumJgDILwWqICquAEkjGnKFd2qeNglV0Fj48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GiwfIJRW6htTOCYz4vY83oBu4yX9wW+6WIa38njBEM52kljg2M66ios/115sU9km/
         CIcNiVu85V7RAfWiFFhuSRYG/bUup4EERSMDMH7m35CNiRqbChpG3Vdq5gETsURnsI
         pUrURk0fJ57nRAzhHYheMN7zP6vrTFP5k5hV5vyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 56/81] ARM: dts: imx7d: Specify IMX7D_CLK_IPG as "ipg" clock to SDMA
Date:   Thu, 13 Jun 2019 10:33:39 +0200
Message-Id: <20190613075653.291109838@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 412b032a1dc72fc9d1c258800355efa6671b6315 ]

Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
clock to determine if it needs to configure the IP block as operating
at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
clocks as IMX7D_CLK_SDMA results in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA funtionality. Fix the code
to specify IMX7D_CLK_IPG as "ipg" clock for SDMA, to avoid detecting
incorrect clock ratio.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 82ad26e766eb..bf15efbe8a71 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -997,8 +997,8 @@
 				compatible = "fsl,imx7d-sdma", "fsl,imx35-sdma";
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_SDMA_CORE_CLK>,
-					 <&clks IMX7D_AHB_CHANNEL_ROOT_CLK>;
+				clocks = <&clks IMX7D_IPG_ROOT_CLK>,
+					 <&clks IMX7D_SDMA_CORE_CLK>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
-- 
2.20.1



