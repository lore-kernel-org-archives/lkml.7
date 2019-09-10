Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EB8C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A6A217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="INQUOKo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfIJTFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 15:05:34 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:63043 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfIJTFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 15:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568142332; x=1599678332;
  h=from:to:subject:date:message-id:mime-version;
  bh=nvto+j8LpSPGTaN7OYir8EQdAm7BrTOi6EMVT7BQo00=;
  b=INQUOKo393EH2j7wygKBV2mzAQJT2DMhmfkIedPOOJQDv0hTrmnYGV+m
   mKMXv7N6XmEYB/d8/8T1QDGXt/fAyiI+rSAvjeccqrlrtwXPlra7Lnfwk
   SAX83x768aI0KbLYdMsPK856BHWvEVTiNoQGs6X/dLK9R3IsBvO2cO9no
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="414566627"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 10 Sep 2019 19:05:30 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 19FE4A26E9;
        Tue, 10 Sep 2019 19:05:29 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 19:05:28 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.5) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 19:05:21 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <mchehab+samsung@kernel.org>,
        <shawn.lin@rock-chips.com>, <gregkh@linuxfoundation.org>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <talel@amazon.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/3] Amazon's Annapurna Labs POS Driver
Date:   Tue, 10 Sep 2019 22:05:07 +0300
Message-ID: <1568142310-17622-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.5]
X-ClientProxiedBy: EX13D03UWC002.ant.amazon.com (10.43.162.160) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amazon's Annapurna Labs SoCs includes Point Of Serialization error
logging unit that reports an error in case of write error (e.g. attempt to
write to a read only register).

This patch series introduces the support for this unit.

Changes since v1: =================
- move MODULE_ to the end of the file
- simplified resource remapping devm_platform_ioremap_resource()
- use platform_get_irq() instead of irq_of_parse_and_map()
- removed the use of _relaxed accessor in favor to the regular ones
- removed driver selected based on arch
- added casting to u64 before left shifting (reported by kbuild test robot)


Talel Shenhar (3):
  dt-bindings: soc: al-pos: Amazon's Annapurna Labs POS
  soc: amazon: al-pos: Introduce Amazon's Annapurna Labs POS driver
  soc: amazon: al-pos: cast to u64 before left shifting

 .../bindings/soc/amazon/amazon,al-pos.txt          |  18 +++
 MAINTAINERS                                        |   7 ++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/amazon/Kconfig                         |   5 +
 drivers/soc/amazon/Makefile                        |   1 +
 drivers/soc/amazon/al_pos.c                        | 127 +++++++++++++++++++++
 7 files changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt
 create mode 100644 drivers/soc/amazon/Kconfig
 create mode 100644 drivers/soc/amazon/Makefile
 create mode 100644 drivers/soc/amazon/al_pos.c

-- 
2.7.4

