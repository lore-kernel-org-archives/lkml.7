Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D70C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96D320870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1nLUBGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbfIEIT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:19:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36634 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfIEIT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:19:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so1247636pfr.3;
        Thu, 05 Sep 2019 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9/BdIi9v9vT+sjdaqY5A0ECHD5U3qpWLnzpWXvofxDY=;
        b=r1nLUBGcm0bfuZZ9Lr7GSA62KRvGRugvYiQ3s1TSi2oyWNKhdrBXHjTf2ZtGebVm1N
         sh7wZ2uUUHgw84Q64gm7NOKnM0JGC/frypk5e84p9I93pn5Id8i2RviYRI88bsveSHDY
         ceTGu6jIfXr9Le2TXdJ+7MVGNwyPmLaPPkUmHclpGnhzdzhdqP5K7uzohK6MqPjmYfoN
         cSif/IsIjUZQxbdq+gMqUnq0Fel1F2/dwk5Bg2aKRRTkuEgPUD0hhrEZmFnxelU/97z/
         tbLkUGImiJljqmi2Vnf1sUR9WIOiAuluSIlPrsiRQWDY+2lgmJqYpeo+dU8x/kpG06Lx
         Q2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9/BdIi9v9vT+sjdaqY5A0ECHD5U3qpWLnzpWXvofxDY=;
        b=KfALPtawcr0CiiVOCKYdYLNrVT7+VNXwDrk2PKpvWAn8pCv7wLgPBaBZoxay0vuy0i
         8kk29AY4KU8THN1SOuTxCw3OqbteTMrxh5bat19+6jpCytvjnSZJ1FWCyyXLGRF9aiKZ
         qHz69xX0CAAJs3uPkGVjlxzg7d9bqIJId4F+NCJMd3Ouj9ebVLZxSFoyzD/OK+GEuPZg
         MifxJUQPs0GRnj/gD09zp7doQiHPmwopi2b7kfMBHxdbyxv4Sdt6R0YWQ5bm6hhQ51tH
         y9l/UU3uMQnTBJoWsYKPEkFjLD9zF0EpyUAWYYnuZ9gGtAt1pQZ7clKO37SI+6lEhrsl
         aPmA==
X-Gm-Message-State: APjAAAW8J+Bp25pJjf27bHjE8oYY+UklzriABO28CmzQmXGjH6cevqD4
        ZZd4dupuDXXorJJjNvLBlJ/pAzG2
X-Google-Smtp-Source: APXvYqxe1QnHt/X7OsIxUjVUHyE38n/yrBYayr07GhF9bIM7Bs1edEmFMoAIFICZevF1sqQC3j1bCw==
X-Received: by 2002:a63:e148:: with SMTP id h8mr2013798pgk.275.1567671565558;
        Thu, 05 Sep 2019 01:19:25 -0700 (PDT)
Received: from localhost.localdomain ([49.216.8.243])
        by smtp.gmail.com with ESMTPSA id h9sm1170401pgh.51.2019.09.05.01.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 01:19:24 -0700 (PDT)
From:   jamestai.sky@gmail.com
X-Google-Original-From: james.tai@realtek.com
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        CY_Huang <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>,
        "james.tai" <james.tai@realtek.com>
Subject: [PATCH] dt-bindings: arm: Convert Realtek board/soc bindings to json-schema
Date:   Thu,  5 Sep 2019 16:17:21 +0800
Message-Id: <20190905081721.1548-1-james.tai@realtek.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james.tai" <james.tai@realtek.com>

Convert Realtek SoC bindings to DT schema format using json-schema.

Signed-off-by: james.tai <james.tai@realtek.com>
---
 .../devicetree/bindings/arm/realtek.txt       | 22 -------------------
 .../devicetree/bindings/arm/realtek.yaml      | 17 ++++++++++++++
 2 files changed, 17 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/realtek.txt
 create mode 100644 Documentation/devicetree/bindings/arm/realtek.yaml

diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Documentation/devicetree/bindings/arm/realtek.txt
deleted file mode 100644
index 95839e19ae92..000000000000
--- a/Documentation/devicetree/bindings/arm/realtek.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Realtek platforms device tree bindings
---------------------------------------
-
-
-RTD1295 SoC
-===========
-
-Required root node properties:
-
- - compatible :  must contain "realtek,rtd1295"
-
-
-Root node property compatible must contain, depending on board:
-
- - MeLE V9: "mele,v9"
- - ProBox2 AVA: "probox2,ava"
- - Zidoo X9S: "zidoo,x9s"
-
-
-Example:
-
-    compatible = "zidoo,x9s", "realtek,rtd1295";
diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
new file mode 100644
index 000000000000..ad9b13bc42f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/realtek.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek platforms device tree bindings
+
+properties:
+  compatible:
+    oneOf:
+        items:
+          - enum:
+              - mele,v9
+              - probox2,ava
+              - zidoo,x9s
+          - const: realtek,rtd1295
-- 
2.17.1

