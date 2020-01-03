Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E316C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64D621835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ66prh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgACTEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:04:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39471 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgACTEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:04:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so43341834wrt.6;
        Fri, 03 Jan 2020 11:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kMyTupLDldKkb1lWgqnDbAPS5C9Z9guf82HYxQir48s=;
        b=jQ66prh718gJMoV+1DBJtLQlPCRpQ4+XIFJK/vf7k/tNMPP/W9KwYeStWKmJMNIZo+
         rYv4DtnE13DYgYoT+F4sNQwkiRK4U6DTEmVM9Dm8F+3cQAufXwYUplZRDP422LLFcP2Y
         CaisK1TnXNgJPl+Cso+4ACyAdCf9ik3W2kscwrmRrieRkINOalvXpjBpFRypWGw64prF
         jEZezp6JZ/XTAw0A4Y2Ur5KVF4HEP4+LXsOvSO9tS2lx4eoX64gh/r4hkn4L/QZPhd/a
         0vTWpGGNgtIhTvI2B1BnA7etyTIaTeDLyQIY6bnAUaHasIseFlIOs82wFC3PXbF+i+15
         /tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kMyTupLDldKkb1lWgqnDbAPS5C9Z9guf82HYxQir48s=;
        b=LWjCybDEJXwSwZv6R786TMmeWs2TbCXKq+pZqeJGMqsLSms09Y+g8Tq3+kIMDou6jS
         Sf7mGx4yQDP3ak4bE/cV5QomSlUMfVBaFRrvvlZaLbuvRr66OQGBDON0UXptqem5b/cH
         xOyWedo7FH7+qO45Ro3WAUXxjbYP3TRcZ/jKFnYQf/1qUs+TD68oNXA/mwGQtHaxsMZd
         KNg3Pcn9hbwzi30c0tzNWN9dy8Vs/nJkMQn+bx7waV+PoqPSMYrIQ5tSMKt682tTdAuJ
         3T9TXYTRRntLUZqLyJSpIFGAb2Gut48hJ9I+tk0RjhWwZeVhPcrlV0UasbcnAELjGJ0Q
         LGHQ==
X-Gm-Message-State: APjAAAXJLQlgQU81hq72VzGsqoCF6sdzt/5axt/F8Ye3LY9l4fu75Nbk
        f2rB0ZFEKO1pKb3xNoBSOAWjmIjT
X-Google-Smtp-Source: APXvYqyNTQ004k6VM4DiJi8Is8tpAR7kdicrxmD6COOyDlac1QAKY6mJPzFt8QaZkQVle83gzFNVog==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr89419656wrn.75.1578078280497;
        Fri, 03 Jan 2020 11:04:40 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f16sm60822416wrm.65.2020.01.03.11.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 11:04:39 -0800 (PST)
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
Subject: [PATCH v3 1/2] dt-bindings: reset: Document BCM7216 RESCAL reset controller
Date:   Fri,  3 Jan 2020 11:04:28 -0800
Message-Id: <20200103190429.1847-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103190429.1847-1-f.fainelli@gmail.com>
References: <20200103190429.1847-1-f.fainelli@gmail.com>
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

