Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC355C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AFE20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ncdGwmPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgAHFX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:23:59 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54031 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgAHFX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:23:59 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so552696pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 21:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DM0aqT7mORcDNurEQApqfEBtkQorM/LzpTMTVlrl9aM=;
        b=ncdGwmPrHI55/SBDBh0DPZoQrK3Lo1SJ9dJj2j29oKPgH8ThCHSPN8yJdVWZ+MwCoh
         AQH8qdCIHUUUgK3eD0s2gZ7Scd8kIBUxEuPYi/tYu6vCjPnwJEUy+Ic4IhNL/dhbVFoJ
         n9tJAzlRy9Zb0V7jWB54FlbdHEoNXslhoaz2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DM0aqT7mORcDNurEQApqfEBtkQorM/LzpTMTVlrl9aM=;
        b=E15j9bhDgrEqxqxyaMri/rFl9hgaWvNKgjeVU/OAVdf2p00vqBg5q2CWIJT5xm+b6m
         6Kuj+A/yiHEQ/1t/JuTnupB8x/eg4/1FU1qpMfxeT8hcYyyF4y416XzhOHSbntYlLkc6
         ukc5PDrccCk57N0hQKooSieNtwmcLWL6ZrWDgePlIGU0v80Z0yLQCS/HuNu8HqXByVD9
         qW4PiiWsLHAlu4PL+t2Twsd1sebrdnguE1wNUKd4qQ8T7u1jdp1QW3g4dL43QvPdQTAS
         NGCeZV57byG0Ya3GLCxSuJrzZqLQUtyNA/npe9Qm50GMNf77C9zS/vvdk/ZWIXR19Ldv
         OhRg==
X-Gm-Message-State: APjAAAUXjDsr/SBXOJoEr6vwpk8pV3gErC1p8omKodLlGmNeODwphrvu
        FNK7rcfqWdBYa2Lc/JHwBMJu2Q==
X-Google-Smtp-Source: APXvYqx6Kh3IRlEF2mYf7QKx3EM0H7n0giv6QuZmqNIaB7ToM5za17Tr8aM8sd8jKkiVpN89SHLohQ==
X-Received: by 2002:a17:902:6bca:: with SMTP id m10mr3635095plt.212.1578461038146;
        Tue, 07 Jan 2020 21:23:58 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id n24sm387505pff.12.2020.01.07.21.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 21:23:57 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: [PATCH v2 1/7] dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
Date:   Wed,  8 Jan 2020 13:23:31 +0800
Message-Id: <20200108052337.65916-2-drinkcat@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200108052337.65916-1-drinkcat@chromium.org>
References: <20200108052337.65916-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a compatible string for the Mali Bifrost GPU found in
Mediatek's MT8183 SoCs.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 .../bindings/gpu/arm,mali-bifrost.yaml         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 4ea6a8789699709..9e095608d2d98f0 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - amlogic,meson-g12a-mali
+          - mediatek,mt8183-mali
           - realtek,rtd1619-mali
           - rockchip,px30-mali
       - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
@@ -62,6 +63,23 @@ allOf:
           minItems: 2
       required:
         - resets
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8183-mali
+    then:
+      properties:
+        sram-supply: true
+        power-domains:
+          description:
+            List of phandle and PM domain specifier as documented in
+            Documentation/devicetree/bindings/power/power_domain.txt
+          minItems: 3
+          maxItems: 3
+      required:
+        - sram-supply
+        - power-domains
 
 examples:
   - |
-- 
2.24.1.735.g03f4e72817-goog

