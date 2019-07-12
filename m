Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CD0C742B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0EF2064B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XTv+fxtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfGLJl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:41:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35631 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfGLJlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:41:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so9278086wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PCPAVIoBuVICJSah+Q7UfWDYKagBj0M35hF6OR30pG8=;
        b=XTv+fxtBppMxkNUV39HwSKjm+deYXMOAp6Ae0Cxil9saa5GRQbgNN2qbAu8xmovzhX
         Rizm8MeFlAfIZQDiK2g63C2f3c9YL2Y589epi9ViyKSFWM/9Swhk9LjLmF8BJzQLK5el
         bpOrLB/yViwvEwiROw1QWsjAijEiIKYpCCwPBWviZElDCA0LyvPfXuKDbWDkVHGx5Nl5
         aJQjmT0cJ8zJGAyym5GDlImqqUu0CaB9uGG0fdQAP8JxWbdc5ww23koVWt+TLzMuKiyU
         o3yOBRYh3+2ErTbTK/K9+uFFnKPdeFVf8tTxwXpOrqi34Riypne26yTXkeBM66HbHnaf
         XDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PCPAVIoBuVICJSah+Q7UfWDYKagBj0M35hF6OR30pG8=;
        b=iOJgCJpZEGbeS3PeMQUU/PHvEYqCSd2AMBrHADG2WVggY+2esgQVpdp4FdjdYBEM1V
         4gPAPgXu8zzMRg3vM2cIc4WvN3+MxIdxkYx0wtwFEChcmz5OyhMm2qtXnT2Oo6j9TAh5
         JUtU1xyneXNVVLNGGOsHn3ceU7/mCzRhTBi2QLfAzqJVr8mPuDuRls5+5XglZPx7hrzs
         ZM02rcqIE+V0pmDGpBdZoGtnbqIbec1w4fQPzSF3HfBGdgLBCclRWBPRS71G9KQn5r3U
         5FncPyTbYzThdhvoCew0ZtJnwd95vc3yRGTlwD4yYEcvrHThM+4stG/GgyyEKlpNt7GH
         RMkA==
X-Gm-Message-State: APjAAAXTZWXtgaDHMLp0cYTFLqz1S0se9YIv5+UyEIU2k3wOOAJVLkjz
        r4I98MqQzDtHCum5ni0Dv3B1Dg==
X-Google-Smtp-Source: APXvYqyrQ+MUolkbRBUnnn+5K9p7+mItRVyATvV7pPrRV17zZ3oBg9tIPdRguwVSaC+rpzEMJP9FTw==
X-Received: by 2002:adf:fd08:: with SMTP id e8mr10072939wrr.147.1562924481709;
        Fri, 12 Jul 2019 02:41:21 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id p18sm7310891wrm.16.2019.07.12.02.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 02:41:21 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 1/3] dt-bindings: Add pixart vendor
Date:   Fri, 12 Jul 2019 11:40:48 +0200
Message-Id: <20190712094050.17432-2-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712094050.17432-1-amergnat@baylibre.com>
References: <20190712094050.17432-1-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PixArt Imaging Inc. is expertized in CMOS image sensors (CIS),
capacitive touch controllers and related imaging application development.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 18b79c4cf7d5..120529f40c7c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -705,6 +705,8 @@ patternProperties:
     description: Pine64
   "^pineriver,.*":
     description: Shenzhen PineRiver Designs Co., Ltd.
+  "^pixart,.*":
+    description: PixArt Imaging Inc.
   "^pixcir,.*":
     description: PIXCIR MICROELECTRONICS Co., Ltd
   "^plantower,.*":
-- 
2.17.1

