Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2958C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7863D206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BdFMummE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfFEGyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:54:54 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:9252 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfFEGyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559717693; x=1591253693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+AbsMDqrBdK2fo3dMr+KdtdUMgvKB5nc8Jnjl8AQb7w=;
  b=BdFMummETGxiLH4CFE4YVbISRYe65+sashB3/MOePw/LdRJ9ye8fi7au
   VIw41Bnm9ssbYi5IRZQjqZZ6rU4ms5kglww1hAhhpigkvtI4s0Kxg+EJ2
   OI8bKauctBG4gxOSzvK6wEKm7BBpZyUQBGgYa1SgBQMgdfn597HwAnENJ
   E=;
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="808657221"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 05 Jun 2019 06:54:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id AC095A24B2;
        Wed,  5 Jun 2019 06:54:47 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 06:54:46 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.91) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 06:54:37 +0000
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
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: Amazon's Annapurna Labs FIC
Date:   Wed, 5 Jun 2019 09:54:11 +0300
Message-ID: <1559717653-11258-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559717653-11258-1-git-send-email-talel@amazon.com>
References: <1559717653-11258-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.91]
X-ClientProxiedBy: EX13d09UWC001.ant.amazon.com (10.43.162.60) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Amazon's Annapurna Labs Fabric Interrupt Controller SoC binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 .../interrupt-controller/amazon,al-fic.txt         | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
new file mode 100644
index 0000000..a2f31a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
@@ -0,0 +1,22 @@
+Amazon's Annapurna Labs Fabric Interrupt Controller
+
+Required properties:
+
+- compatible: should be "amazon,al-fic"
+- reg: physical base address and size of the registers
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: must be 2.
+- interrupt-parent: specifies the parent interrupt controller.
+- interrupts: describes which input line in the interrupt parent, this
+  fic's output is connected to.
+
+Example:
+
+amazon_fic: amazon_fic {
+	compatible = "amazon,al-fic";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+	reg = <0x0 0xfd8a8500 0x0 0x1000>;
+	interrupt-parent = <&gic>;
+	interrupts = <GIC_SPI 0x0 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.7.4

