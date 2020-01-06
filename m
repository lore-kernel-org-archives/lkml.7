Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831F7C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56691218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbcHXjkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgAFHW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:22:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37169 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFHW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:22:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so26475805pga.4;
        Sun, 05 Jan 2020 23:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qnUvpIVI6jilLhA8MwTkPqoyoqaSkFHL57CbN/GbI7g=;
        b=lbcHXjkpQo7dQQgKv7FiC2zhZQzdkQceveV++pQGU+MBXnRIrRMEHKKa4/E+QDdKgV
         ChUU7UmZG8hoKl4LvDpH34vVSl7A/35BUZq6GU4WOWZ293O2ky4y7WFGsZpdC0Ya2xF4
         scwm60WdiMEU2liYGKPW7bTt6XmrSX7Lu/6rcW080PgnMLGTAaI5nJ0gsZoHC5vA8MQY
         9TX1wHNBnVw/P7lFCwTeGSX4NkKIU+wUGGqW6/j14am3HOiDgg3oRYLwX4ig59ARUY8q
         v4SEYHMBXVkiBv3Y4Ohslp//hecJo2kicHVhEOqxvjyMmya3JjuMQnczLxrKiat5I2K8
         bpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qnUvpIVI6jilLhA8MwTkPqoyoqaSkFHL57CbN/GbI7g=;
        b=BOFO1YLwze6LzPlCzbcXbovi7IpXwrTKFKrEOS2/8sdhu/dJL4TWefHorbaASR2fR7
         ZejbBdRLnfNRLlR+B4xes7m7Rs+eiLQepr2ntZ6xDzId9InNkgVTBWutcJ67HOlGolMa
         XNSo48b3Jl/kaxjsgr0LQ/044D4cip8Gk3QdaO7HrxCJzwPhkfV4Vip5sB347N4baGoQ
         XmKZqx4t3bk+BmiY4GnlHlhZfC6AY5ST8x3Nj9zFOKWmrnLyEl7NhumDH5tspDlSa2wN
         guEtLWwCUI5ySkdZUOsJRIacupt2LM8oLsA4Lsm9q2ydeizB+m+10xfVfuSrgCtJxfeT
         lUUQ==
X-Gm-Message-State: APjAAAWqxShFGCdq9LehlUWvniEJZBmbegYXDPyKFes7cW0AQP3Xp58R
        msp9yPxP65NNSHdw+xLBrKA=
X-Google-Smtp-Source: APXvYqw3mf/xnblDKmwPV7DcEqS1ZCi31H4bCJkPPew0LIQ7H6Q3Ttk79JEHacwOnlMcRI/Rx8dZKg==
X-Received: by 2002:a63:3484:: with SMTP id b126mr106717399pga.17.1578295346391;
        Sun, 05 Jan 2020 23:22:26 -0800 (PST)
Received: from localhost.localdomain ([49.207.56.131])
        by smtp.gmail.com with ESMTPSA id q8sm72968137pgg.92.2020.01.05.23.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jan 2020 23:22:25 -0800 (PST)
From:   Rishi Gupta <gupt21@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v1 1/3] dt-bindings: ttyvs: document serial null modem driver dt bindings
Date:   Mon,  6 Jan 2020 12:51:53 +0530
Message-Id: <68e8f2bc664fd2d624bdb5f7a374abb42e5a5770.1578235515.git.gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1578235515.git.gupt21@gmail.com>
References: <cover.1578235515.git.gupt21@gmail.com>
In-Reply-To: <cover.1578235515.git.gupt21@gmail.com>
References: <cover.1578235515.git.gupt21@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ttyvs driver creates virtual tty devices. These devices can
also be created through device tree. This commit document this.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 .../devicetree/bindings/serial/ttyvs.yaml          | 175 +++++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ttyvs.yaml

