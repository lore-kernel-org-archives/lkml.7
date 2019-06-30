Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BACC5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BF52089C
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNYBHukh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfF3VEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 17:04:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44097 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfF3VEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 17:04:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so7309646lfm.11;
        Sun, 30 Jun 2019 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Phxn/tf35o4+tniCQy6FZM67N1Oc4r2SYyjkEAHWaK4=;
        b=bNYBHukhr9kpdnYh9JoEaWzKPEw0H8FWM/BfLt6mgiuiZgV8qeAgGzoW6uwg5ksIK5
         XQRzEzFue4YODU3ypR6ucgB/s/XxkIsUMyrU6iOTB9vfqZRGqkSRzgIPAIgHr3EE8uKP
         FdsxeNrau0Y1Av6UbelwZ3w/ejdjY/7AunDJ8qFvpv9+eWAyFwgZdaW3/ZSCaSgbOs3m
         tVZeYU9fchLHKpo+xIvHX3q+CF6Uz0Yyp3opYwas174RHpHettj/G6y6Em2Q7xNRUqjN
         Vn72zqaYgdWpVMkTW0XF5HUqFrM7hAHtLNtASLkWYOWCnGENJyqAoCMQ8MHFnE89zBcA
         aigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Phxn/tf35o4+tniCQy6FZM67N1Oc4r2SYyjkEAHWaK4=;
        b=PYbk1ekTWqdI4lJ2mF7yNELPpmO/9WYj6TFgeNaMtDqt0k7uLg6AV1mPE43K081GEK
         Yxn1YTbZz9FUAXecUQtlWn8gcLqjKyj0KF/IKKLYbjDMcDT5ZfsG35qsiYQycPLTgflo
         C730pyDfhwqO28Vw1YydZibTkr/8340pZnyxiCfDoLTC2MqVkjONtSrWsl1pDFr2Q+BS
         q2/jlkpsMT5QTCz4HvH+cwkF0loeK9hJ1uk3ZQ1QRvYu9oTJ/zbtyYBQVxhIjo1cu55N
         5umNe9uxV4XB29TaWSvQSxQGQOrCvm4apOV9aShNuZnECOr2FQVGnXJcq5A6/JJRLJkX
         xOGA==
X-Gm-Message-State: APjAAAVaX4OPJZbw2+vdW51fEattQF9PIDXKOH9G0Xz3474+nvH5V4TX
        VTmysrqgldUiQLhx9pWM/TM=
X-Google-Smtp-Source: APXvYqyqgn98TTvbaNDZMaXoixWumiKQSaXpIYs2iOKoWTNsIUuOWuCYFeyDda6HY+vHM6KXKmwKlQ==
X-Received: by 2002:a19:d5:: with SMTP id 204mr10593188lfa.66.1561928676297;
        Sun, 30 Jun 2019 14:04:36 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id u9sm2221408lfb.38.2019.06.30.14.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 14:04:35 -0700 (PDT)
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
Subject: [PATCH v6 00/15] memory: tegra: Introduce Tegra30 EMC driver
Date:   Mon,  1 Jul 2019 00:00:04 +0300
Message-Id: <20190630210019.26914-1-digetx@gmail.com>
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

v6: - Tegra124 Memory Controller binding factored out into standalone
      binding because it requires to specify MC_EMEM_ARB_MISC1 for EMEM
      programming, which is not required for Tegra30. This makes the
      upstream MC registers specification to match downstream exactly,
      easing porting of boards memory timings configuration to upstream.

    - Tegra30/124 Memory Controller binding converted to YAML.

    - Tegra30 External Memory Controller binding now is in YAML format.

    - Added workaround for hanging during LP2 when EMC runs off PLLP on
      Tegra30 in this new patches:

        clk: tegra20: emc: Add tegra20_clk_emc_on_pllp()
        ARM: tegra30: cpuidle: Don't enter LP2 on CPU0 when EMC runs off PLLP

    - Added info message to the Tegra20/30 EMC drivers, telling about
      RAM code and a number of available timings:

        memory: tegra20-emc: Print a brief info message about the timings

