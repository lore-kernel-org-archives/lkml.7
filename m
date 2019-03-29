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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2FEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBD02082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgvAku8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfC2Gth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:49:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35702 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbfC2Gth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:49:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id p19so570865plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 23:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JyhG4KiqlmUctaeL7IFcdOPmGqfvH8RvX9zGV1WlMVQ=;
        b=SgvAku8jw3wNvgs0TT7my7hxPqoXsHzhUdta34s0A60ci2PMJ4TJtUWb107YbCrxdq
         PwlX3Fu4CBQkx1gTDxhE/Q7H1N0dOREQ6PRtdz83ZijOt56JRd6shbHixMxi2MqsLDNY
         yUHPVP1oQ6zGAsc6iz6jReJkzlbipuLDhs8IUvFdMoyQFBXenyWo5zm+nNNrmCuyZKgP
         As0CoJOfRlDBp4lLxbv6c6PO7235x8S6qJesaHcggxO4c3nGocRoggnreF5TkVGr0U42
         3QSW/amV9/PSJArijESjrm9Zzgqn/Xs7OuTM8YwHEPxQQKpHJpaR0YqwqHSrM/xZUaeV
         glRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JyhG4KiqlmUctaeL7IFcdOPmGqfvH8RvX9zGV1WlMVQ=;
        b=C+C8n9U1LKR9x2oyhrERpr3ksVFCc5/jNFXSbhSN78Fn/eruJggZMTt0uQSzx3Ubxf
         aOtK0LblvHjCcK/wH+bBvJy/PLgm6MW7GG0CzgAE71nqMz0vw9fsM5kexLZD+A6+JEXy
         UsekkG6ealg0QxiuxMSSt/9Z6CbH/bk3TMx7aFiun23AHlJrdOR7DvTYVHh6ZADR1uVd
         DkLPpkWsZJESPV+qEZtLzK1FYUXyqB0R+9+KHzvy2DuEE4hazG15y0/9PwyokDEtb2Wm
         4zBDIfXjnMfHB9+MkyIeAUUkKxpUFicyYvMWwsN2jWcdXfhdTr/whqb8J1JZ6DsdtCBk
         iBAg==
X-Gm-Message-State: APjAAAV5Dj+b/DzZA0j+VGy0SyUfDy+BE0QVIjlgRmMzw2An25SCQrLN
        cdFpjWUR1eYR7OjT9UOwhzg=
X-Google-Smtp-Source: APXvYqxJsoIPHTMM893IvjPDXA3c35Q3WVKowu3BuI5NY3nm2bAneFzlEj+i5R9Xufith4BF5tlTJg==
X-Received: by 2002:a17:902:12f:: with SMTP id 44mr47511002plb.208.1553842176395;
        Thu, 28 Mar 2019 23:49:36 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i5sm1602818pfd.16.2019.03.28.23.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 23:49:35 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as "ipg" clock to SDMA
Date:   Thu, 28 Mar 2019 23:49:16 -0700
Message-Id: <20190329064924.8728-1-andrew.smirnov@gmail.com>
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
ratio is 1:1 which results in broken SDMA funtionality(this at least
breaks RAVE SP serdev driver on RDU2). Fix the code to specify
IMX6QDL_CLK_IPG as "ipg" clock for SDMA, to avoid detecting incorrect
clock ratio.

Fixes: 25aaa75df1e6 ("dmaengine: imx-sdma: add clock ratio 1:1 check")
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
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

