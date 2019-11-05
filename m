Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D760CCA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B340720818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfKEFvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 00:51:01 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:50743 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfKEFvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 00:51:01 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id CFDB93C0588;
        Tue,  5 Nov 2019 06:50:56 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SGKHH59H7g6m; Tue,  5 Nov 2019 06:50:51 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 2F7D23C0585;
        Tue,  5 Nov 2019 06:50:51 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 5 Nov 2019
 06:50:50 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-mmc@vger.kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Machek <pavel@ucw.cz>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: [PATCH 1/3] dt-bindings: mmc: Add 'fixed-emmc-driver-type-hs{200,400}'
Date:   Tue, 5 Nov 2019 06:50:13 +0100
Message-ID: <20191105055015.23656-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A certain eMMC manufacturer provided below requirement:
 ---snip---
 Use "drive strength" value of 4 or 1 for HS400 or 0 for HS200.
 ---snip---

The existing "fixed-emmc-driver-type" property [1] is the closest one
to implement the above, but it falls short due to being unable to define
two values to differentiate between HS200 and HS400 (both modes may be
supported by the same non-removable MMC device).

To allow users to set a preferred HS200/HS400 "drive strength", provide
two more bindings inspired from [1]:
 - fixed-emmc-driver-type-hs200
 - fixed-emmc-driver-type-hs400

For more details about eMMC I/O driver strength types, see Jedec spec.
Keep "fixed-emmc-driver-type" in place for backward compatibility.

[1] commit 6186d06c519e21 ("mmc: parse new binding for eMMC fixed driver type")

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 .../bindings/mmc/mmc-controller.yaml          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 080754e0ef35..1c64b14f91a3 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -248,6 +248,24 @@ properties:
       the driver type as specified in the eMMC specification (table
       206 in spec version 5.1)
 
+  fixed-emmc-driver-type-hs200:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 4
+    description:
+      Same as "fixed-emmc-driver-type", but specific to HS200 mode.
+      If defined, overrides "fixed-emmc-driver-type" in HS200 mode.
+
+  fixed-emmc-driver-type-hs400:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 4
+    description:
+      Same as "fixed-emmc-driver-type", but specific to HS400 mode.
+      If defined, overrides "fixed-emmc-driver-type" in HS400 mode.
+
   post-power-on-delay-ms:
     allOf:
       - $ref: /schemas/types.yaml#/definitions/uint32
@@ -336,6 +354,8 @@ patternProperties:
 dependencies:
   cd-debounce-delay-ms: [ cd-gpios ]
   fixed-emmc-driver-type: [ non-removable ]
+  fixed-emmc-driver-type-hs200: [ non-removable ]
+  fixed-emmc-driver-type-hs400: [ non-removable ]
 
 examples:
   - |
-- 
2.23.0

