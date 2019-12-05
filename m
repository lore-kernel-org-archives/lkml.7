Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F312C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E2824249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1RAkL/Yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfLEPeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:34:18 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:39195 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfLEPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:34:16 -0500
Received: by mail-wr1-f47.google.com with SMTP id y11so4139207wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 07:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzKSFA37zQ+fSsnCSfsJqcJWA1YqoEpujyYe82jiosA=;
        b=1RAkL/YqqEmrVPedzEg2Pc0Ov3GvHhQDDskUsdP88FKftcpyQigTss9I7/RJeNaUWJ
         8SxDYfPOP10oekWk/HW52CxH3vycbaZGijkt/iEktSBaQIOyZ+ZFiih4FwRMEvQrBtKt
         q40mxhTIaXZm6rmsGymyE03yDP1zjMp5GsS4ojcVZP+c8ME5ZADLF9qLjLlhNtZPpVna
         v40EMCUiDKqq0m4nYJfbIXt1EDhDHbUXfxR+luG/18Z936G2of2baLTrugjU1n9HO3i+
         M1BlbA/SLFnu4eSJEi3Ts5ZyZKM7eCVemr2cYZJV0SNcv33nR7gSciCyUWMV6MMUmrRs
         bYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzKSFA37zQ+fSsnCSfsJqcJWA1YqoEpujyYe82jiosA=;
        b=qsiBE1f1c/hDPcn5qS3VwNrCUArdJQ3sWJHe34a/JLDCgsPRtWVCEmOEf+gN72YPOL
         6cKT6XiaxZpSeWaD4YWZE0aXkvdTJqMnLPZ9h4hSeI6C7tKLLbMRP7TSPSpFgQ1v4wtH
         t3YBcrXtrl39xtlCsv3zXO9pmzxPC4mTFqpySv36/vHAxKVzyJdX1gOOKPOiJgFTNad7
         t9w8hd+17r6TtVNXb58KrtxEcFwezjLtjZyvbzYtUS6T3ogRu3KuZCFEyGWvn5XzvYps
         nHj38m9oq/XGt2mfHjrEFEK8Ia2ybJPKmhgbTkJCSTAjRBVul5lGtkt00pm5XPEpzFoo
         w9TQ==
X-Gm-Message-State: APjAAAWtYm/YLiIi5vDaFNti7b9BDu+m5X6Z+4oGJfmVxantZ7y8fpk0
        9i1ZPnA+/+qpqbh6CLFYaOzmiA==
X-Google-Smtp-Source: APXvYqzZBXKnAbQRB+UN+TlYuRc21RIUf2MlSS34PJhj5LkssDhww4cmP6eaWU2qSaFmGTFxlmAbFw==
X-Received: by 2002:adf:83c7:: with SMTP id 65mr10264958wre.368.1575560054836;
        Thu, 05 Dec 2019 07:34:14 -0800 (PST)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id u26sm191894wmj.9.2019.12.05.07.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:34:13 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mjourdan@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: media: amlogic,gx-vdec: add bindings for G12A family
Date:   Thu,  5 Dec 2019 16:34:06 +0100
Message-Id: <20191205153408.26500-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191205153408.26500-1-narmstrong@baylibre.com>
References: <20191205153408.26500-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to support the Amlogic Video Decoder on the Amlogic G12A
family.

For the G12A family, a supplementary clock is needed to operate the
HEVC/VP9 decoder.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/media/amlogic,gx-vdec.yaml       | 42 ++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml b/Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
index 878944867d6e..cc8dc264fc72 100644
--- a/Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
+++ b/Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
@@ -27,12 +27,15 @@ description: |
 
 properties:
   compatible:
-    items:
+    oneOf:
+      - items:
+        - enum:
+          - amlogic,gxbb-vdec # GXBB (S905)
+          - amlogic,gxl-vdec # GXL (S905X, S905D)
+          - amlogic,gxm-vdec # GXM (S912)
+        - const: amlogic,gx-vdec
       - enum:
-        - amlogic,gxbb-vdec # GXBB (S905)
-        - amlogic,gxl-vdec # GXL (S905X, S905D)
-        - amlogic,gxm-vdec # GXM (S912)
-      - const: amlogic,gx-vdec
+        - amlogic,g12a-vdec # G12A (S905X2, S905D2)
 
   interrupts:
     minItems: 2
@@ -59,13 +62,17 @@ properties:
 
   clocks:
     minItems: 4
+    maxItems: 5
 
   clock-names:
+    minItems: 4
+    maxItems: 5
     items:
       - const: dos_parser
       - const: dos
       - const: vdec_1
       - const: vdec_hevc
+      - const: vdec_hevcf
 
   amlogic,ao-sysctrl:
     description: should point to the AOBUS sysctrl node
@@ -77,6 +84,31 @@ properties:
     allOf:
       - $ref: /schemas/types.yaml#/definitions/phandle
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,gx-vdec
+
+    then:
+      properties:
+        clock-names:
+          maxItems: 4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,g12a-vdec
+
+    then:
+      properties:
+        clock-names:
+          minItems: 5
+
 required:
   - compatible
   - reg
-- 
2.22.0

