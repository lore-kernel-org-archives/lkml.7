Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E882C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658F520872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558171345;
	bh=PIiohG80Nlyid3LugSBYke5qTGH+DAvIAbfyvhIwDQY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=zKI54tehISPMK45Q/jShSVFItaHgewVBWXEz5Ht64Yzro6oQyiIViYAhYDCewJk3G
	 e7naBUl5Sr+JKjUarnyf18+XkLFIhwG8ByR/CUuC4ptfIojmMLQcQnQReAVV9x6ase
	 iPyySi97YBmO2qEKnlx1I/jGw/2tEzpMx1snr4DQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfERJWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:22:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54754 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfERJWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:22:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so8949770wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iflnrzBLI30tqXSW7QffxIXOJwULemI4kbrIOB3pipI=;
        b=lSuJ1ldSDvc1U0k60AG89YSXvVVM5pF2anSVowaLxfS4X5TqhIvY3g15WWy5X5RtOX
         ZaQP3u/RpCSFadkFt+6ibx34qOeTjqR8XVITRviuL6vTXkixB00iVzerOFt8Ru42FPPW
         GFHNSzPFZGU20poup46q8rLPiZvwXVP9EuRigoTQi90udTyC+rhp82cEd23dtFGVF6DU
         mMSp21XmkhBkg0eUtubE6Shgr45yIuGEj3jr7fdyIvifyzFpzFaOkuOSo3Fqop4OsiJg
         1mtPWsDpDXBo7xmLq1eHtI52bS+oJwHuZg65VT1eX0SnBEtQ16qVVGSf9Z0h0sw1nI6p
         nHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=iflnrzBLI30tqXSW7QffxIXOJwULemI4kbrIOB3pipI=;
        b=Pbcto/MCqr3M6W0j2L1u3EDFwP4VsOtbnzW5vyxrvCNJ4V/keJARrpmj0bK87x9ICc
         mNQr8+c74VGWjERBg9xBj24dDgOpzZxkM25oBlkhtoRs+eEcsZUuEWvAju8ARzNHq9sl
         h9XAQ4SmcztFPF4a7YEzGAtEpjiGEn7R73UrjI1Xs52eek1TrcNbwbuB9mPLUk8dQb9i
         t7g+wB9df6Y7XjsnPWOmqOPSQHQ2nVdvqVf1aOpIcTs+cUjiHsJOmjAKfzOzMSwE1oK2
         Rcpp5dxEQI1KexZxJArLhyNE0gao/WepZIMdGolgnQwg9Zo29yOLBq3hPHT99wg6jXUJ
         u9pA==
X-Gm-Message-State: APjAAAU8HBzVXeQvzUWdVab+p9ZQFnIDgO20vQsUmbuL9VQSxRL76og4
        ZXAZflXw/+EvlLoLKLjvXG2kHLZ0
X-Google-Smtp-Source: APXvYqxA9PNycloUzVuUEvdjCKpYC72FWno1VYWpIC5jhEwmlC9kvKifGb4eexLtmbNolz7r+Fx88g==
X-Received: by 2002:a1c:4456:: with SMTP id r83mr5362399wma.37.1558171341208;
        Sat, 18 May 2019 02:22:21 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u17sm7153676wmj.1.2019.05.18.02.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 02:22:20 -0700 (PDT)
Date:   Sat, 18 May 2019 11:22:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC GIT PULL] IRQ chip updates
Message-ID: <20190518092218.GA108644@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

   # HEAD: fb4e0592654adb31bc6f3a738d6499b816a655d6 Merge tag 'irqchip-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

A late irqchips update: 

  - New TI INTR/INTA set of drivers
  - Rewrite of the stm32mp1-exti driver as a platform driver
  - Update the IOMMU MSI mapping API to be RT friendly
  - A number of cleanups and other low impact fixes

I marked this RFC because it's a late pull request which fell through the 
cracks.

 Thanks,

	Ingo

------------------>

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

Thomas Gleixner (1):
      Merge tag 'irqchip-5.2' of git://git.kernel.org/.../maz/arm-platforms into irq/core


 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt              |   3 +-
 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt |  66 ++++++++++++
 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt |  82 +++++++++++++++
 MAINTAINERS                                                            |   6 ++
 arch/arm64/Kconfig.platforms                                           |   5 +
 drivers/firmware/ti_sci.c                                              | 651 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h                                              | 102 +++++++++++++++++++
 drivers/gpio/gpio-thunderx.c                                           |  16 +--
 drivers/iommu/Kconfig                                                  |   1 +
 drivers/iommu/dma-iommu.c                                              |  48 +++++----
 drivers/irqchip/Kconfig                                                |  27 +++--
 drivers/irqchip/Makefile                                               |   2 +
 drivers/irqchip/irq-bcm7038-l1.c                                       |   3 +
 drivers/irqchip/irq-bcm7120-l2.c                                       |   3 +
 drivers/irqchip/irq-brcmstb-l2.c                                       |   2 +
 drivers/irqchip/irq-gic-pm.c                                           |  76 +++++++-------
 drivers/irqchip/irq-gic-v2m.c                                          |   8 +-
 drivers/irqchip/irq-gic-v3-its.c                                       |  84 +++++++--------
 drivers/irqchip/irq-gic-v3-mbi.c                                       |  10 +-
 drivers/irqchip/irq-imx-irqsteer.c                                     |   4 +-
 drivers/irqchip/irq-ls-scfg-msi.c                                      |   7 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c                              |   4 +-
 drivers/irqchip/irq-stm32-exti.c                                       | 233 +++++++++++++++++++++++++-----------------
 drivers/irqchip/irq-ti-sci-inta.c                                      | 615 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-ti-sci-intr.c                                      | 275 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/soc/ti/Kconfig                                                 |   6 ++
 drivers/soc/ti/Makefile                                                |   1 +
 drivers/soc/ti/ti_sci_inta_msi.c                                       | 146 +++++++++++++++++++++++++++
 include/linux/dma-iommu.h                                              |  24 ++++-
 include/linux/irq.h                                                    |   2 +
 include/linux/irqchip/arm-gic-v3.h                                     |  12 +--
 include/linux/irqdomain.h                                              |   1 +
 include/linux/msi.h                                                    |  36 +++++++
 include/linux/soc/ti/ti_sci_inta_msi.h                                 |  23 +++++
 include/linux/soc/ti/ti_sci_protocol.h                                 | 124 +++++++++++++++++++++++
 kernel/irq/Kconfig                                                     |   3 +
 kernel/irq/chip.c                                                      |  27 +++++
 kernel/irq/irqdomain.c                                                 |   2 +-
 38 files changed, 2511 insertions(+), 229 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 create mode 100644 drivers/irqchip/irq-ti-sci-inta.c
 create mode 100644 drivers/irqchip/irq-ti-sci-intr.c
 create mode 100644 drivers/soc/ti/ti_sci_inta_msi.c
 create mode 100644 include/linux/soc/ti/ti_sci_inta_msi.h
