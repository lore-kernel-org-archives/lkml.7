Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F94FC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DF021851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a86lshRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfGSHJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:09:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40000 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfGSHJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:09:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so14046881pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 00:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0LeeAyTVsmLsUpPz7KDXnnPyr4L05PS3OGLUvnsErUM=;
        b=a86lshRVZo1JvdbvlNOzh2S2zd3nIg//DqFgL+WW7L8MWBICb0TJIBvAUGRdjviCYd
         P3Ah6m1xBLXnE/VLnZg3N0YXLE+kbAjqtj5lrnkpMfi+V1ZCO95IWOmVw0uXR8R0yg80
         Z/+Mf/94dAjeVtVmNJuhK1wRAOfJGdnjkDbQlgOO0bNu4kvIJ4ggnINhXHFSV9h3TP/r
         oqA2EIOv5PyMwZHbc2hxBvkCzB4k/3BC6lr9SgVTixxwUD+H6o+819s+e0Jlk/bL/wxw
         15YyeJwQAtV79qAHZ4k5Ntr/LumYeiJfUVxZ22pv5e9BV/lrkZkO0cESNWAJMBj4Ez7s
         2d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0LeeAyTVsmLsUpPz7KDXnnPyr4L05PS3OGLUvnsErUM=;
        b=SvjwDnp7Dd3kMkVyLFZeitAm/x5qGUJGw9E4V+z0g5Uo+yuYB3iVRBDnrp6xZdCmwJ
         p90A9W2RuM1yUh8JcV+5aljh3nDWFXhMcKtZnyh5MsemhAcYIfPPfkauy5DIfa2SPAcz
         1cPggvOfS2WYn5NK3gw/gielOYyhpqSN52AtWGy64y2z0QTjBmnFTb7GfkvTQ/6SmUt4
         3Ho9DTVMOEeRydY+iN83sqrv/Bd0qWjeUOvWck3/5i3JqR+ETlavnGCMwu2cp8TBOaKk
         2Ko4EzuKZjz1m6mZD+/Cwhx3B76xURk0ZPGIdr5pdZUv19WRTruH3UEbcTlenXy3pQKh
         NbMw==
X-Gm-Message-State: APjAAAVeuZsz9UTmnqb5+0HCvKYfVFDVxODr4DqDd6ZZx3kstVKm+Q91
        vhxAiHCUSPS2qKvYRH3DCA/J
X-Google-Smtp-Source: APXvYqzrr0Go2Vx0z9CClLEHsJMpXca4xfICOrN1UqAeij1rNOA6ZEyLzOT3xu7pceNkPRgvRU9bEA==
X-Received: by 2002:a17:90a:360c:: with SMTP id s12mr56809775pjb.30.1563520185267;
        Fri, 19 Jul 2019 00:09:45 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:730b:4a40:d09e:c7ec:fbb:1676])
        by smtp.gmail.com with ESMTPSA id r6sm56259346pjb.22.2019.07.19.00.09.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 00:09:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Darshak.Patel@einfochips.com,
        kinjan.patel@einfochips.com, prajose.john@einfochips.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Add support for i.MXQXP AI_ML board
Date:   Fri, 19 Jul 2019 12:39:23 +0530
Message-Id: <20190719070926.29114-1-manivannan.sadhasivam@linaro.org>
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

Changes in v2:

* Incorporated review comments from Dong (small cleanups)

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

