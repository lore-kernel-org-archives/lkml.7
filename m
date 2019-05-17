Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630F8C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355432087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558107314;
	bh=w92p50J4WAoV288Dus1n7+dToN0frjAWnlOVdk3iSsc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=l2AXiKEP1IjvfnK2SXXQ9D+/Jk2HRtFr/JKcK3bwi7wupwiPQWvPn1jzbxf9OOAqM
	 OW4317smY6pg6ICG8E76zHrZwWB8i5Ag8LSLgc2sImFCSuJVX9ncBRNp7hfhI2zeSN
	 h81/QlTSZf3dhrMXmHOx+KQ0QDoUIROjEGTnyJT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfEQPfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:35:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43593 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbfEQPfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:35:12 -0400
Received: by mail-oi1-f195.google.com with SMTP id t187so5443813oie.10;
        Fri, 17 May 2019 08:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PE46hE33zglQ6gPxNshGw7b/oA/SQzmRJJFuwowqkA=;
        b=EL7yUyB4iZTuhOJtYesF77hQaW6f48FH1ufvNTSOMkYRsBA+6ojpTy3ZrN1frzWAWq
         sgS8yQvwZm0OucwaIHQvdflvCUnnd3bOHDjCM72btJnQJANf0pRpCEQi1Y5fe83qgTBt
         VIKlzp2B7PmoC0G3T2zGOVpMXPnWPY1KbgxL0nfXx7dp64MCWPp6KWoyS8Y3GHLKD7BV
         dp7XYvzfsZhLhGKqObzC6G+c4RnS4kF3d3dD57CmbNAzrblqu6py1sm0WOeA7d2i1iJL
         V3W5JPQ+IgXtfPAaV+9YAt4NY8qzmJZOGEFOdM12XdwZJ5ptCqLnNXCvu0G41Pf8R8+H
         7CFA==
X-Gm-Message-State: APjAAAVUuLVyIB7sUIfUfyVGrr/rDszqRzUre0tuj4SqCbOTQEpZI6AR
        CgUICpHQqUL/bviQRMoDjQ==
X-Google-Smtp-Source: APXvYqxzyNii8xeDPTeNjFjj0HEZVfsTow5C33TurWu79HZJioYQxPo0VtxfgUz8a1DtF0zfb47+CA==
X-Received: by 2002:aca:3093:: with SMTP id w141mr85093oiw.173.1558107311782;
        Fri, 17 May 2019 08:35:11 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id f5sm3596859oih.39.2019.05.17.08.35.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 08:35:11 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v3] dt-bindings: arm: Convert Alpine board/soc bindings to json-schema
Date:   Fri, 17 May 2019 10:35:10 -0500
Message-Id: <20190517153510.13647-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Alpine SoC bindings to DT schema format using json-schema.

Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/al,alpine.txt     | 16 --------------
 .../devicetree/bindings/arm/al,alpine.yaml    | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/al,alpine.txt
 create mode 100644 Documentation/devicetree/bindings/arm/al,alpine.yaml

diff --git a/Documentation/devicetree/bindings/arm/al,alpine.txt b/Documentation/devicetree/bindings/arm/al,alpine.txt
deleted file mode 100644
index d00debe2e86f..000000000000
--- a/Documentation/devicetree/bindings/arm/al,alpine.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Annapurna Labs Alpine Platform Device Tree Bindings
----------------------------------------------------------------
-
-Boards in the Alpine family shall have the following properties:
-
-* Required root node properties:
-compatible: must contain "al,alpine"
-
-* Example:
-
-/ {
-	model = "Annapurna Labs Alpine Dev Board";
-	compatible = "al,alpine";
-
-	...
-}
diff --git a/Documentation/devicetree/bindings/arm/al,alpine.yaml b/Documentation/devicetree/bindings/arm/al,alpine.yaml
new file mode 100644
index 000000000000..a70dff277e05
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/al,alpine.yaml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/al,alpine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Annapurna Labs Alpine Platform Device Tree Bindings
+
+maintainers:
+  - Tsahee Zidenberg <tsahee@annapurnalabs.com>
+  - Antoine Tenart <antoine.tenart@bootlin.com>
+
+properties:
+  compatible:
+    items:
+      - const: al,alpine
+  model:
+    items:
+      - const: "Annapurna Labs Alpine Dev Board"
+
+...
-- 
2.20.1

