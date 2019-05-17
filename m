Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2069C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D7721734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZRwoRSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfEQSrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:47:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38781 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfEQSrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:47:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so8166317wrs.5;
        Fri, 17 May 2019 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWjp5N7/2gycMhkjj4F7Je3PI1NUTqU00O1ySy3vSNY=;
        b=ZZRwoRSb1PL/97jGRmzSD44FfFvnZd2iIqEeVhOF3VrLEp9vzAWHatj2PBKWjdz7r1
         yg52bRI0/h8oCYPFhaTaKKThP9PlSn9gRGQt2rUvGnvG9eLmfL73zySDWEsuKGAVa2nK
         9pkwIYCCYzqBP6tfJ9kbGX0jZep2rcV5YEVqufDdd2NbwkkhEW7b8XDabGkEyuaudPT3
         Bf6ynCNlrdw878zv8/FHYA9Mcbvq9E6roUjTWsYVlYLrbwFXXPuEFJYV8f+uG6Ljrlhf
         YYRGkUj5ohV2j0C1nSbkpjJke7iX6ZDj6uEO0eZZuyMu/SZEIGvjAfkl5WObHWgLGYCv
         LIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWjp5N7/2gycMhkjj4F7Je3PI1NUTqU00O1ySy3vSNY=;
        b=GFcieenmwvxnLrp5x8LSwg4nsSoaiZF1RHADzGRALSmpkEcFKIe8MknT0n97ar3UVf
         Yx/cN0jp4QgujxQjm7t6JPz/WR5t3M91NnGigsSFrGzXTdgupVa80w3UHu0USWLOsG0f
         Y9dmQH16ssUK48MlbeRWsv9majPjl5y5O6l1xQZGFfnrqI83YDn87N8gpBuIxeuPT9eu
         u1YpfSJrOFhfvzrgQ1BriIj8H+Sy4QEXVRmLvi9PHjABIjakwXgh/lYrnls/kPwAZDO0
         usGdDuE3Ffn9F79ImdtGBnRDXFK5QngyBD7sVNAoQnX9VgA5iHd54jPSvr0cbmDSszKm
         qPoA==
X-Gm-Message-State: APjAAAVd0aTFHmIxwPALuWQ8O/4p60zhb2/EQgfdUeCxZZbE7SMzVsJ3
        MUtXBtqxL8QGB4BJpDsj7OE=
X-Google-Smtp-Source: APXvYqwBJ1PZ+mVOlD7wgBOxP5lzlCYxaqUa2bsvWXXFw9/yU+63xVcCkN1xYNthpr6aPrD+TDolfg==
X-Received: by 2002:adf:de82:: with SMTP id w2mr24718302wrl.53.1558118830993;
        Fri, 17 May 2019 11:47:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id v20sm5801112wmj.10.2019.05.17.11.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:47:10 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 4/6] dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
Date:   Fri, 17 May 2019 20:46:57 +0200
Message-Id: <20190517184659.18828-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517184659.18828-1-peron.clem@gmail.com>
References: <20190517184659.18828-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the H6 mali compatible in the dt-bindings to later support
specific implementation.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/gpu/arm,mali-midgard.txt         | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 2e8bbce35695..4bf17e1cf555 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -15,6 +15,7 @@ Required properties:
     + "arm,mali-t860"
     + "arm,mali-t880"
   * which must be preceded by one of the following vendor specifics:
+    + "allwinner,sun50i-h6-mali"
     + "amlogic,meson-gxm-mali"
     + "rockchip,rk3288-mali"
     + "rockchip,rk3399-mali"
@@ -49,9 +50,15 @@ Vendor-specific bindings
 ------------------------
 
 The Mali GPU is integrated very differently from one SoC to
-another. In order to accomodate those differences, you have the option
+another. In order to accommodate those differences, you have the option
 to specify one more vendor-specific compatible, among:
 
+- "allwinner,sun50i-h6-mali"
+  Required properties:
+  - clocks : phandles to core and bus clocks
+  - clock-names : must contain "core" and "bus"
+  - resets: phandle to GPU reset line
+
 - "amlogic,meson-gxm-mali"
   Required properties:
   - resets : Should contain phandles of :
-- 
2.17.1

