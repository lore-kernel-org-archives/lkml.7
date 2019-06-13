Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3174EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069E420644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443097;
	bh=WnPZXcNzEfxMzANJxwkOhxhwm2dFitigp5+8teQ6OHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cac6AXMDf4sUnDdurGuC+y6o+x29M/FOFKN4QMvRljQzW9EfrqJgJ2YfBccPavHIm
	 aytltpckkSiKnI6ZNkzPtopCz9Psi+DePOpXMPKyvcpehx/Q1nHyxFs6D61UTRWP6E
	 iun/UUkqow9hk9lT1l6vCOj5pnMkSxXJSv8swKNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392127AbfFMQYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730983AbfFMIgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:36:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45E1E20851;
        Thu, 13 Jun 2019 08:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415014;
        bh=WnPZXcNzEfxMzANJxwkOhxhwm2dFitigp5+8teQ6OHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFS2q/a66LW4Zb8J6r/SCWOR5TtMxfsX34hQnUXss6v+2KvMo+fk/0IkCMkMTOuwQ
         2wqi/1Xgz4QI4F6h1E7Mh9Bf8MrtoNY+Pevy5XEYfHRGYdjaXvfZxIDdpOWiP/pRpT
         G5QZ0ZPr7HnIT37jHQhnOTviPFaF2WwQI7gYj40Y=
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
Subject: [PATCH 4.14 55/81] ARM: dts: imx6sx: Specify IMX6SX_CLK_IPG as "ahb" clock to SDMA
Date:   Thu, 13 Jun 2019 10:33:38 +0200
Message-Id: <20190613075653.237162041@linuxfoundation.org>
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

[ Upstream commit cc839d0f8c284fcb7591780b568f13415bbb737c ]

Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
clock to determine if it needs to configure the IP block as operating
at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
clocks as IMX6SL_CLK_SDMA results in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA funtionality. Fix the code
to specify IMX6SL_CLK_AHB as "ahb" clock for SDMA, to avoid detecting
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
 arch/arm/boot/dts/imx6sl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 3f76f980947e..bd9308b222ba 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -718,7 +718,7 @@
 				reg = <0x020ec000 0x4000>;
 				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_SDMA>,
-					 <&clks IMX6SL_CLK_SDMA>;
+					 <&clks IMX6SL_CLK_AHB>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				/* imx6sl reuses imx6q sdma firmware */
-- 
2.20.1



