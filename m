Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E12C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B2C21841
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfCULXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:23:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54562 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfCULXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:23:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A55C0374;
        Thu, 21 Mar 2019 04:23:18 -0700 (PDT)
Received: from cam-smtp0.cambridge.arm.com (unknown [10.37.10.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 240A83F614;
        Thu, 21 Mar 2019 04:23:14 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jianguo Chen <chenjianguo3@huawei.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rob Herring <robh@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        YueHaibing <yuehaibing@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 5.1-rc2
Date:   Thu, 21 Mar 2019 11:22:37 +0000
Message-Id: <20190321112237.10325-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a few irqchip updates for 5.1-rc2. Nothing really stands out,
this is the usual bunch of fixes, cleanups and DT binding updates.

Please pull,

	M.

The following changes since commit 28528fca4908142bd1a3247956cba56c9c667d71:

  irqchip/imx-irqsteer: Add multi output interrupts support (2019-02-22 09:23:46 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.1-2

for you to fetch changes up to fca269f201a8d9985c0a31fb60b15d4eb57cef80:

  irqchip/mbigen: Don't clear eventid when freeing an MSI (2019-03-21 11:08:26 +0000)

----------------------------------------------------------------
irqchip updates for 5.1, take #2

- irqsteer error handling fix
- GICv3 range coalescing fix
- stm32 coprocessor coexistence fixes
- mbigen MSI teardown fix
- non-DT secondary GIC infrastructure removed
- various cleanups (brcmstb-l2, mmp)
- new DT bindings (r8a774c0)

----------------------------------------------------------------
Arnd Bergmann (1):
      irqchip/imx-irqsteer: Fix of_property_read_u32() error handling

Fabien Dessenne (2):
      irqchip/stm32: Don't clear rising/falling config registers at init
      irqchip/stm32: Don't set rising configuration registers at init

Fabrizio Castro (1):
      dt-bindings: irqchip: renesas-irqc: Document r8a774c0 support

Jianguo Chen (1):
      irqchip/mbigen: Don't clear eventid when freeing an MSI

Marc Zyngier (1):
      irqchip/gic: Drop support for secondary GIC in non-DT systems

Rasmus Villemoes (1):
      irqchip/gic-v3-its: Fix comparison logic in lpi_range_cmp

YueHaibing (2):
      irqchip/brcmstb-l2: Make two init functions static
      irqchip/mmp: Make mmp_irq_domain_ops static

 .../bindings/interrupt-controller/renesas,irqc.txt |  1 +
 arch/arm/mach-cns3xxx/core.c                       |  2 +-
 drivers/irqchip/irq-brcmstb-l2.c                   |  4 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  2 +-
 drivers/irqchip/irq-gic.c                          | 45 ++++++++--------------
 drivers/irqchip/irq-imx-irqsteer.c                 |  8 +++-
 drivers/irqchip/irq-mbigen.c                       |  3 ++
 drivers/irqchip/irq-mmp.c                          |  2 +-
 drivers/irqchip/irq-stm32-exti.c                   | 10 -----
 include/linux/irqchip/arm-gic.h                    |  3 +-
 10 files changed, 32 insertions(+), 48 deletions(-)
