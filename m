Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0893BC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D215327FB1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GILKK69H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfFCJSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:18:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42770 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfFCJKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:10:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id o12so4046421wrj.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rO31uLodqtR0UANwODTPyvdISTtsAPEuGeRxrgglRH8=;
        b=GILKK69Hx1iSG+k6AOOciar2bFvlGC4clbjFLxgycYVPNVnByNoxP7iQg5nnUo9iNK
         i5PSLwV21N3ARniNEUGDelbQuQ0rXfnOybCAlVoHoseCacMLlfjkpuHgwZh0H+u4eSe/
         bMlAsl4e/Vp/dfi99qhztHoisCxUc+MZ/X4YXyVnxwe5UAHJvyTL3a1GqA1Yd0gcDi4u
         K3NM7R3zW2yYy0JPzRojnM4v7bQypNi//BxdJxmkP1uxomNSlYMJ+iEr0eSWrebcGfnl
         q7bYXdyMQTubSWxC5vorXDPyny39PFpkwnOvyPEcELiey/SVGe3+RHdHXwSQ29IXJxyL
         bHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rO31uLodqtR0UANwODTPyvdISTtsAPEuGeRxrgglRH8=;
        b=jtX0C3nSVAfiAetCkJ0ZoJ/oJvlFG8mSvO8TNBzalthLVXCUITU0ZZdgYrtX+75rRx
         JHsvEU9rW6CiLAkWEsqKESnjlI+SSb1iAShKz6L9EUcQSgXTGh656LZpkRLWdMrD0X5T
         ZwoK7H9EXqiR4FByzTKzazlPgYykSDs1IeAzgEBoMqioYkbJu4WBLpr2N8g3Bf9Z2DdX
         fh9PqBFFIW2cAW8nER8NhtL9ZdQJX4R0BmjDrUi7qmeoL660l04S7Us4/L0jLxeHMG27
         70uaGl0vTJ2vZeBQUBqxnhUjnFcoIDD3IbsdVKUb6TMzu7rmx2ruVB0EL87on3Ho/8wF
         7nDQ==
X-Gm-Message-State: APjAAAUKM7cngRc/2/KRAuVCKrhIsQlpVLODe4VaYfy3NBrihi8r80O9
        qz4oDcLJC0zvjzWx71co5q/vhw==
X-Google-Smtp-Source: APXvYqwhB6ROy4l/G46P5gRSukzDQ2ZzoCJP9NJ28xzRpXQf2J19TKDaESEKU+F168cmCcEvpb3UWQ==
X-Received: by 2002:adf:a509:: with SMTP id i9mr1868475wrb.269.1559553022900;
        Mon, 03 Jun 2019 02:10:22 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e15sm10676809wme.0.2019.06.03.02.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jun 2019 02:10:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v5 2/3] dt-bindings: arm: amlogic: add Odroid-N2 binding
Date:   Mon,  3 Jun 2019 11:10:07 +0200
Message-Id: <20190603091008.2382-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603091008.2382-1-narmstrong@baylibre.com>
References: <20190603091008.2382-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Amlogic G12B (S922X) SoC based Odroid-N2 SBC
from HardKernel.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 28115dd49f96..f75df4471c0a 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -139,6 +139,8 @@ properties:
 
       - description: Boards with the Amlogic Meson G12B S922X SoC
         items:
+          - enum:
+              - hardkernel,odroid-n2
           - const: amlogic,g12b
 
 ...
-- 
2.21.0

