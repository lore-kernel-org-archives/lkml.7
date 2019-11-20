Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9675CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E2522419
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574251028;
	bh=yA3N12GL0/xYrSOIRIOnLklhZeoJh1Fsw6khPwQegig=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EmfwoOkWK+HzK+F6IkF/xypdsJMLm61OzelUILDBj2eC1ffXtYxeB5wvt0h/caL6/
	 Yg3T/pGmTbq37Xe4TeCaklZn1xWPUpjvCW85bT2SwfngTfWfj8MzeAi1WvFvYWzOct
	 Mxgy1bq3Pav+D+ZyLQlDwGGBY4+xBYvG/c7Z4sJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfKTL5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:57:07 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:60720 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728908AbfKTL5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:57:06 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iXObE-0002Sv-1p; Wed, 20 Nov 2019 12:56:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Daode Huang <huangdaode@hisilicon.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heyi Guo <guoheyi@huawei.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Maulik Shah <mkshah@codeaurora.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>
Subject: [GIT PULL] irqchip updates for 5.5
Date:   Wed, 20 Nov 2019 11:56:30 +0000
Message-Id: <20191120115630.28116-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, ben.dooks@codethink.co.uk, huangdaode@hisilicon.com, f.fainelli@gmail.com, guoheyi@huawei.com, j.neuschaefer@gmx.net, justinpopo6@gmail.com, ilina@codeaurora.org, linus.walleij@linaro.org, lokeshvutla@ti.com, elfring@users.sourceforge.net, mkshah@codeaurora.org, palmer@sifive.com, paul@crapouillou.net, rnayak@codeaurora.org, linux@rasmusvillemoes.dk, robh@kernel.org, swboyd@chromium.org, yuzenghui@huawei.com, zhouyanjie@zoho.com, linux-kernel@vger.kernel.org, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a large-ish irqchip update targetting 5.5.

The bulk of the changes this time are the QC PDC wakeup support that
has been brewing for longer than I care to remember, a bunch of GICv3
cleanups in preparation for the GICv4.1 code (which is 5.6 material),
a bunch of GICv4 fixes (which owe a lot to Zenghui's careful review
of the v4.1 patches), Broadcom wakeup support and a driver for
a FSL/NXP platform.

The rest is a bunch of DT updates, cleanups, fixes and other cosmetic
changes.

Please pull.

	M.

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.5

for you to fetch changes up to 585d1183ffeea5cbe2cd24863bbc90196d827257:

  pinctrl/sdm845: Add PDC wakeup interrupt map for GPIOs (2019-11-16 10:23:48 +0000)

----------------------------------------------------------------
irqchip updates for Linux 5.5

- Qualcomm PDC wakeup interrupt support
- Layerscape external IRQ support
- Broadcom bcm7038 PM and wakeup support
- Ingenic driver cleanup and modernization
- GICv3 ITS preparation for GICv4.1 updates
- GICv4 fixes
- Various cleanups

----------------------------------------------------------------
Ben Dooks (Codethink) (2):
      irqchip/gic-v3-its: Fix u64 to __le64 warnings
      irqchip/gic-v3: Fix __iomem warning

Daode Huang (1):
      irqchip: Remove redundant semicolon after while

Florian Fainelli (4):
      dt-bindings: Document brcm, irq-can-wake for brcm, bcm7038-l1-intc.txt
      irqchip/irq-bcm7038-l1: Enable parent IRQ if necessary
      dt-bindings: Document brcm, int-fwd-mask property for bcm7038-l1-intc
      irqchip/irq-bcm7038-l1: Support brcm,int-fwd-mask

Jonathan Neuschäfer (1):
      irqchip: Place CONFIG_SIFIVE_PLIC into the menu

Justin Chen (1):
      irqchip/irq-bcm7038-l1: Add PM support

Lina Iyer (7):
      irqdomain: Add bus token DOMAIN_BUS_WAKEUP
      of/irq: Document properties for wakeup interrupt parent
      irqchip/qcom-pdc: Update max PDC interrupts
      irqchip/qcom-pdc: Do not toggle IRQ_ENABLE during mask/unmask
      irqchip/qcom-pdc: Add irqdomain for wakeup capable GPIOs
      pinctrl/msm: Setup GPIO chip in hierarchy
      pinctrl/sdm845: Add PDC wakeup interrupt map for GPIOs

