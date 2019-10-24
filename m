Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D487CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA9C20679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SXQFVePo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439074AbfJXLlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:41:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37592 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439051AbfJXLk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:40:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9OBer6v012089;
        Thu, 24 Oct 2019 06:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571917253;
        bh=WSq9OZdwKdeoLjUwzEDRH2J/CSISTFy2JDeWsxhM3og=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SXQFVePoXYpXmI65MYjCFMB0vDB2iLUax9uohTRDTibK6lDCOtBFQQ5oUSUpngMpv
         9a6hoCww1O9EazeWJpTtTN/+zUOhy0BRAfw43UgSDiuLKD5bmrPUEnKeMWSR57ufUz
         /6vOdQvC07QqoxBaBkjSQ+GhnxY3U2B1IcmAp5dg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9OBerhn128811
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Oct 2019 06:40:53 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 24
 Oct 2019 06:40:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 24 Oct 2019 06:40:40 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9OBeiTC044238;
        Thu, 24 Oct 2019 06:40:49 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
Date:   Thu, 24 Oct 2019 14:40:41 +0300
Message-ID: <20191024114042.30237-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024114042.30237-1-rogerq@ti.com>
References: <20191024114042.30237-1-rogerq@ti.com>
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
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index 8a1eccee6c1d..5dab0010bcdf 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -53,6 +53,21 @@ properties:
   assigned-clock-parents:
     maxItems: 2
 
+  typec-dir-gpios:
+    maxItems: 1
+    description:
+      GPIO to signal Type-C cable orientation for lane swap.
+      If GPIO is active, lane 0 and lane 1 of SERDES will be swapped to
+      achieve the funtionality of an exernal type-C plug flip mux.
+
+  typec-dir-debounce:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description:
+      Number of milliseconds to wait before sampling
+      typec-dir-gpio. If not specified, the GPIO will be sampled ASAP.
+      Type-C spec states minimum CC pin debounce of 100 ms and maximum
+      of 200 ms.
+
 patternProperties:
   "^pll[0|1]_refclk$":
     type: object
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

