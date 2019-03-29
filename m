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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CCCC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC7B2184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcKE6eZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfC2Gtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:49:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41579 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfC2Gtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:49:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id y5so556449plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 23:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ed5a919dY3TxioV9CWgdr4Ii/JOsTqTVDo8QZTkeUjA=;
        b=KcKE6eZhvOYJHOCyRNr4s2zhCAYrl5ce/sL08Ih58ZtQb4/P6Bd804ndV+TBEAqas4
         K7EVk/lOuOTTvDFV+7dQqFeQiUyInitppPvIJOKXJa2HvVG+R8H7XCvZW/KUA5f3f40W
         rYxT7qVqz/2ndfDF0NacotSNNQk8JkranhiTfgmr98QICOR8K/FmipXXaUyI6dOpT5uB
         BMRyohFY94UONxszcSm86DkYC5M15HnmjsSwUvLGve5x40RuH9u6bSavV8Pn0rf9kqZw
         4vPadMwfe57PKh74ZJn6PWv6tBODJQm53nlg+0JSMqPQxIL1/CzPHouG4lkmYrMQD2bJ
         W5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ed5a919dY3TxioV9CWgdr4Ii/JOsTqTVDo8QZTkeUjA=;
        b=bHcw8THRFVDnT8S1ubJNozv5DZjgyvcVR33j0AScoLq8scRv1/pPTP2T/SI/MFWnVZ
         7AbBmPa4ZVTkNc1+d9ZlQRvjF0Nf9sL9b8zt33KwNAB7Wpg1+2JXoWCQ7W9FA59gVGZf
         ug1V3D6Acg4h+GMT4ZjOOQDJZQrZGMzmAGMZpjTaPcNNG+wWzuusN6xDOBqS8CmCCSJC
         QUCp9o/+l9CPb0Ai51OcsKGFLsVGRRhngXrhi5F9UeWk60wNDWsauy+Y1lxGUyyufkYs
         NrQtWbkNHORFA3Z0MPIYW8R7ZJDZUgiSnQiy0/xbVI08fO0Bf+JYyHJ6+cwwMYzgCv1P
         OW+w==
X-Gm-Message-State: APjAAAUDs/qdzTSv/u+EZjZ2jMJaq67jmuygoAvbRhlYjjX7CEdINypd
        SgFAcSq2nvJMGmJ+mPQvJJM=
X-Google-Smtp-Source: APXvYqxOo1/psk3OHk8i2powPOqxmXlOQVNlKw+z26Vm4Mk9/xWXvGHAkg5lpLFi3mthdjz1MPB3FQ==
X-Received: by 2002:a17:902:5ac9:: with SMTP id g9mr47531462plm.205.1553842179162;
        Thu, 28 Mar 2019 23:49:39 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i5sm1602818pfd.16.2019.03.28.23.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 23:49:38 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] ARM: dts: imx7d: Specify IMX7D_CLK_IPG as "ipg" clock to SDMA
Date:   Thu, 28 Mar 2019 23:49:18 -0700
Message-Id: <20190329064924.8728-3-andrew.smirnov@gmail.com>
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
clocks as IMX7D_CLK_SDMA results in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA funtionality. Fix the code
to specify IMX7D_CLK_IPG as "ipg" clock for SDMA, to avoid detecting
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
 arch/arm/boot/dts/imx7s.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index e67c8dd4bdab..31c610e6c788 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1071,8 +1071,8 @@
 				compatible = "fsl,imx7d-sdma", "fsl,imx35-sdma";
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_SDMA_CORE_CLK>,
-					 <&clks IMX7D_AHB_CHANNEL_ROOT_CLK>;
+				clocks = <&clks IMX7D_IPG_ROOT_CLK>,
+					 <&clks IMX7D_SDMA_CORE_CLK>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
-- 
2.20.1

