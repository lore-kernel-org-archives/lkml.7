Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D96C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9051920861
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlwvpwq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfFPXgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:36:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40526 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfFPXgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:36:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id a21so7494255ljh.7;
        Sun, 16 Jun 2019 16:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+LU7+GDzyc9Nezc+LMmj0Gd4S4WEMfsuAb4Lyp6cQA=;
        b=mlwvpwq8BYWuen554yfnPbl0SQlVE/+XpwxFTQ2pMNUOtCLzgPsUsRBVAbYQ+Zx5Vh
         cxMaJA8DaR+sAk1NI8/B6tH8egUZizK9iIlbHpSJcEzU3iNC9ofxm4spRjiixGNopPce
         8Ga0tRXayoEE4dU4AmPb6aWwJgruB2DQP2ClVTn82jyI5ZtoFeMpDJZAL6OE9S+00YHT
         25g4JiyLwyzKCdMti9mfxzU8Kl1BUAT5P4lolJfZT6MPjhOhtAcvkAXD5MZlorIthfW+
         lD8farvJ6fbxK6nxnOOajxrFDfeyaV4KktMCpfcKGI46kAdZSw66WCN1uqOb61Z0YdZS
         XxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+LU7+GDzyc9Nezc+LMmj0Gd4S4WEMfsuAb4Lyp6cQA=;
        b=pIyciNegFiHr+sLg+xNawtn9rk/T0r83I2eaDw2+IOYD77THPqRVhHTvbUOQ0CR1Aj
         VF7lYdmPoz7v442x5NDXtP1qnX+Gjs66YN8lqEGH9XYw2jF8161+i9MtsuH9VPtxDTRd
         2IcO6ka/jGiKFp0nH5KrNltN+LsekSoyYwSKxEbNW8SxsfwrXZunBtZyPq45kg4bTvPP
         r7NePlOiAwHR4iGb+ptHD/i0kfJmsf8T9lAupgsPoxW0kuiLML7RYR+N/SxYpAYHvfm4
         Du3E1dtuhiX9K04p++MrJtzPouNtt7UGznGnKzLh0kEC1Enhj2NV3x0CW0Iaazw0bPYy
         eCyQ==
X-Gm-Message-State: APjAAAV9N+pFVbwr/9ReEfxtlV/ImAtgfUOMhuedl1sFcpkl2CManfnY
        dnDyYfGGammDEvBW3X9BccI=
X-Google-Smtp-Source: APXvYqzfF1XY4C9BCOmR4qJUkLfJ0SYMovCjrMqGNLFtbazopEydcGQi6N2rFSrgtNIRIDFtePQGlQ==
X-Received: by 2002:a2e:3013:: with SMTP id w19mr45588286ljw.73.1560728164706;
        Sun, 16 Jun 2019 16:36:04 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q4sm2008377lje.99.2019.06.16.16.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 16:36:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/10] memory: tegra: Introduce Tegra30 EMC driver
Date:   Mon, 17 Jun 2019 02:35:41 +0300
Message-Id: <20190616233551.6838-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series introduces driver for the External Memory Controller (EMC)
found on Tegra30 chips, it controls the external DRAM on the board. The
purpose of this driver is to program memory timing for external memory on
the EMC clock rate change. The driver was tested using the ACTMON devfreq
driver that performs memory frequency scaling based on memory-usage load.

Changelog:

v4: - Addressed review comments that were made by Peter De Schrijver to v3
      by adding fence_udelay() after writes in the "Add custom EMC clock
      implementation" patch.

    - Added two new minor patches:

        memory: tegra: Ensure timing control debug features are disabled
        memory: tegra: Consolidate registers definition into one place

      The first one is needed to ensure that EMC driver will work
      properly regardless of hardware configuration left after boot.
      The second patch is just a minor code cleanup.

    - The "Introduce Tegra30 EMC driver" got also few very minor changes.
      Now every possible error case is handled, nothing is ignored.
      The EMC_DBG register is explicitly initialized during probe to be
      on the safe side.

