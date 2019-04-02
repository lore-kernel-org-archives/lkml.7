Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F34C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC9B2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfDBMvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:51:08 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43621 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfDBMvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:51:08 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A541820017;
        Tue,  2 Apr 2019 12:51:05 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 0/7] clk: at91: add sam9x60 pmc clock support
Date:   Tue,  2 Apr 2019 14:50:49 +0200
Message-Id: <20190402125056.21509-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for the sam9x60 clocks handled by the PMC.

The first four patches are preparatory patches to handle register layout
and offset differences. Then, a driver for the new interface for PLLs is
added and the final patch is the driver for the sam9x60 PMC.

This supersedes
https://patchwork.kernel.org/project/linux-clk/list/?series=82811 and
https://patchwork.kernel.org/project/linux-clk/list/?series=100115

changes in v2:
 - rebased on v5.1-rc1
 - changed the PLL_ACR handling to conform to the datasheet errata

changes in v3:
 - remove unrelated patches

Alexandre Belloni (7):
  clk: at91: allow configuring peripheral PCR layout
  clk: at91: allow configuring generated PCR layout
  clk: at91: usb: Add sam9x60 support
  clk: at91: master: Add sam9x60 support
  clk: at91: add sam9x60 PLL driver
  dt-bindings: clk: at91: add bindings for SAM9X60 pmc
  clk: at91: add sam9x60 pmc driver

 .../devicetree/bindings/clock/at91-clock.txt  |   3 +-
 drivers/clk/at91/Makefile                     |   2 +
 drivers/clk/at91/at91sam9x5.c                 |   9 +
 drivers/clk/at91/clk-generated.c              |  48 +--
 drivers/clk/at91/clk-master.c                 |   8 +-
 drivers/clk/at91/clk-peripheral.c             |  46 +--
 drivers/clk/at91/clk-sam9x60-pll.c            | 330 ++++++++++++++++++
 drivers/clk/at91/clk-usb.c                    |  33 +-
 drivers/clk/at91/dt-compat.c                  |  12 +-
 drivers/clk/at91/pmc.h                        |  23 ++
 drivers/clk/at91/sam9x60.c                    | 307 ++++++++++++++++
 drivers/clk/at91/sama5d2.c                    |  10 +
 drivers/clk/at91/sama5d4.c                    |   8 +
 include/linux/clk/at91_pmc.h                  |  12 +-
 14 files changed, 786 insertions(+), 65 deletions(-)
 create mode 100644 drivers/clk/at91/clk-sam9x60-pll.c
 create mode 100644 drivers/clk/at91/sam9x60.c

-- 
2.20.1

