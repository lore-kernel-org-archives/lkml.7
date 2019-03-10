Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA7DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7905F20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiGI1fkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfCJSam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:30:42 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:38983 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfCJS3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:12 -0400
Received: by mail-wm1-f45.google.com with SMTP id z84so2203670wmg.4;
        Sun, 10 Mar 2019 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AhQIwe/gxRnDRcjlbe2VznqprPge1pjrgW8dTQ2ChFE=;
        b=TiGI1fkwyx5dcwV5PMpQDAvWcHdDPohVGv1eW9EXRCLzNKbkVOKK13M4f+BDC5xXse
         U6rtsbjhVJdIMwyvvUAkEF5ybm+SKkF/9rihayXTkQ0Cm9Ex3NQbA/4dCCJCiafe5OFl
         3rH7aok85w7m5ii/O4Z6ogufbmXgcrAB9UXyyhEpwzAKO5jMW3Ts8rlSAplnrqIwXDzX
         zNqIaLRI4XkIp5nvBSbXMwOo5I+ER0a2EPEEbotVfnMqDejQCIjgHadJ4AnftgcPHXU8
         FgtDP0tIayfCyTdsuutzBCWziGhdKV/N1pLFSK6+o2MS2RksjIam70rNXHnXSA31SviR
         LoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AhQIwe/gxRnDRcjlbe2VznqprPge1pjrgW8dTQ2ChFE=;
        b=ose2fsK4EnjZCfUc4jHy5faimqqIhPAAf7Or5OVCgho0VVRl/vcajsgW3z7HIeJYhW
         IozhzQ+WtcNjPYBbpOrZ9fPXS8AXvoHsMwhkH3LvEDMzJx3ilhrmvdNYPRc6MUyFwXq+
         CIae1PdOmZT/Fcqr1eR2YCCyzdPMcFFmAI8JcIpGLzOr8VoFUOlaZo9I6RCqOdZYQK9k
         /vIEOjqRNfoAiUQr9MMdNQ2NO9o6tH+UaUp+xyNDSsz4nnKbhmUZkNF8MgfaiBw2038C
         6Ofv6V2tr4Z1D7sboq9iOTC2LZ+mEg8IG8dB/MReVN8dukA9oNPAGlHbQQHlOPbZF8xF
         a1Mw==
X-Gm-Message-State: APjAAAVQonwifDHg1hkzbl5DVrJ1tp4Ngp5ietSwkFqxYzOh8JT/oadh
        v9U4vYNC//3KMVKHyq/MPmBisMsX
X-Google-Smtp-Source: APXvYqzExIUvVpmnnFETqdkekEm4KcurQ0lWKVMM0U5ikog0dIGsG4AFkeg1eacBVK5N2/U4paISKQ==
X-Received: by 2002:a1c:4844:: with SMTP id v65mr16019379wma.66.1552242550099;
        Sun, 10 Mar 2019 11:29:10 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:09 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com
Subject: [PATCH 10/25] dt-bindings: lp8860: Add function and color properties
Date:   Sun, 10 Mar 2019 19:28:21 +0100
Message-Id: <20190310182836.20841-11-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/leds/leds-lp8860.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp8860.txt b/Documentation/devicetree/bindings/leds/leds-lp8860.txt
index 5f0e892ad759..623065a55ed8 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp8860.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lp8860.txt
@@ -20,12 +20,16 @@ Required child properties:
 	- reg : 0
 
 Optional child properties:
-	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- function : see Documentation/devicetree/bindings/leds/common.txt
+	- color : see Documentation/devicetree/bindings/leds/common.txt
+	- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 	- linux,default-trigger :
 	   see Documentation/devicetree/bindings/leds/common.txt
 
 Example:
 
+#include <dt-bindings/leds/common.h>
+
 led-controller@2d {
 	compatible = "ti,lp8860";
 	#address-cells = <1>;
@@ -36,7 +40,8 @@ led-controller@2d {
 
 	led@0 {
 		reg = <0>;
-		label = "white:backlight";
+		function = LED_FUNCTION_BACKLIGHT;
+		color = LED_COLOR_NAME_WHITE;
 		linux,default-trigger = "backlight";
 	};
 }
-- 
2.11.0

