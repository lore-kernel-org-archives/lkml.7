Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0339C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68ACA22362
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKSCTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 21:19:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:57968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726952AbfKSCTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:19:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C2BAAC6F;
        Tue, 19 Nov 2019 02:19:22 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Aleix Roca Nonell <kernelrocks@gmail.com>,
        James Tai <james.tai@realtek.com>
Subject: [PATCH v4 0/8] ARM: Realtek RTD1195/RTD1295/RTD1395 IRQ mux
Date:   Tue, 19 Nov 2019 03:19:09 +0100
Message-Id: <20191119021917.15917-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds two IRQ muxes for the Realtek RTD1195, RTD1295 and RTD1395
SoC families.

The implementation is based on register offsets seen in the vendor DT,
split up into two separate nodes, as well as code from QNAP's rtk119x and
Synology's RTD1293/96 GPL code dumps.

v3 does various cleanups, renames variables, reworks unmask vs. enable/disable
and adds an isr/scpu_int_en map as well as full RTD1195 support.

More experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

v3 -> v4:
* Drop no-op .irq_set_affinity callback (Thomas)
* Clear all interrupts (James)
* Updated SPDX-License-identifier
* Use tabular formatting (Thomas)
* Adopt different braces style (Thomas)
* Use raw_spinlock_t (Thomas)
* Shortened callback name (Thomas)
* Fixed of_iomap() error handling
* Don't mask unmapped NMIs
* Cache SCPU_INT_EN (Thomas)
* Renamed binding and source files
* Dropped UART1/UART2 TO interrupts
* Expanded commit messages
* Added RTD1395 patches

v2 -> v3:
* Rebased, adding nodes to rtd129x.dtsi instead of rtd1295.dtsi
* Adopted {readl,writel}_relaxed() (Marc)
* Adopted spin_lock_irqsave() (Marc)
* Implemented RTD1195
* Implemented mapping for non-linear bits such as i2c3

v1 -> v2:
* Rebased, avoiding dependency on reset series for DT nodes
* Don't forward set_affinity to GIC (Marc)
* Added more spinlocks (Marc)
* Code cleanups
* Investigated quirk
* Fixed spinlock initialization (Andrew)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Aleix Roca Nonell <kernelrocks@gmail.com>
Cc: James Tai <james.tai@realtek.com>

Andreas Färber (8):
  dt-bindings: interrupt-controller: Add Realtek RTD1195/RTD1295 mux
  irqchip: Add Realtek RTD1295 mux driver
  arm64: dts: realtek: rtd129x: Add irq muxes and UART interrupts
  irqchip: rtd1195-mux: Add RTD1195 definitions
  ARM: dts: rtd1195: Add irq muxes and UART interrupts
  dt-bindings: interrupt-controller: rtd1195-mux: Add RTD1395
  irqchip: rtd1195-mux: Add RTD1395 definitions
  arm64: dts: realtek: rtd139x: Add irq muxes and UART interrupts

 .../interrupt-controller/realtek,rtd1195-mux.yaml  |  55 +++
 arch/arm/boot/dts/rtd1195.dtsi                     |  20 +
 arch/arm64/boot/dts/realtek/rtd129x.dtsi           |  22 +
 arch/arm64/boot/dts/realtek/rtd139x.dtsi           |  22 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-rtd1195-mux.c                  | 463 +++++++++++++++++++++
 6 files changed, 583 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1195-mux.yaml
 create mode 100644 drivers/irqchip/irq-rtd1195-mux.c

-- 
2.16.4

