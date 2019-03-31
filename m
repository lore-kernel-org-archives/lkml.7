Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13529C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD23420830
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="psN6qJlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfCaMfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:35:02 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:55212 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfCaMfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1554035701; x=1585571701;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Iul4vSYsr5VYCV8EP6+bp2FKLpnLhXgg24oWcD2zEZk=;
  b=psN6qJlUEcMn45EdKpD6fpt4X6raXVSCw8NA9kzu6WLZ99fEhrEDDHhz
   9YXyvnH0o6eICRB3rgDdVHKw2kQqEVuB8mUAwZ+jdotIZffIpq8KGxVKW
   5aWqGuqtvWMVATD2Q4pyMS6cQmMnc2YhsuPMBMI/ftAfhSPz/YzzvmGli
   U=;
X-IronPort-AV: E=Sophos;i="5.60,292,1549929600"; 
   d="scan'208";a="796653331"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Mar 2019 12:34:59 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x2VCYl4M045137
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 31 Mar 2019 12:34:54 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 12:34:53 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.160.69) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 12:34:43 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     <ronenk@amazon.com>, <dwmw@amazon.co.uk>, <vaerov@amazon.com>,
        <zeev@amazon.com>, <alisaidi@amazon.com>, <talel@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <barakw@amazon.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 0/7] al-msi: Rename driver and add support for ACPI
Date:   Sun, 31 Mar 2019 15:34:08 +0300
Message-ID: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.69]
X-ClientProxiedBy: EX13P01UWA003.ant.amazon.com (10.43.160.197) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes three major changes:
1. IOMMU DMA mapping MSI message fix.
2. Re-name the AL-MSIx driver to new name convention.
3. Add ACPI support for the driver.

Alpine is the name of the SoC family, while AL stands for Annapurna
Labs. Rename to the latter since the driver will appear in other SoC
families other than Alpine.

The AL-MSIx controller is not standard, is not included in the UEFI
specification, and will not be added. The driver ACPI binding is
performed when the following conditions are true:
- OEM ID is AMAZON
- MADT table type is 0x80 (part of the OEM reserved range).

GICv2m driver is called from context of parent interrupt controller,
which ensures that the parent interrupt domain exists and holds valid
information. As calling AL-MSIx driver from GICv3 driver would not make
sense, a new API was added, to get the GSI IRQ domain that was registered
by GICv3 driver in the ACPI framework.

Hanna Hawa (7):
  irqchip/alpine-msi: Call IOMMU DMA mapping MSI message hook
  irqchip/alpine-msi: Update driver license to use SPDX
  irqchip/al-msi: Rename AL-MSIx driver
  irqchip/al-msi: Update wrong parameter naming
  ACPI / irq: Add GSI IRQ domain getter function
  irqchip/al-msi: Refactor in preparation to add ACPI support
  irqchip/al-msi: Add ACPI support

 arch/arm/mach-alpine/Kconfig                       |   2 +-
 arch/arm64/Kconfig.platforms                       |   2 +-
 drivers/acpi/irq.c                                 |  13 +
 drivers/irqchip/Kconfig                            |   2 +-
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/{irq-alpine-msi.c => irq-al-msi.c} | 320 ++++++++++++++-------
 include/linux/acpi.h                               |   1 +
 7 files changed, 236 insertions(+), 106 deletions(-)
 rename drivers/irqchip/{irq-alpine-msi.c => irq-al-msi.c} (40%)

-- 
2.7.4

