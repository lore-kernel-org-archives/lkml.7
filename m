Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AFFC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CCF20679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413558;
	bh=cfypHA7a2yjFgpAcnLN6f7iyv0PahxPlsVzQHfmy+js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cIOjAxZ+AXNNoFEmMeCwk3Ns6lCFpMAfJPgFevW4t822c/OOGiuDNGQNZ/7XVBsug
	 7GgMZFxNJNLyGFc27bccS5k9Khtj264F7+aW1vuqnccjzzk60fQlamhGSHr9hNXoqa
	 1PmcpF+yf+sZQO/egJ5Ale2O9kg0v/9/teG+SUhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbfFXV7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:59:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33347 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732713AbfFXV7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:59:12 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so1058941iop.0;
        Mon, 24 Jun 2019 14:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U6pFo/bIhTqQ0w1jnYxKDUFNH921WAQ1SBJslZuGZ/4=;
        b=oW5IhA8hNTi2NwVIRE5C+Fbho70e2zas/UUWY/AfVDlm8oaOaU0nrGh5/C6CTBBX1B
         0b9PMl48uhkPPf4mvHfYGho3HaCswyFygBblQPnPSCCuNkL5qfkrlZTH3dBDGkDLy3rT
         HXgrRRc2c9NyvWTpVtjD9AsvAbUt9NKkan93wK8KHsIjYAKL+2h271EZgh12nKfMZM2l
         kXlCHeEf4q/I0NOObjLvjsePvgrpxPss7dIyM6DCYhY4JJHPQcPFqrI8/QMXY5Jp0fBU
         64eGNDB88Rt6gv6gYluMRVjR/eOpKMaBxO41kIWTXZy+vezKYUiOEn2xjcWfBAOp4uaF
         P4SA==
X-Gm-Message-State: APjAAAXrRxXbqGSagG2Zjq1CrGxpCZTLnSztFgNd0ZsqFGqpk0U+Mjgc
        RRLhq8GemwvL3EA6C78Zow==
X-Google-Smtp-Source: APXvYqxwApUzrVCirnDhUiOVhtpjvg8T1pA8K/0e+4LUTO11JV3Qb/Ynxib5LOUU+BdZ3jjlkFr3Mw==
X-Received: by 2002:a02:aa0d:: with SMTP id r13mr27011835jam.129.1561413551195;
        Mon, 24 Jun 2019 14:59:11 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.59.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:59:10 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v2 12/15] dt-bindings: display: Convert innolux,ee101ia-01 panel to DT schema
Date:   Mon, 24 Jun 2019 15:56:46 -0600
Message-Id: <20190624215649.8939-13-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the innolux,ee101ia-01 LVDS panel binding to DT schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/innolux,ee101ia-01d.txt     |  7 ------
 .../display/panel/innolux,ee101ia-01d.yaml    | 22 +++++++++++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
deleted file mode 100644
index e5ca4ccd55ed..000000000000
--- a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-Innolux Corporation 10.1" EE101IA-01D WXGA (1280x800) LVDS panel
-
-Required properties:
-- compatible: should be "innolux,ee101ia-01d"
-
-This binding is compatible with the lvds-panel binding, which is specified
-in panel-lvds.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
new file mode 100644
index 000000000000..5cc97cbe17fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/innolux,ee101ia-01d.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Innolux Corporation 10.1" EE101IA-01D WXGA (1280x800) LVDS panel
+
+maintainers:
+  - Heiko Stuebner <heiko.stuebner@bq.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: lvds.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: innolux,ee101ia-01d
+      - {} # panel-lvds, but not listed here to avoid false select
+
+...
-- 
2.20.1

