Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04411C468A0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8ACD218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562344962;
	bh=IShDHfOObEva2W5WusJoZM9TZTCbH99fjzYWyGtlO7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CRepOLMCZ3t/b0wozrJJxhJkRboyksSmrXT4QfPO8FVaeyHbW/X1YLJ7xmxsNv7U5
	 lN4LXdZq6+4j2RvFHz2WndgsimpZ444g9ZWuMgfP+JFRfdFLm2jNsIvT0NUvWLYM73
	 7m0aimeRI986EswWAQpDPXrYEPx4JWqLBRhEhNI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfGEQml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:42:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36631 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbfGEQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:42:39 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so4772887iom.3;
        Fri, 05 Jul 2019 09:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tWKOZQN5j63GOMW8bPg2YdYLUphNbaDT5/UX97P/uo=;
        b=OFUU90HEh7wkf/2ctinZpa9cgZRdSl5a6d8ucxAkiUIiDR+ZKcEHHKEBExyOdEw6X8
         l134KhNcYhva0eW2kt2k19p+82w1HnUtKam4+iegiwkRGPYx5Pn7yr4ndW/zfWJe/H90
         fApwINc/fPu9GQ6idZaL6xQUEz69vrcy7mqcD7Sab2Kxd0kF8uBOYFqcIfghOyUUFKzO
         nhlOlicc5fRJcqXMpH+/TaDaAxJ6r8xb7Hweo9F1ezeMYxWpTrLwEpEM6Dro+f6fdV1c
         qVl9oL5zla1BiJp7upA2cFlrh7Gy3cMYN5+2HL2nPiQyUaKmsoC5qPoeMoNGc0w+pRi3
         FDlg==
X-Gm-Message-State: APjAAAXO40SII7FvQiWJKMW1M/12vKfxuBTt56gNzNs4p4l9A9Wdnu60
        vDc+svP5ntunr8PxzSH69Q==
X-Google-Smtp-Source: APXvYqx9WdfjM+nTIv22HXckRghmE2QP5JiFVcCPJrnBeuFT1r//qxUAqUxKtMJB63QyW5QCB7T/Qw==
X-Received: by 2002:a5d:8890:: with SMTP id d16mr2919578ioo.274.1562344958138;
        Fri, 05 Jul 2019 09:42:38 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id b8sm6878104ioj.16.2019.07.05.09.42.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:42:37 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: [PATCH v3 08/13] dt-bindings: display: Convert tfc,s9700rtwv43tr-01b panel to DT schema
Date:   Fri,  5 Jul 2019 10:42:16 -0600
Message-Id: <20190705164221.4462-9-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705164221.4462-1-robh@kernel.org>
References: <20190705164221.4462-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the tfc,s9700rtwv43tr-01b panel binding to DT schema.

Cc: Heiko Stuebner <heiko.stuebner@bq.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/tfc,s9700rtwv43tr-01b.txt   | 15 ---------
 .../display/panel/tfc,s9700rtwv43tr-01b.yaml  | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt b/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt
deleted file mode 100644
index dfb572f085eb..000000000000
--- a/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-TFC S9700RTWV43TR-01B 7" Three Five Corp 800x480 LCD panel with
-resistive touch
-
-The panel is found on TI AM335x-evm.
-
-Required properties:
-- compatible: should be "tfc,s9700rtwv43tr-01b"
-- power-supply: See panel-common.txt
-
-Optional properties:
-- enable-gpios: GPIO pin to enable or disable the panel, if there is one
-- backlight: phandle of the backlight device attached to the panel
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml b/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml
new file mode 100644
index 000000000000..9e5994417c12
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/tfc,s9700rtwv43tr-01b.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TFC S9700RTWV43TR-01B 7" Three Five Corp 800x480 LCD panel with resistive touch
+
+maintainers:
+  - Jyri Sarha <jsarha@ti.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |+
+  The panel is found on TI AM335x-evm.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: tfc,s9700rtwv43tr-01b
+
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

