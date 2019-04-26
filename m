Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC68DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E5D20869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfDZVr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:47:28 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47617 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfDZVr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:47:27 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 38D3AE0005;
        Fri, 26 Apr 2019 21:47:24 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Romain Izard <romain.izard.pro@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 0/9] clocksource: improve Atmel TCB timer driver
Date:   Fri, 26 Apr 2019 23:47:09 +0200
Message-Id: <20190426214718.13470-1-alexandre.belloni@bootlin.com>
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

Changes in v3:
 - collected ack from GKH
 - return -EBUSY instead of 0 when the TCB is already used

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

