Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA52CCA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 10:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4E8208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 10:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dhCDFDoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbfJ1KWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 06:22:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47340 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732186AbfJ1KWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:22:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9SAM68w114584;
        Mon, 28 Oct 2019 05:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572258126;
        bh=Nf1Qs7J2oXPLMu6hs54yffKkCyfxPGxqiMZcwXNIM5s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dhCDFDojXVhujpLyUAozW00lJnyV9SPShf8xvbY3e9EGi6ZHpuIWIrPhqarUm5pD1
         CmQfpP887+fCiFSHdecRdht+8QYhFwkkKfc50qr74nr1SoUDM3AtkNybgdSRBiuI2M
         PtRMVrP/stCgGqNZymIv8p1jwcTaVcc7OnWndFwQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9SAM6Fm000827;
        Mon, 28 Oct 2019 05:22:06 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 28
 Oct 2019 05:21:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 28 Oct 2019 05:22:06 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9SALwqH024783;
        Mon, 28 Oct 2019 05:22:04 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
Date:   Mon, 28 Oct 2019 12:21:52 +0200
Message-ID: <20191028102153.24866-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028102153.24866-1-rogerq@ti.com>
References: <20191028102153.24866-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an optional GPIO, if specified will be used to
swap lane 0 and lane 1 based on GPIO status. This is required
to achieve plug flip support for USB Type-C.

Type-C companions typically need some time after the cable is
plugged before and before they reflect the correct status of
Type-C plug orientation on the DIR line.

Type-C Spec specifies CC attachment debounce time (tCCDebounce)
of 100 ms (min) to 200 ms (max).

Allow the DT node to specify the time (in ms) that we need
to wait before sampling the DIR line.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Cc: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/ti,phy-j721e-wiz.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index 8a1eccee6c1d..b5dcf80b8831 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -53,6 +53,23 @@ properties:
   assigned-clock-parents:
     maxItems: 2
 
+  typec-dir-gpios:
+    maxItems: 1
+    description:
+      GPIO to signal Type-C cable orientation for lane swap.
+      If GPIO is active, lane 0 and lane 1 of SERDES will be swapped to
+      achieve the funtionality of an external type-C plug flip mux.
+
+  typec-dir-debounce-ms:
+    minimum: 100
+    maximum: 1000
+    default: 100
+    description:
+      Number of milliseconds to wait before sampling typec-dir-gpio.
+      If not specified, the default debounce of 100ms will be used.
+      Type-C spec states minimum CC pin debounce of 100 ms and maximum
+      of 200 ms. However, some solutions might need more than 200 ms.
+
 patternProperties:
   "^pll[0|1]_refclk$":
     type: object
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

