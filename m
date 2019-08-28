Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB141C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFB922CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Md/3fBAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfH1OMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:12:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38708 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1OME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:12:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id e16so2684803wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcL3AvqHT7bRzBjlZdaYirVmcHrrTcNQrMrMxpM5Yus=;
        b=Md/3fBANfgsgXmzYx8/JW1lt0iPF0+PbgXaoXZob5EGJKRUx0qIXp/tb6eC1ccBzzi
         XH4G9eKmZPggNRvEG1ARm6Jw/BVdMjs+97H8n469rQWCuUD+0HO/3JPGbgdRDk9tG7zE
         TmIwQtUJjFClFDaBhIE47Nm2hk/Oc8SDriGJYEW3+cryh6Q1BUdoByvZJGna5NEWaJrR
         +9yS/A51lCgFmWEzG166CNY39NrU4osMjpTGwZK8im2l+8IIQ5Hz9D+d0zqvWxU+NPR2
         uy1cxOIlUvTqA7PoSIkSbquL1TgDm3oR8ZaCjHqQpQvxb3N9Z2lz0fQlpVAiNDjsveKN
         Wzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcL3AvqHT7bRzBjlZdaYirVmcHrrTcNQrMrMxpM5Yus=;
        b=K7nj9tlv5fltHbffLFX/lyWdWHCSy7hftHIvVW1lWf8aQmTa4boM+pNSL1xulpla9g
         /wUqC0gRIbd/kC+fiSXbU1NGh7t45QVGaV8hkh65aOlZzJydVRNTyOc0V32uU82w46yl
         4azUgqJ3VSWtx2VUqwqdfizmHhARD12a+cxUVeJA1LMONWLeUMoXSVcUWER4NpD+Nvav
         qhqGdZyzd086dtX1i04cwDbaT09kUibxzGccmiO7pk3rsj4S1pMhIO8EQYtReH6PLECX
         WB48Kob7OACCibzHVh/uYh/S56VdDr+ZivUm8DiVltCx4q+GmZ0QzNI4tWaBWiL0M5KZ
         8dkg==
X-Gm-Message-State: APjAAAXQqEcMeAR5nFErWXARrK1yXrUrxZAMOXERFTh2bnNnfAVKiCrJ
        s8qC0manuTsdkcayaqMsFVmDpw==
X-Google-Smtp-Source: APXvYqyrf0ESs+jD2QyAojNvUhYbZpMQlomaI7+FIXl2yK84Z2ycpyt8wNDFiuQ5NlRktCpu+SKeVQ==
X-Received: by 2002:adf:d852:: with SMTP id k18mr118322wrl.88.1567001522020;
        Wed, 28 Aug 2019 07:12:02 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a11sm2774838wrx.59.2019.08.28.07.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 07:12:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] amlogic: arm: add Amlogic SM1 based Khadas VIM3L bindings
Date:   Wed, 28 Aug 2019 16:11:56 +0200
Message-Id: <20190828141157.15503-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190828141157.15503-1-narmstrong@baylibre.com>
References: <20190828141157.15503-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Khadas VIM3 is also available as VIM3L with the Pin-to-pin compatible
Amlogic SM1 SoC in the S905D3 variant package.

Change the description to match the S905X3/D3/Y3 variants like the G12A
description, and add the khadas,vim3l compatible.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b48ea1e4913a..99015cef8bb1 100644
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
+              - khadas,vim3l
           - const: amlogic,sm1
 ...
-- 
2.22.0

