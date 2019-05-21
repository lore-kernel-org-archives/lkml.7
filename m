Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559F5C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2979E21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZlTswiaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfEUXbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 19:31:19 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8288 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEUXbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 19:31:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce48a450000>; Tue, 21 May 2019 16:31:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 16:31:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 21 May 2019 16:31:17 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 23:31:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 21 May 2019 23:31:17 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.174]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce48a450000>; Tue, 21 May 2019 16:31:17 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <jckuo@nvidia.com>, <talho@nvidia.com>, <josephl@nvidia.com>,
        <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 00/12] LP0 entry and exit support for Tegra210
Date:   Tue, 21 May 2019 16:31:11 -0700
Message-ID: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558481477; bh=XkrgQWPSdSys4sY6++u5MjM3R5kQ9ZrMn6kdxayE2Cw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=ZlTswiaWlchA1i+TZL+RyOFISCvqevPVyY+YP/NgZ4BU2XsMNiV922fMJFlGhfN6+
         29AHlT1Q0aGw3L0vXbEq9PhO21sbUx5Ck2Nx9cYbSLp4CPQViSrKmBZjGy6Y/WN5yB
         Rt6xIDfvI4mZ1vvLpRc7trV/fbXQz8CHL/4+bCK8y9HlZYRDEad8SkPZIPytBfliUq
         zjEwOMZgDeqiz4kjR+8Z3GwDAqwpl2BRov/WNfIAuFwMT13+x3dJsfaD42Q40VuLyP
         IW6NrXOePSILRUaDwxzAPvUrkZWrPT1Gf/1TwFkIAHWkjtBfKze00U39i7LM9ir2Nl
         vQs7Nk7Chl5Aw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series includes Tegra210 deepsleep or LP0 support with
deep sleep exit through RTC alarm wake and power button wake events.

This series also includes save and restore of PLLs, clocks, OSC contexts
for basic LP0 exit.

This patch series is doesn't support for 100% suspend/resume to fully
functional state and we are working on some more drivers suspend and
resume implementations.

Sowjanya Komatineni (12):
  irqchip: tegra: do not disable COP IRQ during suspend
  pinctrl: tegra: add suspend and resume support
  clk: tegra: save and restore PLLs state for system
  clk: tegra: add support for peripheral clock suspend and resume
  clk: tegra: add support for OSC clock resume
  clk: tegra: add suspend resume support for DFLL clock
  clk: tegra: support for Tegra210 clocks suspend-resume
  soc/tegra: pmc: allow support for more tegra wake models
  soc/tegra: pmc: add pmc wake support for tegra210
  gpio: tegra: implement wake event support for Tegra210 and prior GPIO
  soc/tegra: pmc: configure tegra deep sleep control settings
  arm64: tegra: enable wake from deep sleep on RTC alarm.

 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi |   7 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi       |   5 +-
 drivers/clk/tegra/clk-dfll.c                   |  82 ++++++
 drivers/clk/tegra/clk-dfll.h                   |   2 +
 drivers/clk/tegra/clk-divider.c                |  19 ++
 drivers/clk/tegra/clk-pll-out.c                |  25 ++
 drivers/clk/tegra/clk-pll.c                    | 220 ++++++++++++--
 drivers/clk/tegra/clk-tegra-fixed.c            |  15 +
 drivers/clk/tegra/clk-tegra210.c               | 382 +++++++++++++++++++++++++
 drivers/clk/tegra/clk.c                        |  74 ++++-
 drivers/clk/tegra/clk.h                        |  18 ++
 drivers/gpio/gpio-tegra.c                      | 109 ++++++-
 drivers/irqchip/irq-tegra.c                    |  10 +-
 drivers/pinctrl/tegra/pinctrl-tegra.c          |  68 ++++-
 drivers/pinctrl/tegra/pinctrl-tegra.h          |   3 +
 drivers/pinctrl/tegra/pinctrl-tegra114.c       |   1 +
 drivers/pinctrl/tegra/pinctrl-tegra124.c       |   1 +
 drivers/pinctrl/tegra/pinctrl-tegra20.c        |   1 +
 drivers/pinctrl/tegra/pinctrl-tegra210.c       |   1 +
 drivers/pinctrl/tegra/pinctrl-tegra30.c        |   1 +
 drivers/soc/tegra/pmc.c                        | 159 +++++++++-
 21 files changed, 1167 insertions(+), 36 deletions(-)

-- 
2.7.4

