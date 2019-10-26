Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB33CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A702070B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPDj2tUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfJZLDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 07:03:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41036 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfJZLDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:03:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id l3so3335650pgr.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 04:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Te4hyUs2iDsjEynBEc6A/BW85RL88H97jpqUudpii6I=;
        b=iPDj2tUUcSqxzeAd1AA4UPcWCZpHzzSTmcnD9iA05zOFGSiCosWfBLv1fmxWovoSMw
         Nooo/XuJbVLk8w6WwvZ+jWeTiIOg05F6cKI/E9CnrNgLLz9uwIxUqCntUImQc4FM8PoW
         VtML6ovmFJaV+l9XTRE+kZzmDBPce+peIbQ6b8wp86y1wSm7Bx7gT3aBHDwcrVLoqq7t
         KnpOINJC14zjypzmA+g+6ApnJLpLnpd7JY6+/46p6YoE89XWvkON5Ne5u6fsEUohM12r
         JcJ6P1AQnez0NSaWXAxNTzSvwyaX/eMzNWcHqN+n4k/tbuQDfqXkyE+Ll92JNUjWuy/Y
         qq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Te4hyUs2iDsjEynBEc6A/BW85RL88H97jpqUudpii6I=;
        b=kE1fcce3X3LCf+J69YzIrDgY4XieZLqeME3khaqbhPMK2toB0Ia1ss2fQoa8NJJzSg
         horiO+zvnh9joNGbaFFKHP11hjuMd9LtMZM7VToUNwZSkUkCPmq6T32h6A3YCO0MFzub
         wbdUQwdkkuyDrHQSn+Idcs644HA0cT9rIVBZKw1plTMsNLeQLCDwSxzVUV6jiLsIp3t4
         XCRzuzkSPZhFfS35z/HNJ70s3pPie4c9tqy2YM5gh4Ts6deKIe2aYiJ8LrqwQ+p1zl3D
         TxGA+0WkZJrSjtPzvmOMWKzyrkUOsU9pt0HfFL3xOPPmWzuDJw/FKbWWxqMTK33R5NwV
         YriQ==
X-Gm-Message-State: APjAAAU8d7/K3PJliFPuUpnzCUdkYdW7MhRxN98C0+gVlrD/8idLEVDo
        GUzGJW5eUKN7GrqzBu6Lw8RD
X-Google-Smtp-Source: APXvYqwi9UuyH6qOR0ST53cx0b0o8jH7bWLugr7dpfuSwN3/kjsaS2qDW6cv9pykg240BdvrugOaAA==
X-Received: by 2002:a17:90a:9b85:: with SMTP id g5mr10179772pjp.95.1572087785228;
        Sat, 26 Oct 2019 04:03:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6214:69c4:49ad:ba3c:6f9:2d8a])
        by smtp.gmail.com with ESMTPSA id x129sm5543379pfx.14.2019.10.26.04.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 04:03:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 0/7] Add Bitmain BM1880 clock driver
Date:   Sat, 26 Oct 2019 16:32:46 +0530
Message-Id: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org>
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
 drivers/clk/clk-bm1880.c                      | 970 ++++++++++++++++++
 drivers/clk/clk-composite.c                   |  13 +-
 drivers/clk/clk-divider.c                     |   2 +-
 drivers/clk/clk-fixed-rate.c                  |   2 +-
 drivers/clk/clk-gate.c                        |   2 +-
 drivers/clk/clk-mux.c                         |   2 +-
 include/dt-bindings/clock/bm1880-clock.h      |  82 ++
 13 files changed, 1182 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
 create mode 100644 drivers/clk/clk-bm1880.c
 create mode 100644 include/dt-bindings/clock/bm1880-clock.h

-- 
2.17.1

