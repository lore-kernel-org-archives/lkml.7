Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC384C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C7120673
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTPl8YCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfGGWyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:54:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40951 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfGGWyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:54:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so16263155qtn.7;
        Sun, 07 Jul 2019 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tuOi/8r0NnDH+fqBMlSJg2pGRDBZ//kqhhMPZGnJ6wU=;
        b=RTPl8YCqBakZ65Tjc7AziwFzT9I3XM9QZWRubsIWkZlc+wfwj7u6JhEg8s1xuvAVBt
         ETHjo7xyqtTSrUY7FvVGVdCh/cgr6rYB5XNoenCpqrLGrHDcSGq8XyQh1L61Eal0PzWr
         JAUISs93YAacs0gzGXA93e5uldpQsmVbFg7+pRx7q7wHFBC2m79qZTmjF1EoVcBCyaxU
         ALHfqK1aBjeIDuxy7A48LRLZF9WuVewpRBggYlawsY8iVwctkyoZpNXRadnzXcYCqlOF
         RkdyYi96Wiw7SExpmNA6KwpoJgEDlyRK5+RivI0S5TQXh7iIMKGFrg6LaBByagkoLoC/
         2hDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tuOi/8r0NnDH+fqBMlSJg2pGRDBZ//kqhhMPZGnJ6wU=;
        b=LwtauXD9JT1+s2UpOiwUlVWcN0X+WwgYaSu0wSL3chg4+PiN5WxebUpEP5RDJSFEhP
         tk3/5/8+p8V0yBH/zfaojco9CJXDiQILuFR7GvUtaGcxEgTpOwAhyJBvIpQUObZ8xh/N
         +2OMMatwdcBFx3cLLk9tRxzBDHYsMNacji2jlYNbphwM4VVQqWp7JrVd1XnaFfol0Ww+
         exsypQ5qTVCgPFpMoX+GS8uDfkfxgJApHNhyk16CJXsYCAIM7L6lNGC5038RQY7U9sfY
         3W1mkVYJoGgFcThTd9d0kZvUije5wQuh0aU2JMcm3SfrxJbgoYuL8ncQpJg5bOCfxQFG
         4DxA==
X-Gm-Message-State: APjAAAXOMWS2F4Zitq6+33XTLW9MbajAdxpscb8pSM69WvJp6fnyAM8g
        kumppNvoMQWTzg5ywZCCPAE=
X-Google-Smtp-Source: APXvYqyD9jYNgUPEfedU95w6Z01GH7JuMVecqpDG1wzB1TPYkwemonyMPbW1yh2hca1A+ILvkc7oow==
X-Received: by 2002:a0c:baa8:: with SMTP id x40mr12671071qvf.168.1562540087682;
        Sun, 07 Jul 2019 15:54:47 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id t2sm8217556qth.33.2019.07.07.15.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:54:47 -0700 (PDT)
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
Subject: [PATCH v7 00/13] memory: tegra: Introduce Tegra30 EMC driver
Date:   Mon,  8 Jul 2019 01:54:11 +0300
Message-Id: <20190707225424.9562-1-digetx@gmail.com>
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

Dmitry Osipenko (13):
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
  ARM: dts: tegra30: Add External Memory Controller node

 .../nvidia,tegra124-mc.yaml                   |  156 +++
 .../nvidia,tegra30-emc.yaml                   |  339 +++++
 .../memory-controllers/nvidia,tegra30-mc.txt  |  123 --
 .../memory-controllers/nvidia,tegra30-mc.yaml |  171 +++
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
 drivers/memory/tegra/tegra20-emc.c            |  126 +-
 drivers/memory/tegra/tegra30-emc.c            | 1234 +++++++++++++++++
 drivers/memory/tegra/tegra30.c                |   23 +
 include/linux/clk/tegra.h                     |   11 +
 include/soc/tegra/mc.h                        |    2 +-
 20 files changed, 2425 insertions(+), 307 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
 create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
 create mode 100644 drivers/memory/tegra/tegra30-emc.c

-- 
2.22.0

