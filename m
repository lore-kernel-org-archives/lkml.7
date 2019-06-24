Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637F2C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCBD20679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413549;
	bh=Vwj4On9AT2bwJBRCAZ8BNVHzGIg7UVrIFUForYQt+/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2KHREwJCkRzO8yNeCE80S64FnqUn+oIzqZcgqY+Jf0RaVaVE9GoH/S39W0iUP/v3F
	 viCH8HNppjjtunVt44VtA5NOXoFi2gdDLMEba7dL2dMS0zkjOuw982ZWDWDXIm+tvg
	 VqNWR6ByXcRSw7vqKKdvinxSfktHvXxtUbbW1R/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbfFXV7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:59:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44847 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732619AbfFXV7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:59:00 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so374047iob.11;
        Mon, 24 Jun 2019 14:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hgTCH8T1FFouuaZoULxX1dk9vJ97SA7YisaMIiZjBD4=;
        b=K4Hj3FauDTUZ0twFUvEXPvr2tZRqRq/sWML9n3iXHTr6rKuW/PlYpeBcRqOWsVFNZk
         bMyBdYbIM0wtCUKqBBOCZv8HTRdSUCNLjRtMUXJ+ph9MHIHcFSvxjLVzNVZbaqVd+0Kd
         +Di/Mw3+He9GfzicgDkVmSkMGrkGo+LpWxcBVl9SpPQoy+eYukkfw1ngOIGkYjkX0sGG
         EnmVSDMg/eB8uGsNuifz+yXb8G/bcwKxeI4pQ7w391tgEmci6FVJgnBeFcPZIGqZuRuP
         /hGDqZJYu8JkUYRL95jMFP8CAMeaQndZHKJcEK69TrwOk/VQAc35K09b7BIVPss7IgN1
         XkCg==
X-Gm-Message-State: APjAAAXhKB3IvQyfq0rAl/vjlgVD8IpxTDQ5oJfW29jU25gCXEly7ALI
        sT3PzJkcAU6ef9mbdQLRjA==
X-Google-Smtp-Source: APXvYqwpRjRUo5xyI5qpCoBZMiPUylQk+P5cFQRqkbHuKdgufy+mn/WStchkhrO7hxpKdKO0z38dag==
X-Received: by 2002:a02:600c:: with SMTP id i12mr14366350jac.108.1561413539674;
        Mon, 24 Jun 2019 14:58:59 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.58.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:58:59 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 05/15] dt-bindings: display: Convert bananapi,s070wv20-ct16 panel to DT schema
Date:   Mon, 24 Jun 2019 15:56:39 -0600
Message-Id: <20190624215649.8939-6-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bananapi,s070wv20-ct16 panel binding to DT schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/bananapi,s070wv20-ct16.txt  | 12 ----------
 .../display/panel/bananapi,s070wv20-ct16.yaml | 24 +++++++++++++++++++
 2 files changed, 24 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
deleted file mode 100644
index 35bc0c839f49..000000000000
--- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
-
-Required properties:
-- compatible: should be "bananapi,s070wv20-ct16"
-- power-supply: see ./panel-common.txt
-
-Optional properties:
-- enable-gpios: see ./simple-panel.txt
-- backlight: see ./simple-panel.txt
-
-This binding is compatible with the simple-panel binding, which is specified
-in ./simple-panel.txt.
diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.yaml b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.yaml
new file mode 100644
index 000000000000..2c1d3bf2baa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/bananapi,s070wv20-ct16.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: bananapi,s070wv20-ct16
+
+required:
+  - compatible
+  - power-supply
+
+...
-- 
2.20.1

