Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96866C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B2420693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nrf6evJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfDQU5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:57:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37506 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387442AbfDQUzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id v13so23776411ljk.4;
        Wed, 17 Apr 2019 13:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iEhJTflmg7KQbde2xxTokDIVhFAkE+Q29EtuKzQtszg=;
        b=Nrf6evJozIej00rRseWAnoj/NTaSSpUCybr63EuD1uhk6WeHTmrUxVH/QmNhSz7TiM
         IEEjqqv0Q+aYyfThhAqevoZefKrXKZB6r63IWmOCka37NeLuZ3QGs5PsS4uYRxCHuU+v
         6tjbczoJMgwrXmsIwQdQdEyRWr7PQMOOlbiPfoehFyeHTXpStrGoOa1Czy3UyDFdWkg+
         T3wNxR5jNN2q/TdWFDQvtJIEm/rCCUQ6lbFbwopM0VXE2MSek7YbuEqNgLHWXyCP0AVh
         bFA/BvtnXVJjCu9kK+BT7DTjoAXWEl/qUgbDLUR1Qmq287lyMXpg95yMfgBYb47azV0E
         y69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iEhJTflmg7KQbde2xxTokDIVhFAkE+Q29EtuKzQtszg=;
        b=rzWTBD/2FnQNx6KiMYLj/jwFBK0RVfqjYSCimQJZuF/SVyt5I/vYgBmHHBYew2Jirz
         FO3Ybaw3Xi1HdEswIv8CSjwx3GxWvX+QlrAENPeV/zdNRWiUXlNoIY1fgOgA3lG/sfj4
         I4glZom6k98LwD+JqYhjQ6iyhaBqWHD02lZOZYDvtVVPsoI44YsJvoNfXCrbAApxaZPj
         HQkln5dhvPb0+cg8+7EfmH5jk1ooCg1NVAOtP2M9+4ANBwR0HxvBYGUye/kN+XGIfP0W
         wgXcpp48u4zagk7L2xkwZ3faU928PnS2nclg7EH5lvm1Ra2aO3JLy5iw9m4aX8EKMCFM
         xrAg==
X-Gm-Message-State: APjAAAVC7Oov3wRd3sZM6WK/TVCVLJ9jABXgc5TVLgZaj4ssDDm6cDnr
        NZ8PbiKp9tF17Q33b457s9g4YfWqBRs=
X-Google-Smtp-Source: APXvYqyvI4X4RdHlOT14HdA+iSoZj7ezjqv1xh0o0DTiziOKK+7hBkHxe9zk9jqiK1USSP99iMctKQ==
X-Received: by 2002:a2e:731a:: with SMTP id o26mr48619313ljc.69.1555534506946;
        Wed, 17 Apr 2019 13:55:06 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:06 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v4 07/26] dt-bindings: sc27xx-blt: Add function and color properties
Date:   Wed, 17 Apr 2019 22:54:20 +0200
Message-Id: <20190417205439.17685-8-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
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
index dddf84f9c7ea..df2b4e1c492b 100644
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
+		color = <LED_COLOR_ID_RED>;
 		reg = <0x0>;
 	};
 
 	led@1 {
-		label = "green";
+		color = <LED_COLOR_ID_GREEN>;
 		reg = <0x1>;
 	};
 
 	led@2 {
-		label = "blue";
+		color = <LED_COLOR_ID_BLUE>;
 		reg = <0x2>;
 	};
 };
-- 
2.11.0

