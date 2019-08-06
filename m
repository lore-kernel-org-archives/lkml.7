Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3DDC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEC220651
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565085691;
	bh=dTquUB8U9WfxRwR2ViHmd5/p9wyQE+iiaVKNDPiTmBs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ygSA+HuaiKbydVta3aXh9JbsmPU8eyqGtZ0iqcfDtmPVZp9EE5K9Kp89et9fGaVOe
	 rJlK3D3lKsfTcmSTXifmzFl7WZQ24EFO6aYWlzzkkJcgsByQXjT7Zv9FmItpwfgM2L
	 u2TrUsc2MiwTM6n4/S+58KtTnGncHAuVPBFwF8jM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbfHFKBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:01:30 -0400
Received: from foss.arm.com ([217.140.110.172]:59356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732610AbfHFKB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:01:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24F33337;
        Tue,  6 Aug 2019 03:01:28 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF92F3F706;
        Tue,  6 Aug 2019 03:01:26 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/12] irqchip/gic-v3: Add support for GICv3.1 extended PPI/SPI ranges
Date:   Tue,  6 Aug 2019 11:01:09 +0100
Message-Id: <20190806100121.240767-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, having ~1000 wired interrupts is not enough, and some
people need more. Fear not! The GIC Achitecture Department hereby
grants you another 1024 SPIs, together with 64 PPIs, provided that you
implement GICv3.1 (see [1] for the details)

This series implements the required support, which requires a bit of
infrastructure rework in order to make the thing less horrible...

This has been tested on a FastModel. If there is no additional issue being
reported, I plan to put this into -next toward the end of this week and
let it simmer there for a bit.

[1] https://developer.arm.com/docs/ihi0069/latest (version E)

* From v1:
  - Tighten ESPI range matching
  - Added a warning to detect inconsistent distributor/cpu interface
    configurations
  - Added quirks to handle HIP06/07 erratum 161010803 which unexpectedly
    advertise ESPI support

Marc Zyngier (12):
  irqchip/gic: Rework gic_configure_irq to take the full ICFGR base
  irqchip/gic-v3: Add INTID range and convertion primitives
  dt-bindings: interrupt-controller: arm,gic-v3: Describe ESPI range
    support
  irqchip/gic-v3: Add ESPI range support
  irqchip/gic: Prepare for more than 16 PPIs
  irqchip/gic-v3: Dynamically allocate PPI NMI refcounts
  irqchip/gic-v3: Dynamically allocate PPI partition descriptors
  dt-bindings: interrupt-controller: arm,gic-v3: Describe EPPI range
    support
  irqchip/gic-v3: Add EPPI range support
  irqchip/gic-v3: Warn about inconsistent implementations of extended
    ranges
  irqchip/gic: Skip DT quirks when evaluating IIDR-based quirks
  irqchip/gic-v3: Add quirks for HIP06/07 invalid GICD_TYPER erratum
    161010803

 Documentation/arm64/silicon-errata.rst        |   2 +
 .../interrupt-controller/arm,gic-v3.yaml      |   6 +-
 drivers/irqchip/irq-gic-common.c              |  35 +-
 drivers/irqchip/irq-gic-common.h              |   2 +-
 drivers/irqchip/irq-gic-v3.c                  | 380 ++++++++++++++----
 drivers/irqchip/irq-gic.c                     |  12 +-
 drivers/irqchip/irq-hip04.c                   |   9 +-
 include/linux/irqchip/arm-gic-v3.h            |  30 +-
 8 files changed, 372 insertions(+), 104 deletions(-)

-- 
2.20.1

