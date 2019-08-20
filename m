Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D883C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E144722DCC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="THtpAiEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfHTOlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:41:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40447 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbfHTOlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:41:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so2872963wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+B7REDHU/ovFPUfldbcJXV4L0h+E+r837AnmR62Xvg4=;
        b=THtpAiEZ8FDC8w6bGE0jMKzv2nuMML19Eyyaz8Cx5MENhXZu47XdOwxa4Er1TzmWyi
         c/fNsj+tYTmTUOXXgC2+kaI4h2lYsTyWRF88fmwsMkKedfL67dIkPMU2nI4Tjs2TIiJv
         GT9aI95NysUExLkL8dpoRE2Iqyq0DRYopI37CMn37aTwsS7W3L2q9HoX2NWBN4BP/LVT
         luubPtV5oNWY33VFbu+TwtGNV6zXPDG0jO/tocW+J1jRia6Wkvb7NqwXjOemZ7E2OVgM
         hov/xluVQZ/BPtlmTRmddQqVBoYxdOeLo9LVRBDZ8rBb4xWmdaOJ7C3+h43cBTKzgaXr
         bsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+B7REDHU/ovFPUfldbcJXV4L0h+E+r837AnmR62Xvg4=;
        b=pnqlDe5kB/WIsqjwQKLx9vG1wsbfJIxwreRDF/jKI55OaW8GaZcLpyUa1tdjC3OKxe
         c1nFePIcLfJIt030vHwsYbGGmZXkN5MNpKm9ZgJ83klP1QalFr6A8dt0IJkU4Nj4uM9j
         qAn3DJdWp+Di5Jx5QC064VEfChaQEikg5VuuakfPxVn4rDHAFeiVl9+uzWIGH9/5FDm2
         wQJgYUtrlXGOPwbtgpY48FkIvMtMxSmi0NJP+YrgIDgyS0GXJaV9SVPbSnlmE/RLNjrF
         +ljOJcOHT4GsYj26Y+U1m8YJkGTCaPlKkA25t8B5APlX2Cci8nfrU1s+9C9wZpk6HqCs
         XvVQ==
X-Gm-Message-State: APjAAAWbjOC4P2qIZKx1RM+vPUewt9LTrn6RHqeE8IwghirTH0ZOiWsk
        ninyDI4C9TqQc1p6IS7qdVTyXA==
X-Google-Smtp-Source: APXvYqzpqzb1cEn6sX/X/nUVR/ouGUD681P90VIKTY4Fd7zMUfZWiMOnS2gQOKltP1pj4r6y5T+iBQ==
X-Received: by 2002:a05:600c:ce:: with SMTP id u14mr356456wmm.5.1566312059713;
        Tue, 20 Aug 2019 07:40:59 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a18sm21826750wrt.18.2019.08.20.07.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 07:40:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 4/6] dt-bindings: arm: amlogic: add SM1 bindings
Date:   Tue, 20 Aug 2019 16:40:50 +0200
Message-Id: <20190820144052.18269-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820144052.18269-1-narmstrong@baylibre.com>
References: <20190820144052.18269-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the new Amlogic SM1 SoC Family.

It a derivative of the G12A SoC Family with :
- Cortex-A55 core instead of A53
- more power domains
- a neural network co-processor
- a CSI input and image processor

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 96f66911e3c6..d701e8447363 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -150,4 +150,7 @@ properties:
           - const: amlogic,s922x
           - const: amlogic,g12b
 
+      - description: Boards with the Amlogic Meson SM1 S905X3 SoC
+        items:
+          - const: amlogic,sm1
 ...
-- 
2.22.0

