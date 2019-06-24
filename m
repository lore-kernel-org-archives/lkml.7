Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF04C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA96320673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei9Nsrac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfFXC2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:28:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39706 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfFXC2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:28:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so10959956ljh.6;
        Sun, 23 Jun 2019 19:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxwkbS0fcKxl/zIGar7QxJotcV1Cfh9QGSRQWWbJSBg=;
        b=Ei9NsraczeHKUZb0Z0zmCoMcPr+e5hwgLg05gvNPMZ8DLa4IiTm2zelemz7bINhTwi
         vy2xpLJ8202+q2bOJBRssMDimnxVFqyGvWutFBzgawBniOHvXtAo11l0ozfiFSxOyTbv
         TukZ8a0b8HG6Gi0LcreguEcrmfDwqxC5X4rNLaEaF/scgej/hruRcBf1XXsXR4b/O5YW
         Daheluu9KxWOa5ApxVukBIoglVVOXH1FWPs24mKHEFyuv0+Lnt83tz8s65ptamRRKmad
         yHlK+llIfRy9Z+9Oulq9aZFWJSq6mIQvZ/XCGHIrnPfoQDTWvovjVhQNKgmhucfdo+jq
         5dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxwkbS0fcKxl/zIGar7QxJotcV1Cfh9QGSRQWWbJSBg=;
        b=DYgmO1YW7VN+qXB4K+LorDpsMYGb3yApY524TiXAPqoDH+x6K3wZd0X+Nu6YY65Du2
         ois3KWr7JQ0qZ52g+W6tX8MZxIzLSA5R8VI0R9ZAbI4DJwKBnUZP4eT0DTk3blL1AkIJ
         ZwgNHmAI0qAAaCAEQG+qIvleBB0p7qvZYLp1j86ih+EMf3NG3HyFTB0Gvn7KBMDs8vSP
         PiwRwBhizdBdR8WnYlWeZoeYDNM3f5kcfCUj+J6vBW5DNMEVABgAGgXGzFSEewm24EaD
         pXPFpo27zhwa4H6ed5vyrzlddFvJXxKUqtp/RU3Q+rQAAxjvOHPDU1BVpLzk5qLwzxR0
         zAyA==
X-Gm-Message-State: APjAAAV2F39LLbdF9G3z7N/1TcZ5HtftpK0Fp7t2fB2uiBELchJMLWIm
        hHB8BoKtlOyk3g31mMOgk9uX0krn
X-Google-Smtp-Source: APXvYqwPpB9/9fAw0cA0stESzi1IeHuvaf8NeVtoSNT9CqQKSwzfeCmcUwm33KL6BbTdnMnqUTIqeQ==
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr40819998ljk.90.1561336316510;
        Sun, 23 Jun 2019 17:31:56 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id y5sm1495146ljj.5.2019.06.23.17.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 17:31:55 -0700 (PDT)
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
Subject: [PATCH v5 00/10] memory: tegra: Introduce Tegra30 EMC driver
Date:   Mon, 24 Jun 2019 03:31:22 +0300
Message-Id: <20190624003132.29473-1-digetx@gmail.com>
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

Dmitry Osipenko (10):
  clk: tegra20/30: Add custom EMC clock implementation
  memory: tegra20-emc: Drop setting EMC rate to max on probe
  memory: tegra20-emc: Adapt for clock driver changes
  memory: tegra20-emc: Include io.h instead of iopoll.h
  memory: tegra20-emc: Pre-configure debug register
  dt-bindings: memory: Add binding for NVIDIA Tegra30 External Memory
    Controller
  memory: tegra: Introduce Tegra30 EMC driver
  memory: tegra: Ensure timing control debug features are disabled
  memory: tegra: Consolidate registers definition into common header
  ARM: dts: tegra30: Add External Memory Controller node

 .../memory-controllers/nvidia,tegra30-emc.txt |  249 ++++
 arch/arm/boot/dts/tegra30.dtsi                |   11 +
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
 drivers/memory/tegra/tegra20-emc.c            |  119 +-
 drivers/memory/tegra/tegra30-emc.c            | 1225 +++++++++++++++++
 drivers/memory/tegra/tegra30.c                |   24 +
 include/linux/clk/tegra.h                     |   11 +
 include/soc/tegra/mc.h                        |    2 +-
 17 files changed, 1995 insertions(+), 184 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt
 create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
 create mode 100644 drivers/memory/tegra/tegra30-emc.c

-- 
2.22.0

