Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D4FC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39652207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dbzFKeQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLIQWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:22:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48286 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLIQWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:22:21 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9GMI7Z104372;
        Mon, 9 Dec 2019 10:22:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575908538;
        bh=11P/kNtBZr7To0mT7AsXhF9sB871Rf94OEck46/XMgI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dbzFKeQEGsD5elBkX4hgBjCcgUo8rksyXW9Z82/Lri6FFb7XVyWg90B7i3sbPe0VC
         AyOsptONJDCvWAIhaIYpEjhVJ1fxiEL/EXJYfzZE4ip0bcj2q2anZ99d6FcpR/rDzx
         kjPXOw/WLkhgGkZ3Grddwjkt3R0FadHMkrrwjgk8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB9GMINa093851
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 10:22:18 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 10:22:14 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 10:22:14 -0600
Received: from jadmar.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9GMBdO002331;
        Mon, 9 Dec 2019 10:22:12 -0600
From:   Jyri Sarha <jsarha@ti.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
CC:     <tomi.valkeinen@ti.com>, <praneeth@ti.com>, <yamonkar@cadence.com>,
        <sjakhade@cadence.com>, <rogerq@ti.com>, <jsarha@ti.com>
Subject: [PATCH 2/3] dt-bindings: phy: Add lane<n>-mode property to WIZ (SERDES wrapper)
Date:   Mon, 9 Dec 2019 18:22:11 +0200
Message-ID: <fb79923b1591cc5f26b6973beb92ce503ad3f4d1.1575906694.git.jsarha@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575906694.git.jsarha@ti.com>
References: <cover.1575906694.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add property to indicate the usage of SERDES lane controlled by the
WIZ wrapper. The wrapper configuration has some variation depending on
how each lane is going to be used.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index 94e3b4b5ed8e..399725f65278 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -97,6 +97,18 @@ patternProperties:
       Torrent SERDES should follow the bindings specified in
       Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 
+  "^lane[1-4]-mode$":
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [0, 1, 2, 3, 4, 5, 6]
+    description: |
+     Integer describing static lane usage for the lane indicated in
+     the property name. For Sierra there may be properties lane0 and
+     lane1, for Torrent all lane[1-4]-mode properties may be
+     there. The constants to indicate the lane usage are defined in
+     "include/dt-bindings/phy/phy.h". The lane is assumed to be unused
+     if its lane<n>-use property does not exist.
+
 required:
   - compatible
   - power-domains
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

