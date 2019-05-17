Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683B0C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB93216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558107726;
	bh=BKrfk+As2w0WYhhZ8aohK54c8m600fvX9J78C6gg8nQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zcUKyOOg3cpzx7Y0M5cflIozmV685k7+cgvuypd65jHahJo6lmElV6N8i22FFUd+g
	 zBu06ssav9ZZjcvXP+XXSohKym23Nc6wnv+QY8qCO/OyTfXDXHA6xlmD1L0PXdDuxs
	 V73xTEp4dZK9qVsjod7p8RK/DoELOq//DeJKFR7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfEQPmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:42:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35103 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfEQPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:42:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id n14so7155064otk.2;
        Fri, 17 May 2019 08:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M14rlFzwcUBHjfiLjquFIIr+CTAHX9KTzEGha2QcIb4=;
        b=JSEU8DRAj5pbv6moQA8tzwPSirg7FFpgKy2ZhXAR89mxmGo0/l9DQ5+byGLlC3052B
         jYfj1Ncl8BAmLL4rY3flYsG//alf/rIO+Gt6PFdlJLnaFaKS0L40KUmcr4/LislrFCTH
         BkEpbPvS6OKWwHBjDGk9ZIGFRl7zi1b/QegvxuYXSvIxC9tgL7GTvyuJu0M0J0MsuvBS
         3VE52ACaDtQurq8A3ENauO8xUo+giMzJ2vz/sSRT7AaG1VvlMqPjQQzmgxsb73BJjBMP
         vcCVyQikIqRAgPna2LDBJUuYbdg9MDW1aX3VMSd07WwJ6ETwHKORt/WyhJ/1UEbJz9u4
         06vg==
X-Gm-Message-State: APjAAAV9T7970WvhelLQ0bmNOi1yQc9pk7wErSpYzHKG7DzLwRj0SxXl
        m6X4cjOZY1nxd72sCyrD0KUVvRI=
X-Google-Smtp-Source: APXvYqw0Xw5KM/Ug+L3eQ59evU0HzCljrxLHoWvrm2B6Bua1+oOoEbMfCxmoUgUa8UTB+GUNxkAMjw==
X-Received: by 2002:a05:6830:208a:: with SMTP id y10mr8971186otq.293.1558107724092;
        Fri, 17 May 2019 08:42:04 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x21sm2912108otk.4.2019.05.17.08.42.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 08:42:03 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3] dt-bindings: arm: Convert MediaTek board/soc bindings to json-schema
Date:   Fri, 17 May 2019 10:42:02 -0500
Message-Id: <20190517154202.24594-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert MediaTek SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - Rebase to Linus' master

 .../devicetree/bindings/arm/mediatek.txt      | 89 ------------------
 .../devicetree/bindings/arm/mediatek.yaml     | 91 +++++++++++++++++++
 2 files changed, 91 insertions(+), 89 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
