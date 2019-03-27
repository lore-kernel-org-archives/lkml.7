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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3B92075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwmXc8RF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfC0GfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:35:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36611 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfC0GfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:35:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id r124so9470462pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 23:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isVyGu4L9+2S0FNKN5ZEi8kzQawHlgpIIQ13w9ZrByI=;
        b=OwmXc8RFOwbR84z8LBgKF6An2yApZn709Q/xuBqmcNZ7255Qpe/8TfCPhSgrJriFTc
         tG7GLoIlhKqqnUbArDhIQ62O79gk3mJ8Oo8dPnsR39VCg6oEeBgp8S1ZKU8z3bsw+hYe
         DJOlBFU7MVlFrLfzcaQz0xaFxf6dRRH1TgTBAJ5CNmwMIxM3N1lA15mSfNmPRcTIBde+
         YqXgDSIxe+lwIfNc86Yp1xNwBIGbnDMywc2QbRwcRYohZutf/Cr3FT8sk7niduppUeB6
         OU33gHtykQ1aI6KE3YJrtCns4hCrsOnWoTYKFVek3PLJ0qKlzja6gxM2SSGO4nM16aUi
         RROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isVyGu4L9+2S0FNKN5ZEi8kzQawHlgpIIQ13w9ZrByI=;
        b=ni0gnv8omXkhAC9fU8c80bwpn4JM8CIFZQgx/pECuBC807t9B98AZHdUQr9c+4qzHX
         i/t+aOnEbHW+15D2mklvD6oa391bSw3PRrYBthjKnvLP/MPbKVRXKhzgdH2cwf/sY/J+
         51794ONoYlNIsmx1LGqE1juc69tb34l4UjeZJXNWptMLhRSwdLOfg2huX3MZ9Su7QFKO
         KOe6AAsXuVBQW/IC+83jzwzUShQGibujdEcQPuHaV5Fdw7n97IBd42qEGgOpPzyki+LW
         NENjAAHY7nP3nsAxA369hxR6tlueiUYSLY3ppzwzHPJpyICy/5a/RotLR6h/md/Y5Iu1
         s8cQ==
X-Gm-Message-State: APjAAAW4pqiwGr5kgXinG1K2q/Pzlon9sulVb5FNcxjZuRF9gNV/2BQH
        YhnuZaf6RpzDlYUrAM7eXGpMRXbG
X-Google-Smtp-Source: APXvYqzfvcGTW5dPqnlN/meZmb4Nyb1yCdbzoFpAnIh6kvUqFcFU9vRop5tEc3fXpb1ZOO07QLHQ1A==
X-Received: by 2002:a63:cd47:: with SMTP id a7mr2969266pgj.434.1553668503628;
        Tue, 26 Mar 2019 23:35:03 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k1sm19950258pfo.121.2019.03.26.23.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 23:35:02 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as "ipg" clock to SDMA
Date:   Tue, 26 Mar 2019 23:34:49 -0700
Message-Id: <20190327063451.25629-1-andrew.smirnov@gmail.com>
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
clocks as IMX6QDL_CLK_SDMA result in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA functionality(this at least
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

