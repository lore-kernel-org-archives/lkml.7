Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB6DC2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5A6208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfL0JqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 04:46:11 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:21024 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfL0JqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 04:46:11 -0500
Received: from droid15-sz.amlogic.com (10.28.8.25) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Fri, 27 Dec 2019
 17:46:27 +0800
From:   Jian Hu <jian.hu@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 0/5] add Amlogic A1 clock controller driver
Date:   Fri, 27 Dec 2019 17:46:01 +0800
Message-ID: <20191227094606.143637-1-jian.hu@amlogic.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.25]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add support for Amlogic A1 clock driver, the clock includes 
three parts: peripheral clocks, pll clocks, CPU clocks.
sys pll and CPU clocks will be sent in next patch.

Changes since v4 at [5]:
- change yaml GPL
- drop meson-eeclk.c patch, add probe function in each driver
- add CLK_IS_CRITICAL for sys_clk clock, drop the flag for sys_a and sys_b
- add new parm for pll, add protection for rst parm
- drop flag for a1_fixed_pll
- remove the same comment for fclk_div, add "refer to"
- add critical flag for a1_sys_clk
- remove rtc table
- rename a1_dspa_en_dspa and a1_dspb_en_dspb
- remove useless comment

Changes since v3 at [3]:
-fix reparenting orphan failed, it depends on jerome's patch [4]
-fix changelist in v3 about reparenting orphan
-remove the dts patch 

Changes since v2 at [2]:
-add probe function for A1
-seperate the clock driver into two patch
-change some clock flags and ops
-add support for a1 PLL ops
-add A1 clock node
-fix reparenting orphan clock failed, registering xtal_fixpll
 and xtal_hifipll after the provider registration, it is not
 a best way.

Changes since v1 at [1]:
-place A1 config alphabetically
-add actual reason for RO ops, CLK_IS_CRITICAL, CLK_IGNORE_UNUSED
-separate the driver into two driver: peripheral and pll driver
-delete CLK_IGNORE_UNUSED flag for pwm b/c/d/e/f clock, dsp clock
-delete the change in Kconfig.platforms, address to Kevin alone
-remove the useless comments
-modify the meson pll driver to support A1 PLLs

[1] https://lkml.kernel.org/r/1569411888-98116-1-git-send-email-jian.hu@amlogic.com
[2] https://lkml.kernel.org/r/1571382865-41978-1-git-send-email-jian.hu@amlogic.com
[3] https://lkml.kernel.org/r/20191129144605.182774-1-jian.hu@amlogic.com
[4] https://lkml.kernel.org/r/20191203080805.104628-1-jbrunet@baylibre.com
[5] https://lkml.kernel.org/r/20191206074052.15557-1-jian.hu@amlogic.com

Jian Hu (5):
  dt-bindings: clock: meson: add A1 PLL clock controller bindings
  clk: meson: add support for A1 PLL clock ops
  clk: meson: a1: add support for Amlogic A1 PLL clock driver
  dt-bindings: clock: meson: add A1 peripheral clock controller bindings
  clk: meson: a1: add support for Amlogic A1 Peripheral clock driver

 .../bindings/clock/amlogic,a1-clkc.yaml       |   67 +
 .../bindings/clock/amlogic,a1-pll-clkc.yaml   |   54 +
 drivers/clk/meson/Kconfig                     |   18 +
 drivers/clk/meson/Makefile                    |    2 +
 drivers/clk/meson/a1-pll.c                    |  374 +++
 drivers/clk/meson/a1-pll.h                    |   56 +
 drivers/clk/meson/a1.c                        | 2263 +++++++++++++++++
 drivers/clk/meson/a1.h                        |  120 +
 drivers/clk/meson/clk-pll.c                   |   40 +-
 drivers/clk/meson/clk-pll.h                   |    2 +
 include/dt-bindings/clock/a1-clkc.h           |   98 +
 include/dt-bindings/clock/a1-pll-clkc.h       |   16 +
 12 files changed, 3105 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
 create mode 100644 drivers/clk/meson/a1-pll.c
 create mode 100644 drivers/clk/meson/a1-pll.h
 create mode 100644 drivers/clk/meson/a1.c
 create mode 100644 drivers/clk/meson/a1.h
 create mode 100644 include/dt-bindings/clock/a1-clkc.h
 create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h

-- 
2.24.0

