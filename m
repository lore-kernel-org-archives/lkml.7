Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E644CC3276E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B865521655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgU9n65k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgABXOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:14:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45546 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgABXOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:14:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so40813396wrj.12;
        Thu, 02 Jan 2020 15:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kMyTupLDldKkb1lWgqnDbAPS5C9Z9guf82HYxQir48s=;
        b=QgU9n65k0J62aUAR3QexuN7AaghnWdbzXWtrwQNU8gQiUaY7nAn34Xzy5qvfnFvKcS
         5NlUdrK/9zZyfrYwDS1X3h7hARQfvSJ7a9r0TFyuu9eo5FO3RSv6QkEYG6Yr+h9blzM7
         mKCDUwYiM5e58JsvHhyKjNhHgqLqfd31p2zhtIe4yV4vwrq1a445HbdJXIPf4wDFvffR
         ZZXZa11gn28ushEiKdP06tLndt8LgYTeRNTKZMhWNbO6ijT0T1xKchfPq7TPbrcKQxkr
         ef8uXnD+tjBTnkUwx1SUgy1AZUAG3fYx+bL2sCHP1DlqU7PHGXiMU3v40vNyCe2kLtdI
         Zcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kMyTupLDldKkb1lWgqnDbAPS5C9Z9guf82HYxQir48s=;
        b=OoqKmakZ9YFQqzVsJxa46UJQzk8z/L8OQNXzjSw9v+cSxFnPiYHQJ9mxBFgGBf4PBP
         7qkRoceIPL6lMPt/DPJ/tq63egbuzV3+2WMneK33I57vriB2IxxyKqsexTnQmgiPOIxU
         awUOhtsD+rCsTrg8febBuNwHG+K27zpWXBxNOhzlbHJSRoST9sThH3HXkktsgqFwJZdY
         3W7C1I4MBEjS/IHJbipN4+a2qhruBoc5WGtlF3fwQ/JVH487yvm0HhKXSF1fhHmJE6If
         sTbkEFdhynB8fPtC/nHRvZglydwqZ2wxC8c1o75oMgziYvEi343/QiOL0PEbzkZ8bI4g
         pOZw==
X-Gm-Message-State: APjAAAVOG3C+hr44FBZTkRZK5T3+n8Z+VxGuImxsmYY+ZvYR/N/vvPLm
        5mLPWDoGlX3CaghNmrwAtbzNoLKz
X-Google-Smtp-Source: APXvYqzURx81wFYnSVFGlVgdBvQmAelB8Np8cexU5H0xK4XgknY0rgZQ72RWFUgiEuPFDDiUp/D0sw==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr86340755wrm.345.1578006888330;
        Thu, 02 Jan 2020 15:14:48 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i10sm58214711wru.16.2020.01.02.15.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 15:14:47 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v2 1/2] dt-bindings: reset: Document BCM7216 RESCAL reset controller
Date:   Thu,  2 Jan 2020 15:14:34 -0800
Message-Id: <20200102231435.21703-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102231435.21703-1-f.fainelli@gmail.com>
References: <20200102231435.21703-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Quinlan <jim2101024@gmail.com>

BCM7216 has a special purpose RESCAL reset controller for its SATA and
PCIe0/1 instances. This is a simple reset controller with #reset-cells
set to 0.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
[florian: Convert to YAML binding]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../reset/brcm,bcm7216-pcie-sata-rescal.yaml  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml

diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml
new file mode 100644
index 000000000000..411bd76f1b64
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 Broadcom
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/brcm,bcm7216-pcie-sata-rescal.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: BCM7216 RESCAL reset controller
+
+description: This document describes the BCM7216 RESCAL reset controller which is responsible for controlling the reset of the SATA and PCIe0/1 instances on BCM7216.
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+  - Jim Quinlan <jim2101024@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,bcm7216-pcie-sata-rescal
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+examples:
+  - |
+    reset-controller@8b2c800 {
+          compatible = "brcm,bcm7216-pcie-sata-rescal";
+          reg = <0x8b2c800 0x10>;
+          #reset-cells = <0>;
+    };
-- 
2.17.1

