Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9C6C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C561F2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s5yZZB7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfHEOkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:40:10 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:43425 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfHEOkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1565016008; x=1596552008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=GDxlgW2iIFv1GHLeEOVVxdcmyywibrFDiGbFKaCrd54=;
  b=s5yZZB7+fsZjcCUlufVXZ8XpEbOtMZXbFApek3i6J/rWmDKzKxTLx8R2
   Xy4uoZ7eGQaxYGzAr6TtY0FOhNUelZQffnHGWl5evk08SBIe4NmnXzxK3
   bcMzPekEy1fQVTMorHC8r3EB5RREMxZG3KLJbrRXDA+ebVYt64wAXDE97
   8=;
X-IronPort-AV: E=Sophos;i="5.64,350,1559520000"; 
   d="scan'208";a="816815379"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Aug 2019 14:40:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id DA2E7A26E8;
        Mon,  5 Aug 2019 14:40:01 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 5 Aug 2019 14:40:01 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.162.137) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 5 Aug 2019 14:39:51 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <nicolas.ferre@microchip.com>,
        <paulmck@linux.ibm.com>
CC:     <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <hhhawa@amazon.com>
Subject: [PATCH v5 3/4] dt-bindings: EDAC: Add Amazon's Annapurna Labs L2 EDAC
Date:   Mon, 5 Aug 2019 15:39:10 +0100
Message-ID: <20190805143911.12185-4-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190805143911.12185-1-hhhawa@amazon.com>
References: <20190805143911.12185-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.137]
X-ClientProxiedBy: EX13D03UWA001.ant.amazon.com (10.43.160.141) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Amazon's Annapurna Labs L2 EDAC SoC binding.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 .../bindings/edac/amazon,al-l2-edac.txt       | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt b/Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt
new file mode 100644
index 000000000000..7b0b7347b711
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt
@@ -0,0 +1,20 @@
+* Amazon's Annapurna Labs L2 EDAC
+
+Amazon's Annapurna Labs SoCs supports L2 single bit correction and
+two bits detection capability based on ARM implementation.
+
+Required properties:
+- compatible:
+	should be "amazon,al-l2-edac".
+- l2-cache:
+	Phandle to L2 cache handler.
+	This property is used to compare with the CPU node property
+	'next-level-cache' to create cpu-mask with all CPUs that
+	share same L2 cache.
+
+Example:
+
+	al_l2_edac {
+		compatible = "amazon,al-l2-edac";
+		l2-cache = <&cluster0_l2>;
+	};
-- 
2.17.1

