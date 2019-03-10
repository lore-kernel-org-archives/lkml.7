Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44E4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD1E2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="po+ELMug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfCJSbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:31:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37930 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCJS3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so2192120wmf.3;
        Sun, 10 Mar 2019 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PymmEnRdwIKr9YKH2uBcUo/Frl2MK1Mw0y8FSvhA2qQ=;
        b=po+ELMugPVb21mcV11zAkjR54B4g2lzDmrcM1aAG+hLHgSOO/Wc298gkNf/r8OU737
         fNJ63yl+ZMqP8tswI8fThBY2QWQfsQdINtqBqX/lx910DbOZxxs5wV3RExEw6BpQwEFC
         UVCXNE3Ehb4VUIk2Yxo1ZB/BX+TJ0XO7wOc2HzzOIY/EgC4Ah/JqX7ir+ftpiIs/3aoe
         H65OcL7CDxdxArpGpVarApEzONHTKeFC+LphF1tpsVuhrXW9HgbryO9MRsXVgo0AEy4q
         Joz0yQx65F78EhvtSucHFlHZx0jOnStDbOqY/KhAY8cYozcY5NCYH94KgL5nItKE4Pkx
         SgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PymmEnRdwIKr9YKH2uBcUo/Frl2MK1Mw0y8FSvhA2qQ=;
        b=I5IMnhplFJPJBPAXWZpxFNzs89UNjPnzIM6MHt2bAtua5COIkzNA5kPyFBigjScz3T
         B/epINYV/jQPjwgtv7YOZ+E22HEptxTWUA5TglPcQGMT1TnwTjeUKaroQMtQvIjp1Px4
         u7YGd46oFBGeoZhdSjTNEH9fk4ejc8UxBqrQLkgWL5UFM+8yEpIQOIYaBTovD0bjKrQb
         m9Z2Zdp1dSuVGUjBKdfg6gUcEz+dqxR2qiejhHrz/fqPzEw/KQeDnp4Vtvc+cvYBMy8x
         GjPHlGg8RJI5r9m96VUvAIhIp2M8z3IdAg36otgSmv6p5y075SHlrbaG1cdkoc8oWjif
         DeQQ==
X-Gm-Message-State: APjAAAXNygOL8PMrC3WlRakjrOcoPNWqkKg0rPZpd8dAguX7A6lVo/PF
        g/lwehEOAO80BFV740Sk/7w93Mb+
X-Google-Smtp-Source: APXvYqw9InWk/sgQKl60d8DNdGh8welZSF6R2wEZ/LWNPX5Ck9I7hMRaqwqH9LaiY8GcdqvV0ABcRw==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr15806833wma.101.1552242545152;
        Sun, 10 Mar 2019 11:29:05 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:04 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 06/25] dt-bindings: sc27xx-blt: Add function and color properties
Date:   Sun, 10 Mar 2019 19:28:17 +0100
Message-Id: <20190310182836.20841-7-jacek.anaszewski@gmail.com>
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
Cc: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
index dddf84f9c7ea..0073dcea0761 100644
--- a/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
+++ b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
@@ -14,7 +14,9 @@ Required child properties:
 - reg: Port this LED is connected to.
 
 Optional child properties:
-- label: See Documentation/devicetree/bindings/leds/common.txt.
+- function: See Documentation/devicetree/bindings/leds/common.txt.
+- color: See Documentation/devicetree/bindings/leds/common.txt.
+- label: See Documentation/devicetree/bindings/leds/common.txt (deprecated).
 
 Examples:
 
@@ -25,17 +27,17 @@ led-controller@200 {
 	reg = <0x200>;
 
 	led@0 {
-		label = "red";
+		color = LED_COLOR_NAME_RED;
 		reg = <0x0>;
 	};
 
 	led@1 {
-		label = "green";
+		color = LED_COLOR_NAME_GREEN;
 		reg = <0x1>;
 	};
 
 	led@2 {
-		label = "blue";
+		color = LED_COLOR_NAME_BLUE;
 		reg = <0x2>;
 	};
 };
-- 
2.11.0

