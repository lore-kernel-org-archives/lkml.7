Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9484AC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD85205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfLDOmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:42:43 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:56378 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfLDOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:42:43 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: +9RXOtXOFcqc0C2PEUn2bWakLYQg1Jwsi+X+/C2WP04OAGGUfbHMDMnlycCrtVULAXMDo/gjBW
 SpRrzKLB8HL0LLnbj+Rh6rRfkKl2BAMAR0M6bvp+AXblBClY1HdNXAJfGImjxa/1CvK0Wf4MNu
 PqrFkq2u5yZc/bB+ZVxyJL1RcqsKWW3dhBB+zKRrkoGwaYkeyqkAbtGBpqknN9v8mWOQqgZ0S9
 kith57QQe5XSFp3h5OJReHKiQ2notWZIgJpaQIzGEjPm0hh9HwsFxfuKavT4NKqio3svBaRniA
 rho=
X-IronPort-AV: E=Sophos;i="5.69,277,1571727600"; 
   d="scan'208";a="56592278"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Dec 2019 07:42:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 4 Dec 2019 07:42:41 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 4 Dec 2019 07:42:38 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/2] add Microchip PIT64B timer
Date:   Wed, 4 Dec 2019 16:42:27 +0200
Message-ID: <1575470549-702-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds driver for Microchip PIT64B timer.
Timer could be used in continuous or oneshot mode. It has 2x32 bit registers
to emulate a 64 bit timer. The timer's period could be configured via LSB_PR
and MSB_PR registers. The current timer's value could be checked via TLSB and
TMSB registers. When (TMSB << 32) | TLSB value reach the (MSB_PR << 32) | LSB_PR
interrupt is raised. If in contiuous mode the TLSB and TMSB resets and restart
counting.

This drivers uses PIT64B capabilities for clocksource and clockevent.
The first requested PIT64B timer is used for clockevent. The second one is used
for clocksource. Individual PIT64B hardware resources were used for clocksource
and clockevent to be able to support high resolution timers with this PIT64B
implementation.

Thank you,
Claudiu Beznea

Changes in v3:
- rework data structures:
	- timer related data structure is called now mchp_pit64b_timer embedding
	  base iomem, clocks, interrupt, prescaler value
	- introduced struct mchp_pit64b_clksrc and struct mchp_pit64b_clkevt
	  instead of mchp_pit64b_clksrc_data and mchp_pit64b_clkevt_data
	- use container_of() to retrieve mchp_pit64b_timer objects on
	  clocksource/clockevent specific APIs
	- document data structures
- use raw_local_irq_save()/raw_local_irq_restore() when reading
  MCHP_PIT64B_TLSBR and MCHP_PIT64B_TMSBR in mchp_pit64b_get_period()
- get rid of mchp_pit64b_read(), mchp_pit64b_write() and use instead
  readl_relaxed(), writel_relaxed()
- get rid of mchp_pit64b_set_period() and inlined its instructions in
  mchp_pit64b_reset()
- mchp_pit64b_reset() gets now as arguments an object of type
  struct mchp_pit64b_timer, cycles to program and mode
- remove static struct clocksource mchp_pit64b_clksrc and
  static struct clock_event_device mchp_pit64b_clkevt and instead allocate
  and fill them in mchp_pit64b_dt_init_clksrc() and
  mchp_pit64b_dt_init_clkevt()
- call mchp_pit64b_reset() in mchp_pit64b_clkevt_set_next_event() and
  program clockevent timer with SMOD=0; if SMOD=1 the timer's period could
  be reprogrammed also if writing TLSB, TMSB if it is running. In cases
  were its period expired START bit still has to be set in control register.
  In case the programming sequence is like in v2, with SMOD=1:
	- program MSB_PR
	- program LSB_PR
	- program START bit in control register
  for short programmed periods we may start the timer twice with this
  programming sequence, 1st time after LSB_PR is updated (and due to SMOD=1),
  2nd time after programming START bit in control register and in case
  programmed period already expire
- simplify mchp_pit64b_interrupt() by just reading ISR register, to clear the
  received interrupt, and just call irq_data->clkevt->event_handler(irq_data->clkevt);
- in mchp_pit64b_pres_compute() chose the bigest prescaler in case a good
  one not found
- document mchp_pit64b_pres_prepare() and simplified it a bit
- enforce gclk as mandatory
- introduce mchp_pit64b_timer_init() and mchp_pit64b_timer_cleanup()
- keep the clocksource timer base address in a mchp_pit64b_cs_base variable so
  that it could be used by mchp_pit64b_sched_read_clk()
- rework mchp_pit64b_dt_init() and return -EINVAL in case it was called
  more than two times: one for initialization of clockevent, one for
  initialization of clocksource
- introduce MCHP_PIT64B_MR_ONE_SHOT define
- move the new lines introduced in Makefile and Kconfig at the end of files
- collect Rob's Reviewed-by tag on patch 1/2
- review the commit message of patch 2/2

Changes in v2:
- remove clock-frequency DT binding and hardcoded it in the driver
- initialize best_pres variable in mchp_pit64b_pres_prepare()
- remove MCHP_PIT64B_DEF_FREQ 
- get rid of patches 3-5 from v1 [1] since there is no entry in MAINTAINERS file
  for this entry. It was removed in
  commit 44015a8181a5 ("MAINTAINERS: at91: remove the TC entry")

[1] https://lore.kernel.org/lkml/1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com/

Claudiu Beznea (2):
  dt-bindings: arm: atmel: add bindings for PIT64B
  clocksource/drivers/timer-microchip-pit64b: add Microchip PIT64B
    support

 .../devicetree/bindings/arm/atmel-sysregs.txt      |   6 +
 drivers/clocksource/Kconfig                        |   6 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-microchip-pit64b.c       | 501 +++++++++++++++++++++
 4 files changed, 514 insertions(+)
 create mode 100644 drivers/clocksource/timer-microchip-pit64b.c

-- 
2.7.4

