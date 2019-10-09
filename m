Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2ADECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9485E218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbfJIWkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:40:12 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:51577 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730999AbfJIWkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:40:12 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C1DADC0006;
        Wed,  9 Oct 2019 22:40:09 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/8] clocksource/drivers/timer-atmel-tcb: add sama5d2 support
Date:   Thu, 10 Oct 2019 00:39:58 +0200
Message-Id: <20191009224006.5021-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series mainly adds sama5d2 support where we need to avoid using
clock index 0 because that clock is never enabled by the driver.

There is also a rework of the 32khz clock handling so it is not used for
clockevents on 32 bit counter because the increased rate improves the
resolution and doesn't have any drawback with that counter width. This
replaces a patch that has been carried in the linux-rt tree for a while.

Alexandre Belloni (8):
  dt-bindings: mfd: atmel-tcb: convert bindings to json-schema
  dt-bindings: mfd: atmel,at91rm9200-tcb: add sama5d2 compatible
  ARM: dts: at91: sama5d2: add TCB GCLK
  clocksource/drivers/timer-atmel-tcb: rework 32khz clock selection
  clocksource/drivers/timer-atmel-tcb: fill tcb_config
  clocksource/drivers/timer-atmel-tcb: stop using the 32kHz for
    clockevents
  clocksource/drivers/timer-atmel-tcb: allow selecting first divider
  clocksource/drivers/timer-atmel-tcb: add sama5d2 support

 .../bindings/mfd/atmel,at91rm9200-tcb.yaml    | 113 ++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-tcb.txt     |  56 ---------
 arch/arm/boot/dts/sama5d2.dtsi                |  12 +-
 drivers/clocksource/timer-atmel-tcb.c         | 101 +++++++++-------
 include/soc/at91/atmel_tcb.h                  |   1 +
 5 files changed, 178 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,at91rm9200-tcb.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt

-- 
2.21.0