v5: - Addressed review comments that were made by Thierry Reding to v4 by
      adding appropriate copyrights to the source code headers and making
      Tegra30 EMC driver to use common Tegra20 CLK API directly instead
      of having a dummy-proxy functions specifically for Tegra30.

    - Addressed review comments that were made by Stephen Boyd to v4 by
      rewording commit message of the "Add custom EMC clock implementation"
      patch and adding clarifying comment (to that patch as well) which
      tells why EMC is a critical clock.

    - Added suspend-resume to Tegra30 EMC driver to error out if EMC driver
      is in a "bad state" as it will likely cause a hang on entering suspend.

    - Dropped patch "tegra20-emc: Replace clk_get_sys with devm_clk_get"
      because the replaced clocks are actually should be removed altogether
      in the "Drop setting EMC rate to max on probe" patch and that was
      missed by an accident.

    - Added "tegra20-emc: Pre-configure debug register" patch which ensures
      that inappropriate HW debug features are disabled at a probe time.
      The same change is also made in the "Introduce Tegra30 EMC driver"
      patch.

    - Added ACKs to the patches from Peter De Schrijver that he gave to v4
      since all of the v5 changes are actually very minor.

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

Dmitry Osipenko (15):
  clk: tegra20/30: Add custom EMC clock implementation
  memory: tegra20-emc: Drop setting EMC rate to max on probe
  memory: tegra20-emc: Adapt for clock driver changes
  memory: tegra20-emc: Include io.h instead of iopoll.h
  memory: tegra20-emc: Pre-configure debug register
  memory: tegra20-emc: Print a brief info message about the timings
  dt-bindings: memory: tegra30: Convert to Tegra124 YAML
  dt-bindings: memory: Add binding for NVIDIA Tegra30 Memory Controller
  dt-bindings: memory: Add binding for NVIDIA Tegra30 External Memory
    Controller
  memory: tegra: Introduce Tegra30 EMC driver
  memory: tegra: Ensure timing control debug features are disabled
  memory: tegra: Consolidate registers definition into common header
  clk: tegra20: emc: Add tegra20_clk_emc_on_pllp()
  ARM: tegra30: cpuidle: Don't enter LP2 on CPU0 when EMC runs off PLLP
  ARM: dts: tegra30: Add External Memory Controller node

 .../nvidia,tegra124-mc.yaml                   |  149 ++
 .../nvidia,tegra30-emc.yaml                   |  332 +++++
 .../memory-controllers/nvidia,tegra30-mc.yaml |  160 +++
 arch/arm/boot/dts/tegra30.dtsi                |    9 +
 arch/arm/mach-tegra/cpuidle-tegra30.c         |    9 +-
 drivers/clk/tegra/Makefile                    |    2 +
 drivers/clk/tegra/clk-tegra20-emc.c           |  307 ++++
 drivers/clk/tegra/clk-tegra20.c               |   55 +-
 drivers/clk/tegra/clk-tegra30.c               |   38 +-
 drivers/clk/tegra/clk.h                       |    3 +
 drivers/memory/tegra/Kconfig                  |   10 +
 drivers/memory/tegra/Makefile                 |    1 +
 drivers/memory/tegra/mc.c                     |   42 +-
 drivers/memory/tegra/mc.h                     |   74 +-
 drivers/memory/tegra/tegra124.c               |   20 -
 drivers/memory/tegra/tegra20-emc.c            |  126 +-
 drivers/memory/tegra/tegra30-emc.c            | 1234 +++++++++++++++++
 drivers/memory/tegra/tegra30.c                |   23 +
 include/linux/clk/tegra.h                     |   12 +
 include/soc/tegra/mc.h                        |    2 +-
 20 files changed, 2422 insertions(+), 186 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
 create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
 create mode 100644 drivers/memory/tegra/tegra30-emc.c

-- 
2.22.0