diff --git a/Documentation/devicetree/bindings/serial/ttyvs.yaml b/Documentation/devicetree/bindings/serial/ttyvs.yaml
new file mode 100644
index 0000000..d37c237
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ttyvs.yaml
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/ttyvs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual multi-port serial card DT bindings
+
+maintainers:
+  - Rishi Gupta <gupt21@gmail.com>
+
+description: |
+  The ttyvs driver creates a virtual card accessible through node
+  /dev/ttyvs_card. This card can have 0 to 65535 virtual tty devices.
+  The card is modeled as a node with zero or more child nodes each
+  representing a virtual tty device. These devices can be configured
+  to be a loop-back type device or it can be part of a null-modem pair.
+
+  Devices can be created through DT (see examples Ex1/2/3 at the end)
+  or by writing pre-formatted string to card node.
+
+  If the driver is built as loadable module, standard null modem pairs
+  can be created by passing 'init_num_nm_pairs' parameter. Similarly,
+  standard loopback devices can be created by passing 'init_num_lb_devs'
+  parameter. When DT is used and device nodes are defined, all devices
+  created due to module parameters will be deleted first and then
+  devices specified by DT will be created.
+
+  Devices can be deleted only by writing pre-formatted string to card node,
+  irrespective of whether they were created using DT or through string.
+
+properties:
+  compatible:
+    const: ttyvs,virtual-uart-card
+
+  max-num-vs-devs:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 0xffff
+    maxItems: 1
+    description:
+      By default, the driver can create upto 64 devices. This number can
+      be changed by passing 'max_num_vs_devs' parameter to the driver or
+      by defining 'max-num-vs-devs' DT property. If both are used then
+      first all devices created during module loading are deleted, then
+      driver updates itself to support total number of devices as defined
+      by max-num-vs-devs property.
+
+patternProperties:
+  "^ttyvs@[0-9]+$":
+    type: object
+    description:
+      A node representing one virtual tty device. This node optionally,
+      describes, device number and its configuration.
+
+    properties:
+      dev-num:
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 0
+          - maximum: 0xffff
+        maxItems: 1
+        description:
+          Specifies index (N in /dev/ttyvsN) to use for creating device.
+          If this property is not specified then next lowest free index
+          is used by driver. Valid value for N is 0 to 65535.
+
+      rtsmap:
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          - enum: [1, 6, 8, 9]
+        maxItems: 1
+        description:
+          Specifies to which pin(s) RTS pin of this device should be
+          connected. Valid values are pin 1 (DCD), pin 6 (DSR), pin 8
+          (CTS) and pin 9 (RI). If this is not used then RTS pin is
+          left unconnected.
+
+      dtrmap:
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          - enum: [1, 6, 8, 9]
+        maxItems: 1
+        description:
+          Specifies to which pin(s) DTR pin of this device should be
+          connected. Valid values are pin 1 (DCD), pin 6 (DSR), pin 8
+          (CTS) and pin 9 (RI). If this is not used then DTR pin is
+          left unconnected.
+
+      set-dtr-at-open:
+        type: boolean
+        description:
+          If used, DTR signal will be asserted by driver when device
+          node is opened by user space application.
+
+      peer-dev:
+        $ref: /schemas/types.yaml#definitions/phandle
+        description:
+          Phandle to the peer DT node if this node is part of a null
+          modem pair.
+
+required:
+  - compatible
+
+examples:
+  - |
+    # Ex1; Null-modem pair only TX/RX connected
+    # /dev/ttvs0  <---> /dev/ttyvs1
+    #      TX (3) ----> (2) RX
+    #      RX (2) <---- (3) TX
+
+    ttyvs-card@0 {
+        compatible = "ttyvs,virtual-uart-card";
+
+        ttyvs0: ttyvs0 {
+            dev-num = <0>;
+            peer-dev = <&ttyvs1>;
+        };
+
+        ttyvs1: ttyvs1 {
+            dev-num = <1>;
+            peer-dev = <&ttyvs0>;
+        };
+    };
+
+  - |
+    # Ex2; Standard loop-back device
+    # TX (3) -->|
+    # RX (2) <--|
+
+    ttyvs-card@0 {
+        compatible = "ttyvs,virtual-uart-card";
+        ttyvs2 {
+            dev-num = <2>;
+            rtsmap = <8>;
+            dtrmap = <1 6>;
+            set-dtr-at-open;
+        };
+    };
+
+  - |
+    # Ex3; Standard null-modem pair for hardware flow control
+    # TX  (3) ----> (2) RX
+    # RX  (2) <---- (3) TX
+    # RTS (7) ----> (8) CTS
+    # DTR (4) --+-> (1) DCD
+    #           +-> (6) DSR
+    # CTS (8) <---- (7) RTS
+    # DCD (1) <-+-- (4) DTR
+    # DSR (6) <-+
+
+    ttyvs-card@0 {
+        compatible = "ttyvs,virtual-uart-card";
+        max-num-vs-devs = <128>;
+
+        ttyvs3: ttyvs3 {
+            dev-num = <3>;
+            rtsmap = <8>;
+            dtrmap = <1 6>;
+            set-dtr-at-open;
+            peer-dev = <&ttyvs4>;
+        };
+
+        ttyvs4: ttyvs4 {
+            dev-num = <4>;
+            rtsmap = <8>;
+            dtrmap = <1 6>;
+            set-dtr-at-open;
+            peer-dev = <&ttyvs3>;
+        };
+    };
+...
-- 
2.7.4

