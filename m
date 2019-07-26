Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D872CC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3F520838
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbfGZSlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:41:01 -0400
Received: from mailoutvs8.siol.net ([185.57.226.199]:54758 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387834AbfGZSk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:40:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id EA650523037;
        Fri, 26 Jul 2019 20:40:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cl05FhubSUTB; Fri, 26 Jul 2019 20:40:56 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id A124A523038;
        Fri, 26 Jul 2019 20:40:56 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id ECACD523037;
        Fri, 26 Jul 2019 20:40:53 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 1/6] dt-bindings: pwm: allwinner: Add H6 PWM description
Date:   Fri, 26 Jul 2019 20:40:40 +0200
Message-Id: <20190726184045.14669-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726184045.14669-1-jernej.skrabec@siol.net>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 PWM block is basically the same as A20 PWM, except that it also has
bus clock and reset line which needs to be handled accordingly.

Expand Allwinner PWM binding with H6 PWM specifics.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pw=
m.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.ya=
ml
index 0ac52f83a58c..deca5d81802f 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -30,13 +30,47 @@ properties:
       - items:
           - const: allwinner,sun50i-h5-pwm
           - const: allwinner,sun5i-a13-pwm
+      - const: allwinner,sun50i-h6-pwm
=20
   reg:
     maxItems: 1
=20
-  clocks:
+  # Even though it only applies to subschemas under the conditionals,
+  # not listing them here will trigger a warning because of the
+  # additionalsProperties set to false.
+  clocks: true
+  clock-names: true
+  resets:
     maxItems: 1
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-h6-pwm
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Module Clock
+            - description: Bus Clock
+
+        clock-names:
+          items:
+            - const: pwm
+            - const: bus
+
+      required:
+        - clock-names
+        - resets
+
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+
 required:
   - "#pwm-cells"
   - compatible
--=20
2.22.0

