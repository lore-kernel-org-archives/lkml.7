Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3EFCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5184218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KZY93pcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbfJVNXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:23:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:32930 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbfJVNXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:23:16 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9MDNEtS003725;
        Tue, 22 Oct 2019 08:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571750594;
        bh=gR7OAXsQc4OiOhV7DWYE58CP8SVL3y7X8+jWjC3qNZ0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KZY93pcExSDQEi9oLzUIIiXl5q/7TsnHy7jPRnKLrHCT/ic5AslsO5BpI+RJWXNSz
         UzZ6hLRY1vnJdVC4MEM4vE9oC56pDT12OHWZSac9Jnze3/RXTEE7PxoAD9cWAeUY6c
         rVjbxsMV93eHx9x6tavZtyC4A6WmRRQh98BHdcqY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9MDNEc6068197
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 08:23:14 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 22
 Oct 2019 08:23:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 22 Oct 2019 08:23:04 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9MDMpla126427;
        Tue, 22 Oct 2019 08:22:56 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/3] dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
Date:   Tue, 22 Oct 2019 16:22:48 +0300
Message-ID: <20191022132249.869-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191022132249.869-1-rogerq@ti.com>
References: <20191022132249.869-1-rogerq@ti.com>
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
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.txt         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt
index 19b4c3e855d6..253535a8819f 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt
@@ -24,6 +24,15 @@ Optional properties:
 assigned-clocks and assigned-clock-parents: As documented in the generic
 clock bindings in Documentation/devicetree/bindings/clock/clock-bindings.txt
 
+ - typec-dir-gpios: GPIO to signal Type-C cable orientation for lane swap.
+     If GPIO is active, lane 0 and lane 1 of SERDES will be swapped to
+     achieve the funtionality of an exernal type-C plug flip mux.
+
+ - typec-dir-debounce: Number of milliseconds to wait before sampling
+     typec-dir-gpio. If not specified, the GPIO will be sampled ASAP.
+     Type-C spec states minimum CC pin debounce of 100 ms and maximum
+     of 200 ms.
+
 Required subnodes:
  - Clock Subnode: WIZ node should have '3' subnodes for each of the clock
      selects it supports. The clock subnodes should have the following names
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

