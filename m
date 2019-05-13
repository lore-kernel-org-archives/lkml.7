Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A4EC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8962146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aEfNnn+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfEMOVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:21:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33018 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfEMOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:21:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so7144509wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AUf8m75b1jcXgPG7N+MQYE2RSkYM8jBGz55TKb5hL3g=;
        b=aEfNnn+IfrPwWIU5xkBCmp50TmqPUsCXSA6rTulbbQ2PC6DDXGfjkMXMgKuHliOvi0
         b3NfiIJRaKglH08KEDtel0WexYxJv9i3cPCXmhFPqZIBGk+3fA1WVqJPot2RNKy++6Ld
         oxSuktx/cNdc/RDX8VW1WKXf26U2yO5PtzKRpUS/JqrqWsUtz9UIHleIzxtpU0eB0tzy
         od84ATyaVGGg2mjYZzCmhUvHiTaqt9I6dY+ps1eps8/wdjvoL5QNPD2M40tchmOkn9Lw
         8Fz4SB5YjUsoh/Uoa7AYS3Ev7afXIUH3TR3+pR8y2oal81KVXzPFSGEzP95FKpEzLOgN
         FaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AUf8m75b1jcXgPG7N+MQYE2RSkYM8jBGz55TKb5hL3g=;
        b=SplMIMDL14hwo4Z8s5yIZ/LxWdjHuxFquWZAtopAn/VmTku0eP+1s/AKzRKU6mlvYJ
         i40bPgzCR/EGXdgONbGISKEScL2yuKFx+sfWGNpqwV3rWSmDiNYf2SsXm0iXFOD8/ij0
         9pu0PhlBYHoCJW1CMBVxfLrXlYEYglejNThM0WE1BBzYx85A54ozR7xt3U21R/yCsxjR
         gG9C8Y5K67zIDkcFkkhGdQvQiUhJeeQgmQjG6iOjGF8Pp3Z+dAVmKS7p8wdWj5dytetj
         icI1nfZr0bnbqKZVlswEc0SAfOdAduBGkA+k0xjm6HmdSvoCA/iNpC0l1ZQ26gNL/s1w
         fBpw==
X-Gm-Message-State: APjAAAXpxWsLi//+yMr/tkE61UhSSKCXM+7WK1iZzXuINpQdlUloF+Hw
        BG5ZlKZ7qNUTdmKYXXkb+VwBsA==
X-Google-Smtp-Source: APXvYqzn91lD6eedmAzVssO5xswe1ZAQaefUBlpsZtRJs7YMayR6NIvT1sEdX34ZQ1nzfs4XhaBA1w==
X-Received: by 2002:adf:ef50:: with SMTP id c16mr1707151wrp.296.1557757303963;
        Mon, 13 May 2019 07:21:43 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-11-31.w90-86.abo.wanadoo.fr. [90.86.214.31])
        by smtp.gmail.com with ESMTPSA id v184sm21133615wma.6.2019.05.13.07.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 07:21:43 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
Date:   Mon, 13 May 2019 16:21:19 +0200
Message-Id: <20190513142120.6527-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../devicetree/bindings/input/mtk-pmic-keys.txt       | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
index 2888d07c2ef0..858f78e7262c 100644
--- a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
+++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
@@ -1,15 +1,18 @@
-MediaTek MT6397/MT6323 PMIC Keys Device Driver
+MediaTek MT6397/MT6392/MT6323 PMIC Keys Device Driver
 
-There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
+There are two key functions provided by MT6397/MT6392/MT6323 PMIC, pwrkey
 and homekey. The key functions are defined as the subnode of the function
 node provided by MT6397/MT6323 PMIC that is being defined as one kind
 of Muti-Function Device (MFD)
 
-For MT6397/MT6323 MFD bindings see:
+For MT6397/MT6392/MT6323 MFD bindings see:
 Documentation/devicetree/bindings/mfd/mt6397.txt
 
 Required properties:
-- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+- compatible: Should be one of:
+	- "mediatek,mt6397-keys"
+	- "mediatek,mt6392-keys"
+	- "mediatek,mt6323-keys"
 - linux,keycodes: See Documentation/devicetree/bindings/input/keys.txt
 
 Optional Properties:
-- 
2.20.1

