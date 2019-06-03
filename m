Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218BAC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BAB27FBE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SwuDnWbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfFCJSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:18:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34987 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbfFCJKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:10:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so7249249wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=flCBkYYx+PdHsv3XsjTv06FvsWqxIYgVPOMABFKuON0=;
        b=SwuDnWbt+BrQnQbtSVGVqHEKRwhgpuaH9QN4iH7n58msM+doavax1lbAs5vFSK7Q0F
         oknUZcm8NJUzRm1eBmLB0P4JsyeqJiqifAZlHLp8KlL7dV0hZ3fP4aHWQ2UHc7yxpJHk
         deycQtVX+Cjn4UHcZBdcCfjg1AF8Bt7IOlGBHLgBa75Bm28PolHcvHtIfWefwgP8G7FX
         yYsu+rdKLV1bOVeRGXLWsPPnjAnn50Gy33bJHN3JBZt/ZANjDUXKFKg02g2jvjlv0OD0
         r9X3Lo/cYrfu5t26qEKi+uV/fbVb8HEcDMBHp6BoPGDjopy22Rhz1xtKLQVGPAf4nKIK
         f1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=flCBkYYx+PdHsv3XsjTv06FvsWqxIYgVPOMABFKuON0=;
        b=Gyd5QT/sTAp2vOEtPKeNXLbE+9Tirvv/MjdqtB7QwqYwVsRnxGuaMy2sDu4msnOBtb
         6O5b2T+mQI6VDOWyKgLYef+riXWm9foyMQRrTDIQkWxXImp8anMdlgTIpMIwwaNWC4BJ
         JXGwMxBvGr7QN0+R900hps7E/S3AP1U1bAZnnjQo4TXfsA99tqL1SCXFSGrxru61fP45
         Ei5+V2XZzBQObZvnFzxOMQTjjKp6FuiZHj/UIIKj3VVT/hbvotn1G0VfDaGMHLaIBhpM
         gCbTbFEyGKTRD9Pj1jjlBEFuL9YVZoL+T0LXnGQxSofjSd7jHH2ARDxra7ZtkTJDLEl2
         5l6g==
X-Gm-Message-State: APjAAAUJkahAkRALsF3fIkRV63xqQVd/2Uf+Kbh6v8qiNK1pEDB77mep
        Rs/BlZwpu2dDVF5cUeSZIUDhHA==
X-Google-Smtp-Source: APXvYqzcNF1uAs9S8hg0XUv2b9wOOsxIrr/vf886v2rk2wi9jg/PFMdqP6QfBdMc3j/0O8fBWS+JhA==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr1449423wme.39.1559553021966;
        Mon, 03 Jun 2019 02:10:21 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e15sm10676809wme.0.2019.06.03.02.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jun 2019 02:10:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v5 1/3] dt-bindings: arm: amlogic: add G12B bindings
Date:   Mon,  3 Jun 2019 11:10:06 +0200
Message-Id: <20190603091008.2382-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603091008.2382-1-narmstrong@baylibre.com>
References: <20190603091008.2382-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Amlogic G12B SoC, sharing most of the
features and architecture with the G12A SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 6d5bb493db03..28115dd49f96 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -137,4 +137,8 @@ properties:
               - amlogic,u200
           - const: amlogic,g12a
 
+      - description: Boards with the Amlogic Meson G12B S922X SoC
+        items:
+          - const: amlogic,g12b
+
 ...
-- 
2.21.0

