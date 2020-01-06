Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE6C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C712072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sKxyxPnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgAFNGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:06:40 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42000 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgAFNGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:06:35 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 006D6Xgc036311;
        Mon, 6 Jan 2020 07:06:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578315993;
        bh=JQ+tNlpIJ8e70gEYjYxw/hfIy11SngDevZqNAyKwkfQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sKxyxPnU+7t7mzpG4hSG19zyf5nrYuDp83bNVPal4desYWDN2rnGcQiP2+ym+I8Ku
         A5hu01DmTpmqLAR6ENHWtHFcXwdUDz691pIdDgSv1zh8lpIY5xVDqhZrNPHXCt9sok
         TpeOyDD5AUCo4foAIfGIfh7Ug0vmllAw2BqcMBf4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 006D6XHx014410
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jan 2020 07:06:33 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 07:06:32 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 07:06:32 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006D6PkI089522;
        Mon, 6 Jan 2020 07:06:30 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/3] dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
Date:   Mon, 6 Jan 2020 15:06:21 +0200
Message-ID: <20200106130622.29703-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106130622.29703-1-rogerq@ti.com>
References: <20200106130622.29703-1-rogerq@ti.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/ti,phy-j721e-wiz.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index e010ea46b88d..ec85f365da23 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -50,6 +50,23 @@ properties:
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
   "^pll[0|1]-refclk$":
     type: object
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

