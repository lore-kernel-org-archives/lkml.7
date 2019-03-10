Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C265C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EA820657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoAfN9S9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfCJS3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:29:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34856 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfCJS3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id t18so2683448wrx.2;
        Sun, 10 Mar 2019 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5A+248rk4JnvXB1a3PQMyRVG12kf6mt1d++t7Eote1k=;
        b=AoAfN9S9UywUinIsWQ6FAk86WHMsbIkAVgbHTGDWqNph3iNBO3be9o/CiqHMeWYYow
         hlYluqh7ziSGNUcMShiwhrrL5IDXdxgzVIyCSRZxKXmfvDuZ7YM+vCTgac2g97IJgBbc
         1Z5s8f71oKEnBlciPD+zbzh3TOXDxQt1Se5ng6RFeUud3VsiDiv3uH5WN2R1c4fbDx2o
         WUa8oikCGnqmSxZTP1ctz8XkIHfVkXDUyJN0f5UKgkHwyLydTaBJgxwg+EJYBdYWeVZ/
         vj+U1+HjsBsSLQGq6jtJwHwdKYvNoxoxdlArtlLoxuew+B4THtUNdL25SwACz+e2eNSH
         +18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5A+248rk4JnvXB1a3PQMyRVG12kf6mt1d++t7Eote1k=;
        b=dEbUcvKbA7gMjeKi27MbXqze03jYR8/MO+uAguyi+tzGp0ukbSB3yE6KZKZgDMtzui
         8kInMDxiThAW1gXl1DmdBH7vzdgu2LjS3C3Z4mhMMSXgxlyfdqux4ibr7B1/R5ctWjXN
         NfR88fEzOSBY4vRtyuCCQOzEU+CiuaaPDNtPwlUJilFDe4xiK1JteDYzPPe0lM4VN3yC
         f3yviC45O8zpRfx+aeVRj4vaksco0dajG9597k8HQZOjYAC5IX6TmsY64o3s56vf++70
         0vKxq1PTycCX64wTmJ23nZmiba6h1y/F8MN3phpqa5+1r02b6R0GaXBKSXAvYMze4/rb
         CCnw==
X-Gm-Message-State: APjAAAXwoRTpdgK034arrtG1c7/aWeXgq7cNTyb5YYfDTz8M3zL/z66R
        gcgIqkRjNa8ukZ7EBHYSdw2D4uQnzVs=
X-Google-Smtp-Source: APXvYqzlM9Y1+SfQ+SWecSiTtyOC0z0sos7W0C7lV2/e5rQJpFDV5o0FBg4F0YzDTij3OqrTun7YAw==
X-Received: by 2002:adf:e58f:: with SMTP id l15mr17294851wrm.309.1552242558038;
        Sun, 10 Mar 2019 11:29:18 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:17 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH 16/25] dt-bindings: cr0014114: Add function and color properties
Date:   Sun, 10 Mar 2019 19:28:27 +0100
Message-Id: <20190310182836.20841-17-jacek.anaszewski@gmail.com>
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
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
---
 .../devicetree/bindings/leds/leds-cr0014114.txt    | 26 ++++++++++++++++------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-cr0014114.txt b/Documentation/devicetree/bindings/leds/leds-cr0014114.txt
index 4255b19ad25c..311b5dbbacac 100644
--- a/Documentation/devicetree/bindings/leds/leds-cr0014114.txt
+++ b/Documentation/devicetree/bindings/leds/leds-cr0014114.txt
@@ -11,14 +11,20 @@ Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
 apply. In particular, "reg" and "spi-max-frequency" properties must be given.
 
 LED sub-node properties:
-- label :
+- function :
+	see Documentation/devicetree/bindings/leds/common.txt
+- color :
 	see Documentation/devicetree/bindings/leds/common.txt
+- label :
+	see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 - linux,default-trigger : (optional)
 	see Documentation/devicetree/bindings/leds/common.txt
 
 Example
 -------
 
+#include <dt-bindings/leds/common.h>
+
 led-controller@0 {
 	compatible = "crane,cr0014114";
 	reg = <0>;
@@ -28,27 +34,33 @@ led-controller@0 {
 
 	led@0 {
 		reg = <0>;
-		label = "red:coin";
+		function = "coin";
+		color = LED_COLOR_NAME_RED;
 	};
 	led@1 {
 		reg = <1>;
-		label = "green:coin";
+		function = "coin";
+		color = LED_COLOR_NAME_GREEN;
 	};
 	led@2 {
 		reg = <2>;
-		label = "blue:coin";
+		function = "coin";
+		color = LED_COLOR_NAME_BLUE;
 	};
 	led@3 {
 		reg = <3>;
-		label = "red:bill";
+		function = "bill";
+		color = LED_COLOR_NAME_RED;
 	};
 	led@4 {
 		reg = <4>;
-		label = "green:bill";
+		function = "bill";
+		color = LED_COLOR_NAME_GREEN;
 	};
 	led@5 {
 		reg = <5>;
-		label = "blue:bill";
+		function = "bill";
+		color = LED_COLOR_NAME_BLUE;
 	};
 	...
 };
-- 
2.11.0

