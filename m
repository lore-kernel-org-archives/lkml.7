Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5539FC282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204BA20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxNFQTJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDHJWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:22:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41288 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfDHJWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:22:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so15424275wrq.8;
        Mon, 08 Apr 2019 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gehye2PBes+2WkveZsU+3KMZWypo81Tcgj6ag1K6XNQ=;
        b=CxNFQTJlCof2qOWt0eb+qDsKhVDXu9GUwUYIOb+NjYTw/NGQpk6k9CZAPc97PamOfF
         ytc+DUGvHHM+Z7fzhJ/1Pcj85aTmD5ZHBaY1zVRuFs9uAfrJkhri3QB4Tou2exe4t39f
         I2XWmJoYtlSlYcNpztL9X9Aozuy4n6auar7Zl5/WlZXyxAWleyhXLkc9kYtrzbug4zRY
         CQIy6rqlLxIiWKgEuW6fnK73VD0Bf/T27VWkB5oMy2LgUZnB0CwI+YvgVFJViaSwpNMX
         n2VPQOnGlVEaB/ua1Jyuk1jpB8xVxhnLYRaBOYJBLUjOxGqkQiACs4AEASufQcqKV+8x
         rVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gehye2PBes+2WkveZsU+3KMZWypo81Tcgj6ag1K6XNQ=;
        b=IxRyEdHEGZ5/B5SAxLZNCnnq3Nf3Ye7p+6qa/V/vyc4/ARQFzUpAJh1TERx2eaaVun
         b8Q+1pjl6g+GryNQHe0ryDEP57dLwBW4kDUChsfAEik2QqxpgnXwh9N5JsXc4WmwJiqm
         dRB+EuMmEjUP5N1Vr1fTvw5TqXR5FBTf5KVnInf9+l7cZPK85yWojZQOnlag3mOzxBqr
         PwwEe0ZSh7IQo0mPTpg14iYT1qGSkkPVxiuvt1BB6VMcKwnE1FnEzqLVzpNRNUy4jKq/
         zP32FPhewFBAb3GVCroxYWIUyY2oQnq9VlSRLt9NmVEQQ3P1e/OMtEUWD/6cfBr4zk4L
         JDLw==
X-Gm-Message-State: APjAAAURIP1M6E2Y28i3bMxVExiLKfNqV2du3E4JhUoGdWhaVt2YnFM+
        1yJEmq0rkNS0Rdxx6hHAsn0=
X-Google-Smtp-Source: APXvYqzdq+E3S9zMsnrluCuntM0zINzScKFZ9mNZM6+tED4TEfvdT4TUKI3ys0hwY5HBgBBKlot1Jg==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr12578165wrp.241.1554715351410;
        Mon, 08 Apr 2019 02:22:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id u17sm22671883wmu.36.2019.04.08.02.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 02:22:30 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 4/6] dt-bindings: arm: sunxi: Add Beelink GS1 board
Date:   Mon,  8 Apr 2019 11:26:17 +0200
Message-Id: <20190408092619.23152-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408092619.23152-1-peron.clem@gmail.com>
References: <20190408092619.23152-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink GS1 device-tree has been introduced.

Add it to the sunxi yaml documentation.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 11563d3f7c65..9ab9b266881d 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -136,6 +136,11 @@ properties:
           - const: lemaker,bananapro
           - const: allwinner,sun7i-a20
 
+      - description: Beelink GS1
+        items:
+          - const: azw,beelink-gs1
+          - const: allwinner,sun50i-h6
+
       - description: Beelink X2
         items:
           - const: roofull,beelink-x2
-- 
2.17.1

