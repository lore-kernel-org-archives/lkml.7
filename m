Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE907C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8250B2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DxvBvjmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbfFJIf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:35:28 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:17836 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387862AbfFJIf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560155727; x=1591691727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=U0u9f9JhFHz7rp9Kz2+M+95jCGGSqSmwhpc8qziinY0=;
  b=DxvBvjmP0zihBs+YZLDdFNzo2nFX1/9en0X3hDrORmP+Tx8g7WwCV729
   IM9vB8RZ8d5OrzkjbAs9U5aaf1Q63E1s09bDvUyjCLsNM9ldPmufU0DTx
   ac7I8UUNJoauSyfv5fkbsVSKGTeyblh1tc/iZDIwKlTywhbMzPkp/WUWh
   8=;
X-IronPort-AV: E=Sophos;i="5.60,573,1549929600"; 
   d="scan'208";a="736771736"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Jun 2019 08:35:26 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id C8DB9A27B3;
        Mon, 10 Jun 2019 08:35:22 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Jun 2019 08:35:21 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.69) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Jun 2019 08:35:12 +0000
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
Subject: [PATCH v4 1/2] dt-bindings: interrupt-controller: Amazon's Annapurna Labs FIC
Date:   Mon, 10 Jun 2019 11:34:42 +0300
Message-ID: <1560155683-29584-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560155683-29584-1-git-send-email-talel@amazon.com>
References: <1560155683-29584-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.69]
X-ClientProxiedBy: EX13D15UWB004.ant.amazon.com (10.43.161.61) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Amazon's Annapurna Labs Fabric Interrupt Controller SoC binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 .../interrupt-controller/amazon,al-fic.txt         | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
new file mode 100644
index 0000000..4e82fd5
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
@@ -0,0 +1,29 @@
+Amazon's Annapurna Labs Fabric Interrupt Controller
+
+Required properties:
+
+- compatible: should be "amazon,al-fic"
+- reg: physical base address and size of the registers
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: must be 2.
+  First cell defines the index of the interrupt within the controller.
+  Second cell is used to specify the trigger type and must be one of the
+  following:
+    - bits[3:0] trigger type and level flags
+	1 = low-to-high edge triggered
+	4 = active high level-sensitive
+- interrupt-parent: specifies the parent interrupt controller.
+- interrupts: describes which input line in the interrupt parent, this
+  fic's output is connected to. This field property depends on the parent's
+  binding
+
+Example:
+
+amazon_fic: interrupt-controller@0xfd8a8500 {
+	compatible = "amazon,al-fic";
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	reg = <0x0 0xfd8a8500 0x0 0x1000>;
+	interrupt-parent = <&gic>;
+	interrupts = <GIC_SPI 0x0 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.7.4