Marc Zyngier (11):
      irqchip/gic-v3-its: Free collection mapping on device teardown
      irqchip/gic-v3-its: Factor out wait_for_syncr primitive
      irqchip/gic-v3-its: Allow LPI invalidation via the DirectLPI interface
      irqchip/gic-v3-its: Make is_v4 use a TYPER copy
      irqchip/gic-v3-its: Kill its->ite_size and use TYPER copy instead
      irqchip/gic-v3-its: Kill its->device_ids and use TYPER copy instead
      irqchip/gic-v3-its: Add its_vlpi_map helpers
      irqchip/gic-v3-its: Synchronise INV command targetting a VLPI using VSYNC
      irqchip/gic-v3-its: Synchronise INT/CLEAR commands targetting a VLPI using VSYNC
      irqchip/gic-v3-its: Lock VLPI map array before translating it
      irqchip/gic-v3-its: Make vlpi_lock a spinlock

Markus Elfring (1):
      irqchip/ti-sci-inta: Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...))

Maulik Shah (2):
      genirq: Introduce irq_chip_get/set_parent_state calls
      irqchip/qcom-pdc: Add irqchip set/get state calls

Paul Cercueil (4):
      irqchip: ingenic: Drop redundant irq_suspend / irq_resume functions
      irqchip: ingenic: Error out if IRQ domain creation failed
      irqchip: ingenic: Get virq number from IRQ domain
      irqchip: ingenic: Alloc generic chips from IRQ domain

Rajendra Nayak (2):
      drivers: irqchip: qcom-pdc: Move to an SoC independent compatible
      dt-bindings: qcom,pdc: Add compatible for sc7180

Rasmus Villemoes (2):
      dt/bindings: Add bindings for Layerscape external irqs
      irqchip: Add support for Layerscape external interrupt lines

Zhou Yanjie (1):
      irqchip: Ingenic: Add process for more than one irq at the same time.

 .../interrupt-controller/brcm,bcm7038-l1-intc.txt  |  11 +
 .../interrupt-controller/fsl,ls-extirq.txt         |  49 ++++
 .../bindings/interrupt-controller/interrupts.txt   |  12 +
 .../bindings/interrupt-controller/qcom,pdc.txt     |   3 +-
 arch/arm/include/asm/arch_gicv3.h                  |   2 +-
 drivers/irqchip/Kconfig                            |   8 +-
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-bcm7038-l1.c                   | 119 +++++++-
 drivers/irqchip/irq-gic-v3-its.c                   | 302 ++++++++++++++++-----
 drivers/irqchip/irq-gic-v3.c                       |   4 +-
 drivers/irqchip/irq-ingenic.c                      |  85 +++---
 drivers/irqchip/irq-ls-extirq.c                    | 197 ++++++++++++++
 drivers/irqchip/irq-ti-sci-inta.c                  |   5 +-
 drivers/irqchip/irq-zevio.c                        |   2 +-
 drivers/irqchip/qcom-pdc.c                         | 149 +++++++++-
 drivers/pinctrl/qcom/pinctrl-msm.c                 | 112 +++++++-
 drivers/pinctrl/qcom/pinctrl-msm.h                 |  14 +
 drivers/pinctrl/qcom/pinctrl-sdm845.c              |  23 +-
 include/linux/irq.h                                |   6 +
 include/linux/irqchip/arm-gic-v3.h                 |   4 +-
 include/linux/irqchip/ingenic.h                    |  14 -
 include/linux/irqdomain.h                          |   1 +
 include/linux/soc/qcom/irq.h                       |  34 +++
 kernel/irq/chip.c                                  |  44 +++
 24 files changed, 1041 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
 create mode 100644 drivers/irqchip/irq-ls-extirq.c
 delete mode 100644 include/linux/irqchip/ingenic.h
 create mode 100644 include/linux/soc/qcom/irq.h
