Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17C4C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8072184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562345004;
	bh=PCFOYt7Thns+5SJFnKZXuD+e1k3G6zZiDVIc9TkVAfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KsFHLPjuaqpoew+HiglirdLZ3T5i07+aidBBsxtSlWCEZ2nJbulGfjeQLXLrb0b0+
	 XfjMgK7v5vKoFwKFL7eFo52R37o+7Vh+TmsJbALvTLIsW6SZ2MTFIMTDyKmqo96IBQ
	 baJe0XKPH54Ci4gTTaMjJtIf+/BMVedYG8eDh7Eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfGEQnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:43:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40709 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfGEQm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:42:29 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so12147310iom.7;
        Fri, 05 Jul 2019 09:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TlywxX14ySmHTYN+js2f/7/fr0bdtbmAsh6I7swK/0=;
        b=X16NUEgcSG6SocyUYk6h30B2Om2JBOo2szofSWuonUFcnAQl+9qfuVI82UaW0DrgEc
         KoPKB13DllaOsqJn1yrxDLtQ2sASUkwJU0vU7n9JFVaUdZuO/PWYceV3djxXfe38Jy1J
         qXuaW+PauhqRvbGTGfVkSxBJ1hLosvnnpMXDyStIz/TwVcxZGQZFqY/DmvV14wL4acUh
         Aoc4uEpkLGBexjPMQKaBnl1+8hijsjJf23yT/7An3PsdP3NgY3V9qXyMAMx7s+ypHBAh
         b9Til2bOqfBMioJiLlL3rc+8Mbc9CB13tr+ADP8DF5AfRNfzZWDL7+9OtR2c5Z0nz5Kq
         /hLg==
X-Gm-Message-State: APjAAAVA6DnJkW5kZt0qEKIIZJrtttxUIKVtPRDVCrqyhj7d8NicEHgI
        bpyYaxj4lE4ckqjkF0nqSsEZbFM=
X-Google-Smtp-Source: APXvYqxHWyS0u8xIf/9PqymPEaYm32f/ja9lh5ILK483/3hMdxhqSKzUW9ptROughYD9aVnk66SskA==
X-Received: by 2002:a5e:990a:: with SMTP id t10mr1765957ioj.182.1562344948712;
        Fri, 05 Jul 2019 09:42:28 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id b8sm6878104ioj.16.2019.07.05.09.42.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:42:28 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 03/13] dt-bindings: display: Convert armadeus,st0700-adapt panel to DT schema
Date:   Fri,  5 Jul 2019 10:42:11 -0600
Message-Id: <20190705164221.4462-4-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705164221.4462-1-robh@kernel.org>
References: <20190705164221.4462-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the armadeus,st0700-adapt panel binding to DT schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/armadeus,st0700-adapt.txt   |  9 -----
 .../display/panel/armadeus,st0700-adapt.yaml  | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
deleted file mode 100644
index a30d63db3c8f..000000000000
--- a/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
+++ /dev/null
@@ -1,9 +0,0 @@
-Armadeus ST0700 Adapt. A Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT with
-an adapter board.
-
-Required properties:
-- compatible: "armadeus,st0700-adapt"
-- power-supply: see panel-common.txt
-
-Optional properties:
-- backlight: see panel-common.txt
diff --git a/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.yaml b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.yaml
new file mode 100644
index 000000000000..a6ade47066b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/armadeus,st0700-adapt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Armadeus ST0700 Adapter
+
+description:
+  A Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT with an adapter board.
+
+maintainers:
+  - '"Sébastien Szymanski" <sebastien.szymanski@armadeus.com>'
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: armadeus,st0700-adapt
+
+  power-supply: true
+  backlight: true
+  port: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - power-supply
+
+...
-- 
2.20.1

