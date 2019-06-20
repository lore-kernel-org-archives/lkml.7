Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125E1C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E7A2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561055307;
	bh=+jRxuSXqPh6iPUXu/kw9ugzs9f/QZb/GAeAV4h+1Ax0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=znfHGCgw/p0Sqf7V2bUCPBVBeE/cEaGbd6QfyB+AL3LW6NjHpsjzqEI/cotsAQSkK
	 Shsnm3bt7itA6em2XYy/d8cg6bNeobmTDXj0R55VsPE80/BgDfeV9C6ji1XcG+kzzH
	 74U6UPHQEAILGUzK2ed4RAs+aCeKu8bSzto9hq58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfFTS2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbfFTSDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:03:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 060222089C;
        Thu, 20 Jun 2019 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053833;
        bh=+jRxuSXqPh6iPUXu/kw9ugzs9f/QZb/GAeAV4h+1Ax0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tw8xXXse+1lZmmYElLwjk24UFSPFAqbh/IrV8DZieCy/SZe6a10R+xjW6YWAzUwlw
         6FjQwez0Gv+d9OE/CLnfkWITRJyJYyZZfBBi7T+0NcBwxB2Td1ejQhVwFuOQBLABbA
         Ji17u6as8I6MgxHV9xpDT3s06CvXl5GOHO/SGKGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Adam Ford <aford173@gmail.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 041/117] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as "ipg" clock to SDMA
Date:   Thu, 20 Jun 2019 19:56:15 +0200
Message-Id: <20190620174354.452331200@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b14c872eebc501b9640b04f4a152df51d6eaf2fc ]

Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
clock to determine if it needs to configure the IP block as operating
at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
clocks as IMX6QDL_CLK_SDMA results in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA funtionality(this at least
breaks RAVE SP serdev driver on RDU2). Fix the code to specify
IMX6QDL_CLK_IPG as "ipg" clock for SDMA, to avoid detecting incorrect
clock ratio.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Tested-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b13b0b2db881..8ccafdfbe87c 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -875,7 +875,7 @@
 				compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6QDL_CLK_SDMA>,
+				clocks = <&clks IMX6QDL_CLK_IPG>,
 					 <&clks IMX6QDL_CLK_SDMA>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
-- 
2.20.1



