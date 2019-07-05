Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B8AC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3E9216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fc5wkPe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfGEPO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:14:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45702 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfGEPOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:14:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so38040plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LG/wQK5eDhZO2JkmChNMhmQOYOK1XGmyw1rFFuxqroU=;
        b=fc5wkPe+dcpEqURdBxoMZHkCu7ruRwywX8u94KSlg4PtNUUKv1XNQ2h+hPrPex7hXK
         VD2FrV3QrNPFHljlLp9iA3TAwyCJpbQfIZMu6IeYhFFbqVNCG+4dRcpTTex9MIDA8isg
         MFmW4PlzYaU+rHd8q7Ml+nbonIDBGxC7smUnWlWgqx65ULvaH0VoOPEpDYz/AlfiLjSP
         cas8EcLbYQ59WCanZWRNFY1apouJ4wbEn9R7Px2mQNL9hTgQbIqhPKx99nOoihYL2EXK
         o64Bn2pewcsOvDIoscJDs8Pw2X+wWGYA4h5uX7U+sSA6S495hfr2tgBdrTazwNhv1WYd
         NN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LG/wQK5eDhZO2JkmChNMhmQOYOK1XGmyw1rFFuxqroU=;
        b=i3bi8AnAPR/KwcwzzCQZHZOZS6S+PMu5KbymAi9eZTc0TpSk386W1rwoDVQJn3f7H9
         i+YeqWw8JvVXZo5DHe0Vcy76wd1olhYeDWTFkQAxYIPWI7eDL7KfFQ4omBqNroOY0hC/
         /EmYPmmPMp7WyiEij8ZS3Z/8NbgXzthO7tlM01UDX38i1ZfxMXmdTMWO/2pem1X/8DG5
         BGYThiywUAmgndvVBuyUENvKZ1GXVMeL3/KtT2E+02s+PYOhb4/9XwXa3cgQWKzawhQF
         ETTj2FicPup1X4vOMpQ0BttzvFzI57LIp9njWXsM5st/a0cubfTECAmfH0pEXz/ff9W8
         B5oA==
X-Gm-Message-State: APjAAAUBlww9bPvW+eOVXVCkBpVNms+nXcfSFVxvdYi7HxfI0vZfFLjE
        inQZ4WzTnaGMImFnO26x0KJj
X-Google-Smtp-Source: APXvYqyuyWM051xgjkop2EkbkL9HbE7ns7a3MbZMkVaSgI+NVgtU3F46u+LXPNsBGqLnjeIMdq97bg==
X-Received: by 2002:a17:902:16f:: with SMTP id 102mr6040122plb.94.1562339693237;
        Fri, 05 Jul 2019 08:14:53 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:916:7317:a59d:72b6:ef7f:a938])
        by smtp.gmail.com with ESMTPSA id w3sm8248778pgl.31.2019.07.05.08.14.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 08:14:52 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] Add Bitmain BM1880 clock driver
Date:   Fri,  5 Jul 2019 20:44:35 +0530
Message-Id: <20190705151440.20844-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds common clock driver for Bitmain BM1880 SoC clock
controller. The clock controller consists of gate, divider, mux
and pll clocks with different compositions. Hence, the driver uses
composite clock structure in place where multiple clocking units are
combined together.

This patchset also removes UART fixed clock and sources clocks from clock
controller for Sophon Edge board where the driver has been validated.

Thanks,
Mani

Manivannan Sadhasivam (5):
  dt-bindings: clock: Add Bitmain BM1880 SoC clock controller binding
  arm64: dts: bitmain: Add clock controller support for BM1880 SoC
  arm64: dts: bitmain: Source common clock for UART controllers
  clk: Add driver for Bitmain BM1880 SoC clock controller
  MAINTAINERS: Add entry for Bitmain BM1880 SoC clock driver

 .../bindings/clock/bitmain,bm1880-clk.txt     |  47 +
 MAINTAINERS                                   |   2 +
 .../boot/dts/bitmain/bm1880-sophon-edge.dts   |   9 -
 arch/arm64/boot/dts/bitmain/bm1880.dtsi       |  27 +
 drivers/clk/Kconfig                           |   6 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-bm1880.c                      | 947 ++++++++++++++++++
 include/dt-bindings/clock/bm1880-clock.h      |  82 ++
 8 files changed, 1112 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.txt
 create mode 100644 drivers/clk/clk-bm1880.c
 create mode 100644 include/dt-bindings/clock/bm1880-clock.h

-- 
2.17.1

