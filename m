Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E267AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B960D22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="C2llLjqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392508AbfHWIOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:14:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33716 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392444AbfHWIOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:14:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so7815752wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=an7EFK4JvkBoKoM3Yeo8YPBrJ2AtkRzJC4yL9T9DOFQ=;
        b=C2llLjqzUduLdL9VZmxRQLNAh79gNPvOHxRc6lEKIqSOnsdMwk9J/IuO0IKipl51LV
         ExpFAffmyTqbQbSu6k2d5JgfNOs9nStxyJMcW1WfPkYvMA+8RDoMaoi/ygi6ySq3m/Pj
         pONoERsHmpyXMtpyhd807rWxNI6OdtVU3OlM5PR7rpnA7WDQJYeyt8nOBjKcPFg3NIWQ
         uUv+L6aN9WgbbiDmYKLqveuXxDxnoaqph79iwXrxx4lzgTLCwxaLDTPOkuwHUYWz1+3Q
         6ZfZOtzqwDnQcbXFt/ajvuL/K59ukUFusOgXWhri4IH9mlgFQNUEGqBxcG0hVgpgXkCF
         4WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=an7EFK4JvkBoKoM3Yeo8YPBrJ2AtkRzJC4yL9T9DOFQ=;
        b=fmthdt3HJ1T+mTMyCHwRp0DzD5Tgbm3bHuBPOyT/5phvo4JEn0KDMreMYytsBBgyNM
         /pNrM97JsUCbmsgMkshF+KuBy7wPnJXN4oYcOs6m+m15w6zuizJeMAdsLIJFJDgJhwzZ
         lRqpI69TrVOu8JxJ+r4BZCKPqgVSr18DS26A8F2J8/MY//uoTvHIxGqotdczGHydzVh2
         hsNGPQXpt4dTq27YzwhW0oipCrGPDTONrmM4UqrvQqpZ43ZUawnwpqTM4PHcLf95n6pm
         d7eNuJPBGzp2XOM0vKx8MveenClJS4o/6dRLjvI5GVHVxMtYi3og0NZCBVc6OjtN3Pt3
         TC7A==
X-Gm-Message-State: APjAAAW7mcqqdbjobiwksII1SFAFgEr3x9sLwbIZHDXvAfrZGZ6T7oza
        KlXRSht9Dj6jlTZhQGnKDTJ0lg==
X-Google-Smtp-Source: APXvYqzGW6+sUuZMXFxTaQiVCRz6B52nyNUkpqM6pyYGjlS9BL/UG5O9FVm9nklwKZfHr9awWgIN/g==
X-Received: by 2002:a5d:5343:: with SMTP id t3mr3487147wrv.156.1566548071564;
        Fri, 23 Aug 2019 01:14:31 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 74sm3632535wma.15.2019.08.23.01.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 01:14:31 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] amlogic: arm: add Amlogic SM1 based Khadas VIM3 variant bindings
Date:   Fri, 23 Aug 2019 10:14:26 +0200
Message-Id: <20190823081427.17228-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823081427.17228-1-narmstrong@baylibre.com>
References: <20190823081427.17228-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Khadas VIM3 is also available with the Pin-to-pin compatible
Amlogic SM1 SoC in the S905D3 variant package.

Change the description to match the S905X3/D3/Y3 variants like the G12A
description, and add the vim3 compatible.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b48ea1e4913a..2751dd778ce0 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -150,9 +150,10 @@ properties:
           - const: amlogic,s922x
           - const: amlogic,g12b
 
-      - description: Boards with the Amlogic Meson SM1 S905X3 SoC
+      - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
         items:
           - enum:
               - seirobotics,sei610
+              - khadas,vim3
           - const: amlogic,sm1
 ...
-- 
2.22.0

