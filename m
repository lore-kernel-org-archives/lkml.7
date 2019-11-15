Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4DDC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B232072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tj5frAAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfKOQ3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:29:14 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37068 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfKOQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:29:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id bb5so5000028plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3XT/nLG3xpNr361wlgEfm3508OHRkJv7ggspM9qj6fM=;
        b=tj5frAAfuA+MTShJ5+0l80OMXjtbw082FDfq/rA8bY1A3dWturu5e1zJmLDWbnvrXJ
         iGSNJqubAcqELVVZo2SfEw2GnW4MVCEZP5t8bjMdRr3tEgEfyyybafB+MSiK+aRVINq7
         cgR60rt2GtCGEt/ffaVAEExBI5o0ce/+pVQ0q2dd6q6G/gWkBt9cfQHLlsHMC6Oqkq1F
         i5r7gP0+yfqLVsI4ssLVVB/9JN4HQ/Kn93r2pNfCeftl4gWIOIxkyo6y/YU04dpu6j7l
         hICTbb4ORXJF2tZs879Y5IjGD62IZkpDfYhHyTJ1822+CR4O+6xpPmRMpisnAEuK/Mmw
         GXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3XT/nLG3xpNr361wlgEfm3508OHRkJv7ggspM9qj6fM=;
        b=L6JTYcwY2O0OEsHFlS2VPjEve8C57r+pa/rnfr91fNtMtMXogQ3WL987RMLeOyx5Ug
         kQvKiH+7JKf8JZjPq8Iyb+RNvkUJIb56rG33AlWPSV508tqbZrE1BRs3iWTt+Kw8rJhP
         ILWFtLt9PevE6fkdP1kbhkb0I+keb4lT5c05/4GZjoXN+BzdHsKt0oKY0JXaau+4bGEn
         /2IVJ47II5ddOcMWhhXJuNaQhnAXOA6DhLJdMPoIpMviMeKwH1BDMxuFFw3vxCNut3rP
         3mSiOVlmCsLMqHJJ4qdvGCrUm8A7s1MKLHBg/PYhEqDemLog9xIThDfrXpywFHWHMOfY
         XHFQ==
X-Gm-Message-State: APjAAAUcwAUfPWifMJvWJLsNS3RqWin/fUzuqumYFVQvg2mwn/XqWEmC
        d4DeFijh8Ul42Xollz0MTr3w
X-Google-Smtp-Source: APXvYqwimP7JI1pnz9yCWsM+bKNEZAPTI0UZ1+a3yXspAKR7FXS9hRU58T4IQjJ/o7Dc92EJdHGhbA==
X-Received: by 2002:a17:902:744b:: with SMTP id e11mr15625825plt.208.1573835351821;
        Fri, 15 Nov 2019 08:29:11 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6183:6d55:8418:2bbc:e6d8:2b4])
        by smtp.gmail.com with ESMTPSA id y24sm12295288pfr.116.2019.11.15.08.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 08:29:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 0/7] Add Bitmain BM1880 clock driver
Date:   Fri, 15 Nov 2019 21:58:54 +0530
Message-Id: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org>
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

Changes in v7:

* Fixed the do_div() issue detected by kbuild test bot

Changes in v6:

* Dropped 'clk: Warn if clk_init_data is not zero initialized' patch
* Added fixes tag to the patch adding 'clk_hw_unregister_composite'
  definition
* Reworked the use of CLK_IS_CTITICAL flag from clk driver
* Removed the use of CLK_DIVIDER_HIWORD_MASK flag from driver
* Some misc cleanups to the driver
* Added Rob's reviewed tag for the binding

Changes in v5:

* Incorporated review comments from Rob on dt binding

Changes in v4:

* Fixed devicetree binding issue
* Added ARCH_BITMAIN as the default for the clk driver

Changes in v3:

* Switched to clk_hw_{register/unregister} APIs
* Returned clk_hw from the in-driver registration helpers

Changes in v2:

* Converted the dt binding to YAML
* Incorporated review comments from Stephen (majority of change is switching
  to new way of specifying clk parents)

Manivannan Sadhasivam (7):
  clk: Zero init clk_init_data in helpers
  clk: Add clk_hw_unregister_composite helper function definition
  dt-bindings: clock: Add devicetree binding for BM1880 SoC
  arm64: dts: bitmain: Add clock controller support for BM1880 SoC
  arm64: dts: bitmain: Source common clock for UART controllers
  clk: Add common clock driver for BM1880 SoC
  MAINTAINERS: Add entry for BM1880 SoC clock driver

 .../bindings/clock/bitmain,bm1880-clk.yaml    |  76 ++
 MAINTAINERS                                   |   2 +
 .../boot/dts/bitmain/bm1880-sophon-edge.dts   |   9 -
 arch/arm64/boot/dts/bitmain/bm1880.dtsi       |  28 +
 drivers/clk/Kconfig                           |   7 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-bm1880.c                      | 969 ++++++++++++++++++
 drivers/clk/clk-composite.c                   |  13 +-
 drivers/clk/clk-divider.c                     |   2 +-
 drivers/clk/clk-fixed-rate.c                  |   2 +-
 drivers/clk/clk-gate.c                        |   2 +-
 drivers/clk/clk-mux.c                         |   2 +-
 include/dt-bindings/clock/bm1880-clock.h      |  82 ++
 13 files changed, 1181 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
 create mode 100644 drivers/clk/clk-bm1880.c
 create mode 100644 include/dt-bindings/clock/bm1880-clock.h

-- 
2.17.1

