Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1762FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97D32068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="r27RUl/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfK0E7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 23:59:40 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15248 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfK0E7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 23:59:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dde02ba0000>; Tue, 26 Nov 2019 20:59:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Nov 2019 20:59:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Nov 2019 20:59:36 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov
 2019 04:59:35 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov
 2019 04:59:35 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Nov 2019 04:59:35 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.149]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dde02b60000>; Tue, 26 Nov 2019 20:59:35 -0800
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
Subject: [PATCH v2 00/11] Move PMC clocks into Tegra PMC driver
Date:   Tue, 26 Nov 2019 20:59:22 -0800
Message-ID: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574830778; bh=EHkcandgidEY+5/J4Nluq3Lh1kptaZ7ThaFlxB23sW4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=r27RUl/y3hDLc18P8mGrqrwUXyMl44E1X7disCs3Q1miy9bH2wD8tYTHMvvUhNtWX
         1npBTD+2oKQ92rpUqX/GAWe5cY/ZdIJZEL6a04pS4UPriH9fvNLjs5MEAItq2I8KK+
         o8ecju+mOLKOXHBz3icYsvFmIw6uAsfilrIJ4cX6sDthkATFRxVKwkzLUQhK5byP4G
         ByKoE36PNjGRZAJ0ZVn+LLNcY01KYMO+kUscQwVsahnXva59dfL0eEv/9bbYHDHsW8
         A8M1HkjKmfTiWOFKUwJmu7CqW76oer7XKVTX5j3lAPyGkKrIcbytUADOVFIH4ikqgk
         nkffA2nGwGHYg==
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

[v2]:	Changes between v1 and v2 are
	- v2 includes patches for adding clk_out_1, clk_out_2, clk_out_3,
	  blink controls to Tegra PMC driver and removing clk-tegra-pmc.
	- feedback related to pmc clocks in Tegra PMC driver from v1
	- Removed patches for WB0 PLLM overrides and PLLE IDDQ PMC programming
	  by the clock driver using helper functions from Tegra PMC.

 	  Note:
	  To use helper functions from PMC driver, PMC early init need to
	  happen prior to using helper functions and these helper functions are
	  for PLLM Override and PLLE IDDQ programming in PMC during PLLM/PLLE
	  clock registration which happen in clock_init prior to Tegra PMC
	  probe.
	  Moving PLLM/PLLE clocks registration to happen after Tegra PMC
	  impacts other clocks EMC, MC and corresponding tegra_emc_init and
	  tegra_mc_init.
	  This implementation of configuring PMC registers thru helper
	  functions in clock driver needs proper changes across PMC, Clock,
	  EMC and MC inits to have it work across all Tegra platforms.

	  Currently PLLM Override is not enabled in the bootloader so proper
	  patches for this fix will be taken care separately.

[v1]:	v1 includes patches for below fixes.
	- adding clk_out_1, clk_out_2, clk_out_3, blink controls to Tegra PMC
	  driver and removing clk-tegra-pmc.
	- updated clock provider from tegra_car to pmc in the device tree
	  tegra210-smaug.dts that uses clk_out_2.
	- Added helper functions in PMC driver for WB0 PLLM overrides and PLLE
	  IDDQ programming to use by clock driver and updated clock driver to
	  use these helper functions and removed direct PMC access from clock
	  driver and all pmc base address references in clock driver.


Sowjanya Komatineni (11):
  dt-bindings: soc: tegra-pmc: Add Tegra PMC clock ids
  soc: tegra: Add Tegra PMC clock registrations into PMC driver
  dt-bindings: soc: tegra-pmc: Add id for Tegra PMC blink control
  soc: pmc: Add blink output clock registration to Tegra PMC
  clk: tegra: Remove tegra_pmc_clk_init along with clk ids
  dt-bindings: clock: tegra: Remove pmc clock ids from clock dt-bindings
  arm: tegra: Add clock-cells property to Tegra PMC
  arm64: tegra: Add clock-cells property to Tegra pmc
  dt-bindings: Add Tegra PMC clock configuration bindings
  arm64: tegra: smaug: Change clk_out_2 provider from tegra_car to pmc
  ASoC: nau8825: change Tegra clk_out_2 provider from tegra_car to pmc

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  45 ++-
 .../devicetree/bindings/sound/nau8825.txt          |   2 +-
 arch/arm/boot/dts/tegra114.dtsi                    |   4 +-
 arch/arm/boot/dts/tegra124.dtsi                    |   4 +-
 arch/arm/boot/dts/tegra20.dtsi                     |   4 +-
 arch/arm/boot/dts/tegra30.dtsi                     |   4 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           |   4 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   2 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   2 +
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      |   2 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   2 +
 drivers/clk/tegra/Makefile                         |   1 -
 drivers/clk/tegra/clk-id.h                         |   7 -
 drivers/clk/tegra/clk-tegra-pmc.c                  | 122 -------
 drivers/clk/tegra/clk-tegra114.c                   |  11 -
 drivers/clk/tegra/clk-tegra124.c                   |  27 +-
 drivers/clk/tegra/clk-tegra20.c                    |   4 -
 drivers/clk/tegra/clk-tegra210.c                   |  11 -
 drivers/clk/tegra/clk-tegra30.c                    |  12 -
 drivers/clk/tegra/clk.h                            |   1 -
 drivers/soc/tegra/pmc.c                            | 379 +++++++++++++++++++++
 include/dt-bindings/clock/tegra114-car.h           |  14 +-
 include/dt-bindings/clock/tegra124-car-common.h    |  14 +-
 include/dt-bindings/clock/tegra20-car.h            |   2 +-
 include/dt-bindings/clock/tegra210-car.h           |  14 +-
 include/dt-bindings/clock/tegra30-car.h            |  14 +-
 include/dt-bindings/soc/tegra-pmc.h                |  19 ++
 27 files changed, 501 insertions(+), 226 deletions(-)
 delete mode 100644 drivers/clk/tegra/clk-tegra-pmc.c
 create mode 100644 include/dt-bindings/soc/tegra-pmc.h

-- 
2.7.4

