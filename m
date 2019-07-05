Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD4DC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F71321721
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562344998;
	bh=cjn1RDgAvn7mPSLQ3RGUdAXR8GwCs11TRXQyqqRLwJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ILP6qf3WLKpZ9syfTiuWJQsjF1tQl4oyFz23Cy4icp9fHDSVqmmALDzgodnxTlTo0
	 3K04Ld2qWOzS+PHsA+3ZGhWjXK/ap5ah9NofkXbrVadJI4uMFMUlkDP67je+w2sXld
	 WCtliUtyx0S5K+s7sKWegGji28uGCVSogQrXB+H0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfGEQmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:42:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40718 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbfGEQmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:42:32 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so12147489iom.7;
        Fri, 05 Jul 2019 09:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmMSkEMpERvJyjJRrG5g4f+OapV9H/whTXHG0VCoTaM=;
        b=bAJ3dJsSEDx37lDcdylhtFwIh+zzgw//9MuFylvBiiSvjLMHFjA3f+aRyu/oRmFSJ6
         WeCSzXthiWLFFMLj1rq0BqborXHW4OPV6BvGl+fePzpTLC6RsTbuwStFQ/p5P0GsQFgW
         doTR6zM6Dj0te9P4QgtKgIivDz8XeWCh4iv2fOXHdxIizzcHV6OVOBLqRY7XqV91TMx9
         uBsHiamciOnPFm3fBWed7O/OOfHXVIZK+ldgCsfeY1U6W0PKJmPO9J3OCKf2s1uCCfcd
         T9KTY+0zulJ+QnVbb25bNp97n685OLVWSGvqNbkxqQ4DWWWcrAf5+qma1sQbAvjboA5W
         AwYw==
X-Gm-Message-State: APjAAAXpydqqNmkC8I5v6HajtIjDGg73uIEyNKxzmqARQJ9waVX9e9ob
        w8BwUBONEa3qbHl9ZXs0Fw==
X-Google-Smtp-Source: APXvYqwgijG0bDl9MQ8QMzy7JFWGEXki+c5Gsm88CadBQrl5AZgvMPes1qJpGkDYhMRNkc9YrsNmpg==
X-Received: by 2002:a02:8a:: with SMTP id 132mr5543519jaa.89.1562344950866;
        Fri, 05 Jul 2019 09:42:30 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id b8sm6878104ioj.16.2019.07.05.09.42.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:42:30 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 04/13] dt-bindings: display: Convert bananapi,s070wv20-ct16 panel to DT schema
Date:   Fri,  5 Jul 2019 10:42:12 -0600
Message-Id: <20190705164221.4462-5-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705164221.4462-1-robh@kernel.org>
References: <20190705164221.4462-1-robh@kernel.org>
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
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/bananapi,s070wv20-ct16.txt  | 12 -------
 .../display/panel/bananapi,s070wv20-ct16.yaml | 31 +++++++++++++++++++
 2 files changed, 31 insertions(+), 12 deletions(-)
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
index 000000000000..bbf127fb28f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.yaml
@@ -0,0 +1,31 @@
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
+  power-supply: true
+  backlight: true
+  enable-gpios: true
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

