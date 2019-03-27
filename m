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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4FBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2681120811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8SHaAQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbfC0Gis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:38:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44730 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfC0Gis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:38:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id g12so2850413pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 23:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w1sZMmfF4xAIW6tEXT/kd8lzvn8l0pe5UHrZYgSM9mg=;
        b=c8SHaAQA6Lq5RQT3g2JaoY+oW94pHeG4269vqjGR9nGY8S7DnA47z+nXDa+RCuG374
         K9F3d95w4B43ulbOsQIFI5XYiAouCmwzTf9vbCo+cLLLddCvCBf225WXjdS1qn9jBucp
         bcKIHcRlKRTp4nyYjbK1Ip7/qPCOUKi+nw4a2Ae15goDE2iJNxs/gUeAl8iCUkVFBBHP
         JJw2qvqTg8QKbhYwLGYYMjuFz7Si6uMonem4tK6+J/6PmOyGanunw3f7TF6jcznLZ3YM
         qY4fcxDN0ltXQHXi95wC82AIWlLNFTx/znUUPnSiXQxVqXYLRKZpNpaZznUmHmcmKuTl
         OL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w1sZMmfF4xAIW6tEXT/kd8lzvn8l0pe5UHrZYgSM9mg=;
        b=RWhFpzS5PZTp5Tb+z7lNVFYA6gNFrFf5XiconqB5fVl4r56vl8zmlaqTjhDSvuof4G
         /RT0VnHrXaC9KOzdZOVR7uIDJ1hW6tUsJH21+gppEsK9fizFjgkacFmkwd9O8GLWcPMX
         UItvs8dC0LQW4m/Fiyv7097ggAC5hP02+ESXuV4rcTRaSqf/CW0tDkgvKAKAi39deZOF
         6fpYKrIguR+77xp63yYeeUwwl3CvKYyogjdYn7B1rQmDwUASRExj3nf5x3Mt/smcpCz8
         XpeleP0dW39YlheIeuU6KlXgP0qK1jjT1BOrj3YLvBYcBmjdjiaoSJ/cpmnnCdiNZptV
         zg1A==
X-Gm-Message-State: APjAAAV9pLQ1VAoWZh5ybIMttoD50bmkctRV7Uxvwd0rT6iX0sSXNKmh
        vHRC8ExTCUy/jklKFm6q220=
X-Google-Smtp-Source: APXvYqyOfpRmyNY1MzDVXQqtLeKtoaVW1xA9rLOYu4C0zAwF/eR79qwHKnf4wevs8a2aOsNMVk4MBA==
X-Received: by 2002:a17:902:7084:: with SMTP id z4mr34489660plk.305.1553668727605;
        Tue, 26 Mar 2019 23:38:47 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id y37sm36866116pgk.78.2019.03.26.23.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 23:38:46 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: imx7d: Specify viewport count for PCIE block
Date:   Tue, 26 Mar 2019 23:38:40 -0700
Message-Id: <20190327063841.28350-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7D comes with 4 viewports, so configure PCIE node accordingly so
that the driver won't assume we only have 2.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/imx7d.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 6eb98e7c568d..f33b560821b8 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -154,6 +154,7 @@
 		ranges = <0x81000000 0 0          0x4ff80000 0 0x00010000   /* downstream I/O */
 			  0x82000000 0 0x40000000 0x40000000 0 0x0ff00000>; /* non-prefetchable memory */
 		num-lanes = <1>;
+		num-viewport = <4>;
 		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "msi";
 		#interrupt-cells = <1>;
-- 
2.20.1

