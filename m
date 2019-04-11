Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED44C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE2D2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCvh5DJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfDKKrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:47:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40752 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKKrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:47:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so6085219wmi.5;
        Thu, 11 Apr 2019 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JHkOGE5uu1KF72uJBHM3+EVdhQraRuZIRYHO0QubjyY=;
        b=DCvh5DJN/VhCX8twV583hUuNgsfSrt4arzUvg9WdmDMr4gFsPQIZP5S3N4KtF8fJYt
         99FymPlUe6sGtGWuF0O/vszLfuObtYKWss7mpmGWX9QiKsG5MONdbP9uDotpKYKg+ess
         yB/nP3dNHfZ7R659mVg3LLeDRLKWdVm01qIs/sjjUJn3MflWG7rMesrUlf4fUR0P71bi
         tqRO7He6L2ekx/Fk1naW5mBTywUF6xXN+WS2EwJNm8V1kwg7rWaooO4gdZX7ecEHTrVk
         3G65jbB06ogBj/uHJ/PebdGwMUDowbQOz1T6RehMQluJYaEkBA441JSKwmRhbjt2UfIs
         v91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JHkOGE5uu1KF72uJBHM3+EVdhQraRuZIRYHO0QubjyY=;
        b=ElgorAhM8tIpbEx3+dHjI4zsvfIEdSKkyboThwURNqrnfI722Q/DjtNyDEbv0HdmK3
         8btun5KkUtaqiPKdZhqNMVqBrXBCVrNgJt5F4I21908SgDlBkPNcmjyM7pp3OIy7rMiX
         mqtU3I+hDmxCQnTphSMmyvjlUZj9RvmD8Ju5Gq6nEled94WLUvuO1SNT+YODNI/1oaUJ
         rdLpiB5koofDeLL6FHcFI28oOOmBAJ6vBDxCrx568EsH0td8MQkIfFSxfe47Wm7+ILCd
         LwNPwlya6cbj4sJ/DzR+sf6cmMYtVWfB1VPynqI1R56y0Ue9kqAXKo1b3/KOuzyet+Zn
         7+kA==
X-Gm-Message-State: APjAAAXl6qo7HbZaB7KG42p5JHPZHK/BVumsIovRyUgZalpaybv7Ge0s
        o72Psb3essojQ3Lb+g1DeHY=
X-Google-Smtp-Source: APXvYqwUVO47Xzv2wwLZM5mMaymg37EacWx0IUtmMP2cUVDdxOkoyVaeBEJxOwxhGQeCdikT5Puxqg==
X-Received: by 2002:a1c:67c1:: with SMTP id b184mr5906273wmc.12.1554979659783;
        Thu, 11 Apr 2019 03:47:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id k4sm54987587wro.33.2019.04.11.03.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 03:47:38 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 3/8] dt-bindings: gpu: mali-midgard: Add h6 mali gpu compatible
Date:   Thu, 11 Apr 2019 12:57:15 +0200
Message-Id: <20190411105720.32357-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411105720.32357-1-peron.clem@gmail.com>
References: <20190411105720.32357-1-peron.clem@gmail.com>
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
---
 .../devicetree/bindings/gpu/arm,mali-midgard.txt         | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 2e8bbce35695..0000ec4a9f44 100644
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

