Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403D8C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179A12189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfGCJPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:15:03 -0400
Received: from foss.arm.com ([217.140.110.172]:42096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbfGCJPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:15:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F400344;
        Wed,  3 Jul 2019 02:15:02 -0700 (PDT)
Received: from big-swifty.cambridge.arm.com (e120212.arm.com [10.1.26.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AC293F246;
        Wed,  3 Jul 2019 02:14:56 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <ren_guo@c-sky.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jiangfeng Xiao <xiaojiangfeng@huawei.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Talel Shenhar <talel@amazon.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zeev Zilberman <zeev@amazon.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for Linux 5.3
Date:   Wed,  3 Jul 2019 10:14:03 +0100
Message-Id: <20190703091403.11855-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's the round of irqchip updates for 5.3. This time around, a
couple of new drivers (RZ1A and al-fic), ACPI support for the exiu
driver and its GPIO companion, a quirk for the GICv2m-like widget in
the Amazon Graviton, and a bunch of cleanups (mostly in the Renesas
drivers).

Please pull,

	M.

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.3

for you to fetch changes up to 3dae67ce600caaa92c9af6e0cb6cad2db2632a0a:

  irqchip/gic-pm: Remove PM_CLK dependency (2019-07-03 09:33:01 +0100)

----------------------------------------------------------------
irqchip updates for Linux 5.3:

- ACPI support for the exiu and mb86s7x drivers
- New Renesas RZ/A1, Amazon al-fic drivers
- Add quirk for Amazon Graviton GICv2m widget
- Large Renesas driver cleanup
- CSky mpintc trigger type fixes
- Meson G12A driver support
- Various minor cleanups

----------------------------------------------------------------
Ard Biesheuvel (4):
      acpi/irq: Implement helper to create hierachical domains
      irqchip/exiu: Preparatory refactor for ACPI support
      irqchip/exiu: Implement ACPI support
      gpio: mb86s7x: Enable ACPI support

Geert Uytterhoeven (10):
      dt-bindings: interrupt-controller: Add Renesas RZ/A1 Interrupt Controller
      irqchip: Add Renesas RZ/A1 Interrupt Controller driver
      irqchip/renesas-irqc: Remove unneeded inclusion of <linux/spinlock.h>
      irqchip/renesas-irqc: Remove error messages on out-of-memory conditions
      irqchip/renesas-irqc: Add helper variable dev = &pdev->dev
      irqchip/renesas-irqc: Replace irqc_priv.pdev by irqc_priv.dev
      irqchip/renesas-irqc: Convert to managed initializations
      irqchip: Enable compile-testing for Renesas drivers
      irqchip/renesas-intc-irqpin: Use proper irq_chip name and parent
      irqchip/renesas-irqc: Use proper irq_chip name and parent

Guo Ren (3):
      irqchip/irq-csky-mpintc: Add triger type
      dt-bindings: interrupt-controller: Update csky mpintc
      irqchip/irq-csky-mpintc: Remove unnecessary loop in interrupt handler

Gustavo A. R. Silva (1):
      irqchip/qcom: Use struct_size() in devm_kzalloc()

Jiangfeng Xiao (1):
      irqchip/gic: Add dependency for ARM_GIC_MAX_NR

Kefeng Wang (1):
      irqchip/mbigen: Stop printing kernel addresses

Sameer Pujar (1):
      irqchip/gic-pm: Remove PM_CLK dependency

Talel Shenhar (2):
      dt-bindings: interrupt-controller: Add Amazon's Annapurna Labs FIC
      irqchip/al-fic: Introduce Amazon's Annapurna Labs Fabric Interrupt Controller Driver

Xingyu Chen (2):
      dt-bindings: interrupt-controller: New binding for Meson-G12A SoC
      irqchip/meson-gpio: Add support for Meson-G12A SoC

Zeev Zilberman (1):
      irqchip/gic-v2m: Add support for Amazon Graviton variant of GICv3+GICv2m

 .../interrupt-controller/amazon,al-fic.txt         |  29 +++
 .../amlogic,meson-gpio-intc.txt                    |   1 +
 .../bindings/interrupt-controller/csky,mpintc.txt  |  20 +-
 .../interrupt-controller/renesas,rza1-irqc.txt     |  43 ++++
 MAINTAINERS                                        |   6 +
 drivers/acpi/irq.c                                 |  26 ++
 drivers/gpio/gpio-mb86s7x.c                        |  51 +++-
 drivers/irqchip/Kconfig                            |  32 ++-
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-al-fic.c                       | 278 ++++++++++++++++++++
 drivers/irqchip/irq-csky-mpintc.c                  |  86 ++++++-
 drivers/irqchip/irq-gic-v2m.c                      |  85 +++++--
 drivers/irqchip/irq-gic-v3.c                       |   3 +
 drivers/irqchip/irq-mbigen.c                       |   3 +-
 drivers/irqchip/irq-meson-gpio.c                   |   1 +
 drivers/irqchip/irq-renesas-intc-irqpin.c          |   3 +-
 drivers/irqchip/irq-renesas-irqc.c                 |  91 +++----
 drivers/irqchip/irq-renesas-rza1.c                 | 283 +++++++++++++++++++++
 drivers/irqchip/irq-sni-exiu.c                     | 142 ++++++++---
 drivers/irqchip/qcom-irq-combiner.c                |   5 +-
 include/linux/acpi.h                               |   7 +
 include/linux/irqchip/arm-gic-common.h             |   5 +
 include/linux/irqchip/arm-gic.h                    |   3 -
 23 files changed, 1067 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt
 create mode 100644 drivers/irqchip/irq-al-fic.c
 create mode 100644 drivers/irqchip/irq-renesas-rza1.c
