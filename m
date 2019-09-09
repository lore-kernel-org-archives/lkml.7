Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7072C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A762067D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="efBvLZog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389720AbfIIJK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:10:56 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:28288 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfIIJK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568020255; x=1599556255;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ey40doxX0rG3pVBsPnyWR0CfVV2FkV/uoAA9DcuSCtw=;
  b=efBvLZog0TBHxq86JvIpJl+8ECtshWWRp88im5svuaxWdSUy7NHYl8YL
   fGYFmUaQjxZhuwiyRncArfnZvFrv3whAxcz7QU5H3edmWBrS6EbmEi8If
   ttnscbXQErNjBfSeZ9coOI0cg/eb8gylAPJCK/a+xCOtpYMrVy1Lqbj1Y
   0=;
X-IronPort-AV: E=Sophos;i="5.64,484,1559520000"; 
   d="scan'208";a="783971868"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 09 Sep 2019 09:10:50 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 7832DA1D01;
        Mon,  9 Sep 2019 09:10:48 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 09:10:47 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.176) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 09:10:36 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <tglx@linutronix.de>, <arnd@arndb.de>, <venture@google.com>,
        <linus.walleij@linaro.org>, <olof@lixom.net>, <mripard@kernel.org>,
        <ssantosh@kernel.org>, <paul.kocialkowski@bootlin.com>,
        <mjourdan@baylibre.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <talel@amazon.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <barakw@amazon.com>
Subject: [PATCH 0/3] Amazon's Annapurna Labs POS Driver
Date:   Mon, 9 Sep 2019 12:10:17 +0300
Message-ID: <1568020220-7758-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.176]
X-ClientProxiedBy: EX13D23UWA001.ant.amazon.com (10.43.160.68) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amazon's Annapurna Labs SoCs includes Point Of Serialization error
logging unit that reports an error in case of write error (e.g. attempt to
write to a read only register).

This patch series introduces the support for this unit.


Talel Shenhar (3):
  dt-bindings: soc: al-pos: Amazon's Annapurna Labs POS
  soc: amazon: al-pos: Introduce Amazon's Annapurna Labs POS driver
  arm64: alpine: select AL_POS

 .../bindings/soc/amazon/amazon,al-pos.txt          |  18 +++
 MAINTAINERS                                        |   6 +
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/amazon/Kconfig                         |   5 +
 drivers/soc/amazon/Makefile                        |   1 +
 drivers/soc/amazon/al_pos.c                        | 129 +++++++++++++++++++++
 8 files changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt
 create mode 100644 drivers/soc/amazon/Kconfig
 create mode 100644 drivers/soc/amazon/Makefile
 create mode 100644 drivers/soc/amazon/al_pos.c

-- 
2.7.4

