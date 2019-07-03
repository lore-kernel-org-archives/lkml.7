Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B587C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED0C218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ctbLRFOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGCTho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:37:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45745 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfGCThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:37:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so1713541pgp.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXvptO9miNVQX6P/GNSlZbxo0zu4mNrAE7cY3AYPeMM=;
        b=ctbLRFOSui1ATCTtWhlWFgR+/btEJy5hHBmol2KcteKybq8QttVKOBp4YGRScU6kYH
         4tjsDBBO4rCljL/Fkicauoj9lvRMqhhsj6F6408m/2g9Dh/cUgmjcvde4Oq4OcmvwGYI
         KPguyIjin7hycnJnmQp61Cf5hh+wu5YOXqd5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXvptO9miNVQX6P/GNSlZbxo0zu4mNrAE7cY3AYPeMM=;
        b=BD3Eh0VV/0MvMgtLgSg/6aT+OF+Pn+NEnPMuaMxch4HI2Min8txlhNtnsSZc3TPY9S
         Z1r1KxT4xkoyYdLtBy6P+2YJIh3t7W6t1QJTQOvFIPLcXQQRmSaKrhr39G0yT1kiTMf2
         dNKFSwFlPxEkMhvbaZU870mScGOAvjtzRFE9yrUx9T1Y830nwr2OzUG+W7gYIKd7kqL9
         CMuq7NzPwbcvxAbHErKe99ej/ijcXiV8YZM8IaUp+Tkk7Iy5XM6r6yqEZiDdLzaSrXuO
         FVmgpckKS0sQQ3iwixmn+JA/RiokeXC11mxGvbBjv+n49wUdUbMKLun6Kmwz7TG+aZ9K
         6VqQ==
X-Gm-Message-State: APjAAAU1EAbI1mhq0TrQLg71bPvX/pKu90odRlBsOisv5mWhbeo3u405
        ad5+KvJgQJVJMDxNOVH+PEJwAA==
X-Google-Smtp-Source: APXvYqxAfTzUlNZ5dBxRhN6Mi+9N2fpYHC7cRd7UQ+83UEFHLvWH79iKLt1EuGdZqUSWCCB9OoV76A==
X-Received: by 2002:a63:8c0f:: with SMTP id m15mr38629125pgd.441.1562182658360;
        Wed, 03 Jul 2019 12:37:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r1sm3539210pfq.100.2019.07.03.12.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 12:37:38 -0700 (PDT)
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
Subject: [PATCH v2 6/7] dt-bindings: net: realtek: Add property to configure LED mode
Date:   Wed,  3 Jul 2019 12:37:23 -0700
Message-Id: <20190703193724.246854-6-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190703193724.246854-1-mka@chromium.org>
References: <20190703193724.246854-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LED behavior of some Realtek PHYs is configurable. Add the
property 'realtek,led-modes' to specify the configuration of the
LEDs.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- patch added to the series
---
 .../devicetree/bindings/net/realtek.txt         |  9 +++++++++
 include/dt-bindings/net/realtek.h               | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 include/dt-bindings/net/realtek.h

diff --git a/Documentation/devicetree/bindings/net/realtek.txt b/Documentation/devicetree/bindings/net/realtek.txt
index 71d386c78269..40b0d6f9ee21 100644
--- a/Documentation/devicetree/bindings/net/realtek.txt
+++ b/Documentation/devicetree/bindings/net/realtek.txt
@@ -9,6 +9,12 @@ Optional properties:
 
 	SSC is only available on some Realtek PHYs (e.g. RTL8211E).
 
+- realtek,led-modes: LED mode configuration.
+
+	A 0..3 element vector, with each element configuring the operating
+	mode of an LED. Omitted LEDs are turned off. Allowed values are
+	defined in "include/dt-bindings/net/realtek.h".
+
 Example:
 
 mdio0 {
@@ -20,5 +26,8 @@ mdio0 {
 		reg = <1>;
 		realtek,eee-led-mode-disable;
 		realtek,enable-ssc;
+		realtek,led-modes = <RTL8211E_LINK_ACTIVITY
+				     RTL8211E_LINK_100
+				     RTL8211E_LINK_1000>;
 	};
 };
diff --git a/include/dt-bindings/net/realtek.h b/include/dt-bindings/net/realtek.h
new file mode 100644
index 000000000000..8d64f58d58f8
--- /dev/null
+++ b/include/dt-bindings/net/realtek.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DT_BINDINGS_REALTEK_H
+#define _DT_BINDINGS_REALTEK_H
+
+/* LED modes for RTL8211E PHY */
+
+#define RTL8211E_LINK_10		1
+#define RTL8211E_LINK_100		2
+#define RTL8211E_LINK_1000		4
+#define RTL8211E_LINK_10_100		3
+#define RTL8211E_LINK_10_1000		5
+#define RTL8211E_LINK_100_1000		6
+#define RTL8211E_LINK_10_100_1000	7
+
+#define RTL8211E_LINK_ACTIVITY		(1 << 16)
+
+#endif
-- 
2.22.0.410.gd8fdbe21b5-goog

