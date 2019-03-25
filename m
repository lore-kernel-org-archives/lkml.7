Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7494C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C4E2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQbKn3wF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfCYFBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:01:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33787 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfCYFBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 01:01:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so5511582pfd.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 22:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdqiUqpCCqjlbO4cGUPp77lKkW7nNkFREk67Kdc/S4U=;
        b=GQbKn3wFQQPcgHY1liBFlSxrm+RX5+95eb87S5Rz0JEXOSzR9NxVUR/qslfwirDoGv
         ipN66LrEvnaQHuQgA+kl3/BxOGeorepy5ascwIdaGfg90TyjANrlzhWsjVdDQ8ntyYHE
         cyrxGqLfUJ+060ODVS2VwNfewlKEXDcY1QitoiRlfZ6nd3rmY6Geff4WrAKeBKUVPT/W
         /sbdaWCCMX/Yq9THONknsb4GJqVkJ0SCdu/dB4MRtr3NRqK2Ritaax5ZVHEp7IGBQ1V1
         6aXYnnktxxmqBDaQl1SdE6lV3iLCCpsqcZeusIqvrsi+X72cJg1waHo7zkVXkXoFhG0x
         kQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdqiUqpCCqjlbO4cGUPp77lKkW7nNkFREk67Kdc/S4U=;
        b=dKWxhBjUH+owGtyLTyFB1iVt0Eid4PK5jqL68UJcJCBAyjFOAA6mV1jU2g/1i3yzlK
         JfK+iompe11+9nSdilSep5pLRfrtCtmESke4IP+S/RSa5/tPlIU3EuoiXD/yuNCvDDre
         6TFeMHdu5mKq29p3WVhO6Oxb/1eWxLsMOwXFMqkhol8NQQhP69fb+RtSftVDpICv7jf5
         wDhpiKyjmw1a/fvYZHU9v6Vcrw3G5Qm7ZuMjoK3DSKpUDk3hEJO7+MJuaCPgCmkmiNMI
         55JJ7LnvRImeZ5GQhx26NrV+u+t0OdSUCrAcUWEaIjOtk2xJ2UZNRLYUm4fGs//abnaT
         Narw==
X-Gm-Message-State: APjAAAXH6BNNlAbE57PlVd84UTTe3BWHGHXnJGDRGJZx9v88wxR579EJ
        kAsU2swUedRTg2ZNTEtMk14=
X-Google-Smtp-Source: APXvYqwj/L2DlBgQD7K1Lr6oTwVyn7NNHNwC4UtAuYE0TBEbj3pZadiM+3bIYzOGZZyx08gK7sMYbQ==
X-Received: by 2002:a17:902:8692:: with SMTP id g18mr22613304plo.149.1553490076743;
        Sun, 24 Mar 2019 22:01:16 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id 17sm20238200pgt.0.2019.03.24.22.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 22:01:15 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as "ipg" clock for SDMA
Date:   Sun, 24 Mar 2019 22:01:00 -0700
Message-Id: <20190325050100.29517-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
clock to determine if it needs to configure the IP block as operating
at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
clocks as IMX6QDL_CLK_SDMA results in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA functionality(this at least
breaks RAVE SP serdev driver on RDU2). Fix the code to specify
IMX6QDL_CLK_IPG as "ipg" clock for SDMA, to the problem.

Fixes: 25aaa75df1e6 ("dmaengine: imx-sdma: add clock ratio 1:1 check")
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

This probably has been fixed already, so please ignore this patch if
that is the case.

Thanks,
Andrey Smirnov

 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 9f9aa6e7ed0e..354feba077b2 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -949,7 +949,7 @@
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

