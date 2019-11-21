Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B343CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B80620672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGAi9mOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfKUTCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:02:00 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43530 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfKUTCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:02:00 -0500
Received: by mail-io1-f68.google.com with SMTP id r2so4706424iot.10;
        Thu, 21 Nov 2019 11:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8rpCD9rYYwa0faJPn9zZeednYRLE+tWPhyK/GFBhRbo=;
        b=HGAi9mOl1G/6fKsA6XGAYgUInx2JHYMfr3B8kIRuTIRgKNbq2q5a4TK/7FGW/EYEm3
         TjfnXuTAmMPA8pc+diXLtyDHaZA4rOPzcxC449cv7yZjU9NPHPrtYsDG9O5c6CF7PXNL
         6C/hd5DZLpzACcFoQzOz5py5+wYzBZYHr2HB/bKU/P+HKSAidwvAlwQb9vZyV9xCJgql
         +oPZ5ym81mBNl+sY7tGJS0BN6tDE4pna7lOfLhPBML82rzQHVZfJBRTrpT+bWZaZl1Cl
         GZ07cVMkoiQ7It2EvT93xGG1NegvZXRhmdje+0Fb3Dbkgw5UT/4vr8ByJMQwuKvHvG7A
         hkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8rpCD9rYYwa0faJPn9zZeednYRLE+tWPhyK/GFBhRbo=;
        b=tyzADLS6eagkLN+Oc7HgpJtkOwxwohHWYvcjANPwYRDXJn/30/YrUji2t5cqL3Kg73
         ur12JsAw1EcQtfIX8mnZefvV2Dgepg5an9xCYDJnDF2bYqpgr/DiFc8MyZOzHr/MrN/e
         biO1XUZL+KFJoI+sX4NgRLL8bbw8y5ljrYxI8VpNOx518YCHSPKDgi7NpaWwBNo4jGo8
         dicRlDzrSDugaeBEEYNsHiDNuQ5V9kc+K1OrLGbOxEnyq4TbdLEY990sKwpyy/xbF9jW
         OwfgdBh4Th3A8wBRA3BUW/gZTEVIRCpwpk5mA3/101Vxj7kKve55D8KRIHHMNVJQkl6V
         emWA==
X-Gm-Message-State: APjAAAWzLefK1Pxb5GFBIdyAfy9dUk80TecOj0gj1da9TguWs0/TC/Rb
        wGMaYHIE5okyzKhGiYxkyb+pTR2l
X-Google-Smtp-Source: APXvYqyojkqHmYVutVHekAu4uYyt23an4xkkRX4nZvAeLppKlJoIfSHmuxMj0Co+s9oC4mZAJdorlQ==
X-Received: by 2002:a6b:6f09:: with SMTP id k9mr8725846ioc.91.1574362918844;
        Thu, 21 Nov 2019 11:01:58 -0800 (PST)
Received: from localhost.localdomain (c-68-55-68-202.hsd1.mi.comcast.net. [68.55.68.202])
        by smtp.gmail.com with ESMTPSA id x1sm1204053ioh.59.2019.11.21.11.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:01:57 -0800 (PST)
From:   Jason Kridner <jkridner@gmail.com>
X-Google-Original-From: Jason Kridner <jdk@ti.com>
To:     devicetree@vger.kernel.org
Cc:     Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jason Kridner <jdk@ti.com>, Jyri Sarha <jsarha@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Add vendor prefix for BeagleBoard.org
Date:   Thu, 21 Nov 2019 14:01:24 -0500
Message-Id: <20191121190124.1936-1-jdk@ti.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for BeagleBoard.org Foundation

Signed-off-by: Jason Kridner <jdk@ti.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..3e3d8e3c28d3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -139,6 +139,8 @@ patternProperties:
     description: Shenzhen AZW Technology Co., Ltd.
   "^bananapi,.*":
     description: BIPAI KEJI LIMITED
+  "^beagleboard.org,.*":
+    description: BeagleBoard.org Foundation
   "^bhf,.*":
     description: Beckhoff Automation GmbH & Co. KG
   "^bitmain,.*":
-- 
2.17.1

