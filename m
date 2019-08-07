Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B83DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D5622297
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ao2pGRXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389096AbfHGRFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:05:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37948 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389067AbfHGRE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:04:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id m12so3111315plt.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vhZ9nsrUD9hIgyTDzwXKunAVA/2Wy6GZsnqTKgw2n8=;
        b=Ao2pGRXOpKDk4nbYtcHDtkTBYFkyLx4Yni5jQwZYVlY8sDhj/4xgjNVN9qOgXiwL/J
         Hj2OphsBVTd0gxtiFwK/jvT8Gv1DTq2dJOXWmqdchM0bF5BJWkC3iCG3eF9OjtXp+fhc
         nmdczgH0b4eZWwT+GNRaNSasLDOJCBYHcVdnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vhZ9nsrUD9hIgyTDzwXKunAVA/2Wy6GZsnqTKgw2n8=;
        b=FBW3xTTpA2Cl5mmmtQRU7LxdkqMmNCIddK/JB+LAmYHY3EyWTy4r6pmUwCIH8k9+J/
         wRv0WnTEE4xXrMstI28cATBLktkeEhm+ZZkLiSTQTGPbzPCnwhoWTCIN30bJ12G2DMzD
         FhcH/BTdbBDv1GIPSPoNGplJXz+a3D9m9NDymhm0yj7pttk1VSYCd4MmC7DMpBRgpoRj
         VXBx/ueWR7psqi3VFM7rZVXmC9HblwxpkD8uLhG6Uvi1tpgKS4l9EzJZrrjwqD4Nc/Zx
         o5OM/Wrksjwy65PsZo0bNR0Qnqpi/YThAVdhxWAR65slJkyHv3+uDVVe72IFn3OfCFBY
         wUZg==
X-Gm-Message-State: APjAAAX7uyoFPdTXlAv8Cw/VgTQhBUymyJ3IXn8kyFpPgduJYzTtAk1Y
        wMr7EqTSZcaMlj1tMERKIzeX/w==
X-Google-Smtp-Source: APXvYqxU13J673ziusogsa1/C6DTIQqz7ShxegM9+j0/+rcB+5nM8TkT9NV+jdgAZa9cwmloa9LJKA==
X-Received: by 2002:a17:902:968c:: with SMTP id n12mr9486680plp.59.1565197498966;
        Wed, 07 Aug 2019 10:04:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p187sm146394184pfg.89.2019.08.07.10.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 10:04:58 -0700 (PDT)
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
Subject: [PATCH v5 1/4] dt-bindings: net: phy: Add subnode for LED configuration
Date:   Wed,  7 Aug 2019 10:04:46 -0700
Message-Id: <20190807170449.205378-2-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190807170449.205378-1-mka@chromium.org>
References: <20190807170449.205378-1-mka@chromium.org>
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
2.22.0.770.g0f2c4a37fd-goog

