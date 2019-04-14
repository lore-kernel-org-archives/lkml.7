Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05814C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C015C20818
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqktNvK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfDNU3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:29:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45231 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNU3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:29:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so7536397pgk.12;
        Sun, 14 Apr 2019 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OizTUPFMNYZbO4Qg57g2+1uZwlgqwnT3ggJ3bxKJrDU=;
        b=EqktNvK4pHVtRIddHW4Jc6eDg/6IaehRG7VvUzT/FgnOGigeyBEobbXOY+DEpLlO8E
         iKZjL8IRCgVzl6ka8EsoahJfTbjR4VY2WG8CVHnXQ6Zj2xL+yczZncOBxIbPvS4BS0NV
         ym67eIVijItMRunzysGeAj0DMZEB1V7ngJo0UFBXK+GsEYJZUI47WXstCd+anYLNpe6V
         ko0iqYQibSO40T7KqnxYoLjkjT8C1zHOclmeJvdeBYV6RTS1SzwXi8Pe7Ror4Bn4Em+c
         D6aKWk6kODCFkHiz4uFMlc1T2ETqOdDlZAO6yd3Mp8uxPH7nK1I5o0v47rxLFrfkqRja
         CTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OizTUPFMNYZbO4Qg57g2+1uZwlgqwnT3ggJ3bxKJrDU=;
        b=gfSqnW4twVKBVo4taUS22RkChXgONzwLCDiLbwRoU2kwWiRlLHAwJXfV2wwcsNA/dA
         fvfRiIs0a/aJrIyOjUJWvH75NFI0DPsM7EiS+3FI3695lSzYNzHDDawPDfejb0K5sn5A
         Gajrl3cLyj4E58Sg3mWLbUY/oymH77sxar/wV/qCqqA76DhnVqxsXidMwkxB8vZs+C5W
         sJuKWLUHrNq0X0X7HW3IuiN7+bcXF5uVG83tBjlXDkcGZIim73iOYcgCziDdo+qScs93
         2l43is1rX6eTaOoes5G31ZIGz/KGqxOB+uK7apVvzD6wFguyjFigEwdgHHtP2c4Ofax5
         wflQ==
X-Gm-Message-State: APjAAAV5lz5uTZ+1gC2w51v6WLd+1Mn8ucTSfF+L+FPEOhr7YxZ8cmIa
        sqVloWtT/LAhDCWLjQIxxeQ=
X-Google-Smtp-Source: APXvYqy1GVEFCAhTYn87WM+g4Mz6lnnuSuCLQ1Ko08ixhinqAiN5bXBUyv+WdG+dMCScA6yuiIAbkg==
X-Received: by 2002:a62:1193:: with SMTP id 19mr69576318pfr.82.1555273756735;
        Sun, 14 Apr 2019 13:29:16 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m25sm63142091pfa.175.2019.04.14.13.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 13:29:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] memory: tegra: Introduce Tegra30 EMC driver
Date:   Sun, 14 Apr 2019 23:20:05 +0300
Message-Id: <20190414202009.31268-1-digetx@gmail.com>
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

Please also note that this patchset is based on this series:

https://www.spinics.net/lists/linux-tegra/msg39687.html

Changelog:

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

Dmitry Osipenko (4):
  clk: tegra20/30: Add custom EMC clock implementation
  dt-bindings: memory: Add binding for NVIDIA Tegra30 External Memory
    Controller
  memory: tegra: Introduce Tegra30 EMC driver
  ARM: dts: tegra30: Add External Memory Controller node

 .../memory-controllers/nvidia,tegra30-emc.txt |  257 ++++
 arch/arm/boot/dts/tegra30.dtsi                |   11 +
 drivers/clk/tegra/Makefile                    |    2 +
 drivers/clk/tegra/clk-tegra20-emc.c           |  307 +++++
 drivers/clk/tegra/clk-tegra20.c               |   51 +-
 drivers/clk/tegra/clk-tegra30.c               |   35 +-
 drivers/clk/tegra/clk.h                       |    6 +
 drivers/memory/tegra/Kconfig                  |   10 +
 drivers/memory/tegra/Makefile                 |    1 +
 drivers/memory/tegra/mc.c                     |    3 -
 drivers/memory/tegra/mc.h                     |   30 +-
 drivers/memory/tegra/tegra30-emc.c            | 1159 +++++++++++++++++
 drivers/memory/tegra/tegra30.c                |   44 +
 include/linux/clk/tegra.h                     |    6 +
 14 files changed, 1860 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt
 create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
 create mode 100644 drivers/memory/tegra/tegra30-emc.c

-- 
2.21.0

