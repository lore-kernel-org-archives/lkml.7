Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F65C48BD3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F43F208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413543;
	bh=uhYx1AeiddJbv4tzvdr5Z38+Q44NwCk7+axoBSLb23A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CmS0V75zjdQBJmiPTHAey9yhULiIe/T38/TnnFceXWM54wJGtcZkbVk2otzJOqXWk
	 c2zXcnFFu7VptKSLo6F5CKxC/YuRi06tD4/S7nuaGKyoJ1nOppuOCo5JvoINdUXAqP
	 RPgIo6oFFM2PRwEWBMPt+5Dske3R0sBxwY70ZcCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbfFXV7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:59:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46704 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732611AbfFXV67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:58:59 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so809176iol.13;
        Mon, 24 Jun 2019 14:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WiTWFl+2LVv/eOXw13HDcJuOO4CS5h8+NNPFsB+2NKE=;
        b=dyuNZ2w/ZuGYEB9qzn1jYGpU9jzJhIHnt+YX+BlEED4XKv29veAAomL9326jm12RUX
         MFaAFQ1ADRmYWiM5jmqtA/hwf02Ajq92hOhr1tceAjoFMnTJ7NvscVaiplLt5tsZmUT1
         K/bb9bkNGoz/RaxxG6stQ/3gJJhld+aw7GoWkXIYDHwtp78L3917HcUpJhnPSxCmDhlA
         7k3K5Sc2QBqisaATbxbu45R3y/pAfyma/lmy83L6HsrqXmWT6E2PvkZNiGDRGbbMbTn/
         oiW3BL9EPO3gPzqhj3qKY5wQbSkMZhhbX7oJ4st8SMFKZK4pkdb1VUjwrisYb+yx8Sor
         yqtQ==
X-Gm-Message-State: APjAAAUl5MAdkcFCaJAIytCKzVgXrat+cf6AfrtxErv0v+DrvZyg6Wam
        3kDJfszVmoA4xUqfUvMM8A==
X-Google-Smtp-Source: APXvYqxq++mc5I7wrF7ScvEQZ8FcQXjoNxrYK1T5UgPSYsQ75AYxxW3mX65fkti/Qu0r4eHZQ19gMQ==
X-Received: by 2002:a5d:8c97:: with SMTP id g23mr3403649ion.250.1561413538556;
        Mon, 24 Jun 2019 14:58:58 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.58.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:58:58 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 04/15] dt-bindings: display: Convert armadeus,st0700-adapt panel to DT schema
Date:   Mon, 24 Jun 2019 15:56:38 -0600
Message-Id: <20190624215649.8939-5-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/armadeus,st0700-adapt.txt   |  9 -------
 .../display/panel/armadeus,st0700-adapt.yaml  | 27 +++++++++++++++++++
 2 files changed, 27 insertions(+), 9 deletions(-)
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
index 000000000000..59376669442a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.yaml
@@ -0,0 +1,27 @@
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
+required:
+  - compatible
+  - power-supply
+
+...
-- 
2.20.1

