Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C64C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F265E20644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443080;
	bh=Vbj9xKVfn06Vf0f9vOlGthpIi1V9VffjlxLnF5ezOqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q9HSHY5c3yrs5D4P5KfUvPqit+vp1SPGjXc023QBzFKY5SiBzQ1MDyXfSYlMxq+zK
	 2Xqo7kk1NivSk33TDTCl5QtWIskPKQ79vDqjvjz7ZfSF2vxDBocIzNP1qnnF6bRbeB
	 hnkFYJKWe6pYPByedk9/2eyauMEKuqkcObzhb2eQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392083AbfFMQYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730990AbfFMIhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:37:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B47952146F;
        Thu, 13 Jun 2019 08:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415026;
        bh=Vbj9xKVfn06Vf0f9vOlGthpIi1V9VffjlxLnF5ezOqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kkTNeXOy5f1LpS3BoROa/pO/SqoODOB9tkySPj/4F8T5f/AO23uX6yQ6i8w1ATF0a
         8X0sV9k2O2E+dfITvfLgfrjsBrb3UHihNU88uy4TadE67v0nUz9I4Di5W55Eve4kar
         M4EOy5+yGM06trabfpb1Idt/N0+kbQrIPeIYEgGM=
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
Subject: [PATCH 4.14 58/81] ARM: dts: imx6sx: Specify IMX6SX_CLK_IPG as "ipg" clock to SDMA
Date:   Thu, 13 Jun 2019 10:33:41 +0200
Message-Id: <20190613075653.409493151@linuxfoundation.org>
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

[ Upstream commit 8979117765c19edc3b01cc0ef853537bf93eea4b ]

Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
clock to determine if it needs to configure the IP block as operating
at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
clocks as IMX6SX_CLK_SDMA results in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA funtionality. Fix the code
to specify IMX6SX_CLK_IPG as "ipg" clock for SDMA, to avoid detecting
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
 arch/arm/boot/dts/imx6sx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index d64438bfa68b..61ad4e296257 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -766,7 +766,7 @@
 				compatible = "fsl,imx6sx-sdma", "fsl,imx6q-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6SX_CLK_SDMA>,
+				clocks = <&clks IMX6SX_CLK_IPG>,
 					 <&clks IMX6SX_CLK_SDMA>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
-- 
2.20.1



