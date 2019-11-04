Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A59ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADD620659
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfKDPKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:10:42 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:5403 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbfKDPKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:10:41 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: D2HUH/WJuuYjGhJihYzCYYxMHpzl5Liz525GSPPeLttmySP6QiZgo92lYn0CvjufvtuuzSorTS
 3V7pEW+GilL97puxXRQzMOGcWg4e93ZCLmQarOqJ78O/u2rYPrx+URt6b1cO9AE9KgQGIqcPrc
 gJyxRQYe8xJEMT9usajxPeuxyle4K+tj3VKEkgrT3vPL0Nfa1/JhnP0IZFL2KFkpstgagvWkrs
 9BEBMg2181B2wQFNBIwrFobSasOXnVjfhxPoF3XFdfx7/aWpk1BCGpby5hMHGyXwuq3UBucmv8
 Opc=
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="55584277"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Nov 2019 08:10:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Nov 2019 08:10:21 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Mon, 4 Nov 2019 08:10:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/2] add Microchip PIT64B timer
Date:   Mon, 4 Nov 2019 17:10:02 +0200
Message-ID: <1572880204-4514-1-git-send-email-claudiu.beznea@microchip.com>
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

Changes in v2:
- remove clock-frequency DT binding and hardcoded it in the driver
- initialize best_pres variable in mchp_pit64b_pres_prepare()
- remove MCHP_PIT64B_DEF_FREQ 
- get rid of patches 3-5 from v1 [1] since there is no entry in MAINTAINERS file
  for this entry. It was removed in commit
  44015a8181a5 ("MAINTAINERS: at91: remove the TC entry")

[1] https://lore.kernel.org/lkml/1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com/

Claudiu Beznea (2):
  dt-bindings: arm: atmel: add bindings for PIT64B
  clocksource/drivers/timer-microchip-pit64b: add Microchip PIT64B
    support

 .../devicetree/bindings/arm/atmel-sysregs.txt      |   6 +
 drivers/clocksource/Kconfig                        |   6 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-microchip-pit64b.c       | 462 +++++++++++++++++++++
 4 files changed, 475 insertions(+)
 create mode 100644 drivers/clocksource/timer-microchip-pit64b.c

-- 
2.7.4