deleted file mode 100644
index 56ac7896d6d8..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ /dev/null
@@ -1,89 +0,0 @@
-MediaTek SoC based Platforms Device Tree Bindings
-
-Boards with a MediaTek SoC shall have the following property:
-
-Required root node property:
-
-compatible: Must contain one of
-   "mediatek,mt2701"
-   "mediatek,mt2712"
-   "mediatek,mt6580"
-   "mediatek,mt6589"
-   "mediatek,mt6592"
-   "mediatek,mt6755"
-   "mediatek,mt6765"
-   "mediatek,mt6795"
-   "mediatek,mt6797"
-   "mediatek,mt7622"
-   "mediatek,mt7623"
-   "mediatek,mt7629"
-   "mediatek,mt8127"
-   "mediatek,mt8135"
-   "mediatek,mt8173"
-   "mediatek,mt8183"
-
-
-Supported boards:
-
-- Evaluation board for MT2701:
-    Required root node properties:
-      - compatible = "mediatek,mt2701-evb", "mediatek,mt2701";
-- Evaluation board for MT2712:
-    Required root node properties:
-      - compatible = "mediatek,mt2712-evb", "mediatek,mt2712";
-- Evaluation board for MT6580:
-    Required root node properties:
-      - compatible = "mediatek,mt6580-evbp1", "mediatek,mt6580";
-- bq Aquaris5 smart phone:
-    Required root node properties:
-      - compatible = "mundoreader,bq-aquaris5", "mediatek,mt6589";
-- Evaluation board for MT6592:
-    Required root node properties:
-      - compatible = "mediatek,mt6592-evb", "mediatek,mt6592";
-- Evaluation phone for MT6755(Helio P10):
-    Required root node properties:
-      - compatible = "mediatek,mt6755-evb", "mediatek,mt6755";
-- Evaluation board for MT6765(Helio P22):
-    Required root node properties:
-      - compatible = "mediatek,mt6765-evb", "mediatek,mt6765";
-- Evaluation board for MT6795(Helio X10):
-    Required root node properties:
-      - compatible = "mediatek,mt6795-evb", "mediatek,mt6795";
-- Evaluation board for MT6797(Helio X20):
-    Required root node properties:
-      - compatible = "mediatek,mt6797-evb", "mediatek,mt6797";
-- Mediatek X20 Development Board:
-    Required root node properties:
-      - compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
-- Reference board variant 1 for MT7622:
-    Required root node properties:
-      - compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
-- Bananapi BPI-R64 for MT7622:
-    Required root node properties:
-      - compatible = "bananapi,bpi-r64", "mediatek,mt7622";
-- Reference board for MT7623a with eMMC:
-    Required root node properties:
-      - compatible = "mediatek,mt7623a-rfb-emmc", "mediatek,mt7623";
-- Reference board for MT7623a with NAND:
-    Required root node properties:
-      - compatible = "mediatek,mt7623a-rfb-nand", "mediatek,mt7623";
-- Reference board for MT7623n with eMMC:
-    Required root node properties:
-      - compatible = "mediatek,mt7623n-rfb-emmc", "mediatek,mt7623";
-- Bananapi BPI-R2 board:
-      - compatible = "bananapi,bpi-r2", "mediatek,mt7623";
-- Reference board for MT7629:
-    Required root node properties:
-      - compatible = "mediatek,mt7629-rfb", "mediatek,mt7629";
-- MTK mt8127 tablet moose EVB:
-    Required root node properties:
-      - compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
-- MTK mt8135 tablet EVB:
-    Required root node properties:
-      - compatible = "mediatek,mt8135-evbp1", "mediatek,mt8135";
-- MTK mt8173 tablet EVB:
-    Required root node properties:
-      - compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
-- Evaluation board for MT8183:
-    Required root node properties:
-      - compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
new file mode 100644
index 000000000000..a4ad2eb926f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoC based Platforms Device Tree Bindings
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+  - Matthias Brugger <matthias.bgg@gmail.com>
+description: |
+  Boards with a MediaTek SoC shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2701-evb
+          - const: mediatek,mt2701
+
+      - items:
+          - enum:
+              - mediatek,mt2712-evb
+          - const: mediatek,mt2712
+      - items:
+          - enum:
+              - mediatek,mt6580-evbp1
+          - const: mediatek,mt6580
+      - items:
+          - enum:
+              - mundoreader,bq-aquaris5
+          - const: mediatek,mt6589
+      - items:
+          - enum:
+              - mediatek,mt6592-evb
+          - const: mediatek,mt6592
+      - items:
+          - enum:
+              - mediatek,mt6755-evb
+          - const: mediatek,mt6755
+      - items:
+          - enum:
+              - mediatek,mt6765-evb
+          - const: mediatek,mt6765
+      - items:
+          - enum:
+              - mediatek,mt6795-evb
+          - const: mediatek,mt6795
+      - items:
+          - enum:
+              - archermind,mt6797-x20-dev
+              - mediatek,mt6797-evb
+          - const: mediatek,mt6797
+      - items:
+          - enum:
+              - bananapi,bpi-r64
+              - mediatek,mt7622-rfb1
+          - const: mediatek,mt7622
+      - items:
+          - enum:
+              - mediatek,mt7623a-rfb-emmc
+              - mediatek,mt7623a-rfb-nand
+              - mediatek,mt7623n-rfb-emmc
+              - bananapi,bpi-r2
+          - const: mediatek,mt7623
+
+      - items:
+          - enum:
+              - mediatek,mt7629-rfb
+          - const: mediatek,mt7629
+      - items:
+          - enum:
+              - mediatek,mt8127-moose
+          - const: mediatek,mt8127
+      - items:
+          - enum:
+              - mediatek,mt8135-evbp1
+          - const: mediatek,mt8135
+      - items:
+          - enum:
+              - mediatek,mt8173-evb
+          - const: mediatek,mt8173
+      - items:
+          - enum:
+              - mediatek,mt8183-evb
+          - const: mediatek,mt8183
+...
-- 
2.20.1

