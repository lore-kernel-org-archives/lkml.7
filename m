Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECFBC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C0C21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R80k6ZW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbfEXRYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:24:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46329 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEXRYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:24:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id m15so9292595ljg.13;
        Fri, 24 May 2019 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssbN1TdbzNBmflVEU1aQ4WjQYnrmIvlJ3fJbTkCYEoc=;
        b=R80k6ZW4+477eCiLEWOyECzHViN14QHa/kc5EGUKydeVagXzDJWmZ7z+meczBLoeyW
         pCQ94EWNunx6Ta5bYQhRIv+Tbr9vPSBTilIF7022NToesQ6zbpz1t8U9aQdmTL06UXrU
         QbmcWcCG2K0J+Ra4eYS4j8KpamYnZNDi4svTSO6b1kF7Ej4PxQRHNOmtFQjd8CntkQwY
         Xr24AmDUKHzhmdQjIVN4Z1cG0NO7KwBj0T3ohcgoKFbYL+9VEs3sG++iM8fDYEOwKwUE
         wB11Dk5zVbzxI8hdpsXFtaDD+tHTA13o2lLmym5uznvx4DGncqPXtDWjKz3P2H/qcjFR
         LFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssbN1TdbzNBmflVEU1aQ4WjQYnrmIvlJ3fJbTkCYEoc=;
        b=Zi4Qye3R529K/7zL92/0BNGkcw1NhMoU3DsyuL1iZx0pzk80Yiljz54l+NTSzctLzd
         RT443tXg1HiFd5KrWI5MZacufOxWHqLXiQPPdh/8eDjraQ/w7ez1lzaMQ/ss+ID3UtFv
         DZIKJY86k5ukgVnvPE2pEYObDTKCB5b9pHrhzD2VcMH5OJxz3dx+QZaIJa6eFlrkNEdS
         5A6/pLdKomSDPdaaen/F5UtED2omDyqGGuqkuDwte8ssKwne4heSzaoZJm91M66zNRrz
         zptj+vQQtdhszsv3+1KiKrTQSjo1/pmIrRHtt9BUJrj+JzldtjiF9oMtFTWtkZmvTiDW
         3RQQ==
X-Gm-Message-State: APjAAAXZYbzDFh2W/4ehycs2IzXrS/rWYx3dSd6rA5py6ty5H5LgqaBR
        n6WFxrTebDHG2dcnjONexTk=
X-Google-Smtp-Source: APXvYqzyc1Puq1aWXJFdGKsz3v4v+LL6XzFiaqiieBRLRqI9otzuddshUBYwjZTlBA/waQu/xMB7vw==
X-Received: by 2002:a2e:9acb:: with SMTP id p11mr24038393ljj.129.1558718655086;
        Fri, 24 May 2019 10:24:15 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id d13sm196957lfm.27.2019.05.24.10.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:24:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] memory: tegra: Introduce Tegra30 EMC driver
Date:   Fri, 24 May 2019 20:23:45 +0300
Message-Id: <20190524172353.29087-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
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

v3: - Addressed review comments that were made by Stephen Boyd to v2 by
      adding explicit typing for the callback variable, by including
      "clk-provider.h" directly in the code and by dropping __clk_lookup
      usage where possible.

      Added more patches into this series:

        memory: tegra20-emc: Drop setting EMC rate to max on probe
        memory: tegra20-emc: Adapt for clock driver changes
        memory: tegra20-emc: Include io.h instead of iopoll.h
        memory: tegra20-emc: Replace clk_get_sys with devm_clk_get

      Initially I was going to include these patches into other patchset,
      but changed my mind after rearranging things a tad. The "Adapt for
      clock driver changes" patch is directly related to the clock changes
      done in the first patch of this series, the rest are minor cleanups
      that are fine to include here as well.

      Added some more words to the commit message of "Add binding for NVIDIA
      Tegra30 External Memory Controller" patch, clarifying why common DDR
      timing device-tree form isn't suitable for Tegra30.

      The Tegra30 EMC driver now explicitly selects the registers access
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

Dmitry Osipenko (8):
  clk: tegra20/30: Add custom EMC clock implementation
  memory: tegra20-emc: Drop setting EMC rate to max on probe
  memory: tegra20-emc: Adapt for clock driver changes
  memory: tegra20-emc: Include io.h instead of iopoll.h
  memory: tegra20-emc: Replace clk_get_sys with devm_clk_get
  dt-bindings: memory: Add binding for NVIDIA Tegra30 External Memory
    Controller
  memory: tegra: Introduce Tegra30 EMC driver
  ARM: dts: tegra30: Add External Memory Controller node

 .../memory-controllers/nvidia,tegra30-emc.txt |  249 ++++
 arch/arm/boot/dts/tegra30.dtsi                |   11 +
 drivers/clk/tegra/Makefile                    |    2 +
 drivers/clk/tegra/clk-tegra20-emc.c           |  299 +++++
 drivers/clk/tegra/clk-tegra20.c               |   55 +-
 drivers/clk/tegra/clk-tegra30.c               |   38 +-
 drivers/clk/tegra/clk.h                       |    6 +
 drivers/memory/tegra/Kconfig                  |   10 +
 drivers/memory/tegra/Makefile                 |    1 +
 drivers/memory/tegra/mc.c                     |    3 -
 drivers/memory/tegra/mc.h                     |   30 +-
 drivers/memory/tegra/tegra20-emc.c            |   94 +-
 drivers/memory/tegra/tegra30-emc.c            | 1165 +++++++++++++++++
 drivers/memory/tegra/tegra30.c                |   44 +
 include/linux/clk/tegra.h                     |   14 +
 15 files changed, 1903 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt
 create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
 create mode 100644 drivers/memory/tegra/tegra30-emc.c

-- 
2.21.0

