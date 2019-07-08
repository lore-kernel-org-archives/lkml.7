Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E63C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621B7217D8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Swc5kxgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404036AbfGHTZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:25:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42756 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403832AbfGHTZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:25:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so8061464pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XWbP/dCS1tGcjo88wg6gDGGHLplE0DvcXvP3Oeiy9UU=;
        b=Swc5kxgl5rIe9OaAt1N63AxfODEw3kumM3N8MfT45AsUykZcx27fjKTzNBUG/UiLq9
         C7cZNxvR8HdtbUbPAIxPiFZsVOlFA4KpZF1Rc2hua3Pg4jqsafBYtCO/b13DdOEhzjMn
         zbFl+OUTwbyNtzVkXFsZO6t0w1KS0rr3xvFSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XWbP/dCS1tGcjo88wg6gDGGHLplE0DvcXvP3Oeiy9UU=;
        b=k8t/0z8zvN0z4RjyunUltenXuiaMBp6OFojITYhE7dgV095Z8a2sxlo+fBFTtuAshr
         bhpmgux0hQ2Bd54TkrKCkp17Q/DArqKly4oHSIX9Mf2JRa+6LNmSMQi5GOUwwRL7+xCi
         tR3LoxKS3kHXE4vNSlcopL0LZQBEoohUWWKsdvrgfDe7eGsF2TDChgc36dumwKe91EHe
         d1JmF96Y3pCm8W0Av6BS6RnBAmN6tU5K1HubxeT8pzv7qNgqXIszK5EKY6Ow+hLIsW3T
         lOrxxlp3u+zQWu4O0Y4waEtx3as0WhON9GyvscS0//YTbpd65LuzIKP47QN3ITBEXVzA
         ahBQ==
X-Gm-Message-State: APjAAAVkrDzBWtbKrGVOG2ZZYPMcArdSuzOfTWfOKdQ0QowoZJSMILjR
        xt3ql6e6or3Y+o+w7N2ElvCwsw==
X-Google-Smtp-Source: APXvYqxj8gwX0MrPf9c4HdvT72aVScvAKz1wrH5AksRYEurt1SzUJRc1/Q7Jf6KoqCILHaraNuL+Fw==
X-Received: by 2002:a17:90a:17c4:: with SMTP id q62mr28281541pja.104.1562613918931;
        Mon, 08 Jul 2019 12:25:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e13sm14330483pff.45.2019.07.08.12.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:25:18 -0700 (PDT)
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
Subject: [PATCH v3 6/7] dt-bindings: net: realtek: Add property to configure LED mode
Date:   Mon,  8 Jul 2019 12:24:58 -0700
Message-Id: <20190708192459.187984-7-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708192459.187984-1-mka@chromium.org>
References: <20190708192459.187984-1-mka@chromium.org>
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
Changes in v3:
- added RTL8211E_LED_OFF to LED modes
- changed wording for supported PHY models

Changes in v2:
- patch added to the series
---
 .../devicetree/bindings/net/realtek.txt        | 11 +++++++++++
 include/dt-bindings/net/realtek.h              | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 include/dt-bindings/net/realtek.h

diff --git a/Documentation/devicetree/bindings/net/realtek.txt b/Documentation/devicetree/bindings/net/realtek.txt
index af2824664f08..ab218f2b7653 100644
--- a/Documentation/devicetree/bindings/net/realtek.txt
+++ b/Documentation/devicetree/bindings/net/realtek.txt
@@ -19,6 +19,14 @@ Optional properties:
 
   Only supported for "realtek,rtl8211e".
 
+- realtek,led-modes: LED mode configuration.
+
+  A 0..3 element vector, with each element configuring the operating
+  mode of an LED. Omitted LEDs are turned off. Allowed values are
+  defined in "include/dt-bindings/net/realtek.h".
+
+  Only supported for "realtek,rtl8211e".
+
 
 Example:
 
@@ -32,5 +40,8 @@ mdio0 {
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
index 000000000000..023cb776a7a3
--- /dev/null
+++ b/include/dt-bindings/net/realtek.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DT_BINDINGS_REALTEK_H
+#define _DT_BINDINGS_REALTEK_H
+
+/* LED modes for RTL8211E PHY */
+
+#define RTL8211E_LED_OFF		0
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

