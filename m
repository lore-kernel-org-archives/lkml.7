Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145F8C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD2720840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WyIrrUoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfHMTL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:11:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41406 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfHMTL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:11:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so41402764pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F5AyXCx/QmI9rH4K6aLYamGqeaWZ1S6PDC5Nf41bKkw=;
        b=WyIrrUoUSkNtHBI9z7wgaA6fP/WFma1wFLGLMPg/xMvcK91Ci0rniw350VSEV3p88K
         4VORSA1Wn7T06D+JBLhklkIUi+3LXgvFSSQwpyrLsm22zykF/i1Fj5tEupn+EQc6Vq86
         DOCPK8lgV8FgIsSan0/coGwMLEFlFO8ohJAkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F5AyXCx/QmI9rH4K6aLYamGqeaWZ1S6PDC5Nf41bKkw=;
        b=h/EJ/95ORhVIPg00fV3a4xpxi/c//E67+R0bDA1bzEhI0swVFzk+QVq28bgSp3K24t
         8mvy64TGpe/SOAItqyqWDe5iU6CzW/fLM62Tt4ZLaZlIRuEHe2IS5lCgM4h/eXcVd9pT
         aHdQ9MbdidTd78fql66Wp+rbvbmDVa1PkpwDdJ8TKVq9WtKhFAMpdTglG5QPJZvUs5yF
         zGjuoWuJTRwjBmHWKOb3HJrmar0dlBMJdo4/IR5Zbunf/J5HAXovd9SqlzFCm6ASKMVa
         vjDgJ5UODXmD/ZqMxqILYHWJWGlfBGYzHweui08ftTuwIPbkQfIgUzPPVakBTCWqu2yH
         HJvw==
X-Gm-Message-State: APjAAAUOvg4QU98w1eY6/os6giJbLkZtlvxU7p9WDqjxixWkG3l+yFOA
        gzderDKmvcT09QNmXc6xQx6brg==
X-Google-Smtp-Source: APXvYqwePoQk7GtsasNE2CHPI7WEOyjvLAhhK8sOQJR6FcIy5NGuw+eiY4/p+PQAE7XhzEHVCHYlwg==
X-Received: by 2002:a62:cec4:: with SMTP id y187mr42137245pfg.84.1565723516634;
        Tue, 13 Aug 2019 12:11:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e13sm2836023pff.181.2019.08.13.12.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 12:11:56 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 1/4] dt-bindings: net: phy: Add subnode for LED configuration
Date:   Tue, 13 Aug 2019 12:11:44 -0700
Message-Id: <20190813191147.19936-2-mka@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190813191147.19936-1-mka@chromium.org>
References: <20190813191147.19936-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LED behavior of some Ethernet PHYs is configurable. Add an
optional 'leds' subnode with a child node for each LED to be
configured. The binding aims to be compatible with the common
LED binding (see devicetree/bindings/leds/common.txt).

A LED can be configured to be:

- 'on' when a link is active, some PHYs allow configuration for
  certain link speeds
  speeds
- 'off'
- blink on RX/TX activity, some PHYs allow configuration for
  certain link speeds

For the configuration to be effective it needs to be supported by
the hardware and the corresponding PHY driver.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v6:
- none

Changes in v5:
- renamed triggers from 'phy_link_<speed>_active' to 'phy-link-<speed>'
- added entries for 'phy-link-<speed>-activity'
- added 'phy-link' and 'phy-link-activity' for triggers with any link
  speed
- added entry for trigger 'none'

Changes in v4:
- patch added to the series
---
 .../devicetree/bindings/net/ethernet-phy.yaml | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index f70f18ff821f..98ba320f828b 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -153,6 +153,50 @@ properties:
       Delay after the reset was deasserted in microseconds. If
       this property is missing the delay will be skipped.
 
+patternProperties:
+  "^leds$":
+    type: object
+    description:
+      Subnode with configuration of the PHY LEDs.
+
+    patternProperties:
+      "^led@[0-9]+$":
+        type: object
+        description:
+          Subnode with the configuration of a single PHY LED.
+
+    properties:
+      reg:
+        description:
+          The ID number of the LED, typically corresponds to a hardware ID.
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+
+      linux,default-trigger:
+        description:
+          This parameter, if present, is a string specifying the trigger
+          assigned to the LED. Supported triggers are:
+            "none" - LED will be solid off
+            "phy-link" - LED will be solid on when a link is active
+            "phy-link-10m" - LED will be solid on when a 10Mb/s link is active
+            "phy-link-100m" - LED will be solid on when a 100Mb/s link is active
+            "phy-link-1g" - LED will be solid on when a 1Gb/s link is active
+            "phy-link-10g" - LED will be solid on when a 10Gb/s link is active
+            "phy-link-activity" - LED will be on when link is active and blink
+                                  off with activity.
+            "phy-link-10m-activity" - LED will be on when 10Mb/s link is active
+                                      and blink off with activity.
+            "phy-link-100m-activity" - LED will be on when 100Mb/s link is
+                                       active and blink off with activity.
+            "phy-link-1g-activity" - LED will be on when 1Gb/s link is active
+                                     and blink off with activity.
+            "phy-link-10g-activity" - LED will be on when 10Gb/s link is active
+                                      and blink off with activity.
+
+        $ref: "/schemas/types.yaml#/definitions/string"
+
+    required:
+      - reg
+
 required:
   - reg
 
@@ -173,5 +217,20 @@ examples:
             reset-gpios = <&gpio1 4 1>;
             reset-assert-us = <1000>;
             reset-deassert-us = <2000>;
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    linux,default-trigger = "phy-link-1g";
+                };
+
+                led@1 {
+                    reg = <1>;
+                    linux,default-trigger = "phy-link-100m-activity";
+                };
+            };
         };
     };
-- 
2.23.0.rc1.153.gdeed80330f-goog

