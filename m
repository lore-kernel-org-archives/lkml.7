Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CB4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113B020657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT/qx71H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfCJSaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:30:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37938 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfCJS3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id a188so2192281wmf.3;
        Sun, 10 Mar 2019 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yMTlUNNmUOMV1zYadWHv3Crjm4aF5ceU1QT1t1CeYUA=;
        b=WT/qx71H722tMedjlMl/jPlfLJeg6jWNjClddkP9FNiDB1v1WOJM4hROcVbTA7Jcj5
         UU825NYDzGl7kWDz2jdGNFMVTnmNQssJ8OE8GFgHBHTLtP6doJmcxkcLHA4Gs2nk8d+T
         JKECH320jtDkGgvnESffVrnY2rrhfwL3ttjLrKOyg79Wkfs0nNsqoVwbzHkNhyXdDu3k
         8nbncSpwiDTo1yaVmoYARYhgrQ3/O1cIMCKksoy13546uhzKBDNNAQi5G/h/0nu//2hn
         /u///PR9UwvRFDL5oVuxLh21DSrBtgG1GxBstIKNwtbyTbMu972pftm/rOOqfh6kk+Mm
         /w1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yMTlUNNmUOMV1zYadWHv3Crjm4aF5ceU1QT1t1CeYUA=;
        b=cTXAnx91MlERYI7tqrdG1nQs4nj+F2Mnh2TgQEsiC1meW2waQHLsupUxHdLuAmbh2e
         9BdVgPX9Aio2xXz59SrmN10jIGio0HgwZdUtX3cWpH5DnS5wlNgZfIE8Hg/7TVwzxFtw
         Eld6nf2OiVIpIKcGziQcG0NGLL7GbLodQqC7avBtxd1laVkcqNjtD9mI5qH86OhVsKTt
         G8ge0PGTO9/exU8TwalG5x1HJuoO3O9IlMMdeRMoCxaPo3DV9HpcQJAX15X3CSV+w0Jn
         9DxapeDbdoxDxdXBZ4mph5GXRTocVVgGpFtCDsw8Vq7kld0uDUmLjsJV6c8NsPN8b2Fy
         9O7A==
X-Gm-Message-State: APjAAAVf3I1v8zUdYl2Jk3jhq9KDymglMk44rayvYh2y6Z5qCmDjWb+E
        ta9BNn8eW5+Ai+sjFiCq8odtGBuiS0Y=
X-Google-Smtp-Source: APXvYqxWMbu27yegvWknnX1SkozlMp7y3FwXuzLRqWt1WLq4gYh03o3sUMsQk50wWuA3KsAhWCc73Q==
X-Received: by 2002:a05:600c:2143:: with SMTP id v3mr14741461wml.14.1552242552921;
        Sun, 10 Mar 2019 11:29:12 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:12 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 12/25] dt-bindings: lm3692x: Add function and color properties
Date:   Sun, 10 Mar 2019 19:28:23 +0100
Message-Id: <20190310182836.20841-13-jacek.anaszewski@gmail.com>
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
Cc: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/leds/leds-lm3692x.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
index 08b352840bd7..c15806235e85 100644
--- a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
@@ -26,12 +26,16 @@ Required child properties:
 		3 - Will enable the LED3 sync (LM36923 only)
 
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
 led-controller@36 {
 	compatible = "ti,lm3692x";
 	reg = <0x36>;
@@ -43,7 +47,8 @@ led-controller@36 {
 
 	led@0 {
 		reg = <0>;
-		label = "white:backlight_cluster";
+		function = LED_BACKLIGHT_CLUSTER;
+		color = LED_COLOR_NAME_WHITE;
 		linux,default-trigger = "backlight";
 	};
 }
-- 
2.11.0

