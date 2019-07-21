Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B5BC76196
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8712420823
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HyW8NdF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfGUTlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 15:41:01 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12456 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGUTk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 15:40:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d34bfc30000>; Sun, 21 Jul 2019 12:40:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 21 Jul 2019 12:40:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 21 Jul 2019 12:40:55 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 21 Jul
 2019 19:40:50 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 21 Jul
 2019 19:40:50 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 21 Jul 2019 19:40:50 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.164.85]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d34bfc00000>; Sun, 21 Jul 2019 12:40:50 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>, <skomatineni@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>
Subject: [PATCH V6 00/21] SC7 entry and exit support for Tegra210
Date:   Sun, 21 Jul 2019 12:40:39 -0700
Message-ID: <1563738060-30213-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563738056; bh=MfIKsreVhJ1u3mpmTwqU/Oh0iS/9VlKOiJ8ud8kUytU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=HyW8NdF0WtstbL8EFgZgL9fspTh2v7sMqQYsOhVIQ0nRzAKKpZFELYSIspVu5xn3o
         hjUEBIMwiuHVMjPERnjLFOPtFhvWImdrFJRXtzIZ8l5lUjKYUl8RN3RNNBNTRwYMiQ
         XqvVSvUeJS3gNMr6iSo8KXVgh1KN2IDgzsmwxt2gVWO9CrffxvqBSi63FRSp3UAhX/
         VcU9R8u5hwQRErMCxOtbiLgGxzw3bo/7ikpYfVLMjFFTjN4oCWPwO2Ys6h6eEc42tQ
         QAV3juCG7QyhxhFD5V6N6p3goNHmcjALoMa5V4vU+QdEdENmFfkVG0cu3aB3sDrTB8
         WlRVjvHQX6koQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series includes Tegra210 deepsleep support with RTC alarm
wake event.

This series also includes save and restore of PLLs, clocks, OSC contexts
for deepsleep exit to normal operation.

This patch series doesn't support 100% suspend/resume to allow fully
functional state upon resume and we are working on some more drivers suspend
and resume implementations.

[V6]: Changes between V5 & V6 are
	- V5 feedback fixes
	- DFLL suspend and resume moved to DFLL clock driver
	- Add suspend and resume support for CPUFreq driver to explicitly
	  switch source to safe source of PLLP and disable DFLL clock.
	- Fix to super clock driver to enable PLLP branch to CPU before
	  source switch to PLLP.
	- Added save and restore support for super clock driver.

[V5]: Changes between V4 & V5 are
	- V4 feedback fixes

[V4]: Changes between V3 & V4 are
	- V3 feedback fixes
	- Removed park bits clear for EMMC pads in pinctrl-tegra driver
	  function tegra_pinctrl_clear_parked_bits as based on V3 feedback
	  parked_bit is updated to parked_bitmask to use with DRV_PINGROUP
	  as well and thierry posted patch series for this.
	- Implemented all peripheral clocks save and restore through their
	  corresponding clk_ops save_context and restore_context and removed
	  all direct registers store and restore in clk-tegra210 driver.
	- Created separate patch for fence_delay update during PLLU init based
	  on V3 feedback.
	- Added more comments in tegra210_clk_resume regarding dfll restore
	  sequence and its dependency on peripheral clocks restore.

[V3]: Changes between V2 & V3 are
	- V2 feedback fixes
	- GPIO restore should happen prior to Pinctrl restore to prevent
	  glitch on GPIO lines. So using resume_noirq for gpio tegra to allow
	  gpio resume prior to pinctrl resume.
	- Implemented save_context and restore_context callbacks for clock
	  plls, pll outs and dividers in corresponding drivers.
	  Note: Peripheral clocks and clock enable and reset need to be in
	  Tegra210 clock suspend/resume as they need to be in proper sequence
	  w.r.t DFLL resume for restoring CPU clock.
	- Removed gpio-tegra changes for hierarchical support to have PMC as
	  parent to GPIOs for GPIO wake event support. Thierry is working on
	  gpiolib for some cleanup before adding hierarchical support. So
	  holding on to GPIO wake support for now.

