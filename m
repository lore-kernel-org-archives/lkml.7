Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5776C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02C320883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbfDBMkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:40:22 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:38589 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDBMkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:40:22 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DD120240004;
        Tue,  2 Apr 2019 12:40:18 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 00/10] 
Date:   Tue,  2 Apr 2019 14:40:06 +0200
Message-Id: <20190402124016.20558-1-alexandre.belloni@bootlin.com>
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

changes in v2:
 - rebased on v5.1-rc1
 - changed the PLL_ACR handling to conform to the datasheet errata

Alexandre Belloni (7):
  clk: at91: allow configuring peripheral PCR layout
  clk: at91: allow configuring generated PCR layout
  clk: at91: usb: Add sam9x60 support
  clk: at91: master: Add sam9x60 support
  clk: at91: add sam9x60 PLL driver
  dt-bindings: clk: at91: add bindings for SAM9X60 pmc
  clk: at91: add sam9x60 pmc driver

Claudiu Beznea (3):
  clk: at91: sckc: add support to specify registers bit offsets
  clk: at91: sckc: add support for SAM9X60
  dt-bindings: clk: at91: add bindings for SAM9X60's slow clock
    controller

 .../devicetree/bindings/clock/at91-clock.txt  |   6 +-
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
 drivers/clk/at91/sckc.c                       | 142 ++++++--
 include/linux/clk/at91_pmc.h                  |  12 +-
 15 files changed, 895 insertions(+), 101 deletions(-)
 create mode 100644 drivers/clk/at91/clk-sam9x60-pll.c
 create mode 100644 drivers/clk/at91/sam9x60.c

-- 
2.20.1

