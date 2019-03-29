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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C9BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1782082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzYiADF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfC2Gtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:49:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40119 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbfC2Gtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:49:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id b11so555956plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 23:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14vBhqFf5cJryvoCa3IsFyVfRVbgmQyJmJY/JUXSOH8=;
        b=bzYiADF+z5x4y+NuS5hTb/LAfuQlw750wIfQ8yvJUY+ijj2Q9TuMAa2oSHZhNJqKpt
         m3XKhpZhynAlNtnjXpivMxZ2Cor8wwXK3H7VdgeNXJ6D9PMfVDjOLUpJ7GvFDhHf1oP5
         HB9/L1nND9PYa4/Ytg0cxeOhclbAFK1z9rpU2A105YV3aga2FGCzfEKcsw7jRQsgPWLY
         ttuVg/EQmi5+HVkQw8RJPtzBSMyM0o3asep8jQv0+fceWq+Bjm1cWUhIVVEQ5FenJrkP
         6nSPZXCHwvqrOKwQKfxLxkJrWhxd9E+Y30bZlOTRiVQ04yuOr0K/2jwWW8pCi81jp6sZ
         mBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14vBhqFf5cJryvoCa3IsFyVfRVbgmQyJmJY/JUXSOH8=;
        b=LksG2LMMwsKYtkhdKjy21p7BYmLI4qPmfxnT4hUbcKKO1G1zvbsEMq8NQgqNavao9Y
         xHAvFxHzO6rcdoI3iYR1bhS23IPTPG3NaJiwJ1C+ONeFFyarMp4Jsz7zvg6IbcFJp8B/
         MoQiSUAE7MFWTojRQ+F0V6jQLaAIZl1SpptWtTbeEv0EBRTFC5JAgpvOPwBHvSXuqiP1
         r2LzjWaEm43JlEVLe99efZ3PhOujrrFs715CskJi/W5fgttWtw586CXLJyy9FqebN/YJ
         Qevv1AE15Js2dMvr2FH+/QjL2m5xqSc2cjqsCfHv588OKdgBqJWFXSC/iJKC+gQr4GfN
         Nnbw==
X-Gm-Message-State: APjAAAU4/ILZrD1yAz0aUhOrRopjCzzNOsTcWeG5xJf9W3YqEYE9GbFD
        YWkkjO2sXKaJUtYlr5tuOj8=
X-Google-Smtp-Source: APXvYqxvEvw/9gvcKhnyndKu5mOIK4ZeAoGtW9V1jSyslFFz3RZMUyzGoT7UD10MJVH9r1nYfkuahQ==
X-Received: by 2002:a17:902:6907:: with SMTP id j7mr44998446plk.32.1553842184488;
        Thu, 28 Mar 2019 23:49:44 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i5sm1602818pfd.16.2019.03.28.23.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 23:49:43 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/9] ARM: dts: imx53: Specify IMX5_CLK_IPG as "ahb" clock to SDMA
Date:   Thu, 28 Mar 2019 23:49:22 -0700
Message-Id: <20190329064924.8728-7-andrew.smirnov@gmail.com>
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
 arch/arm/boot/dts/imx53.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index b3300300aabe..9b672ed2486d 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -702,7 +702,7 @@
 				reg = <0x63fb0000 0x4000>;
 				interrupts = <6>;
 				clocks = <&clks IMX5_CLK_SDMA_GATE>,
-					 <&clks IMX5_CLK_SDMA_GATE>;
+					 <&clks IMX5_CLK_AHB>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
-- 
2.20.1

