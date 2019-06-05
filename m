Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EDCC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC5420874
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TACV0Qvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfFEO7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:59:45 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:51687 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFEO7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559746783; x=1591282783;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=P+pgIBJt0BnhCfVQrWsShJT+/ohoDjIa/OF/ZGXpPzU=;
  b=TACV0QvqCW15RaJ9DMKSmXd2aBMSDhq8AO/mk0zxomB4L9yz71DQVJdj
   2nzkoVjyTopqW+GQZKkBtosP0e62eSp21rWH1NwaGY9qa6GAvKLPehv4w
   8DzPHiCNEplAhI+30WYta8sLou27Zl/awSVwssz4+DGlOiypTnMoausTF
   0=;
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="803761190"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Jun 2019 14:59:41 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id C9A96A0739;
        Wed,  5 Jun 2019 14:59:40 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 14:59:40 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.203) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 14:59:31 +0000
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
Subject: [PATCH v3 0/2] Amazon's Annapurna Labs Fabric Interrupt Controller
Date:   Wed, 5 Jun 2019 17:59:16 +0300
Message-ID: <1559746758-20208-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13P01UWA001.ant.amazon.com (10.43.160.213) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for Amazon's Annapurna Labs Fabric Interrupt
Controller.

The Amazon's Annapurna Labs FIC (Fabric Interrupt Controller) has 32
inputs/sources. This FIC may be cascaded into another FIC or connected
directly to the main CPU Interrupt Controller (e.g. GIC).

Changes since v2:
=================
- updated dt-bindings to use proper format for entry name
- removed kernel-doc format style from Copyright
- removed unneeded/misplaced selects from Kconfig
- changed used mmio operation to relaxed flavor
- changed error return value from EPERM to EINVAL int case of attempting to
  reconfigure the FIC after it has been configured
- fixed commenting format
- used drivers define instead of subsystem internals
- moved al_fic_hw_init function to caller
- removed al_fic_wire_get_domain from documentation
- removed argument validation from al_fic_wire_init

Changes since v1:
=================
- removing unused exported APIs
- updating cover letter and commit message accordingly



Talel Shenhar (2):
  dt-bindings: interrupt-controller: Amazon's Annapurna Labs FIC
  irqchip: al-fic: Introduce Amazon's Annapurna Labs Fabric Interrupt
    Controller Driver

 .../interrupt-controller/amazon,al-fic.txt         |  22 ++
 MAINTAINERS                                        |   6 +
 drivers/irqchip/Kconfig                            |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-al-fic.c                       | 278 +++++++++++++++++++++
 5 files changed, 315 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
 create mode 100644 drivers/irqchip/irq-al-fic.c

-- 
2.7.4

