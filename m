Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E1AC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6842080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BjpNSB0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfLIOiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:38:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39513 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfLIOir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:38:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so16445118wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0cCfs61dLVx99fBZ8UFqKBrRs+hUJEpQvqJWKvBMa08=;
        b=BjpNSB0H6WS+od4I9bWu7mlwGn05HdzHiVd7EYabnNtot4Dn/na/nH45rPrdImid/J
         75FjSOBvibW/Luu/9AxWOHuAYSGJ0mzkLyq2sutVsVezSxgFykoCtVWT1k4vx7Mbpjhc
         UYXRNVyIgHzzQQzV6FwKEUyLKUW5nQqtkB8GXEwMA/MTqi+/VbX+32/61QajiVtZgcA4
         +qq11SKhrE8bKeFclgsiYG1X6Yr9xjGZ/VMDrXh1FWCEQ4Q1l7Ka+C96/rFXWcXyokdM
         MPxrmWqGTQVxo+GsiGX44ZXLAcFra5YNstiC4L/BKDs2+t2bIyHJj/nJnX0YJsicd4xy
         9J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0cCfs61dLVx99fBZ8UFqKBrRs+hUJEpQvqJWKvBMa08=;
        b=A3iJLZUQLj2SyE64tVLnQGNzok50NS3fuYg8YXsp1WIEo/2VZjSun6EMX9yBq43x7v
         C54uw3bYhUi0bPzfP5BaRsOfI5mk6tv1rbHnCP1ngh+ywxLqd7jkgAKVs8X1T7badjzY
         tGGQvcpSvi5MsgBwnmcjoOJxFtZT8g9/do6tRXKt9blq9/nkhk2N54ZkczPR30nGyemN
         g3US4OGMA8+TqwOaytP2HcDsmEfBF4L2crC/B5B5+4c8i3c1zc72JfGynJRSuWjR9RPl
         CrWfAvZq3L2wQ3nq0673q1II0zA9kvzMZHCcOhxUCU0IcsxRJNnrlT7rUf8BG65SIbmt
         c70A==
X-Gm-Message-State: APjAAAUzz3Z1T4E4bNzHWYgwjzAKAU1JA0++OT9h+gqnWLAreYc1tLki
        OssLlYJhioYc20GTR8Ku3XP5wA==
X-Google-Smtp-Source: APXvYqxuKaXKo89bA2CEldplyJh5hTpjzijO2zBIg9wfzU3ZNPMf2FYGVCGr68YLEg/CiaQcsRPXzQ==
X-Received: by 2002:adf:f091:: with SMTP id n17mr2560209wro.387.1575902323022;
        Mon, 09 Dec 2019 06:38:43 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a1sm1904165wrr.80.2019.12.09.06.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:38:42 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: arm: amlogic: add libretech-pc bindings
Date:   Mon,  9 Dec 2019 15:38:35 +0100
Message-Id: <20191209143836.825990-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191209143836.825990-1-jbrunet@baylibre.com>
References: <20191209143836.825990-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board bindings for the libretech PC form factor

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index c6a443352ef8..2660ba3b129b 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -104,6 +104,7 @@ properties:
           - enum:
               - amlogic,p230
               - amlogic,p231
+              - libretech,aml-s905d-pc
               - phicomm,n1
           - const: amlogic,s905d
           - const: amlogic,meson-gxl
@@ -115,6 +116,7 @@ properties:
               - amlogic,q201
               - khadas,vim2
               - kingnovel,r-box-pro
+              - libretech,aml-s912-pc
               - nexbox,a1
               - tronsmart,vega-s96
           - const: amlogic,s912
-- 
2.23.0

