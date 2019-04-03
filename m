Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E583C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EC42084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfDCOLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:11:40 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54219 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCOLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:11:39 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5095560007;
        Wed,  3 Apr 2019 14:11:36 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 00/12] clocksource: improve Atmel TCB timer driver
Date:   Wed,  3 Apr 2019 16:11:08 +0200
Message-Id: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
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

The plan is to get those changes upstream as soon as possible as they
arre fixing real issues that people are facing. There are further
changes needed on the clocksource driver to try to stop wasting a TCB
channel.
the PWM TCB driver will also be changed to actually used the reviewed
binding and this will allow to get rif of atmel_tclib.

Alexandre Belloni (12):
  ARM: at91: move SoC specific definitions to SoC folder
  misc: atmel_tclib: drop AVR32 support
  misc: atmel_tclib: move definitions to header file
  clocksource/drivers/tcb_clksrc: stop depending on atmel_tclib
  clocksource/drivers/tcb_clksrc: Use tcb as sched_clock
  ARM: at91: Implement clocksource selection
  clocksource/drivers/tcb_clksrc: move Kconfig option
  clocksource/drivers/timer-atmel-pit: rework Kconfig option
  clocksource/drivers/tcb_clksrc: Rename the file for consistency
  ARM: configs: at91: unselect PIT
  misc: atmel_tclib: do not probe already used TCBs
  clocksource/drivers/timer-atmel-tcb: Use ARRAY_SIZE instead of  
    hardcoded size

 arch/arm/configs/at91_dt_defconfig            |   1 +
 arch/arm/configs/sama5_defconfig              |   1 +
 arch/arm/mach-at91/Kconfig                    |  23 ++++
 drivers/clocksource/Kconfig                   |  12 +-
 drivers/clocksource/Makefile                  |   2 +-
 .../{tcb_clksrc.c => timer-atmel-tcb.c}       | 123 ++++++++++++------
 drivers/misc/Kconfig                          |  24 ----
 drivers/misc/atmel_tclib.c                    |  37 +-----
 drivers/pwm/pwm-atmel-tcb.c                   |   2 +-
 .../atmel_tc.h => soc/at91/atmel_tcb.h}       |  25 +++-
 10 files changed, 146 insertions(+), 104 deletions(-)
 rename drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} (81%)
 rename include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} (95%)

-- 
2.20.1

