Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF42C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052C720863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BwWnqSas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbfFJIfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:35:22 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:33603 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387862AbfFJIfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560155720; x=1591691720;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ykr4rzL4VAsv6dmWe3aUa6AdEVp465Gxa0La54MnkBo=;
  b=BwWnqSassoHzeZCbJMjdA2+4mCL2B0Vsu77Oisds8Lruzb7TjJ+rhviv
   T7qz1Xl2TU785OZdCAVntvH9CqPqXp+cE2TMOZN06maqBcwJKdbQ/0rYm
   NIGe93CfPQu5fk+YznbkMPT2MFHnxZhP131dxetwdiTZX9UdvuYVFrkZg
   k=;
X-IronPort-AV: E=Sophos;i="5.60,573,1549929600"; 
   d="scan'208";a="804494672"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 10 Jun 2019 08:35:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 1B767A2006;
        Mon, 10 Jun 2019 08:35:13 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Jun 2019 08:35:13 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.69) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Jun 2019 08:35:04 +0000
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
Subject: [PATCH v4 0/2] Amazon's Annapurna Labs Fabric Interrupt Controller
Date:   Mon, 10 Jun 2019 11:34:41 +0300
Message-ID: <1560155683-29584-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.69]
X-ClientProxiedBy: EX13D15UWB004.ant.amazon.com (10.43.161.61) To
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

Changes since v3:
=================
- tightened the verification for supported trigger types
- updated dt-binding's example to meet the binding description
  (interrupt-cells to 2)
- added description to interrupt-cells to explain each field
- changed pr_err to pr_debug inside al_fic_irq_set_type in order to allow
  the user to enable printouts for verbose information in case of errors

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

 .../interrupt-controller/amazon,al-fic.txt         |  29 +++
 MAINTAINERS                                        |   6 +
 drivers/irqchip/Kconfig                            |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-al-fic.c                       | 278 +++++++++++++++++++++
 5 files changed, 322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
 create mode 100644 drivers/irqchip/irq-al-fic.c

-- 
2.7.4

