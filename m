Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A63C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D772082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567764489;
	bh=vCJY/JrhI7oFqx9y/d1DwbrICaW/VP2SZmqhCRLJ5NI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SKXlOY5BvdYrlWm1mBevQJOQwmWAyjVZZzK/+6/VabhBMQgdwslEaneBXRyD5tDcT
	 BjdyoMNytwlPIDX8rngp4+JLzsxMZ8TGHFn5tHSwmrXyJ43q3/H/94ivshdFdh5L0z
	 dvZZCdLTogJFtLTu0gWEC9sznFCRrc4o5xrNh2L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbfIFKII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:08:08 -0400
Received: from foss.arm.com ([217.140.110.172]:53976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfIFKII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:08:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC6731570;
        Fri,  6 Sep 2019 03:08:07 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE0A93F59C;
        Fri,  6 Sep 2019 03:08:05 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andres Salomon <dilinger@queued.net>,
        Dexuan Cui <decui@microsoft.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jiaxing Luo <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lili Deng <v-lide@microsoft.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Pavel Machek <pavel@ucw.cz>,
        Stephen Boyd <swboyd@chromium.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 5.4
Date:   Fri,  6 Sep 2019 11:07:59 +0100
Message-Id: <20190906100759.116674-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

This is the bulk of the 5.4 updates from the irqchip department. The
largest items are the new GICv3.1 updates to support new interrupt
ranges and the alloc_fwnode fixes. The rest is a random collection of
new (and old) HW support as well as fixes.

As you'll probably notice, I've started incorporating quilttools in my
flow to generate the Link: tags. Unfortunately, I started as a lot of
things were already queued, so they only appear in the second part. I
plan to use it more consistently in the future.

Please pull,

       M.

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.4

for you to fetch changes up to c9c96e30ecaa0aafa225aa1a5392cb7db17c7a82:

  irqchip/gic-v3-its: Fix LPI release for Multi-MSI devices (2019-09-05 16:03:48 +0100)

----------------------------------------------------------------
irqchip updates for Linux 5.4

- Large GICv3 updates to support new PPI and SPI ranges
- Conver all alloc_fwnode() users to use PAs instead of VAs
- Add support for Marvell's MMP3 irqchip
- Add support for Amlogic Meson SM1
- Various cleanups and fixes

----------------------------------------------------------------
Andres Salomon (1):
      irqchip/mmp: Mask off interrupts from other cores

Dexuan Cui (1):
      irqdomain: Add the missing assignment of domain->fwnode for named fwnode

Jerome Brunet (2):
      dt-bindings: interrupt-controller: New binding for the meson sm1 SoCs
      irqchip/meson-gpio: Add support for meson sm1 SoCs

Lubomir Rintel (4):
      irqchip/mmp: Do not call irq_set_default_host() on DT platforms
      irqchip/mmp: Do not use of_address_to_resource() to get mux regs
      irqchip/mmp: Add missing chained_irq_{enter,exit}()
      irqchip/mmp: Coexist with GIC root IRQ controller

Marc Zyngier (21):
      irqchip/gic-v3: Register the distributor's PA instead of its VA in fwnode
      irqchip/gic-v3-its: Register the ITS' PA instead of its VA in fwnode
      irqchip/gic: Register the distributor's PA instead of its VA in fwnode
      irqchip/gic-v2m: Register the frame's PA instead of its VA in fwnode
      irqchip/ixp4xx: Register the base PA instead of its VA in fwnode
      gpio/ixp4xx: Register the base PA instead of its VA in fwnode
      PCI: hv: Allocate a named fwnode instead of an address-based one
      irqdomain/debugfs: Use PAs to generate fwnode names
      irqchip/gic: Rework gic_configure_irq to take the full ICFGR base
      irqchip/gic-v3: Add INTID range and convertion primitives
      dt-bindings: interrupt-controller: arm,gic-v3: Describe ESPI range support
      irqchip/gic-v3: Add ESPI range support
      irqchip/gic: Prepare for more than 16 PPIs
      irqchip/gic-v3: Dynamically allocate PPI NMI refcounts
      irqchip/gic-v3: Dynamically allocate PPI partition descriptors
      dt-bindings: interrupt-controller: arm,gic-v3: Describe EPPI range support
      irqchip/gic-v3: Add EPPI range support
      irqchip/gic-v3: Warn about inconsistent implementations of extended ranges
      irqchip/gic: Skip DT quirks when evaluating IIDR-based quirks
      irqchip/gic-v3: Add quirks for HIP06/07 invalid GICD_TYPER erratum 161010803
      irqchip/gic-v3-its: Fix LPI release for Multi-MSI devices

Masahiro Yamada (2):
      irqchip: Add include guard to irq-partition-percpu.h
      irqchip/uniphier-aidet: Use devm_platform_ioremap_resource()

Stephen Boyd (1):
      irqchip: Remove dev_err() usage after platform_get_irq()

Zenghui Yu (1):
      irqchip/gic-v3-its: Remove the redundant set_bit for lpi_map

 Documentation/arm64/silicon-errata.rst             |   2 +
 .../amlogic,meson-gpio-intc.txt                    |   1 +
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |   6 +-
 arch/arm/mach-mmp/regs-icu.h                       |   3 +
 drivers/gpio/gpio-ixp4xx.c                         |   2 +-
 drivers/irqchip/irq-gic-common.c                   |  35 +-
 drivers/irqchip/irq-gic-common.h                   |   2 +-
 drivers/irqchip/irq-gic-v2m.c                      |   2 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  13 +-
 drivers/irqchip/irq-gic-v3.c                       | 384 ++++++++++++++++-----
 drivers/irqchip/irq-gic.c                          |  14 +-
 drivers/irqchip/irq-hip04.c                        |   9 +-
 drivers/irqchip/irq-imgpdc.c                       |   8 +-
 drivers/irqchip/irq-ixp4xx.c                       |   2 +-
 drivers/irqchip/irq-keystone.c                     |   4 +-
 drivers/irqchip/irq-meson-gpio.c                   |  52 ++-
 drivers/irqchip/irq-mmp.c                          |  86 ++++-
 drivers/irqchip/irq-uniphier-aidet.c               |   4 +-
 drivers/irqchip/qcom-irq-combiner.c                |   4 +-
 drivers/pci/controller/pci-hyperv.c                |  10 +-
 include/linux/irqchip/arm-gic-v3.h                 |  30 +-
 include/linux/irqchip/irq-partition-percpu.h       |   5 +
 include/linux/irqdomain.h                          |   6 +-
 kernel/irq/irqdomain.c                             |  10 +-
 24 files changed, 529 insertions(+), 165 deletions(-)
