Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9151C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6C6204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558107147;
	bh=fXDNx7CY34eKZz0tXhvUJN2URFYHXe1oJl0Cq/pmcRU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pS7GLyJSQVdP0EpwwsgDKfqmU901ZDRjY7iBnCYeXkIaKMJ3VhsGH4l8AImpzLtoO
	 0HJbxYc9kykCjdEeTo43R6Is7LL7o9FZmIaBxKYeG2w4ZmxglYBbATUS7FHBKzN5Dc
	 AuakCqgKqCYbvCp4cuH69MLTR2UC3unSTulV7eYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfEQPc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:32:27 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42385 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfEQPc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:32:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id w9so3647626oic.9;
        Fri, 17 May 2019 08:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pjjzE4+GT6QIjZ+kII5LCAwn20M8y12XM5bh0VRi7ew=;
        b=QPjP0oJ6RMh6MukTk0X1uK1y7Uuc4O0BZcNGheaTxvgLRcALDmfrFVTYbSWOCnl+r1
         TWt4OavzH0g3RdCEpa7efq3s2ijh3q9tU0KKyi929Yw72SU+8IzVKlvUC8rs4Phkq85u
         C9pi6hxKaPTq5g1iKYkwPN1bLfXJosLMqO6QaH9QhRv/7dpJNKL7KbRQbG2Mn0dk0MEd
         Nq8eLRGyg/tCcb/6UeoV83ejUkeG7JhrUGMA0ArvFug9Ejh2fzqHcpRcThTTAXUnHkro
         41UmL00Knn/a/hv5EJHb264aid3I7HKiMkwlPSPEMRhnnmg2BYQc2D0OjgJoXptCWCn6
         o46A==
X-Gm-Message-State: APjAAAX3jMD8FXjm+7yQK1wC0A62ErEySauoj5XEqrgqjxDo5G9mu2Yc
        iaEv7mRkd2XamNZ8Jg7WmQ==
X-Google-Smtp-Source: APXvYqwg5SXymU7zD7SeYVYMf5gcjpsxlY2K1eWVqSYq+9YY8ETKnHq7xVg6IvwAIHJDUEMqkXhgqA==
X-Received: by 2002:aca:aa8c:: with SMTP id t134mr9914294oie.169.1558107145584;
        Fri, 17 May 2019 08:32:25 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o124sm3340730oig.23.2019.05.17.08.32.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 08:32:24 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3] dt-bindings: arm: Convert Actions Semi bindings to jsonschema
Date:   Fri, 17 May 2019 10:32:23 -0500
Message-Id: <20190517153223.7650-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Actions Semi SoC bindings to DT schema format using json-schema.

Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
- update MAINTAINERS

 .../devicetree/bindings/arm/actions.txt       | 56 -------------------
 .../devicetree/bindings/arm/actions.yaml      | 38 +++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 39 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
 create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml

diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
deleted file mode 100644
index d54f33c4e0da..000000000000
--- a/Documentation/devicetree/bindings/arm/actions.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Actions Semi platforms device tree bindings
--------------------------------------------
-
-
-S500 SoC
-========
-
-Required root node properties:
-
- - compatible :  must contain "actions,s500"
-
-
-Modules:
-
-Root node property compatible must contain, depending on module:
-
- - LeMaker Guitar: "lemaker,guitar"
-
-
-Boards:
-
-Root node property compatible must contain, depending on board:
-
- - Allo.com Sparky: "allo,sparky"
- - Cubietech CubieBoard6: "cubietech,cubieboard6"
- - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
-
-
-S700 SoC
-========
-
-Required root node properties:
-
-- compatible :  must contain "actions,s700"
-
-
-Boards:
-
-Root node property compatible must contain, depending on board:
-
- - Cubietech CubieBoard7: "cubietech,cubieboard7"
-
-
-S900 SoC
-========
-
-Required root node properties:
-
-- compatible :  must contain "actions,s900"
-
-
-Boards:
-
-Root node property compatible must contain, depending on board:
-
- - uCRobotics Bubblegum-96: "ucrobotics,bubblegum-96"
diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
new file mode 100644
index 000000000000..60abd371e474
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/actions.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/actions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi platforms device tree bindings
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      # The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC.
+      - items:
+          - enum:
+              - allo,sparky # Allo.com Sparky
+              - cubietech,cubieboard6 # Cubietech CubieBoard6
+          - const: actions,s500
+      - items:
+          - enum:
+              - lemaker,guitar-bb-rev-b # LeMaker Guitar Base Board rev. B
+          - const: lemaker,guitar
+          - const: actions,s500
+
+      # The Actions Semi S700 is a quad-core ARM Cortex-A53 SoC.
+      - items:
+          - enum:
+              - cubietech,cubieboard7 # Cubietech CubieBoard7
+          - const: actions,s700
+
+      # The Actions Semi S900 is a quad-core ARM Cortex-A53 SoC.
+      - items:
+          - enum:
+              - ucrobotics,bubblegum-96 # uCRobotics Bubblegum-96
+          - const: actions,s900
diff --git a/MAINTAINERS b/MAINTAINERS
index 005902ea1450..be8c3564804c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1338,7 +1338,7 @@ F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/linux/soc/actions/
-F:	Documentation/devicetree/bindings/arm/actions.txt
+F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
-- 
2.20.1

