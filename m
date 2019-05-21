Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63023C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390ED21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBYZazpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfEUQL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:11:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33853 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbfEUQLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:11:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8so12904122wrt.1;
        Tue, 21 May 2019 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWjp5N7/2gycMhkjj4F7Je3PI1NUTqU00O1ySy3vSNY=;
        b=mBYZazpRj6EVU7E58MdMi7y+AJ+HedRo3jJJlcg9GWps2CdOi9yPkeRg9EXQZMZ4w0
         lHyOVHvQG/bLCCwVRejE/7v04UpUP4UNkRSoaITOErYNy7bzb4VrnNwAyPY400UzjMIm
         izWERToMX4dzCYvZS7q6lhOmCb5swJ9Npb9pmBtTO4UqvMD73p7YaSOqPmcIuIIRS127
         HaB7/2461amKirTxJ9/9fSDjuy4xeFxCfkA/tMLFaytIcbIjoUhUlLL2E1booh329WNV
         yagjPAkc1KFlf0HzEennc6ozheuvQABWQgPSgZG/NsrQrg32jV46+A96j/6cedbM2qp4
         4SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWjp5N7/2gycMhkjj4F7Je3PI1NUTqU00O1ySy3vSNY=;
        b=kVQD8sG60ygwUMGzYC9+TvFHUczwopO6B4Uglbybaysudq/BCTsY50oICY6EhnK86u
         bBu69+0tkPWsoXNLe2Yx2F/gbh3vw9KD9nIgHY2/gnL7SGqiLXmV63I5f0Ole/Eq1e5d
         kTHGIZn3AOKyRMsgd5luT7JTI2BwC0KPY7SdCzVbTobHzgLhHv8Nh7pXNwHI6CSnhx4d
         JM273O7BW5MJXVT3lDE9HTboeT0Zm92fSzpZYoyxa4moxBfwMS7hCjI88ZIaXz4c/ls6
         vTuqwkBJFsW1ToXZc5DXUldfhBrOUqCTdbi1hD7BzlMvoIkcb7Oq2Ct7USwb+dfo2UzX
         xPvA==
X-Gm-Message-State: APjAAAU5oFBymdzLw3dbQeUr4g6WROX2q38mcFA9L/gEt8xCDCk9hztf
        1ReU2b8d8L2mzAEuHn+ZPBU=
X-Google-Smtp-Source: APXvYqzyKZ0rTYgJlTdwuX2CPB9g3HFvHZgguGxqods3XjUbGjAvqDQc2M25Gwzjc4EFEDphnvB5Pw==
X-Received: by 2002:adf:dfd0:: with SMTP id q16mr18856873wrn.235.1558455073159;
        Tue, 21 May 2019 09:11:13 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net. [37.60.189.18])
        by smtp.gmail.com with ESMTPSA id n63sm3891094wmn.38.2019.05.21.09.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 09:11:12 -0700 (PDT)
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
Subject: [PATCH v6 4/6] dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
Date:   Tue, 21 May 2019 18:11:00 +0200
Message-Id: <20190521161102.29620-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
References: <20190521161102.29620-1-peron.clem@gmail.com>
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

