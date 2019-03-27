Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98A9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD9A2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRX1l50g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbfC0GfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:35:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36012 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733057AbfC0GfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:35:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id p10so9259894pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 23:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8peri8YrjObG6mnV61AuNYFEhPQ7twqVoziYh+diY6w=;
        b=jRX1l50gpnDO44z1/f2GOK8+1xw0+LwdOOCXBhHbSdQMYjXk9QGVaIqhFaxu2XQohT
         NJ8dzSAZq+8WuM9Kbzd2b3tDpeEWnltnUsnJEYSnROVluk6Qopy63AYe5A0IRec8Vfbm
         ke01ZUBF4AsdXSFvjfO5oMei8kFPAN8YufWe1P/B5fCTMDRYRZaBU3Qomw3uMHayj/hb
         pc/+noZBun3L7zP6ow99qmN1DPh///LilRzuJ5wPGOzQDwtavishSr2flEoZdGeelPX5
         TI32cPlV8ZJsGDBsyPDg5YbBBCAe7I6O5tFMN9twKrpYwgb+KYIcCXamdXDoBl9hzYQE
         rkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8peri8YrjObG6mnV61AuNYFEhPQ7twqVoziYh+diY6w=;
        b=WihUvj581tPmovSYgwohVKk0N72ltSgm+YLEpxP0V9ZF7vadcCbtFIWzdef820qvWj
         4ceX1o+7gKkyA1txD+dokr7vcj4SrAd9fO9CB9FEYBWkn644g6Va4MkvKG/euNe5Yd9t
         uqxFwkiHoGrzNqGmgvMqGi49sirOdXHqg2vp48wqRGPPKtAuY9h+uHbLS0O04TVFThkg
         7YtTom7rywwDw7XHrvQqppo27z42Oohii66Xzd/ubPJp/GFL5y0CT1DmSk+lcvnjiRS7
         2pp/qZcDtcga/46Jcvrzx9lqA+PP2yz7Bf+ZVBkmVZTD40ypBCKck9i0X2WUe4AYEdYz
         WdSw==
X-Gm-Message-State: APjAAAUlpx/qdA4ilLHqMGafTHRYtjTx7drU61UFochgqmYwOOgkXG75
        1xjBVTMKfq7x4EsXdE5q/ltXyCJB
X-Google-Smtp-Source: APXvYqyQPZqriXYwvMYuesQUEu6Ora8blYjEhoXUBw1AST2Hn3uM16LQeO86E6eF5Dag4ArWEq3HNQ==
X-Received: by 2002:a63:f310:: with SMTP id l16mr32299019pgh.72.1553668504783;
        Tue, 26 Mar 2019 23:35:04 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k1sm19950258pfo.121.2019.03.26.23.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 23:35:03 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ARM: dts: imx6sx: Specify IMX6SX_CLK_IPG as "ipg" clock to SDMA
Date:   Tue, 26 Mar 2019 23:34:50 -0700
Message-Id: <20190327063451.25629-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327063451.25629-1-andrew.smirnov@gmail.com>
References: <20190327063451.25629-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
clock to determine if it needs to configure the IP block as operating
at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
clocks as IMX6SX_CLK_SDMA result in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA functionality. Fix the code
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

