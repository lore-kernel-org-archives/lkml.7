Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460AAC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26923275CB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfFCRJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:09:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38304 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728660AbfFCRJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:09:34 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hXqSd-0004ZW-Vz; Mon, 03 Jun 2019 19:09:28 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     broonie@kernel.org, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        tony.xie@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v8 RESEND 0/5] support a new rk80x pmic-variants (rk817 and rk809)
Date:   Mon,  3 Jun 2019 19:08:55 +0200
Message-Id: <20190603170900.5195-1-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've picked up and rebased Tony's patch-series for rk809 and rk817.
From the last iteration it looks like the regulator-portion did
fall through the cracks, the other patches seem to be sufficiently
reviewed/acked.

The regulator-patch could either just be picked alone to the regulator-
tree or with an Ack go through the mfd tree with the other patches.


Original cover-letter + changelog follows:

Most of functions and registers of the rk817 and rk808 are the same,
so they can share allmost all codes.

Their specifications are as follows:
  1) The RK809 and RK809 consist of 5 DCDCs, 9 LDOs and have the same
registers
     for these components except dcdc5.
  2) The dcdc5 is a boost dcdc for RK817 and is a buck for RK809.
  3) The RK817 has one switch but The Rk809 has two.

Changes in V2:
1. initialize the pm_pwroff_fn to NULL.
2. use EXPORT_SYMBOL_GPL to export pm_power_off_prepare.
3. change patch 2/3/4/5 subjects.

Changes in V3
1. change patch 4 subjects
2. replace pr_ with dev_ for printing in patch 2
3. modify switch1 and switch2 configs in patch 2
4. explain gpio information for rk809 and rk817 in patch 4

Changes in V4:
1. modify some codes for patch 2 and patch 5 according to comments 
2. add reviewer mail lists for patch 3 and 4

Changes in V5:
modify some codes for patch 1 according to reveiw comments for v3.
 1) remove the pm_power_off_prepare() and replace with shutdown
call-back from syscore
 2) move the macro REGMAP_IRQ_M into the regmap.h and rename it
REGMAP_IRQ_LINE
 3) make some dev_warn() log clear

Changes in V6:
modify some codes according to reveiw comments for v5.

Changes in V7:
modify some codes for patch 2 according to reveiw comments.

Changes in V8:
- [Heiko] rebase onto current mainline
- [Heiko] add some tags from Lee so that he can keep track of what
  he reviewed

Changes in V8 RESEND:
- none, just needs a regulator Ack


Tony Xie (5):
  mfd: rk808: Add RK817 and RK809 support
  regulator: rk808: add RK809 and RK817 support.
  dt-bindings: mfd: rk808: Add binding information for RK809 and RK817.
  rtc: rk808: add RK809 and RK817 support.
  clk: RK808: add RK809 and RK817 support.

 .../devicetree/bindings/mfd/rk808.txt         |  44 ++
 drivers/clk/Kconfig                           |   9 +-
 drivers/clk/clk-rk808.c                       |  64 +-
 drivers/mfd/Kconfig                           |   6 +-
 drivers/mfd/rk808.c                           | 192 ++++-
 drivers/regulator/Kconfig                     |   4 +-
 drivers/regulator/rk808-regulator.c           | 657 +++++++++++++++++-
 drivers/rtc/Kconfig                           |   4 +-
 drivers/rtc/rtc-rk808.c                       |  68 +-
 include/linux/mfd/rk808.h                     | 175 +++++
 10 files changed, 1165 insertions(+), 58 deletions(-)

-- 
2.20.1

