Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76288C04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0DE2189E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557795037;
	bh=2O5Fxjx2lYALZsM+zw5tgPGHy1irMs8ps80aJVg+kso=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Q5FKNUdDJvAJUoEFplGCbaf0Md+ehNT0SE1J8dW8Bl3PFh84f5eG0GUhXMJLcZH72
	 xJ9Xwblt060vFbX9Dmgz+HPrsDY7+bbrZGCnmH5p/+VrOQTAyWIMVJl+c1HSlHjpIj
	 hbTAGsZ8ca84VAiCa7nHb6cFh4hRjYdjyZnCaCt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfENAug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 20:50:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42726 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfENAug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 20:50:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id k9so10819544oig.9;
        Mon, 13 May 2019 17:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rv0mn5KUbHgge7O7vIawkh8Ujbd2zyxMdRjz07XVw40=;
        b=kTtzAuxgmhxh87CJ67XqCJP8v9zY8Q+KVygMCILTgQSm7ovqHV/f6aIIK1tkA4p5pN
         07vWnqadPyrEOekU/IUuwle3BFL2ZTk03VN+Uo1x5h9vn6sJSWY+gjrAPg9tDP1jv4lx
         Ev2p1fc9BTq/Ed4xMFQmF1TB5OZzttsYJ3j4+OO+K0eB7xdu9FV9eBiPe1fVwJxflni/
         60fpmGHKIDGCC+UINkOKTFlQJmGbX9Y4E+6Pj6YIigMfrTB0/gXvbT8Z43Khtm6VEPsO
         Q+i0z593oSf6/8FSZtXBUFAHqEAYEDEe3YrZ0oe0JY/xRvIZKyy0e0LTmlKKtlnEolyF
         acmA==
X-Gm-Message-State: APjAAAWO5Tax4JuQHfz41UuHfavI9uuHwgvsxBQUcm1f8NzOGq9Apftv
        md1GwKwQnsUr0mPxoSLjkA==
X-Google-Smtp-Source: APXvYqwcKIXRuwDcyH4/5BZxQTsVYy/bl0ZkdHMSWsUga3eOtXdA70ypXhk0MsnTri1K/oUOAtmxsQ==
X-Received: by 2002:aca:3cc5:: with SMTP id j188mr1363334oia.88.1557795034674;
        Mon, 13 May 2019 17:50:34 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id w192sm5990259oiw.57.2019.05.13.17.50.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 17:50:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org
Subject: [PATCH] dt-bindings: gpio: Convert Arm PL061 to json-schema
Date:   Mon, 13 May 2019 19:50:33 -0500
Message-Id: <20190514005033.15593-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Arm PL061 GPIO controller binding to json-schema format.

As I'm the author for all but the gpio-ranges line, make the schema dual
GPL/BSD license.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
This warns on a few platforms missing clocks, interrupt-controller 
and/or #interrupt-cells. We could not make those required, but really 
they should be IMO. OTOH, it's platforms like Spear and Calxeda which 
aren't too active, so I don't know that we want to fix them.

 .../devicetree/bindings/gpio/pl061-gpio.txt   | 10 ---
 .../devicetree/bindings/gpio/pl061-gpio.yaml  | 69 +++++++++++++++++++
 2 files changed, 69 insertions(+), 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/pl061-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/pl061-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/pl061-gpio.txt b/Documentation/devicetree/bindings/gpio/pl061-gpio.txt
deleted file mode 100644
index 89058d375b7c..000000000000
--- a/Documentation/devicetree/bindings/gpio/pl061-gpio.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-ARM PL061 GPIO controller
-
-Required properties:
-- compatible : "arm,pl061", "arm,primecell"
-- #gpio-cells : Should be two. The first cell is the pin number and the
-  second cell is used to specify optional parameters:
-  - bit 0 specifies polarity (0 for normal, 1 for inverted)
-- gpio-controller : Marks the device node as a GPIO controller.
-- interrupts : Interrupt mapping for GPIO IRQ.
-- gpio-ranges : Interaction with the PINCTRL subsystem.
diff --git a/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml b/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
new file mode 100644
index 000000000000..313b17229247
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/pl061-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM PL061 GPIO controller
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+  - Rob Herring <robh@kernel.org>
+
+# We need a select here so we don't match all nodes with 'arm,primecell'
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,pl061
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^gpio@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - const: arm,pl061
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    oneOf:
+      - maxItems: 1
+      - maxItems: 8
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  clocks:
+    maxItems: 1
+
+  clock-names: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+  gpio-ranges:
+    maxItems: 8
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - clocks
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
+
+...
-- 
2.20.1

