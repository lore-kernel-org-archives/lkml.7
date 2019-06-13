Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803E7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED3220866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442517;
	bh=R8ua41HVOaLUqHg4rK5lGHnRupPpLDqTsKrg/Dmrpuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AtaPki740VhGgltJspwYpNjurgOyUJUnB1vNEDB5Ip/jaM0rI7QaoMaKPfuwUoKVr
	 AXs5K8umDICq/NEck5RqlDxdgOHyzX8We+aZJAzRZeBkezoGK9mExP2+0oRiWBfLB9
	 euorM8uekTv/tvTvAKi4hOvvj85u0lH4fppvccIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391855AbfFMQPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731175AbfFMIl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:41:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C060F2147A;
        Thu, 13 Jun 2019 08:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415316;
        bh=R8ua41HVOaLUqHg4rK5lGHnRupPpLDqTsKrg/Dmrpuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OS4eRIyQLow0xUMioDRmKlAob/d/gTJMqNvLbT70vj6HAUHi4a06iq3usMaPoFtND
         DS5Dw/Kr8uDr9H6Q+xzGMfW9hv4DCDCZ6QDEtXbVWLA32ZpIKwBGUDCvYrU2ZyHV1O
         KbSGsfRCdDItgV7ErCWnL68qyygoiRst+bqRQS6s=
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
Subject: [PATCH 4.19 082/118] ARM: dts: imx53: Specify IMX5_CLK_IPG as "ahb" clock to SDMA
Date:   Thu, 13 Jun 2019 10:33:40 +0200
Message-Id: <20190613075648.579026885@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 28c168018e0902c67eb9c60d0fc4c8aa166c4efe ]

Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
clock to determine if it needs to configure the IP block as operating
at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
clocks as IMX5_CLK_SDMA results in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA funtionality. Fix the code
to specify IMX5_CLK_AHB as "ahb" clock for SDMA, to avoid detecting
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
 arch/arm/boot/dts/imx53.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 6386185ae234..b6b0818343c4 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -701,7 +701,7 @@
 				reg = <0x63fb0000 0x4000>;
 				interrupts = <6>;
 				clocks = <&clks IMX5_CLK_SDMA_GATE>,
-					 <&clks IMX5_CLK_SDMA_GATE>;
+					 <&clks IMX5_CLK_AHB>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
-- 
2.20.1



