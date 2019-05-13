Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C66C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1DD21473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KKcxIBdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbfEMQKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:10:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39524 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731541AbfEMQKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:10:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so14224814wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmzdSnWA20S0l1Dv500vvfF7v4bE9Z6LameSSeF0Xs0=;
        b=KKcxIBdRMNeROC1hzcs3NlnThY4bCvnalWYKs6wK1F82Ht4eVZUvXCXpUcAVQNhIJ6
         hHRmavqDGhR6K4CwxcA/jBTJYkdZKcirjLViyDe9WNNi5F2IMlK/ck6FkbNYPPvfpZ8K
         Yqbrabsm3YXf3xjo4QoWa3k+e+Hde+2kkcdAT/bOvLSVYc8GcZtBJgjDENFMllEU9Lvo
         eO6hK89l4coMTDLxqaTjw0P2RR487C1icqMd3LcSblFQC1/ACv4TDjWnPGvFKTMD5Z5K
         0Lu9z/MmrxW9xBQXOmY0RtBJpC60s6JQJEPxOTDsR59Bs/YCZ2CNFebDFGtTUEYPWFRW
         KlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmzdSnWA20S0l1Dv500vvfF7v4bE9Z6LameSSeF0Xs0=;
        b=iXBp7hTLMYuORbmiJyq/0oIMY1CfHUBceeQy/yuAu3AQHu2zAt3fiM1ksl7uwlkP4/
         heVeNB0SeX68IgT8boIM/Y4LLzuAKC3AEVuG3+ZdrlgN08GajJ0jpox2arj8nZvqREBZ
         BbQnWqeFvqnLKY6gRy0erCXKIfS79exke0jaBRQmwmkMjSeRP30ZW0paPsKHZmsqWC0T
         yWZclsw6yLjl9zdIJjN+2DKFJkIt+Y4zvE+vvZdjt/uBdcCPBIAm+4zbI3cmY2ED2HWT
         eGoi1Xz0Fh3OY1DjRpix7dymYjIgVzJ8FgRgX55BzjvdllLSQr1KIolBAZU+GCHDtcQz
         LMKw==
X-Gm-Message-State: APjAAAUHId3+/sbZIbEgQmS0D3RXQ+o8CeYvJB/WDYYgRuWn5GJ11fFk
        2yE54cZuwPnQpZ/2/01Ip/WnwQ==
X-Google-Smtp-Source: APXvYqxBwehDJojTePQT86/qCCFdgA3opyb3BPfW3BX35LjOW9JBDBLcXyWa550OfCI3gJ3XwNMH7A==
X-Received: by 2002:a1c:7005:: with SMTP id l5mr16230582wmc.149.1557763835050;
        Mon, 13 May 2019 09:10:35 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-11-31.w90-86.abo.wanadoo.fr. [90.86.214.31])
        by smtp.gmail.com with ESMTPSA id n2sm24439089wra.89.2019.05.13.09.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 09:10:34 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 3/5] dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
Date:   Mon, 13 May 2019 18:10:24 +0200
Message-Id: <20190513161026.31308-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513161026.31308-1-fparent@baylibre.com>
References: <20190513161026.31308-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the currently supported bindings for the MT6392 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V2:
	* New patch

---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 0ebd08af777d..aa6d2eb0eb19 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -17,7 +17,10 @@ Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
 This document describes the binding for MFD device and its sub module.
 
 Required properties:
-compatible: "mediatek,mt6397" or "mediatek,mt6323"
+compatible: Should be one of:
+	- "mediatek,mt6397"
+	- "mediatek,mt6392"
+	- "mediatek,mt6323"
 
 Optional subnodes:
 
@@ -28,6 +31,8 @@ Optional subnodes:
 	Required properties:
 		- compatible: "mediatek,mt6397-regulator"
 	see Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
+		- compatible: "mediatek,mt6392-regulator"
+	see Documentation/devicetree/bindings/regulator/mt6392-regulator.txt
 		- compatible: "mediatek,mt6323-regulator"
 	see Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
 - codec
@@ -43,7 +48,10 @@ Optional subnodes:
 
 - keys
 	Required properties:
-		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+		- compatible: Should be one of:
+			- "mediatek,mt6397-keys"
+			- "mediatek,mt6392-keys"
+			- "mediatek,mt6323-keys"
 	see Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
 
 Example:
-- 
2.20.1

