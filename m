Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4733AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB0220665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442480;
	bh=/xsKunJb0b7JNI+hxbSs2B2m7XRoClfEzzm84fBCY4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ktk6DrZ+BDinpnhiXxLijtX2h5XL5/CDOyW/h3kFYOcXCPsVkVHFggnCGXPq7wKuK
	 gMlbL0Za2NkN2hVyEVuGgcaJV1rv3dMuKlT9J9Kkb4uQFEiPLwBE8W2O99RrKV8OOd
	 vf/hs3NsnmBsruWZN877XjyfNzZJ4Cv673Md99q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391818AbfFMQOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731187AbfFMImQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:42:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 707C12147A;
        Thu, 13 Jun 2019 08:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415335;
        bh=/xsKunJb0b7JNI+hxbSs2B2m7XRoClfEzzm84fBCY4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0R3ww2q310bufO2v/P3vRARdIy2WZ9LPsuSa8NOiND1bUC3ka5DD9Hxgislj+qSm
         GX3G5ZKGfVWpftNRkIRT/V+I7P9G7FBeOB88p6S0nfhF+Pgr2GEPwmUEwGQVUMI/wl
         eI8gTykos4Xnt/a2n3R3Lp/AKpmtztYW1zsGHsDU=
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
Subject: [PATCH 4.19 088/118] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as "ipg" clock to SDMA
Date:   Thu, 13 Jun 2019 10:33:46 +0200
Message-Id: <20190613075648.954823832@linuxfoundation.org>
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
index 61d2d26afbf4..00d44a60972f 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -905,7 +905,7 @@
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



