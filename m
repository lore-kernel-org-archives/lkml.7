Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45714C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198AF20679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413547;
	bh=rv8ss3d2E6H33xqlobUSMc4WD1WvBlR5Yj2hpGkd2rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tLAKuhbhMXSR/9Q23T0CZQ7v2zbJgIIj4fxAAFaWjzCEPkqxXNPkb4ip+isS87Jsi
	 zBgDPdn31A6dYPgfk2VqBNvYtaqdhfml1YBKMlPdBFtiQth3YBMH1o9HyyWTmjPHcs
	 t/+K1rwnVzANCW1ZIuKE7yE9oCbhPxaGL39npCTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbfFXV7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:59:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45166 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732611AbfFXV7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:59:02 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so556436ioc.12;
        Mon, 24 Jun 2019 14:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hq52QEn/OewtdxsavtLn6pDRnEXQBUEM1fJjUXGZO0I=;
        b=fvzz2wrfF8WpdrrnKQzwu+b65dN276WAqdnCvbYtL3Wz5u0Pwdp7kVYFrEE+MHPFvG
         bXId/WPkbkcGJZM2aUGrbnPcrPd6AnyKRgvKyeH8ouD6MNfMi60xXxWyMVUcvPLSwQev
         vqjuzkSi4TAB6CC3WXUJS2ocvU2Y7LnIOkD45thct1fGvXxMFQmCzC0Dyu8AbXH/pJCp
         Kobq9pk8zPmnHkUFcnAFpeUuNG/YI3t2Q2AhgnT1imK88yH4AS7J5PWlP1uuUlf1WV12
         PBWEzmoUiaqT3FSh/7+3u78NIvTK9+JCa+8E30N5yhGVZelTBZxIwhiY4nn4afm0DRit
         uj/A==
X-Gm-Message-State: APjAAAUW3qFKe5LN1vOxo8K1Y7YwJJxTm8AZffoc1svOyIi6t1scfR82
        jqOY+sDCxpgwJoyo15OJ0dGKWRw=
X-Google-Smtp-Source: APXvYqxg84QEBHR5RlNYAPBEKnrmpuactlgd6/VlkRLE3HLK1rUluLr9fwjtrpBI0gA4+XqNtFHSkA==
X-Received: by 2002:a6b:cb07:: with SMTP id b7mr42084336iog.7.1561413541536;
        Mon, 24 Jun 2019 14:59:01 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.58.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:59:01 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 06/15] dt-bindings: display: Convert dlc,dlc0700yzg-1 panel to DT schema
Date:   Mon, 24 Jun 2019 15:56:40 -0600
Message-Id: <20190624215649.8939-7-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the dlc,dlc0700yzg-1 panel binding to DT schema.

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/dlc,dlc0700yzg-1.txt        | 13 ---------
 .../display/panel/dlc,dlc0700yzg-1.yaml       | 28 +++++++++++++++++++
 2 files changed, 28 insertions(+), 13 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt b/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt
deleted file mode 100644
index bf06bb025b08..000000000000
--- a/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-DLC Display Co. DLC0700YZG-1 7.0" WSVGA TFT LCD panel
-
-Required properties:
-- compatible: should be "dlc,dlc0700yzg-1"
-- power-supply: See simple-panel.txt
-
-Optional properties:
-- reset-gpios: See panel-common.txt
-- enable-gpios: See simple-panel.txt
-- backlight: See simple-panel.txt
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml b/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml
new file mode 100644
index 000000000000..1b0b63d46f3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/dlc,dlc0700yzg-1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DLC Display Co. DLC0700YZG-1 7.0" WSVGA TFT LCD panel
+
+maintainers:
+  - Philipp Zabel <p.zabel@pengutronix.de>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: dlc,dlc0700yzg-1
+
+  reset-gpios: true
+  enable-gpios: true
+  backlight: true
+
+required:
+  - compatible
+  - power-supply
+
+...
-- 
2.20.1

