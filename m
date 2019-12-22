Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1D3C2D0D4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 15:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E8320733
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 15:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XK/VMKfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLVPwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 10:52:31 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:22396 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVPwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 10:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577029949; x=1608565949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SL6BZmD4jmjWbjXl8N+TY5rCn4h74dxErtWXusGgkjc=;
  b=XK/VMKfc7mPeDmDTnxv2J98XJ8M3ZLvAqWb6vP8WAjcHXSZ1m6YlTuHe
   2E0ZCyaJV3CoArrqVhkht3rYJzv7bWU1093sAZ/Tp9LFB4Zvp1PsA/Yiy
   zMOA7WFu6PzcTFABBDCFwz0mepqweOO71PeOJzCJcY8tY6M+ZUoYD/sef
   0=;
IronPort-SDR: st9TaiDa9ohKt5OxVutDPwFEF+qQmnfn/CGpLDBG3Y3reRAmI/BrdYddaG5F7hmdMkCHKlwug7
 uuSFuEkofd/A==
X-IronPort-AV: E=Sophos;i="5.69,344,1571702400"; 
   d="scan'208";a="15024073"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 22 Dec 2019 15:52:19 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 3BB0FA220F;
        Sun, 22 Dec 2019 15:52:18 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 22 Dec 2019 15:52:17 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.9) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 22 Dec 2019 15:52:06 +0000
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
Subject: [PATCH v3 4/6] dt-bindings: arm: amazon: add missing alpine-v2 DT binding
Date:   Sun, 22 Dec 2019 17:50:36 +0200
Message-ID: <20191222155038.30633-5-hhhawa@amazon.com>
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

Amazon Annapurna Labs Alpine family includes: Alpine-v1, Alpine-v2.

This patch adds the missing DT binding of Alpine-v2 in amazon,al.yaml.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/amazon,al.yaml        | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amazon,al.yaml b/Documentation/devicetree/bindings/arm/amazon,al.yaml
index 19ee489396f9..7de3a8c6e740 100644
--- a/Documentation/devicetree/bindings/arm/amazon,al.yaml
+++ b/Documentation/devicetree/bindings/arm/amazon,al.yaml
@@ -13,10 +13,15 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - const: al,alpine
-  model:
-    items:
-      - const: "Annapurna Labs Alpine Dev Board"
+    oneOf:
+      - description: Boards with Alpine V1 SoC
+        items:
+          - const: al,alpine
+
+      - description: Boards with Alpine V2 SoC
+        items:
+          - enum:
+              - al,alpine-v2-evp
+          - const: al,alpine-v2
 
 ...
-- 
2.17.1

