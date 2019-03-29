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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB61C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C55A2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3T01U2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfC2Gtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:49:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37788 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbfC2Gtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:49:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id q6so565334pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 23:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=klOQQder074G6QHLH5zIbrfbm39+4L8f6wWRAdAHSDY=;
        b=A3T01U2LaJJfUFIHi9Uynzel0Se7kfMqns7j3aJ+mcXBvDMYUrEKj7kFtywWt3UauZ
         jjghDJ2GN61ejYubBhsRcU8D6i78y5p1Y5nvY6tripyM1xnVJ4Y2/u+cFN4fwi2LiKIe
         v6IojykzLkuSnHTrL/lC9ZF5qcwy0FVm0fOuJfP+lIvI517RSAyjUhxilSUQFbWmhwaB
         9wy/BFPbmyMwk1wPwWkI9t0jmTzMOcVmQi1kfLJkZult0Os9FbEbLLMwTzKL4w0cxLvg
         ZKCixyQegnm/AAVCHimWuuhbrMkHGYIYNtf+yCzsF7kaYGkjK8sD61jn3tRX0jvk0XZw
         WaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=klOQQder074G6QHLH5zIbrfbm39+4L8f6wWRAdAHSDY=;
        b=LhSwOU/RoiKy/3zQ374Q3bQ9wYwnbNs6P2EK+BPSw8Qeo8IM+sAHYCgvmsANgi6h81
         yyaWv4nTpNnA8rHMJwFNAwjD+3aXFM5GLLZ4xYgDVwOsEznI74DD3wSRDHRwrTTqrJf6
         U9qeiTzLyMCIASx8XrHYFkJyj9fAav3IytbgSt4XKNYZDKiYOgfs5KkM1n+Vv+8PFi9v
         kAwDWxK2kYuLrA31GTHy/lP6E/lwZTqvKk0fPKlHij5kWCW+Wp4W/i2BumS+V5xSjGrx
         muzOhqdmXvKaQzN1BNhEeyXiAjQDLLPzaKcaVnWTDZSh6Pd8qJTPcCgR8TDyEhJhrzvS
         EAIQ==
X-Gm-Message-State: APjAAAXaD7tW5BB0e96+urhhQ5bF4anPEqrZ3+CywS1Pw1lfoME9oYEA
        O6PXJ2J1a9q76UdinKPQmNE=
X-Google-Smtp-Source: APXvYqxffam5Lj41/BYdtCA9pV8HcHSI25Yg6Yn5m7tFnacaLSC+0EkebK08KLGNmOwAJaHF4xJhoA==
X-Received: by 2002:a17:902:70c8:: with SMTP id l8mr15461096plt.177.1553842181806;
        Thu, 28 Mar 2019 23:49:41 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i5sm1602818pfd.16.2019.03.28.23.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 23:49:41 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] ARM: dts: imx6sll: Specify IMX6SLL_CLK_IPG as "ipg" clock to SDMA
Date:   Thu, 28 Mar 2019 23:49:20 -0700
Message-Id: <20190329064924.8728-5-andrew.smirnov@gmail.com>
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
clocks as IMX6SLL_CLK_SDMA result in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA funtionality. Fix the code
to specify IMX6SLL_CLK_IPG as "ipg" clock for SDMA, to avoid detecting
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
 arch/arm/boot/dts/imx6sll.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 62847c68330b..ed598d72038c 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -621,7 +621,7 @@
 				compatible = "fsl,imx6sll-sdma", "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6SLL_CLK_SDMA>,
+				clocks = <&clks IMX6SLL_CLK_IPG>,
 					 <&clks IMX6SLL_CLK_SDMA>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
-- 
2.20.1

