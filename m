Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ABAC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8308820652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bx6s5UzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfFEKw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 06:52:29 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:28861 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfFEKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 06:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559731947; x=1591267947;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Z765gJrGCQWNcstd9xr84qW2Pj376xBDQSMf8K7Obcg=;
  b=bx6s5UzFy5adjJKntwzkAeX9KoIhG9NdTnZ31m0/c1Y/LHZv5uTXM+2S
   Tl8pUVRhm5awqIOV6wd1sJr/9TP3A6ScfyKqyTF5jMoZqWbw5yJq5a2bJ
   pQrq8LWkv88lEU22MtiCNhp3ppirMgYQ6jldJ1NKj5rnKR5ElE6NZ0eNc
   Q=;
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="803708477"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Jun 2019 10:52:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 8BBCDA2123;
        Wed,  5 Jun 2019 10:52:22 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 10:52:21 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.162.246) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 10:52:12 +0000
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
Subject: [PATCH v2 0/2] Amazon's Annapurna Labs Fabric Interrupt Controller
Date:   Wed, 5 Jun 2019 13:51:59 +0300
Message-ID: <1559731921-14023-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.246]
X-ClientProxiedBy: EX13D14UWC003.ant.amazon.com (10.43.162.19) To
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
 drivers/irqchip/Kconfig                            |  11 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-al-fic.c                       | 289 +++++++++++++++++++++
 5 files changed, 329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
 create mode 100644 drivers/irqchip/irq-al-fic.c

-- 
2.7.4

