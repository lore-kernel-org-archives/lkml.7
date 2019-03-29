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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304FAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5192082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXVa01cB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfC2Gtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:49:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36772 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbfC2Gti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:49:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id k2so568596plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 23:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATUitjO3l5PbwZI7xwdst/n1EivnhW4ELZtfYtpsmzw=;
        b=mXVa01cBPZ7ASZa37qhHs4ST7gC2TNZy2CJhdh58DleRfCAP5gO4/Gj0HF4UhfotyW
         dLOckldShqSGLe45uZYTabqXJ7AeBliYVfzcRkDT6llDdzcSEIFoTNbsknh3g8mXCKYM
         cu6GdE749wjKCS/dl+3vcMExs0my2l0IVThw1yiR33vxNPuAuB/yJKeoOarXtv3tC5gh
         sxCL+sYFdFyZb+9l8FgrEudBO6Vzqx4X0Sf0B7tFN7YqAYZSAd40G8OshNNhGTQhvrUF
         Mq5AWfsQtuMHddOvpWqbrxvn6JprOWzNOUOMQ8kR84+nu9qjJPP9EWAlEGVtmb7ib7fM
         nyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATUitjO3l5PbwZI7xwdst/n1EivnhW4ELZtfYtpsmzw=;
        b=TrrIuZMnHWVBuvg7NKHlarq9E/FNy4qK8Qr2BIbMAV9ka+Nfn65qIlUc8tCn7Sjhmq
         ISKuExboaug6uYCIBDVAwF0bQVTp//K3WYLTIeTLePmz/m6fsqLx8EcYHxgsuTSb+MXU
         feirScBUB3iLa+1CJUE7+NKGZFkC90zB1wUD0C9sCC8geYeKMIG1uAsHieSjrqkJXofy
         L4CMmFNNgpNVbMa8TfXPwXcb82naMPQkdun/SljVoIRm869YLQ0T9OgejtoW4d97cbL0
         4WA7FZj4WsqoQoy5/KXiZElcYuzagw+4x1KSvBLshk6B1PFcFlIpc9ehzax8PxP9xYV7
         o6dw==
X-Gm-Message-State: APjAAAWYdS6N6Sz3PODIPNjy5Ha5H1bZYNgSPF889kUC462yOCwJwL9X
        uFAXi7y/z0l+ecXfIWI2i9k=
X-Google-Smtp-Source: APXvYqzV0tPHbLG88WNKysL3Wa8O359cTEJVEk9eVaBs+hzI7yM83kE12caFJk5WxVMmsfMrp6Spow==
X-Received: by 2002:a17:902:526:: with SMTP id 35mr44501356plf.276.1553842177646;
        Thu, 28 Mar 2019 23:49:37 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i5sm1602818pfd.16.2019.03.28.23.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 23:49:36 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] ARM: dts: imx6sx: Specify IMX6SX_CLK_IPG as "ipg" clock to SDMA
Date:   Thu, 28 Mar 2019 23:49:17 -0700
Message-Id: <20190329064924.8728-2-andrew.smirnov@gmail.com>
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
clocks as IMX6SX_CLK_SDMA results in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA funtionality. Fix the code
to specify IMX6SX_CLK_IPG as "ipg" clock for SDMA, to avoid detecting
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
 arch/arm/boot/dts/imx6sx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index df0c59519886..b16a123990a2 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -820,7 +820,7 @@
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