[V2] : V1 feedback fixes
	Patch 0002: This version still using syscore. Thierry suggest not to
	use syscore and waiting on suggestion from Linux Walleij for any better
	way of storing current state of pins before suspend entry and restoring
	them on resume at very early stage. So left this the same way as V1 and
	will address once I get more feedback on this.
	Also need to findout and implement proper way of forcing resume order
	between pinctrl and gpio driver.

[V1]:	Tegra210 SC7 entry and exit thru RTC wake and Power button GPIO wake
	using hierarchical IRQ with PMC as parent to GPIO.


Sowjanya Komatineni (21):
  irqchip: tegra: Do not disable COP IRQ during suspend
  pinctrl: tegra: Add suspend and resume support
  pinctrl: tegra210: Add Tegra210 pinctrl pm ops
  clk: tegra: Save and restore divider rate
  clk: tegra: pllout: Save and restore pllout context
  clk: tegra: pll: Save and restore pll context
  clk: tegra: Support for OSC context save and restore
  clk: tegra: clk-periph: Add save and restore support
  clk: tegra: clk-super: Fix to enable PLLP branches to CPU
  clk: tegra: clk-super: Add save and restore support
  clk: tegra: clk-dfll: Add suspend and resume support
  cpufreq: tegra124: Add suspend and resume support
  clk: tegra210: Use fence_udelay during PLLU init
  clk: tegra210: Add suspend and resume support
  soc/tegra: pmc: Allow to support more tegras wake
  soc/tegra: pmc: Add pmc wake support for tegra210
  arm64: tegra: Enable wake from deep sleep on RTC alarm.
  soc/tegra: pmc: Configure core power request polarity
  soc/tegra: pmc: Configure deep sleep control settings
  arm64: dts: tegra210-p2180: Jetson TX1 SC7 timings
  arm64: dts: tegra210-p3450: Jetson nano SC7 timings

 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |   7 +
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts |   7 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   5 +-
 drivers/clk/tegra/clk-dfll.c                       |  44 +++++++
 drivers/clk/tegra/clk-dfll.h                       |   2 +
 drivers/clk/tegra/clk-divider.c                    |  23 ++++
 drivers/clk/tegra/clk-periph-fixed.c               |  33 +++++
 drivers/clk/tegra/clk-periph-gate.c                |  34 +++++
 drivers/clk/tegra/clk-periph.c                     |  43 +++++++
 drivers/clk/tegra/clk-pll-out.c                    |  28 ++++
 drivers/clk/tegra/clk-pll.c                        | 121 +++++++++++++-----
 drivers/clk/tegra/clk-sdmmc-mux.c                  |  30 +++++
 drivers/clk/tegra/clk-super.c                      |  51 ++++++++
 drivers/clk/tegra/clk-tegra-fixed.c                |  15 +++
 drivers/clk/tegra/clk-tegra-super-gen4.c           |   4 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |   1 +
 drivers/clk/tegra/clk-tegra210.c                   |  81 ++++++++++--
 drivers/clk/tegra/clk.c                            |  14 ++
 drivers/clk/tegra/clk.h                            |  36 +++++-
 drivers/cpufreq/tegra124-cpufreq.c                 |  46 +++++++
 drivers/irqchip/irq-tegra.c                        |  20 ++-
 drivers/pinctrl/tegra/pinctrl-tegra.c              |  59 +++++++++
 drivers/pinctrl/tegra/pinctrl-tegra.h              |   3 +
 drivers/pinctrl/tegra/pinctrl-tegra210.c           |   1 +
 drivers/soc/tegra/pmc.c                            | 142 ++++++++++++++++++++-
 25 files changed, 798 insertions(+), 52 deletions(-)

-- 
2.7.4

