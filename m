Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B6CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13902082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbdKKoXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfC2GuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:50:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33689 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfC2Gtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:49:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id bg8so572743plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 23:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m4pOoTrjvfOyO3lHRQoZI3YMKtiCY3JviBbDnHNKrZw=;
        b=vbdKKoXViIM/SovhysLeQXfHIVYG/D4nV9xP5yW5NZ+wAfQ+AjPJujO7Jje835EFof
         4tXzapRiS36ccIrdV+mLfOszyR+PHQ7keR5yfyjE0JueDZ+m2QTAD0PxbFDxHj+vqINh
         FOzsp1lXZtXSnP3vSweHCg0m10zC7gXsuSRw4NmIP6zOVwJl7Dzq+MErSBew2XMJ5hy3
         3v0eaOWGaSlL+kdmQA/MrOv0dhwUX8WhNvwH8gbJcohL8sc/Dl0IoZ5AhaTVorYkQktB
         XWMNipRieOA3tmCnbwk5FXAe05ClKoGjGYrUsC6+qCCflkBQXmqtLtj/NsmZb5PBZZmO
         7l+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4pOoTrjvfOyO3lHRQoZI3YMKtiCY3JviBbDnHNKrZw=;
        b=Y33sZ6IiUHvChk8pGGfLWtvRgWjfAtk3k59zBfL18wbD48vE+a6wsFINPDpZeVfQ4D
         /Z3R09gUDpj+ecsvv5LyVlM4reogSgbzzWh3S2wARxhuJf/+k/RSdPU2Fi/UYjQMGlih
         h+dcP7eiiN5IQ6zc4lTcKbzKWURBPakxSUa6hXm5D0YYdRWooYQibvJwoAx/xXutkbke
         +qfSZZQtrf1LbstS8BRzVGLHuSdC3Y7EOEDsDCzhWO3E2qr15hnEUqpk32l7Pbi7TpyB
         doQrXaoSmlT9z19Dr+034rO6XW7cjJpJ0v45L7VBo6t1KG3OBYcj//h2OU+vg1xneYUX
         34Sw==
X-Gm-Message-State: APjAAAX/Qhs5EXCFEcQBtdJOjnVsEmdJNnKu24c0H2HMHH77K/KLbZuZ
        mlkM9KaV/eteKZl6Iw2ivPY=
X-Google-Smtp-Source: APXvYqze/oP0qjRXMP8y7FGSppGFqi5zNAs7vi/n5aMY6ZrDInjtpFmXY971ohTMpMPSRFLOo0haGA==
X-Received: by 2002:a17:902:2aca:: with SMTP id j68mr270129plb.233.1553842180433;
        Thu, 28 Mar 2019 23:49:40 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i5sm1602818pfd.16.2019.03.28.23.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 23:49:39 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] ARM: dts: imx6ul: Specify IMX6UL_CLK_IPG as "ipg" clock to SDMA
Date:   Thu, 28 Mar 2019 23:49:19 -0700
Message-Id: <20190329064924.8728-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329064924.8728-1-andrew.smirnov@gmail.com>
References: <20190329064924.8728-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
clock to determine if it needs to configure the IP block as operating
at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
clocks as IMX6UL_CLK_SDMA results in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA funtionality. Fix the code
to specify IMX6UL_CLK_IPG as "ipg" clock for SDMA, to avoid detecting
incorrect clock ratio.

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
 arch/arm/boot/dts/imx6ul.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index a77bbcae4571..bbf010c73336 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -708,7 +708,7 @@
 					     "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_SDMA>,
+				clocks = <&clks IMX6UL_CLK_IPG>,
 					 <&clks IMX6UL_CLK_SDMA>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
-- 
2.20.1

