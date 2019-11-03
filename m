Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBBECA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 01:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF4C20663
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 01:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfKCBg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 21:36:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:59452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbfKCBg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 21:36:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE909AFA8;
        Sun,  3 Nov 2019 01:36:54 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [RFC 05/11] dt-bindings: soc: realtek: rtd1195-chip: Extend reg property
Date:   Sun,  3 Nov 2019 02:36:39 +0100
Message-Id: <20191103013645.9856-6-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191103013645.9856-1-afaerber@suse.de>
References: <20191103013645.9856-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to optionally specify a second register to identify the chip.
Whether needed and which register to specify depends on the family;
RTD1295 family will want the CHIP_INFO1 register.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 A SoC specific binding would defeat the purpose of the generic Linux driver;
 is it possible to check the root node's compatible in an if: expression
 to prohibit using more than one reg on "realtek,rtd1195"?
 
 .../devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml  | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
index 565ad2419553..e431cf559b66 100644
--- a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
+++ b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
@@ -11,13 +11,15 @@ maintainers:
 
 description: |
   The Realtek SoCs have some registers to identify the chip and revision.
+  To identify the exact model within a family, further registers are needed.
 
 properties:
   compatible:
     const: "realtek,rtd1195-chip"
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
 required:
   - compatible
@@ -29,4 +31,10 @@ examples:
         compatible = "realtek,rtd1195-chip";
         reg = <0x1801a200 0x8>;
     };
+  - |
+    chip-info@9801a200 {
+        compatible = "realtek,rtd1195-chip";
+        reg = <0x9801a200 0x8>,
+              <0x98007028 0x4>;
+    };
 ...
-- 
2.16.4

