Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98C2C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6062216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDoemDsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfGWDOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:14:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45620 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfGWDOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:14:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so39492038lje.12;
        Mon, 22 Jul 2019 20:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ip48D8E4gCNxD53NwiDWZhsDGGMy2VADB8sLeuiomsU=;
        b=nDoemDsfN3JPh3DaCrmrIQDNqmA5YKRIV28v/kisWClGUZLCw7CvYjhRKdRCnWS3VT
         d715hnySbDVUEX/AVveE5nnrYf7ia/omDCBDejidJODFVzv6ykYnrM5LypOjqlHZpqBY
         2TklM3yu/u6x5+E5++2lfpL7M1GRrMdVDFvL9FkijlGXvsKMvk4FRtXIi8D8+wjOZfO5
         lYLsUCmudaIoW3QaEJCBiZLbGdTn1MQAXbEJ6feANUCCHfLj7ZzTycXm5NoiNL7phmEa
         7MMTaMWMgs7TIStYJdVa4FpdnfvDYI0k6T5KYeowfxwYBDxFOVF7hpdmwbZWd/qNerer
         strQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ip48D8E4gCNxD53NwiDWZhsDGGMy2VADB8sLeuiomsU=;
        b=QI920Nkv9bqCyllPwmgP0cT2XD5BnYu3Fnafx205inwbcyRRmC2Yf9YdtS8OVDhci2
         UlJtHg5iT3aysbL2xGDEslyaQnOPvjE3lN8hVIqxgCnznVuyyuHOX934f36Dq0t2tPHB
         RiNysuoXdPXcoBGtu0KpDU8e+AKNaL19oBGdzwIcjShzYyQY+RwAf+YBbyGtXhXDBHzR
         lJoRquTG+atXh9UVf8UV4IV2y4N1AiW8i5IzOTj6PO14QWnXk9guB28YxEdpmteaaPcy
         ADMNm7Lx2BvWDS4GSfelxAicZFZPTXPYtEmsXLPnCsSs9KNLmxdEFD6SVD4wZ3it0xg3
         sCIQ==
X-Gm-Message-State: APjAAAXoI4pmq+0+amgMSbt/uPJc/F40jBv+/eR7FeG4/wUM9T60uXz3
        HrAHW/ZguOM2XTEfg6vEgnurqKCi
X-Google-Smtp-Source: APXvYqyKjfU70ghIF0Fc+qTZyDTcPuHApR/Hr2heoJCuBMaZv409QunbNrqlEHtYCA+HOJHLc8P5pA==
X-Received: by 2002:a05:651c:1105:: with SMTP id d5mr838631ljo.161.1563851646475;
        Mon, 22 Jul 2019 20:14:06 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id u18sm6217184lfe.65.2019.07.22.20.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:14:05 -0700 (PDT)
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
Subject: [PATCH v8 00/15] memory: tegra: Introduce Tegra30 EMC driver
Date:   Tue, 23 Jul 2019 06:12:32 +0300
Message-Id: <20190723031247.31932-1-digetx@gmail.com>
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

 .../nvidia,tegra124-mc.yaml                   |  156 +++
 .../nvidia,tegra30-emc.yaml                   |  341 +++++
 .../memory-controllers/nvidia,tegra30-mc.txt  |  123 --
 .../memory-controllers/nvidia,tegra30-mc.yaml |  173 +++
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
 drivers/memory/tegra/tegra30-emc.c            | 1230 +++++++++++++++++
 drivers/memory/tegra/tegra30.c                |   23 +
 include/linux/clk/tegra.h                     |   11 +
 include/soc/tegra/mc.h                        |    2 +-
 20 files changed, 2427 insertions(+), 313 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
 create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
 create mode 100644 drivers/memory/tegra/tegra30-emc.c

-- 
2.22.0

