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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BCFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC3D2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2EIPsDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfC2Gts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:49:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34053 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfC2Gtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:49:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so572422plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78oAD7dh5w277bxAutRdh7nAgrOQBYKs5ByiPHxGBA8=;
        b=u2EIPsDCRnexkBkXBBhY4+QyGfu7+OqxmXr8/rIvO07APnvnwDIY3WCbTidyJx2HGI
         ekDympdtLmlCkbuaftjOHfQZ/4Xnh3UwpZSKUj6N535RUxAODbKS9zu/LaId1GfUEUGI
         565KsprppJegS6X5aP9Z5ZBXxb6IM/w07DR0wo2OeIX0cccBheClsOixISgmUjmbmdLR
         0up5jC1ne7jie0t58f2whITfkfoRahC3J+TmTcRytOzuM9VV8jqhLXufrWFNW2kiXeI6
         vbWzgci+2p5yCJXy3KCaN2UXgRWc6SSAdzKtI6r4n8Uv1EIhr6mwAXAJuCJ2CqfeDv9j
         D9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78oAD7dh5w277bxAutRdh7nAgrOQBYKs5ByiPHxGBA8=;
        b=iQfz1XWbEU/WmOOgl/XFR584+AuiWuI9sROZhTlzqcHhjTixFWKi8AlPy6/vmHOSlQ
         nZ2gdlnMliwOWhM2aO3WUmsAgta/A0Hr9sKv33nxK7bw/BSnGG41zYbS9kpt76yUlAyF
         tlzPmigfqFULXtv5gWYLeZYBd4wZrxJcrK2d3hmRiGTYRNg3hydq/R+LZ3tulLIXrNG+
         xkBjp7T6cetMz5yX+/R66SG0cjuPr9D7GHa7XS/PsU165s2JNL0fvxCdKn1C910gkkAy
         MvJf28WdsAOy+0yGW7ZZy/GumKGsYZB+6WZtV0f5jvTT98pkCCaE56EgRoMGoB8yn20q
         U+8w==
X-Gm-Message-State: APjAAAUjwhs58j1NabmRWnNVR5g3197VqWM3c0hp4uXpE/NZtf/eEbql
        TK2H5Ku/neDMwV3LzeHUvMI=
X-Google-Smtp-Source: APXvYqynp+0OiZazdXehyCana77TpGKT7NkRiOb6NE8phdvYxlXMhscTeH9ANLbK0A1N99HYJQWHpQ==
X-Received: by 2002:a17:902:523:: with SMTP id 32mr45978430plf.249.1553842183045;
        Thu, 28 Mar 2019 23:49:43 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i5sm1602818pfd.16.2019.03.28.23.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 23:49:42 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] ARM: dts: imx6sx: Specify IMX6SX_CLK_IPG as "ahb" clock to SDMA
Date:   Thu, 28 Mar 2019 23:49:21 -0700
Message-Id: <20190329064924.8728-6-andrew.smirnov@gmail.com>
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
clocks as IMX6SL_CLK_SDMA results in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA funtionality. Fix the code
to specify IMX6SL_CLK_AHB as "ahb" clock for SDMA, to avoid detecting
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
 arch/arm/boot/dts/imx6sl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 0ad5d507abec..9ddbeea64b72 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -748,7 +748,7 @@
 				reg = <0x020ec000 0x4000>;
 				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_SDMA>,
-					 <&clks IMX6SL_CLK_SDMA>;
+					 <&clks IMX6SL_CLK_AHB>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				/* imx6sl reuses imx6q sdma firmware */
-- 
2.20.1

