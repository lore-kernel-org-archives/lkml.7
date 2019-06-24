Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557D3C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2239120674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+01cCso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732872AbfFXSbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:31:23 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:43443 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfFXSbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:31:20 -0400
Received: by mail-pf1-f177.google.com with SMTP id i189so7998371pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N9k2pKjZb54DMa5kX/oQwQ3xn0qUY3cVYn7J8UKiKqY=;
        b=u+01cCsoBn0eTF+qRKLgW5kpdZ8s3lQnk5Kmp8Aba10JTlWkVKp2VoNMSKVgNAPiD5
         e1HXWNZPMnSvkH37mgvSroZKJPVkMHZFN0YRfz4KJU7tRWTkwj9xKEUsnsdmrJjKfLub
         CFuaKTgl65F+l35kFjTdxy7zTQPRGh4iUU07e82i7HVuQc71DB19XAQ5S+mTAQDGGZZk
         jJTUEOvEyvrMsXKiktrNJ306TF6uYhH3j2HJPwzi6DWuaikQFUcBdJDm8CTFfxTL5YIP
         6dsUMPbH/iZcD7p6PURIxWRA6ghT29qyvq/mklVG9aPSoyGq/aHgXGiESuMtbt9kW8BD
         ugLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N9k2pKjZb54DMa5kX/oQwQ3xn0qUY3cVYn7J8UKiKqY=;
        b=tv+X5xqGuYUTZJT8W+6mOosRkGBYFPpbB7O6gf7Np5iMj0mDn6obAkTyl805InNFYx
         JTriBzwYGD0GFyaSYD6MgEdGKxgHdRuIyqBkAK/8eFeOl4tuy0yQwM3a+s4tKUZdIb9F
         susfKJZD0LTNRSv1i5OFZ0sKGt/ZjFXIds2Is3SnABRm5d116yBafUYtDCH8bqJPvdAb
         ozNPfu36/2D7d8tOtvtyzQ204CudFitJYQZmAZa/OeWmrJj7IeuLTX2YnONUHXboMbDP
         4NTQPM+YtUutVjoOCvkyLi/A7w2OTrkRnzwKd/6vdeeUDGiE8y5EMk5sgOJGE3w3GoDS
         zUYw==
X-Gm-Message-State: APjAAAWrwloR3/5ce6dSHGyrdFr7eW4CadbayrwBGV9AhJ2EYJywOMTJ
        Cpm+1DUuNBSnAp57iI9/YIc=
X-Google-Smtp-Source: APXvYqzt/EgsBU2koGwoh0sXdF9NT5zTgPCxnFKt5Ea/KmHPijDgxcFo+cdzJLicisOJZ5+o39Jm+A==
X-Received: by 2002:a17:90a:2486:: with SMTP id i6mr26260371pje.125.1561401079707;
        Mon, 24 Jun 2019 11:31:19 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id p15sm206601pjf.27.2019.06.24.11.31.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 11:31:18 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bob Langer <Bob.Langer@zii.aero>,
        Liang Pan <Liang.Pan@zii.aero>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: arm: fsl: Add support for ZII i.MX7 RMU2 board
Date:   Mon, 24 Jun 2019 11:30:44 -0700
Message-Id: <20190624183044.30240-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624183044.30240-1-andrew.smirnov@gmail.com>
References: <20190624183044.30240-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ZII i.MX7 RMU2 board.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Bob Langer <Bob.Langer@zii.aero>
Cc: Liang Pan <Liang.Pan@zii.aero>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 407138ebc0d0..91519cb24083 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -157,6 +157,7 @@ properties:
           - enum:
               - fsl,imx7d-sdb             # i.MX7 SabreSD Board
               - tq,imx7d-mba7             # i.MX7D TQ MBa7 with TQMa7D SoM
+              - zii,imx7d-rmu2            # ZII RMU2 Board
               - zii,imx7d-rpu2            # ZII RPU2 Board
           - const: fsl,imx7d
 
-- 
2.21.0

