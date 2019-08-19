Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBFAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C1B205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uhcA35N5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfHSNB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:01:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46168 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfHSNB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:01:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so1178364pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 06:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ro8NKFkgruYUmO3tKNMvPEE1StisH9qvZFC7x6V6Dyo=;
        b=uhcA35N59KiYak0FvJjaWA0JqdakHYRgV6udX5bKaVu2FDZ/jyGdZf/xD07iEIzxPr
         Rek11IDX2I/K530tekaf8eUX26/KRrB2BxoSdpym84viDhBcmw5C7LwHhPGOLRLypYhZ
         mHOzkzjnk4RLJh1pJa4wDOaY/8kK6XMfeTzN0ymvzEsIkCj0GqCr+36J6S4izQ/qeB3g
         +H08Pv2/SBzDAJccPaJ7St511RS7JB1ZuPmjhHSy4BQUswfxndPWftka8HBiVjmUwq2k
         yzIL21ejhxM+sU0E6ss7bxhu7BGfcS3U2O6os7QSuIN2nCJsU6FdDWCZgmkkWP/WqSvE
         9tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ro8NKFkgruYUmO3tKNMvPEE1StisH9qvZFC7x6V6Dyo=;
        b=DkqQkOmt2yac9813fidfYmGfNTi+ihkdBjj9pFqHWb07EE4Me295CDrDBKVZh76QZF
         6PiFO2TMm/6exKfRo/meh0hM6yRGp/LywgGl3LOnzoMxm6h5smOF4g00AT9mKNJH8rom
         LjIwrwLw0hvvo8qO4xi8KOT0mes+58AomwELsKfgZ5zLBLAPRQ78PkqINXMLu6S7M6jt
         d0nIkAKMcE3MjIePElNTBpHXC2XbCIl/YLQxNQKtXjSL7OXA8gsyL4ns7wT62LLoKI2i
         OqBy1IIWr77XhY+UnBrNqS5FPyj1HYKEEZrE+ZWBKPFT6tVzHlcuWvQkPRU5DQjbYnmT
         Bhtg==
X-Gm-Message-State: APjAAAVPfmyCoWvHLivSvcxLSV77cDzFIzqdxB0Yj2ruv5zqQj7lePfW
        3pfa6nWUnNIPVTzkXdpZyLPJ
X-Google-Smtp-Source: APXvYqzsUBOFxMEmt52Se2k/zQQ92PZSTwH/Xijj4LZlyCnpj925m8T8I5xgjlepjNv5jH4kugl9Cw==
X-Received: by 2002:a63:5b52:: with SMTP id l18mr19716563pgm.21.1566219718474;
        Mon, 19 Aug 2019 06:01:58 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id l123sm20626464pfl.9.2019.08.19.06.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 06:01:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/8] Add Bitmain BM1880 clock driver
Date:   Mon, 19 Aug 2019 18:31:35 +0530
Message-Id: <20190819130143.18778-1-manivannan.sadhasivam@linaro.org>
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

Changes in v3:

* Switched to clk_hw_{register/unregister} APIs
* Returned clk_hw from the in-driver registration helpers

Changes in v2:

* Converted the dt binding to YAML
* Incorporated review comments from Stephen (majority of change is switching
  to new way of specifying clk parents)

Manivannan Sadhasivam (8):
  clk: Zero init clk_init_data in helpers
  clk: Warn if clk_init_data is not zero initialized
  clk: Add clk_hw_unregister_composite helper function definition
  dt-bindings: clock: Add devicetree binding for BM1880 SoC
  arm64: dts: bitmain: Add clock controller support for BM1880 SoC
  arm64: dts: bitmain: Source common clock for UART controllers
  clk: Add common clock driver for BM1880 SoC
  MAINTAINERS: Add entry for BM1880 SoC clock driver

 .../bindings/clock/bitmain,bm1880-clk.yaml    |  83 ++
 MAINTAINERS                                   |   2 +
 .../boot/dts/bitmain/bm1880-sophon-edge.dts   |   9 -
 arch/arm64/boot/dts/bitmain/bm1880.dtsi       |  28 +
 drivers/clk/Kconfig                           |   6 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-bm1880.c                      | 966 ++++++++++++++++++
 drivers/clk/clk-composite.c                   |  13 +-
 drivers/clk/clk-divider.c                     |   2 +-
 drivers/clk/clk-fixed-rate.c                  |   2 +-
 drivers/clk/clk-gate.c                        |   2 +-
 drivers/clk/clk-mux.c                         |   2 +-
 drivers/clk/clk.c                             |   8 +
 include/dt-bindings/clock/bm1880-clock.h      |  82 ++
 14 files changed, 1192 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
 create mode 100644 drivers/clk/clk-bm1880.c
 create mode 100644 include/dt-bindings/clock/bm1880-clock.h

-- 
2.17.1

