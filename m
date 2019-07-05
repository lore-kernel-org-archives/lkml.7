Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A6EC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574B621670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562344957;
	bh=t1Ue7FJLbRLfIKFAp7sxqui/K8j/FOIfkqOwmBAz2oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wy0z99/v6irJQ8XRxLfG28YWFmcGpZ1Pv8qnIuve++IUv/8o2moNcQ2XgXovQAWOz
	 LZaR/XqQvnFPXY/ZrCwuoBJdqRsHitl/j5LcusPMElGD4XPOcbQ/G9F4y++bEy+yCa
	 N/Psr1FWaTmwDJ/6ih9s313eOmzrP7zHY1z/TPbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfGEQmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:42:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46074 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbfGEQmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:42:33 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so10769800ioc.12;
        Fri, 05 Jul 2019 09:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WIBJ9DoW85CJmy6TrFg2SdCJgMlWzD7A88ZcXqMgYx0=;
        b=jiY4yUv1IZ6JlULllaBVX237Ax9CiV2Xh+FHEwAMjV4TMRu2CgQQfGaU50mmTTWCCw
         jhAY1rQQFfs5a3uh03WnMsOHqRW7jemXPiw0D0TsQ4WPHcT+cPMLGB4xVpziFbtjBkB2
         x2w029RMH1c3h44lizC1+ws2ETTvCwAmLBLf3fp+bCSBQNSpDpGphKdBo1FVj8df5LMu
         p5KvHZOPShAO9NnimE5zlyBbyKmbS/UaAcpo+vIRBbAwe8fWyFEeRfsaHvG/I4R78wnv
         kETMGWOvK/NKwt0PK98AE++38O1BXofSKFGr3DXiGwYeBEPkenp2GP3Pq9QfKrYmPgCV
         qfNA==
X-Gm-Message-State: APjAAAVh2EU4/PJ8ZMOfgn1O5uMVKjqUpwCdgEBd4IpUdPi9LQHDHrjo
        U/MxjfFilkfJA8vTuDUz6w==
X-Google-Smtp-Source: APXvYqwnniP5BuOD3/e6DU5248zgPFcWecSBjHhu+FwaR6iSC72bYwlQhYmqx6lESF1YMKpSp2Isyw==
X-Received: by 2002:a6b:691d:: with SMTP id e29mr4865968ioc.96.1562344952759;
        Fri, 05 Jul 2019 09:42:32 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id b8sm6878104ioj.16.2019.07.05.09.42.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:42:31 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v3 05/13] dt-bindings: display: Convert dlc,dlc0700yzg-1 panel to DT schema
Date:   Fri,  5 Jul 2019 10:42:13 -0600
Message-Id: <20190705164221.4462-6-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705164221.4462-1-robh@kernel.org>
References: <20190705164221.4462-1-robh@kernel.org>
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
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/dlc,dlc0700yzg-1.txt        | 13 --------
 .../display/panel/dlc,dlc0700yzg-1.yaml       | 31 +++++++++++++++++++
 2 files changed, 31 insertions(+), 13 deletions(-)
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
index 000000000000..287e2feb6533
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml
@@ -0,0 +1,31 @@
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

