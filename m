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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8008C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34D02082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1qTbgw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfC2Gtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:49:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38564 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfC2Gts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:49:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so735790pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 23:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nLcLvDQ0tBdUld5eZ44Ef7wclD7DpyhXGUY4yFYZw3M=;
        b=q1qTbgw+Ievjh/GvVSVJX0qEad3vtX70IL71heAynHc2rhGt/qNzbRuHmUkgkjQt6x
         Bi8UCCKhfeHSXXJXRxJwYBL0OmKRDCbJwyZugFqzZKBjLtjS0AaA+KZqt6T9E5czSeOB
         AcWT40BDH97GlAqyuWCxEKMfjP52m5Jy/I0HJpmStWCsWqlKliVJIO9RkPPxZDiTbPN9
         g1/devdDCQGvUQbeBFDHq3GDLsDYZUfDuyxeW7r8CvNX+L8WHlHaBAzpfXxW3IvnNWly
         pceLk1RAiTHKPGpz59T4Zss701LtA7Soep88KfhF0euDWGru62bzJpSavfmRjQifJoyg
         zTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nLcLvDQ0tBdUld5eZ44Ef7wclD7DpyhXGUY4yFYZw3M=;
        b=n/HdX2WnTcizy0dT687OiXOYZAkXbk79Z0tacqTO34NMO83inY+H6NE+JSAtCL4Drx
         hoJUQmNfWZBW/GcTIZfEXCW6Z4Zza6pFZjCvzVrQ7k78f8kQJbGwBB9mDqpIloI74p0A
         3eVtN0t+9oPPSz6ZZ294MUfrYkPIwZUxlOPGCC0K0iWEEOGaukA056hsOwIcBDLREb8m
         oxcbxfl+cSru5eW+7aGAR3SY374hA6L92modsnwX9ED5RG8Yh8Dwp5pn9qCE8Qne+xvx
         FODsBnXdTZLxV0yBdMjnT8Gxvb9bbjHYiXurvpbWd+RTiZbf3rsjKjP2q4j4TZV84nv/
         DUuQ==
X-Gm-Message-State: APjAAAWalYIOymMNZ2Ush2RQ/aY13THn2aaFUMDnicWqmQ7JlyTQHeKI
        X9bd7cL+Q3f5O0/miwRPpTo=
X-Google-Smtp-Source: APXvYqz5Fm6NvMET8kFLBgZhRHarg/+O+9aIwtUQeHtsyhroZoEY2FTxmmOEg+5tC++QpdIk3gu05w==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr16459312pgv.248.1553842187291;
        Thu, 28 Mar 2019 23:49:47 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i5sm1602818pfd.16.2019.03.28.23.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 23:49:46 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] ARM: dts: imx50: Specify IMX5_CLK_IPG as "ahb" clock to SDMA
Date:   Thu, 28 Mar 2019 23:49:24 -0700
Message-Id: <20190329064924.8728-9-andrew.smirnov@gmail.com>
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
clocks as IMX5_CLK_SDMA results in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA funtionality. Fix the code
to specify IMX5_CLK_AHB as "ahb" clock for SDMA, to avoid detecting
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
 arch/arm/boot/dts/imx50.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 5dd61bff3b76..0bfe7c91d0eb 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -430,7 +430,7 @@
 				reg = <0x63fb0000 0x4000>;
 				interrupts = <6>;
 				clocks = <&clks IMX5_CLK_SDMA_GATE>,
-					 <&clks IMX5_CLK_SDMA_GATE>;
+					 <&clks IMX5_CLK_AHB>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx50.bin";
-- 
2.20.1

