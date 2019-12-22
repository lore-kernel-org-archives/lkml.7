Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6E9C2D0D4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 15:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9179206D3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 15:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rPzpixBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfLVPwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 10:52:36 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:32095 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfLVPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 10:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577029956; x=1608565956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=e2Xw+4d8lNIhM4PNtaJCZ2fQOhyOuwNnLnlDeaT6Q5E=;
  b=rPzpixBzm19rCatuLHn4HsXYBW0RYVnlSKG7GLB4eUtJJVpdcT/RL1IS
   FxUZ86k8PUVftzcEMVGBgoVOXNzVTY+TKEK1RMh2XAYKfebol5kruFmwK
   USmCksLy98CGwC1hXanmtMetd+BQJw4DoyczpG0G9rs8zIh78MHQXSN5C
   w=;
IronPort-SDR: NrcLztEtD1tMYfX6VHskdvhSeH5EveeSdtb6/VZN+q06yVt/kz/ssqu9TVaV9cmQ81pdq7B+I4
 wpPC4gOy/5vQ==
X-IronPort-AV: E=Sophos;i="5.69,344,1571702400"; 
   d="scan'208";a="8758252"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 22 Dec 2019 15:52:35 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 2B490A201F;
        Sun, 22 Dec 2019 15:52:28 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sun, 22 Dec 2019 15:52:28 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.9) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 22 Dec 2019 15:52:17 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <hhhawa@amazon.com>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <tglx@linutronix.de>,
        <xuwei5@hisilicon.com>, <scott.branden@broadcom.com>,
        <dinguyen@kernel.org>, <zhang.lyra@gmail.com>, <treding@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v3 5/6] dt-bindings: arm: amazon: add Amazon Annapurna Labs Alpine V3
Date:   Sun, 22 Dec 2019 17:50:37 +0200
Message-ID: <20191222155038.30633-6-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191222155038.30633-1-hhhawa@amazon.com>
References: <20191222155038.30633-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.9]
X-ClientProxiedBy: EX13D19UWA002.ant.amazon.com (10.43.160.204) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT bindings info for Amazon Annapurna Labs Alpine V3.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amazon,al.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amazon,al.yaml b/Documentation/devicetree/bindings/arm/amazon,al.yaml
index 7de3a8c6e740..a3a4d710bd02 100644
--- a/Documentation/devicetree/bindings/arm/amazon,al.yaml
+++ b/Documentation/devicetree/bindings/arm/amazon,al.yaml
@@ -24,4 +24,10 @@ properties:
               - al,alpine-v2-evp
           - const: al,alpine-v2
 
+      - description: Boards with Alpine V3 SoC
+        items:
+          - enum:
+              - amazon,al-alpine-v3-evp
+          - const: amazon,al-alpine-v3
+
 ...
-- 
2.17.1

