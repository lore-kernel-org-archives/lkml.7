Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2491C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33332070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfECOy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:54:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35272 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbfECOy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:54:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20B38374;
        Fri,  3 May 2019 07:54:27 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43B8C3F5C1;
        Fri,  3 May 2019 07:54:23 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Eric Auger <eric.auger@redhat.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Joerg Roedel <jroedel@suse.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Julien Grall <julien.grall@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Mohan Kumar D <mkumard@nvidia.com>,
        Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 5.2
Date:   Fri,  3 May 2019 15:54:02 +0100
Message-Id: <20190503145402.52365-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's the set of irqchip (and related) updates for 5.2. The main
offenders are the TI SCI drivers, which we've finally managed to fit
in the MSI framework. It comes with its own firmware interface, hence
some touching some files outside of the usual areas. Another one is
the revamp of the IOMMU MSI mapping API, which is now RT friendly (the
relevant IOMMU changes have been acked by Joerg). Also, the
stm32mp1-exti has been rewritten to be be able to deal with probe
deferral.

The rest is a motley crew of smaller cleanups and fixes.

Please pull,

	M.

The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2:

  Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.2

for you to fetch changes up to 16e32c3cde7763ab875b9030b443ecbc8e352d8a:

  iommu/dma-iommu: Remove iommu_dma_map_msi_msg() (2019-05-03 15:30:23 +0100)

----------------------------------------------------------------
irqchip updates for 5.2

- The huge (and terrifying) TI INTR/INTA set of drivers
- Rewrite of the stm32mp1-exti driver as a platform driver
- Update the IOMMU MSI mapping API to be RT friendly
- A number of cleanups and other low impact fixes

----------------------------------------------------------------
Anson Huang (1):
      irqchip/imx-irqsteer: Use devm_platform_ioremap_resource() to simplify code

Fabien Dessenne (1):
      irqchip/stm32: Use a platform driver for stm32mp1-exti device

Florian Fainelli (1):
      irqchip/bcm: Restore registration print with %pOF

Geert Uytterhoeven (2):
      irqchip: Remove unneeded select IRQ_DOMAIN
      irqchip/renesas-intc-irqpin: Remove devm_kzalloc() error printing

Grygorii Strashko (1):
      firmware: ti_sci: Add support to get TISCI handle using of_phandle

Hongbo Yao (1):
      irqchip/gic-v3-its: fix some definitions of inner cacheability attributes

Julien Grall (9):
      irqchip/gic-v3-its: Fix typo in a comment in its_msi_prepare()
      irq/irqdomain: Fix typo in the comment on top of __irq_domain_alloc_irqs()
      genirq/msi: Add a new field in msi_desc to store an IOMMU cookie
      iommu/dma-iommu: Split iommu_dma_map_msi_msg() in two parts
      irqchip/gicv2m: Don't map the MSI page in gicv2m_compose_msi_msg()
      irqchip/gic-v3-its: Don't map the MSI page in its_irq_compose_msi_msg()
      irqchip/ls-scfg-msi: Don't map the MSI page in ls_scfg_msi_compose_msg()
      irqchip/gic-v3-mbi: Don't map the MSI page in mbi_compose_m{b, s}i_msg()
      iommu/dma-iommu: Remove iommu_dma_map_msi_msg()

Lokesh Vutla (12):
      firmware: ti_sci: Add support for RM core ops
      firmware: ti_sci: Add support for IRQ management
      firmware: ti_sci: Add helper apis to manage resources
      genirq: Introduce irq_chip_{request,release}_resource_parent() apis
      gpio: thunderx: Use the default parent apis for {request,release}_resources
      dt-bindings: irqchip: Introduce TISCI Interrupt router bindings
      irqchip/ti-sci-intr: Add support for Interrupt Router driver
      dt-bindings: irqchip: Introduce TISCI Interrupt Aggregator bindings
      irqchip/ti-sci-inta: Add support for Interrupt Aggregator driver
      soc: ti: Add MSI domain bus support for Interrupt Aggregator
      irqchip/ti-sci-inta: Add msi domain support
      arm64: arch_k3: Enable interrupt controller drivers

Peter Ujfalusi (1):
      firmware: ti_sci: Add RM mapping table for am654

Rasmus Villemoes (3):
      irqchip/gic-v3-its: Move allocation outside mutex
      irqchip/gic-v3-its: Drop redundant initialization in mk_lpi_range
      irqchip/gic-v3-its: Make free_lpi_range a little cheaper

Sameer Pujar (2):
      irqchip/gic-pm: Update driver to use clk_bulk APIs
      irqchip/gic-pm: Fix suspend handling

 .../devicetree/bindings/arm/keystone/ti,sci.txt    |   3 +-
 .../bindings/interrupt-controller/ti,sci-inta.txt  |  66 +++
 .../bindings/interrupt-controller/ti,sci-intr.txt  |  82 +++
 MAINTAINERS                                        |   6 +
 arch/arm64/Kconfig.platforms                       |   5 +
 drivers/firmware/ti_sci.c                          | 651 +++++++++++++++++++++
 drivers/firmware/ti_sci.h                          | 102 ++++
 drivers/gpio/gpio-thunderx.c                       |  16 +-
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/dma-iommu.c                          |  48 +-
 drivers/irqchip/Kconfig                            |  27 +-
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-bcm7038-l1.c                   |   3 +
 drivers/irqchip/irq-bcm7120-l2.c                   |   3 +
 drivers/irqchip/irq-brcmstb-l2.c                   |   2 +
 drivers/irqchip/irq-gic-pm.c                       |  76 +--
 drivers/irqchip/irq-gic-v2m.c                      |   8 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  84 +--
 drivers/irqchip/irq-gic-v3-mbi.c                   |  10 +-
 drivers/irqchip/irq-imx-irqsteer.c                 |   4 +-
 drivers/irqchip/irq-ls-scfg-msi.c                  |   7 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c          |   4 +-
 drivers/irqchip/irq-stm32-exti.c                   | 233 +++++---
 drivers/irqchip/irq-ti-sci-inta.c                  | 615 +++++++++++++++++++
 drivers/irqchip/irq-ti-sci-intr.c                  | 275 +++++++++
 drivers/soc/ti/Kconfig                             |   6 +
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/ti_sci_inta_msi.c                   | 146 +++++
 include/linux/dma-iommu.h                          |  24 +-
 include/linux/irq.h                                |   2 +
 include/linux/irqchip/arm-gic-v3.h                 |  12 +-
 include/linux/irqdomain.h                          |   1 +
 include/linux/msi.h                                |  36 ++
 include/linux/soc/ti/ti_sci_inta_msi.h             |  23 +
 include/linux/soc/ti/ti_sci_protocol.h             | 124 ++++
 kernel/irq/Kconfig                                 |   3 +
 kernel/irq/chip.c                                  |  27 +
 kernel/irq/irqdomain.c                             |   2 +-
 38 files changed, 2511 insertions(+), 229 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 create mode 100644 drivers/irqchip/irq-ti-sci-inta.c
 create mode 100644 drivers/irqchip/irq-ti-sci-intr.c
 create mode 100644 drivers/soc/ti/ti_sci_inta_msi.c
 create mode 100644 include/linux/soc/ti/ti_sci_inta_msi.h
