Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B11C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DCF2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY5/4ga9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfHKVBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:01:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36004 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfHKVBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 17:01:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so18936799lfp.3;
        Sun, 11 Aug 2019 14:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UXQH5NXD3A/pYrcCOJnuyCuooRZ8VZx4iNfJw7iMY0I=;
        b=nY5/4ga9NZUanJCoOPDvwQ3A0ltH+Pe6sQiSx5EZf6Gut4kr43N4ne8FEWUfRvkqfk
         gGmMI5riPs94h3V6cdYeFkKHXRDAemtXHWYmYye6k6v2eCJPf55xH4B1DEKOrl1DgKk/
         rvXDnijWf8Udre9WgO9qlhk+7Gfb411gERIWcrAYT/Rd/5FT9EAe1j+6Q4+FBI0+5q1o
         LhhUUscQVU6pC66gEMtZ33IVxuui3OsQIgJBJMsxtmh9IADEFlyMNJlWxkGk48ZjStHp
         p/M33pW3YZi6pacemKSjetwGNizEu21o1ZxCEKYjx/fHm32hJaelYLuDajd95i765uo9
         62bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UXQH5NXD3A/pYrcCOJnuyCuooRZ8VZx4iNfJw7iMY0I=;
        b=dGqCGA+MS8kS46V65OUXXxTX7ubmyv7/F1HjjAJhWhTIhDvcrecyTE8z2gSzdZnkoP
         fQn6/5lEbYvQ5gzXbW8npDfGxqBq/fyO4irwvj4sfB/JJYVGGo/V9yI+MfRU5YY7DP7G
         wBobf4M5LhVJmWpniQdo5Iavkmmia1j4Yyc2ZKRNe+7bieMYHIGabvcNnAZu0lZfSSte
         CYWWiyknJZZ/vo6cTs1EU2pg1C78VeYT1zqmD8kAYURv3f9rvcgNDEZaSQRaa+ntFcAY
         dc/oQib28Icx7tpZqqZ75P3GLmI8UqTaqjs/2K8Y3a6NYRunDegi5prdNj5aYtfohnmj
         JRFw==
X-Gm-Message-State: APjAAAVoqSStv6O/J7poPDNjM/rfGszSNVHpx/9j5NevmnHEJn/MxRTB
        I0QFe4JAMnVk4A7CJhkONDg=
X-Google-Smtp-Source: APXvYqz2PUmwmtcjCK0HvAQfaEEEFfJWjQ0I999NF0jTGH55BzuY6sV8THHEPBao7hsEqhHRWOuOng==
X-Received: by 2002:ac2:599b:: with SMTP id w27mr5304440lfn.75.1565557286428;
        Sun, 11 Aug 2019 14:01:26 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id z25sm18708161lfi.51.2019.08.11.14.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:01:25 -0700 (PDT)
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
Subject: [PATCH v10 00/15] memory: tegra: Introduce Tegra30 EMC driver
Date:   Mon, 12 Aug 2019 00:00:28 +0300
Message-Id: <20190811210043.20122-1-digetx@gmail.com>
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

v10: - Addressed review comments that were made by Rob Herring to v9 by
       dropping unnecessary reg descriptions, specifying valid ranges and
       using boolean type where appropriate in the device-tree patches.

v9: - Fixed memory corruption bug that was uncovered after introducing
      some extra optimizations to the devfreq driver that allows CPU
      to stay longer in the LP2 cpuidle state. The corruption is caused by
      a very late AUTO-REFRESH re-enabling due to a possible schedule on
      waiting for clk-change completion, the re-enabling is now a part of
      "EMC exec-after-clkchange" hardware sequence.

    - Added "type: object" to T124 MC YAML, that was missed in v8 by accident.

v8: - Added two new patches:

        memory: tegra20-emc: Increase handshake timeout
        memory: tegra20-emc: wait_for_completion_timeout() doesn't return error

      Turned out that memory-clk handshake may take much more time under
      some circumstances. The second patch is a minor cleanup. The same
      changes are also applied to the Terga30 EMC driver addition-patch.

      The pattern-properties of YAML bindings gained "type: object", for
      consistency.

v7: - Addressed review comments that were made by Rob Herring to v6 by
      removing old Terga30 Memory Controller binding once it's converted
      to YAML, by using explicit patterns for the sub-nodes and specifying
      min/max clock rates in the YAML.

    - Two patches that were added in v6 are removed from the series:

        clk: tegra20: emc: Add tegra20_clk_emc_on_pllp()
        ARM: tegra30: cpuidle: Don't enter LP2 on CPU0 when EMC runs off PLLP

      Because the problem with the PLLP is resolved now, turned out it was
      a bug in the CPU-suspend code.

    - The "Introduce Tegra30 EMC driver" patch got a fix for the "Same Freq"
      bit typo, it's a bit 27 and not 16.

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
  memory: tegra20-emc: Increase handshake timeout
  memory: tegra20-emc: wait_for_completion_timeout() doesn't return
    error
  dt-bindings: memory: tegra30: Convert to Tegra124 YAML
  dt-bindings: memory: Add binding for NVIDIA Tegra30 Memory Controller
  dt-bindings: memory: Add binding for NVIDIA Tegra30 External Memory
    Controller
  memory: tegra: Introduce Tegra30 EMC driver
  memory: tegra: Ensure timing control debug features are disabled
  memory: tegra: Consolidate registers definition into common header
  ARM: dts: tegra30: Add External Memory Controller node

 .../nvidia,tegra124-mc.yaml                   |  152 ++
 .../nvidia,tegra30-emc.yaml                   |  336 +++++
 .../memory-controllers/nvidia,tegra30-mc.txt  |  123 --
 .../memory-controllers/nvidia,tegra30-mc.yaml |  167 +++
 arch/arm/boot/dts/tegra30.dtsi                |    9 +
 drivers/clk/tegra/Makefile                    |    2 +
 drivers/clk/tegra/clk-tegra20-emc.c           |  293 ++++
 drivers/clk/tegra/clk-tegra20.c               |   55 +-
 drivers/clk/tegra/clk-tegra30.c               |   38 +-
 drivers/clk/tegra/clk.h                       |    3 +
 drivers/memory/tegra/Kconfig                  |   10 +
 drivers/memory/tegra/Makefile                 |    1 +
 drivers/memory/tegra/mc.c                     |   42 +-
 drivers/memory/tegra/mc.h                     |   74 +-
 drivers/memory/tegra/tegra124.c               |   20 -
 drivers/memory/tegra/tegra20-emc.c            |  134 +-
 drivers/memory/tegra/tegra30-emc.c            | 1232 +++++++++++++++++
 drivers/memory/tegra/tegra30.c                |   23 +
 include/linux/clk/tegra.h                     |   11 +
 include/soc/tegra/mc.h                        |    2 +-
 20 files changed, 2414 insertions(+), 313 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
 create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
 create mode 100644 drivers/memory/tegra/tegra30-emc.c

-- 
2.22.0

