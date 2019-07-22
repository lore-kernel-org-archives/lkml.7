Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1549AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE53D21951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oZeSMJbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbfGVWhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:37:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40833 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfGVWhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:37:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so18048833pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 15:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksKwryEikYhGjVkpLSJ2d7zQCe8DuUqlv4mo/6HaEeU=;
        b=oZeSMJbt0AMfUZPBYDSCg4WDd9WxdkA5VTPVj7eIrqhB9+oyCLIlIlmCAp0FfLhCn2
         mQH6DkYbYMdSNqq1Wwm8/jAQ5K5IBuBNwu5F/ZolyJt0haMsYHshsEak6SQLacKy9YIF
         /8lA61DNQwHthtx5RoCPShginCpRzSTn/FKyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksKwryEikYhGjVkpLSJ2d7zQCe8DuUqlv4mo/6HaEeU=;
        b=hbdsa75DeNzoWhXONd036XeT7TLKmzQiqrhYiaVT/CBSmuFld4RRP8uMUcaFCKl6a7
         wNSJfV6PglNbobo40ZTQpjD18dgvdfK2oUMM0+xL67PKRldcXMxSkCS7QCfdcQF2Rwxn
         Kn0SBKvKHvNOYJ+WXGF45gzEWolpXSbkbXyTdxAtXTtPJqJg/JjlJaepv2YIIcOGapO5
         3bm8mx232nzaj7CQeUJCkYMXhaNUdcdYX/AVYHLqZbcehoc4cuHAX7+T4VdVspti2j/r
         lasrFlI37Hw+HdkZsfPGL4trXOSNrJotrR9SQ4zXiRuL4Q81Q1a/sQgEZfQoBC9+6D29
         px6Q==
X-Gm-Message-State: APjAAAUP62WZ//hcIANJy1h9CvCefNHBLCq4KxK5N0jB6Ft+91M4K/2x
        7vTS0FtcQdQwXjKoFIGlxiMkRw==
X-Google-Smtp-Source: APXvYqyS9yizw3stJJhRM+H3zAzF1AcZwtMk43vghhExuNNSliENqS82wWyYIXqTwhiz8bvfLQrEyA==
X-Received: by 2002:a63:2b0c:: with SMTP id r12mr73672130pgr.206.1563835067619;
        Mon, 22 Jul 2019 15:37:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l124sm40587935pgl.54.2019.07.22.15.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 15:37:47 -0700 (PDT)
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
Subject: [RFC] dt-bindings: net: phy: Add subnode for LED configuration
Date:   Mon, 22 Jul 2019 15:37:41 -0700
Message-Id: <20190722223741.113347-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
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

A LED can be configured to be 'on' when a link with a certain speed
is active, or to blink on RX/TX activity. For the configuration to
be effective it needs to be supported by the hardware and the
corresponding PHY driver.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
This RFC is a follow up of the discussion on "[PATCH v2 6/7]
dt-bindings: net: realtek: Add property to configure LED mode"
(https://lore.kernel.org/patchwork/patch/1097185/).

For now posting as RFC to get a basic agreement on the bindings
before proceding with the implementation in phylib and a specific
driver.
---
 Documentation/devicetree/bindings/net/phy.txt | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/phy.txt b/Documentation/devicetree/bindings/net/phy.txt
index 9b9e5b1765dd..ad495d3abbbb 100644
--- a/Documentation/devicetree/bindings/net/phy.txt
+++ b/Documentation/devicetree/bindings/net/phy.txt
@@ -46,6 +46,25 @@ Optional Properties:
   Mark the corresponding energy efficient ethernet mode as broken and
   request the ethernet to stop advertising it.
 
+- leds: A sub-node which is a container of only LED nodes. Each child
+    node represents a PHY LED.
+
+  Required properties for LED child nodes:
+  - reg: The ID number of the LED, typically corresponds to a hardware ID.
+
+  Optional properties for child nodes:
+  - label: The label for this LED. If omitted, the label is taken from the node
+    name (excluding the unit address). It has to uniquely identify a device,
+    i.e. no other LED class device can be assigned the same label.
+
+  - linux,default-trigger: This parameter, if present, is a string defining
+    the trigger assigned to the LED. Current triggers are:
+      "phy_link_10m_active" - LED will be on when a 10Mb/s link is active
+      "phy_link_100m_active" - LED will be on when a 100Mb/s link is active
+      "phy_link_1g_active" - LED will be on when a 1Gb/s link is active
+      "phy_link_10g_active" - LED will be on when a 10Gb/s link is active
+      "phy_activity" - LED will blink when data is received or transmitted
+
 - phy-is-integrated: If set, indicates that the PHY is integrated into the same
   physical package as the Ethernet MAC. If needed, muxers should be configured
   to ensure the integrated PHY is used. The absence of this property indicates
@@ -76,4 +95,18 @@ ethernet-phy@0 {
 	reset-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	reset-assert-us = <1000>;
 	reset-deassert-us = <2000>;
+
+	leds {
+		led@0 {
+			reg = <0>;
+			label = "ethphy0:left:green";
+			linux,default-trigger = "phy_link_1g_active";
+		};
+
+		led@1 {
+			reg = <1>;
+			label = "ethphy0:right:amber";
+			linux,default-trigger = "phy_activity";
+		};
+	};
 };
-- 
2.22.0.657.g960e92d24f-goog

