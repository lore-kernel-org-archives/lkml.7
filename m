Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A9FC2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDCD206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTDgMuV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLUXkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 18:40:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36641 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLUXkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 18:40:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so12929465wru.3;
        Sat, 21 Dec 2019 15:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MVfYqQFb+qmrsv8qfsHnECMUzpb6tM8WaiwY1dc5ybQ=;
        b=hTDgMuV9ocFMN6HJL29uCoDn+FBNbJstQxVmvc+u4Rl0lG/CeiNuShnJOSreWlBU9m
         rN6kVE8caor4UVYFemxzgAT/s5D7VwJvDa3b4kl++114Dl9sJjYQeN942PRuiF+hoDOC
         JvySP39Wt2tGQBcEJKSrbm7h95ozsSfL5oNMhFtLoOG/eSYH/63HQl6Rr9J+zDeVJfey
         TCFUPFo7COpPxYsDodiMGvH+A5lEjp5LGkT8akOlUvBsAVoW+2x/P2+9yGaar2Qy52n7
         bg52tOMNCrVZEsfSSjdjU20hqanWi72ln0T6dxK7IwEXcyADOhCM7YT2osZRObahIjpQ
         5H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MVfYqQFb+qmrsv8qfsHnECMUzpb6tM8WaiwY1dc5ybQ=;
        b=UGC+J/A1mzZF87hEdIz1AaAvPSfoOtrJwXKx22lOnEdJUxBvzorBapgVHomqZ26N4d
         l92QtXqqdiADfkUaLzV9fcH4cDEDCXG9sUHmw5iHvSKO9ynQ4A5ocXIyw70DkQKeM+yj
         8AIF9t13LW1mCLZA5Vl7DZmyG0TEH/LhfaGtfEKoPjpuPZQ4r+SoUQMQw9Qofb4i7d1N
         DdKHdCIHUcPohZSAJ0oPZKGTCe6A+1qULM1JpJ8PwJLyIIzbYB2RR9yhZUjnT5saz1LX
         u4HWMDPAZoj7wZ3kbpaIjYNhN6dB8q2RBsY+8jbj/ZmIC5C4361iQYRa/C8/7myce1+Q
         jybA==
X-Gm-Message-State: APjAAAUnEWweG8VmpZKvCLuUR/bqpR9D3LHc1jllntGge+6zJQgVbf05
        GrXosQhy9TUcmnYkCGR99EE=
X-Google-Smtp-Source: APXvYqz76aggDlVfYf2VkvpqPDkWYHZjFOQXBYbDzIomf25wWJro9hfyvoY14YcQBCi2za8uzFYqbw==
X-Received: by 2002:adf:f411:: with SMTP id g17mr22024878wro.89.1576971642600;
        Sat, 21 Dec 2019 15:40:42 -0800 (PST)
Received: from localhost.localdomain (p5B3F6223.dip0.t-ipconnect.de. [91.63.98.35])
        by smtp.gmail.com with ESMTPSA id q3sm14179151wmj.38.2019.12.21.15.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 15:40:41 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: regulator: add document bindings for mpq7920
Date:   Sun, 22 Dec 2019 00:40:27 +0100
Message-Id: <20191221234029.7796-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191221234029.7796-1-sravanhome@gmail.com>
References: <20191221234029.7796-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding information for mpq7920 regulator driver.
Example bindings for mpq7920 are added.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../bindings/regulator/mpq7920.yaml           | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mpq7920.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
new file mode 100644
index 000000000000..a60d3ef04c05
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mpq7920.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Monolithic Power System MPQ7920 PMIC
+
+maintainers:
+  - Saravanan Sekar <sravanhome@gmail.com>
+
+properties:
+  $nodename:
+    pattern: "mpq@[0-9a-f]{1,2}"
+  compatible:
+    enum:
+	- mps,mpq7920
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller, must be named
+      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
+      The valid names for regulators are
+      buck1, buck2, buck3, buck4, ldortc, ldo2, ldo3, ldo4, ldo5
+
+  properties:
+       mps,time-slot:
+         - $ref: "/schemas/types.yaml#/definitions/uint8"
+         - enum: [ 0, 1, 2, 3 ]
+         - default: 0
+       description: |
+         each regulator output shall be delayed during power on/off sequence which
+         based on configurable time slot value, must be one of following corresponding
+         value 0.5ms, 2ms, 8ms, 16ms
+
+       mps,fixed-on-time:
+          - $ref: "/schemas/types.yaml#/definitions/boolean"
+       description: |
+         select power on sequence with fixed time output delay mentioned in
+         time-slot reg for all the regulators.
+
+       mps,fixed-off-time:
+          - $ref: "/schemas/types.yaml#/definitions/boolean"
+       description: |
+          select power off sequence with fixed time output delay mentioned in
+          time-slot reg for all the regulators.
+
+       mps,inc-off-time:
+          - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+          - minimum: 0
+            maximum: 15
+       description: |
+          mutually exclusive to mps,fixed-off-time an array of 8, linearly increase
+          output delay during power off sequence based on factor of time slot/interval
+          for each regulator.
+
+       mps,inc-on-time:
+          - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+          - minimum: 0
+            maximum: 15
+          - default: [ 0, 6, 0, 6, 7, 7, 7, 9 ]
+       description: |
+          mutually exclusive to mps,fixed-on-time an array of 8, linearly increase
+          output delay during power on sequence based on factor of time slot/interval
+          for each regulator.
+
+       mps,switch-freq:
+         - $ref: "/schemas/types.yaml#/definitions/uint8"
+         - enum: [ 0, 1, 2, 3 ]
+         - default: 2
+       description: |
+          switching frequency must be one of following corresponding value
+          1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz
+
+       mps,buck-softstart:
+         - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+         - enum: [ 0, 1, 2, 3 ]
+         - default: [ 1, 1, 1, 1 ]
+       description: |
+          An array of 4 contains soft start time of each buck, must be one of
+          following corresponding values 150us, 300us, 610us, 920us
+
+       mps,buck-ovp:
+         - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+         - enum: [ 0, 1 ]
+         - default: [ 1, 1, 1, 1 ]
+       description: |
+          An array of 4 contains over voltage protection of each buck, must be
+          one of above values
+
+       mps,buck-phase-delay:
+         - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+         - enum: [ 0, 1, 2, 3 ]
+         - default: [ 0, 0, 1, 1 ]
+       description: |
+          An array of 4 contains phase delay of each buck must be one of above values
+          corresponding to 0deg, 90deg, 180deg, 270deg,
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mpq7920@69 {
+	  compatible = "mps,mpq7920";
+          reg = <0x69>;
+
+          mps,switch-freq = <1>;
+          mps,buck-softstart = /bits/ 8 <1 2 1 3>;
+          mps,buck-ovp = /bits/ 8 <1 0 1 1>;
+
+          regulators {
+            buck1 {
+             regulator-name = "buck1";
+             regulator-min-microvolt = <400000>;
+             regulator-max-microvolt = <3587500>;
+             regulator-min-microamp  = <460000>;
+             regulator-max-microamp  = <7600000>;
+             regulator-boot-on;
+           };
+
+           ldo2 {
+             regulator-name = "ldo2";
+             regulator-min-microvolt = <650000>;
+             regulator-max-microvolt = <3587500>;
+           };
+         };
+       };
+     };
+...
-- 
2.17.1

