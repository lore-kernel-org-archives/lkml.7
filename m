Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64278C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAD12133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FOTeY/vH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfJEKOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 06:14:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37123 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfJEKOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 06:14:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so3432733pgi.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 03:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uxfFhC+Gco8oPLc2lC4Mh4+Ud03liyn0rjCnfNDhxQY=;
        b=FOTeY/vHx02g5ZfG+FGNAYkQdEj/8IPx4lnA8YLbaf08vhNFsGy1Xu8AVYG/Jc04L+
         pANSzFUwMBpMVrxAfnS6u1u/yMgcwe5w72Ir2cSLPVQa3QV7eBFyBHuJ0NYbIREtHPXc
         vOezN6c2Cwmgd9IdG3fxYR//zS/gRL/cyzxtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uxfFhC+Gco8oPLc2lC4Mh4+Ud03liyn0rjCnfNDhxQY=;
        b=c8/c74845d1Ymc/82FD+6C6NIZvM5i9G94mEgqywnTwE9hzbAlDsPjqy9lrYPAqzC+
         FYKXKsQ7NQIPFjzpNj9HzMsOFv1VrRxrQBGwEQ7Ceq1b85O4oFIcVMaHyTUlx66PrtFY
         O6oCgz8DY//vixwJN3rLtihwS78tioZWRPMZxPrV/aZnzmmjpseVMJEVAmotmOTzvZjX
         oi3NA/+0W9R/x5qu6qV/brNyGzfmAI4UW4/XJRURrsZarxP/D7odUTgPllmNPCj2D8VV
         i+Tus2cQRs/PdZOYIeBSq2Gw6eLalLIAgu+2TOPO0qGPLa8Ge6kGDg7PnOidJkn2cPn4
         w9vQ==
X-Gm-Message-State: APjAAAWPie2Rq+0XCO68gZadDHTteKvct1HNH3KlQgNJs2llC9F3XLcA
        RYlj3dbBXkzlx0p2TZJzIpk+pA==
X-Google-Smtp-Source: APXvYqxEZB2oeygrzS2m96wqhJ3bnMYuQjFeV97DuMHCDvFOw1Hw3Trk8BPAx3J7OxP0YcZcuTtWsA==
X-Received: by 2002:a17:90a:28c5:: with SMTP id f63mr22095283pjd.67.1570270440988;
        Sat, 05 Oct 2019 03:14:00 -0700 (PDT)
Received: from ikjn-glaptop.roam.corp.google.com ([61.254.209.103])
        by smtp.gmail.com with ESMTPSA id c3sm7558890pgl.51.2019.10.05.03.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 03:14:00 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@google.com>,
        Ting Shen <phoenixshen@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH 1/3] dt-bindings: input: Add DT bindings for Whiskers switch
Date:   Sat,  5 Oct 2019 18:13:45 +0800
Message-Id: <20191005101345.146460-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding document for Hammer's TABLET_MODE switch.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 .../devicetree/bindings/input/cros-cbas.yaml  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cros-cbas.yaml

diff --git a/Documentation/devicetree/bindings/input/cros-cbas.yaml b/Documentation/devicetree/bindings/input/cros-cbas.yaml
new file mode 100644
index 000000000000..3bc989c6a295
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cros-cbas.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/cros-cbas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChromeOS Hammer's Base Attached Switch
+
+maintainers:
+  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
+
+description:
+  This device is used to signal when a detachable base is attached to a
+  Chrome OS tablet. The node for this device must be under a cros-ec node
+  like google,cros-ec-spi or google,cros-ec-i2c.
+
+properties:
+  compatible:
+    const: google,cros-cbas
+
+required:
+  - compatible
-- 
2.23.0.581.g78d2f28ef7-goog

