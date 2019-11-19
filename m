Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A098BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7895C222F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aXFtn85b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKSGuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:50:52 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14216 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfKSGuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:50:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd390c80000>; Mon, 18 Nov 2019 22:50:48 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 22:50:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Nov 2019 22:50:51 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 06:50:50 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 19 Nov 2019 06:50:50 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.175.254]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd390c90000>; Mon, 18 Nov 2019 22:50:50 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 00/17] Remove direct Tegra PMC access in clock driver
Date:   Mon, 18 Nov 2019 22:50:17 -0800
Message-ID: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574146248; bh=KhvH3a4Cvl4xWtjCv7po3TayPmHArH1qRxX3HoKIC7Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=aXFtn85bVVYAl2J+qxAIaHNRqVTk756e0C+wgcPCXERJMZQisoXIERJMvBZRpvy9n
         zIZ1D8QbKel+spkGXqnwhCETmIfmCGSskehPHeQjYs2y7IKxmltjEoXw8iHrOTSBvC
         RMOVXivWLt3PSIvK7LvX93Nvs8Mb3VwoRB1NVZ+5AuBFjSXalBRCS2xlsDe1D4cP+Z
         MgWwB2ZU4WkqNvxrACh/2GWTnamD2wtey9gYYRUgBCe8rUKgjkWhf1l+wJAdx0SK/f
         GRlPKcKJ2SW+FKHkptMzi6PHRc/zvUm8g8WF2lj4BrGa2Zzgsz7486asr6KzMbhYTu
         e83lcaf1PTMrg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls which
are currently registered by Tegra clock driver using clk_regiser_mux and
clk_register_gate which performs direct Tegra PMC register access.

When Tegra PMC is in secure mode, any access from non-secure world will
not go through.

This patch series adds these Tegra PMC clocks and blink controls to Tegra
PMC driver with PMC as clock provider and removed them from Tegra clock
driver. This also adds PMC specific clock id's to use in device tree and
removed clock ids of PMC clock from Tegra clock driver.

This series also includes patch to update clock provider from tegra_car
to pmc in the device tree tegra210-smaug.dts that uses clk_out_2 from PMC.

Tegra PMC also has WB0 PLLM overrides and PLLE pads IDDQ controls which
are currently configured by Tegra clock driver using direct PMC access.

This series also includes patches that adds helper functions in Tegra PMC
driver to allow programming these from Tegra clock driver and removes
direct PMC access from the clock driver.


Sowjanya Komatineni (17):
  soc: tegra: pmc: Add helper functions for PLLM overrides
  soc: tegra: pmc: Add helper function for PLLE IDDQ override
  dt-bindings: soc: tegra-pmc: Add Tegra PMC clock ids
  soc: tegra: Add Tegra PMC clock registrations into PMC driver
  dt-bindings: soc: tegra-pmc: Add id for Tegra PMC blink control
  soc: pmc: Add blink output clock registration to Tegra PMC
  clk: tegra: Use Tegra PMC helper functions for PLLM overrides
  clk: tegra: Use Tegra PMC helper function for PLLE IDDQ
  clk: tegra: Remove PMC base references from clock registration
  clk: tegra: Remove tegra_pmc_clk_init along with clk ids
  dt-bindings: clock: tegra: Remove pmc clock ids from clock dt-bindings
  arm: tegra: Add clock-cells property to Tegra pmc
  arm64: tegra: Add clock-cells property to Tegra pmc
  dt-bindings: Add Tegra PMC clock configuration bindings
  dt-bindings: tegra186-pmc: Add Tegra PMC clock bindings
  arm64: tegra: smaug: Change clk_out_2 provider from tegra_car to pmc
  ASoC: nau8825: change Tegra clk_out_2 provider from tegra_car to pmc

 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  44 ++
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  42 ++
 .../devicetree/bindings/sound/nau8825.txt          |   2 +-
 arch/arm/boot/dts/tegra114.dtsi                    |   4 +-
 arch/arm/boot/dts/tegra124.dtsi                    |   4 +-
 arch/arm/boot/dts/tegra30.dtsi                     |   4 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           |   4 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   2 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   2 +
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      |   2 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   2 +
 drivers/clk/tegra/Makefile                         |   1 -
 drivers/clk/tegra/clk-id.h                         |   7 -
 drivers/clk/tegra/clk-pll.c                        | 135 ++---
 drivers/clk/tegra/clk-tegra-audio.c                |   4 +-
 drivers/clk/tegra/clk-tegra-periph.c               |   8 +-
 drivers/clk/tegra/clk-tegra-super-gen4.c           |  11 +-
 drivers/clk/tegra/clk-tegra114.c                   |  75 +--
 drivers/clk/tegra/clk-tegra124.c                   |  86 +--
 drivers/clk/tegra/clk-tegra20.c                    |  30 +-
 drivers/clk/tegra/clk-tegra210.c                   |  74 +--
 drivers/clk/tegra/clk-tegra30.c                    |  59 +-
 drivers/clk/tegra/clk.h                            |  48 +-
 drivers/soc/tegra/pmc.c                            | 598 ++++++++++++++++++++-
 include/dt-bindings/clock/tegra114-car.h           |  14 +-
 include/dt-bindings/clock/tegra124-car-common.h    |  14 +-
 include/dt-bindings/clock/tegra20-car.h            |   2 +-
 include/dt-bindings/clock/tegra210-car.h           |  14 +-
 include/dt-bindings/clock/tegra30-car.h            |  14 +-
 include/dt-bindings/soc/tegra-pmc.h                |  17 +
 include/soc/tegra/pmc.h                            |   6 +
 31 files changed, 879 insertions(+), 450 deletions(-)
 create mode 100644 include/dt-bindings/soc/tegra-pmc.h

-- 
2.7.4

