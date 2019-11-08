Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C602FFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1AD22518
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239591;
	bh=PVFCXylIgDGZcUj87fCk4jwfZ9TXjA9zwI3XOHKJw0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C9HcwBSdp6MbWEDx7vp+D9+pyv0gFa0BBlXdFo0DUsvw94V+F1A3+SlrBzGZ3MRhU
	 mz2Cd323QWJCBiDLHp9dsXfZzmCIH/ZNGWqmiryoobWnbFrV9thucRgETi+OB51NB2
	 qKMWl0o74ja+8MC5YpM9N/uhphPmMalr4xAQUK94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfKHS7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730685AbfKHS7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:59:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D1222509;
        Fri,  8 Nov 2019 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239586;
        bh=PVFCXylIgDGZcUj87fCk4jwfZ9TXjA9zwI3XOHKJw0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sdw788DbVcxQ8Ex5FigWhAm7CuTQM4uXzbbcJMkm9ZDd85OxqaLSfGxTeROfOxA18
         2XOoqh4MvIFvY+U0S7VuczRncyP8NWiT0qbauVjP5NzJQ6xGfWlmZlEdff/Q7Tt9yy
         Qi3tI5K4aEmpz+NGwuuk6XudNPUwS+xCWtR7oG1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/62] ARM: dts: imx7s: Correct GPTs ipg clock source
Date:   Fri,  8 Nov 2019 19:50:00 +0100
Message-Id: <20191108174731.554569091@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174719.228826381@linuxfoundation.org>
References: <20191108174719.228826381@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit 252b9e21bcf46b0d16f733f2e42b21fdc60addee ]

i.MX7S/D's GPT ipg clock should be from GPT clock root and
controlled by CCM's GPT CCGR, using correct clock source for
GPT ipg clock instead of IMX7D_CLK_DUMMY.

Fixes: 3ef79ca6bd1d ("ARM: dts: imx7d: use imx7s.dtsi as base device tree")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index bf15efbe8a710..836550f2297ac 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -450,7 +450,7 @@
 				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
 				reg = <0x302d0000 0x10000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_CLK_DUMMY>,
+				clocks = <&clks IMX7D_GPT1_ROOT_CLK>,
 					 <&clks IMX7D_GPT1_ROOT_CLK>;
 				clock-names = "ipg", "per";
 			};
@@ -459,7 +459,7 @@
 				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
 				reg = <0x302e0000 0x10000>;
 				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_CLK_DUMMY>,
+				clocks = <&clks IMX7D_GPT2_ROOT_CLK>,
 					 <&clks IMX7D_GPT2_ROOT_CLK>;
 				clock-names = "ipg", "per";
 				status = "disabled";
@@ -469,7 +469,7 @@
 				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
 				reg = <0x302f0000 0x10000>;
 				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_CLK_DUMMY>,
+				clocks = <&clks IMX7D_GPT3_ROOT_CLK>,
 					 <&clks IMX7D_GPT3_ROOT_CLK>;
 				clock-names = "ipg", "per";
 				status = "disabled";
@@ -479,7 +479,7 @@
 				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
 				reg = <0x30300000 0x10000>;
 				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_CLK_DUMMY>,
+				clocks = <&clks IMX7D_GPT4_ROOT_CLK>,
 					 <&clks IMX7D_GPT4_ROOT_CLK>;
 				clock-names = "ipg", "per";
 				status = "disabled";
-- 
2.20.1