v3: - Addressed review comments that were made by Stephen Boyd to v2 by
      adding explicit typing for the callback variable, by including
      "clk-provider.h" directly in the code and by dropping __clk_lookup
      usage where possible.

    - Added more patches into this series:

        memory: tegra20-emc: Drop setting EMC rate to max on probe
        memory: tegra20-emc: Adapt for clock driver changes
        memory: tegra20-emc: Include io.h instead of iopoll.h
        memory: tegra20-emc: Replace clk_get_sys with devm_clk_get

      Initially I was going to include these patches into other patchset,
      but changed my mind after rearranging things a tad. The "Adapt for
      clock driver changes" patch is directly related to the clock changes
      done in the first patch of this series, the rest are minor cleanups
      that are fine to include here as well.

    - Added some more words to the commit message of "Add binding for NVIDIA
      Tegra30 External Memory Controller" patch, clarifying why common DDR
      timing device-tree form isn't suitable for Tegra30.

    - The Tegra30 EMC driver now explicitly selects the registers access
      mode (EMC_DBG mux), not relying on the setting left from bootloader.

v2: - Added support for changing MC clock diver configuration based on
      Memory Controller (MC) configuration which is part of the memory
      timing.

    - Merged the "Add custom EMC clock implementation" patch into this
      series because the "Introduce Tegra30 EMC driver" patch directly
      depends on it. Please note that Tegra20 EMC driver will need to be
      adapted for the clock changes as well, I'll send out the Tegra20
      patches after this series will be applied because of some other
      dependencies (devfreq) and because the temporary breakage won't
      be critical (driver will just error out on probe).

    - EMC driver now performs MC configuration validation by checking
      that the number of MC / EMC timings matches and that the timings
      rate is the same.

    - EMC driver now supports timings that want to change the MC clock
      configuration.

    - Other minor prettifying changes of the code.

Dmitry Osipenko (10):
  clk: tegra20/30: Add custom EMC clock implementation
  memory: tegra20-emc: Drop setting EMC rate to max on probe
  memory: tegra20-emc: Adapt for clock driver changes
  memory: tegra20-emc: Include io.h instead of iopoll.h
  memory: tegra20-emc: Replace clk_get_sys with devm_clk_get
  dt-bindings: memory: Add binding for NVIDIA Tegra30 External Memory
    Controller
  memory: tegra: Introduce Tegra30 EMC driver
  memory: tegra: Ensure timing control debug features are disabled
  memory: tegra: Consolidate registers definition into one place
  ARM: dts: tegra30: Add External Memory Controller node

 .../memory-controllers/nvidia,tegra30-emc.txt |  249 ++++
 arch/arm/boot/dts/tegra30.dtsi                |   11 +
 drivers/clk/tegra/Makefile                    |    2 +
 drivers/clk/tegra/clk-tegra20-emc.c           |  305 +++++
 drivers/clk/tegra/clk-tegra20.c               |   55 +-
 drivers/clk/tegra/clk-tegra30.c               |   38 +-
 drivers/clk/tegra/clk.h                       |    6 +
 drivers/memory/tegra/Kconfig                  |   10 +
 drivers/memory/tegra/Makefile                 |    1 +
 drivers/memory/tegra/mc.c                     |   42 +-
 drivers/memory/tegra/mc.h                     |   74 +-
 drivers/memory/tegra/tegra124.c               |   20 -
 drivers/memory/tegra/tegra20-emc.c            |   94 +-
 drivers/memory/tegra/tegra30-emc.c            | 1197 +++++++++++++++++
 drivers/memory/tegra/tegra30.c                |   24 +
 include/linux/clk/tegra.h                     |   14 +
 include/soc/tegra/mc.h                        |    2 +-
 17 files changed, 1973 insertions(+), 171 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt
 create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
 create mode 100644 drivers/memory/tegra/tegra30-emc.c

-- 
2.22.0

