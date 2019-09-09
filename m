Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDB8C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5033D21D7A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m7lIyqWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfIIJOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:14:19 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:9552 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfIIJOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568020458; x=1599556458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=qrlI7m65m72RGINBsWezbT/FD0zwclbAbcVQzgJUkqY=;
  b=m7lIyqWGhHvnTA5CcaQxYDVNzu16ZtW6D3oTUhuLFvoTrUbHfD8967Ta
   umI4FcZ7YRrli9jZSFgCArIs6wUyTa7mDuGB+xxfLuHPq1DLZfky3ol9d
   rA9wlYxhxBicqtSZmvij0bhuROCOeSMwK1R1fWLbPMXOl3uT0kVMODruF
   c=;
X-IronPort-AV: E=Sophos;i="5.64,484,1559520000"; 
   d="scan'208";a="829173412"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 09 Sep 2019 09:11:24 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 9920DA1D8D;
        Mon,  9 Sep 2019 09:11:23 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 09:11:23 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.176) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 09:11:11 +0000
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
Subject: [PATCH 3/3] arm64: alpine: select AL_POS
Date:   Mon, 9 Sep 2019 12:10:20 +0300
Message-ID: <1568020220-7758-4-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568020220-7758-1-git-send-email-talel@amazon.com>
References: <1568020220-7758-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.176]
X-ClientProxiedBy: EX13D23UWA001.ant.amazon.com (10.43.160.68) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amazon's Annapurna Labs SoCs uses al-pos driver, enable it.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4778c77..bd86b15 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -25,6 +25,7 @@ config ARCH_SUNXI
 config ARCH_ALPINE
 	bool "Annapurna Labs Alpine platform"
 	select ALPINE_MSI if PCI
+	select AL_POS
 	help
 	  This enables support for the Annapurna Labs Alpine
 	  Soc family.
-- 
2.7.4

