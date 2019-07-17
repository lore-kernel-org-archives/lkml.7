Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00172C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA07020818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrJDYCZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfGQGK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:10:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47068 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfGQGK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:10:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id c73so10278329pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 23:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tcOipK/CbddDVGFHFiGY3BJRXPaA4gC2lnfl7Hga/DI=;
        b=BrJDYCZJB9PG2HE+zn1d3uzhxRGw8nkXBBsMHHsFrRnoKeB07FH6aBz2TGAHjuOp0u
         bMwUGjgVUahRq2G8WwuPSF/hj3iKHxf4F5ptDWZZfaBUevxVf/iSdoi6hZKhe/e70Bco
         /E3DzKUFLNdGkZYFhmukS2xeKpUl7SzGaXjZDi1GhwHDoJqkcrAneHe4+7mq2beYs0q9
         vQTiBYCUMuuRsxteC/AaQaqJ5pq7gq8drIUbOqlQ3FgJXQ8rbis09pge2Ixb/fASqSOG
         Yv6wFtchoJpRuhsS7sa8ITOyR0whajNhJASDzc58bridZxkGG4iSxY/IdDdloKvjMLe/
         l6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tcOipK/CbddDVGFHFiGY3BJRXPaA4gC2lnfl7Hga/DI=;
        b=KtIXD+oS4ARIm7ywFgva4veiqDBqlIuiv05ygVdgM92j4qKw4RGHT6fEtp2MNHduBL
         9Yn3ZkCOoKxx7g4rCaSarlu1A7Q8t+dHA/0mxnqXKpacZqSQsIf69g0QVpF8BBsWUf6S
         64c26/wNdrUMh1hJjcb5erMF3dm8nRSBEDAIUv9UWgZ6a/251FMO3MDuRij0wCdnUU1R
         TuUdXH79ydSCDUq7RvgdJkPXD/YyQkqrbk/nkxWxjSatUBuDTU3QPCR/po9K9QTCg6MZ
         ULEel33qlq0Gf+6xIx/nh2ADVcSocO1zXw6kbgVI54ZLPWguZzgY/hIKBlOg1sMfeh8c
         1dEg==
X-Gm-Message-State: APjAAAXAqgBupMIs5HTcfCq915/dqqhkIejlIRzCw5+6y7F9mMdkrD/R
        gXYf6K9UI+3FVOx3YSnJNNMV
X-Google-Smtp-Source: APXvYqy4gNVYEdgjbXvPK6KcNs5PTafuSPkKcmK8Hq2gFAval1OLYy1Y5GCOnKFcSedCx4Kq8YXApg==
X-Received: by 2002:a17:90a:dac3:: with SMTP id g3mr41743202pjx.45.1563343855049;
        Tue, 16 Jul 2019 23:10:55 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7301:59e6:f493:40df:9c8a:5041])
        by smtp.gmail.com with ESMTPSA id r27sm25993313pgn.25.2019.07.16.23.10.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 23:10:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Darshak.Patel@einfochips.com,
        kinjan.patel@einfochips.com, prajose.john@einfochips.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Add support for i.MXQXP AI_ML board
Date:   Wed, 17 Jul 2019 11:40:36 +0530
Message-Id: <20190717061039.9271-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds support for i.MXQXP AI_ML board from Einfochips.
This board is one of the Consumer Edition boards of the 96Boards family
based on i.MX8QXP SoC from NXP/Freescale.

The initial support includes following peripherals which are tested and
known to be working:

1. Debug serial via UART2
2. uSD
3. WiFi
4. Ethernet

More information about this board can be found in Arrow website:
https://www.arrow.com/en/products/imx8-ai-ml/arrow-development-tools

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: Add Vendor prefix for Einfochips
  dt-bindings: arm: Document i.MX8QXP AI_ML board binding
  arm64: dts: freescale: Add support for i.MX8QXP AI_ML board

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8qxp-ai_ml.dts      | 249 ++++++++++++++++++
 4 files changed, 253 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts

-- 
2.17.1

