Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBCCC742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 08:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEDC2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 08:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VyOLpZSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfGMIFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 04:05:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42011 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMIFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 04:05:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id j8so8007047wrj.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 01:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PCPAVIoBuVICJSah+Q7UfWDYKagBj0M35hF6OR30pG8=;
        b=VyOLpZSo1+lXygJnf7L4tUyVOCvRuvglGR+cOpoMEp+aWlzqFfR0oFDg6Ca9Xyo+AZ
         iwt8F+9XEFXRioksk0AOG7h1zmgXCRhkJiX/BdVnMGLlAjcR543kaqU3aBJe+GqiWhAb
         5J4/EtZ2uHB8VZPW9j1oQxHR3U46wSFjAxyHVNTq6YKwWj6GLnjBYXujHfKfMX4jWc5N
         a4mhxWB7PFeXv5NRvj48T/1pFPXVtO+mcD79EjRloDw2TXUKKHVY3yeKHIy/LvqyDI/5
         dLdyCv8oT4tomgqaSPriTKiHwUQ40mRrqSeTg6psi4ejBHHQhN3M+jHRgGH/f5FPCUeu
         X6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PCPAVIoBuVICJSah+Q7UfWDYKagBj0M35hF6OR30pG8=;
        b=Wjez1P69Oeuz4duujBfDgPxAoUKZb/UQCoLHST735+TrhlISlE4gaV4+F+uAO2yqVO
         IhQtNeqNdjNdyu4X+IUwdx0vVIYqlSs6AHaWy45O/MWa2Hw1CdQufoUA+3932YA0thgN
         zQcjAA9uUqec/wbiue24hjSgLn9hYKkhfq1+8GihSfLJb5evAiiv0rBrJQ8FusH2Aoc5
         cOUH5y6YOat7wbQ+YNjrFKbOCABp+xbwfOr8fiF2g5ODxuce2XwVVslGktPKNjNrWPIO
         DEDIVzogr9Boyxrl2USVwyU5aLwvFuaCFXfdnnNPROGaxeJXD25IsKHvT1GFCHA1IvYb
         b8BQ==
X-Gm-Message-State: APjAAAXwlG32AoQlEAonhhilpV9cERftmvlrwBKZQdBcinBmaooXd7j/
        MwViM0Oqw2urK005Pp8/YpJ7zw==
X-Google-Smtp-Source: APXvYqzwLKvM1hEt5S+/RZGioP8rLTZCageVp8c98fn1RIYt39e9v/S7ytPFoajyUtUAlye133fipg==
X-Received: by 2002:adf:de08:: with SMTP id b8mr16247723wrm.282.1563005105302;
        Sat, 13 Jul 2019 01:05:05 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id o26sm9621634wro.53.2019.07.13.01.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 01:05:04 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 1/3] dt-bindings: Add pixart vendor
Date:   Sat, 13 Jul 2019 10:04:53 +0200
Message-Id: <20190713080455.17513-2-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190713080455.17513-1-amergnat@baylibre.com>
References: <20190713080455.17513-1-amergnat@baylibre.com>
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

