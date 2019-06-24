Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D828DC4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A519320679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413602;
	bh=7eGgTxoczue+ibHksFB39mJn6fuaqj00T1yayZP0tPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AtbZwu0MSp4eeqNfi2uo4EBWw9ZmSa3ztzskRtJjT3DvlyO/BP7FlQVK7lY2qGKAh
	 BhhZ/sKaAl+zDMK5swYLRUptIbaVlICvIgivjnRCQXLcy4E5n9NhepZYpWGNOgziR6
	 BFVR7L+1/SOtO/f2z/EaDkU5aLCaJPR2rW4u8fsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfFXWAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:00:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43825 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbfFXV7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:59:04 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so177251ios.10;
        Mon, 24 Jun 2019 14:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxcMK+QpGg0slednYV4FulPMcMSYDpcVW7BBUR9mgVE=;
        b=klwDYluS12GwQ77j+INLgwQge0R6E6V6u9ZRbl7uciUaEdNiY1mlyENihtjgTZh5B3
         ycz1FJYsZi+AAvS0YeC6DZvP2pKmMoYKS103QyXEZFzecmVMnsahRDctG9o2yGmnuzHq
         3yyk7zCcZ++l5XqhzHhrTJ1c8odj1Qy+7m2tMLZwPU1LWPFQkc7XV+xbdW9PJWD7L06N
         ET5MUauwcZ/OaXXG2tAkpdT7JDSPmUd3iSgSjKPh3rtIN5wQEw0D30aHn0QLT43svNe+
         1PHDqxfL1fPjFo+Hrv2zDw+2oS67V4FRWCNAgWwzrwVspXNO90iWMkjFMvgCTzl3Eozl
         qv1Q==
X-Gm-Message-State: APjAAAWOK2+rKPrPzIfzXgIr5lCa0cw1/U8vHyTYDfgsP20/KQ8Yr8yZ
        wPFtOQSKOhkJk4aURPAWQA==
X-Google-Smtp-Source: APXvYqzwIKIeLoUlThoycHNFqIx8+o4MBi9fk3uxcSvOOQ8J69Gxs8VFNebAx//J6Y37gExO+ippjA==
X-Received: by 2002:a5d:81c6:: with SMTP id t6mr483058iol.86.1561413543153;
        Mon, 24 Jun 2019 14:59:03 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.59.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:59:02 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 07/15] dt-bindings: display: Convert pda,91-00156-a0 panel to DT schema
Date:   Mon, 24 Jun 2019 15:56:41 -0600
Message-Id: <20190624215649.8939-8-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the pda,91-00156-a0 panel binding to DT schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/pda,91-00156-a0.txt         | 14 -----------
 .../display/panel/pda,91-00156-a0.yaml        | 25 +++++++++++++++++++
 2 files changed, 25 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
deleted file mode 100644
index 1639fb17a9f0..000000000000
--- a/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-PDA 91-00156-A0 5.0" WVGA TFT LCD panel
-
-Required properties:
-- compatible: should be "pda,91-00156-a0"
-- power-supply: this panel requires a single power supply. A phandle to a
-regulator needs to be specified here. Compatible with panel-common binding which
-is specified in the panel-common.txt in this directory.
-- backlight: this panel's backlight is controlled by an external backlight
-controller. A phandle to this controller needs to be specified here.
-Compatible with panel-common binding which is specified in the panel-common.txt
-in this directory.
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.yaml b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.yaml
new file mode 100644
index 000000000000..cea5bcb3c455
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/pda,91-00156-a0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PDA 91-00156-A0 5.0" WVGA TFT LCD panel
+
+maintainers:
+  - Cristian Birsan <cristian.birsan@microchip.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: pda,91-00156-a0
+
+required:
+  - compatible
+  - power-supply
+  - backlight
+
+...
-- 
2.20.1

