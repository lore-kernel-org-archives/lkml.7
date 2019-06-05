Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7827C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F22206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="U4WxIUI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFEGyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:54:45 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:42573 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFEGyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559717684; x=1591253684;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=FuBV3uC5Kw67IxIOVRtKTfaR92I/vsHGNbRqB7qOVrU=;
  b=U4WxIUI4a2gveI7qalJaa8ZHpC0BshpLVagOxEbcrY094iIZ0rWcU4eg
   13qGSSLiDC4+B4Ve24y7A2ribAcrT1EBudtBPFUXw1l++aIBNcd7i8jf1
   oUKAIvQZe+6VkftWLYHaMk1RoHPyYGQ+cFTsqiWGOryvrsub6bJ9OAiUN
   w=;
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="399432759"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 05 Jun 2019 06:54:42 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id E009EA26C1;
        Wed,  5 Jun 2019 06:54:38 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 06:54:38 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.91) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 06:54:28 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <nicolas.ferre@microchip.com>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
        <mchehab+samsung@kernel.org>, <robh+dt@kernel.org>,
        <davem@davemloft.net>, <shawn.lin@rock-chips.com>,
        <tglx@linutronix.de>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <jonnyc@amazon.com>, <hhhawa@amazon.com>, <ronenk@amazon.com>,
        <hanochu@amazon.com>, <barakw@amazon.com>,
        Talel Shenhar <talel@amazon.com>
Subject: [PATCH 0/3] Amazon's Annapurna Labs Fabric Interrupt Controller
Date:   Wed, 5 Jun 2019 09:54:10 +0300
Message-ID: <1559717653-11258-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.91]
X-ClientProxiedBy: EX13d09UWC001.ant.amazon.com (10.43.162.60) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for Amazon's Annapurna Labs Fabric Interrupt
Controller.

The Amazon's Annapurna Labs FIC (Fabric Interrupt Controller) has 32
inputs/sources. The output of this interrupt controller can be legacy-wired
output or, in case embedded inside PCIe devices, msi-x message. This FIC may
be cascaded into another FIC or connected directly to the main CPU
Interrupt Controller (e.g. GIC).

The FIC is a flexible HW unit that is embedded inside different parts of
the Amazon's Annapurna Labs chips. It can be a simple level 2 interrupt
controller which is then configured as a wired interrupt controller that
aggregates events from different units, or, while embedded inside PCIe
device, it can generate MSI-X messages based on the tables configured to
that PCIe device or can be configured to generate wired interrupt. 



Talel Shenhar (3):
  dt-bindings: interrupt-controller: Amazon's Annapurna Labs FIC
  irqchip: al-fic: Introduce Amazon's Annapurna Labs Fabric Interrupt
    Controller Driver
  irqchip: al-fic: Introducing support for MSI-X

 .../interrupt-controller/amazon,al-fic.txt         |  22 ++
 MAINTAINERS                                        |   7 +
 drivers/irqchip/Kconfig                            |  11 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-al-fic.c                       | 388 +++++++++++++++++++++
 include/linux/irqchip/al-fic.h                     |  23 ++
 6 files changed, 452 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
 create mode 100644 drivers/irqchip/irq-al-fic.c
 create mode 100644 include/linux/irqchip/al-fic.h

-- 
2.7.4

