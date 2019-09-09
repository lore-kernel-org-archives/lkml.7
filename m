Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60811C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3180820674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LCl1sGzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389741AbfIIJLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:11:09 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:50657 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfIIJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568020267; x=1599556267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Pwyi2LvRvU2P6PihSn1GXJczaDqXg7KVNUJ3MtlBRvI=;
  b=LCl1sGzwa6Eb1uxDcAS/9OUyyYCEWfiOrT2WLKTrBSuKJd+W3aFrMllb
   CPpQEWSfhT+dX0GuXMDYLhj/57qbgffU2CsnIDZ9wUJjIzB+Vt5gO8Iqi
   X7CEe2e6yF/yWUUmYCjJhFMenKnlRU+cCKuxIgsWRX1Jt46vJMeQe2Mhm
   g=;
X-IronPort-AV: E=Sophos;i="5.64,484,1559520000"; 
   d="scan'208";a="749722385"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Sep 2019 09:11:02 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 4EBAAA07A9;
        Mon,  9 Sep 2019 09:11:01 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 09:11:00 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.176) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 09:10:47 +0000
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
Subject: [PATCH 1/3] dt-bindings: soc: al-pos: Amazon's Annapurna Labs POS
Date:   Mon, 9 Sep 2019 12:10:18 +0300
Message-ID: <1568020220-7758-2-git-send-email-talel@amazon.com>
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

Document Amazon's Annapurna Labs POS SoC binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 .../devicetree/bindings/soc/amazon/amazon,al-pos.txt   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt

diff --git a/Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt b/Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt
new file mode 100644
index 00000000..035cc571
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt
@@ -0,0 +1,18 @@
+Amazon's Annapurna Labs POS
+
+POS node is defined to describe the Point Of Serialization (POS) logger
+unit.
+
+Required properties:
+- compatible:	Shall be "amazon,al-pos".
+- reg:		POS logger resources.
+- interrupts:	should contain the interrupt for pos error event.
+
+Example:
+
+al_pos {
+	compatible = "amazon,al-pos";
+	reg = <0x0 0xf0070084 0x0 0x00000008>;
+	interrupt-parent = <&amazon_system_fabric>;
+	interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.7.4

