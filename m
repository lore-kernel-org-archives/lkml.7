Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7092CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF2B20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfDOPJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:09:12 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:58013 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOPJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:09:11 -0400
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 0B3D3240015;
        Mon, 15 Apr 2019 15:09:07 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 0/9] clocksource: improve Atmel TCB timer driver
Date:   Mon, 15 Apr 2019 17:08:47 +0200
Message-Id: <20190415150856.9384-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series immproves the Atmel TCB clocksource driver to address the
most urgent shortcomings:
 - the current tcb_clksrc driver is probed too late to be able to be used at
   boot and we now have SoCs that don't have a PIT. They currently are not able
   to boot an upstream kernel.
 - using the PIT doesn't work well with preempt-rt because its interrupt is
   shared (in particular with the UART) and their interrupt flags are
   incompatible). This also happen with the threadedirq command line
   switch.
 - there is currently no high resolution sched_clock.

The plan is to get those changes upstream as soon as possible as they are fixing
real issues that people are facing. There are further changes needed on the
clocksource driver to try to stop wasting a TCB channel.
The PWM TCB driver will also be changed to actually use the reviewed binding
and this will allow to get rid of atmel_tclib.

Changes in v2:
 - collected acks from Thierry and Arnd
 - dropped most of the atmel_tclib changes that coud be separated.
 - added a patch from kbuild
 - dropped the patch removing the PIT from the defconfig
 - moved the atmel_tcb.h inclusion in drivers/pwm/pwm-atmel-tcb.c as requested
   by Thierry
 - stopped using atmel_tcb_config
 - reworked the irq number parsing to only care for channel 2

Alexandre Belloni (8):
  ARM: at91: move SoC specific definitions to SoC folder
  clocksource/drivers/tcb_clksrc: stop depending on atmel_tclib
  clocksource/drivers/tcb_clksrc: Use tcb as sched_clock
  ARM: at91: Implement clocksource selection
  clocksource/drivers/tcb_clksrc: move Kconfig option
  clocksource/drivers/timer-atmel-pit: rework Kconfig option
  clocksource/drivers/tcb_clksrc: Rename the file for consistency
  misc: atmel_tclib: do not probe already used TCBs

kbuild test robot (1):
  clocksource/drivers/timer-atmel-tcb: tc_clksrc_suspend() can be static

 arch/arm/mach-at91/Kconfig                    |  23 ++++
 drivers/clocksource/Kconfig                   |  12 +-
 drivers/clocksource/Makefile                  |   2 +-
 .../{tcb_clksrc.c => timer-atmel-tcb.c}       | 130 ++++++++++++------
 drivers/misc/Kconfig                          |  24 ----
 drivers/misc/atmel_tclib.c                    |   5 +-
 drivers/pwm/pwm-atmel-tcb.c                   |   2 +-
 .../atmel_tc.h => soc/at91/atmel_tcb.h}       |   4 +-
 8 files changed, 129 insertions(+), 73 deletions(-)
 rename drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} (79%)
 rename include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} (99%)

-- 
2.20.1

