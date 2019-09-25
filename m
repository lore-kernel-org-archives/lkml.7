Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCC2C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1173220640
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569417177;
	bh=B3km3T5Vv4ZYG4SiQh7tlb93sT30lHlD2cjOuwHgj9U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ysc969ABuWcpO7OGimsG3TwOBdN4xKNHf9b3ABRZS9R2gHe0XPVgRjL3Qd57B06/w
	 ZhZe55D7oiiKA/f6xc5DzhEdY6U9IzyVyHnJn2ho6A2rEfN/raInK6RijAHoh488dj
	 LUvqphtWgUVu1JoAlC2pxKzATUOQ06J0koeJ4qhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406230AbfIYNM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 09:12:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35242 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405921AbfIYNMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:12:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id x3so4838453oig.2;
        Wed, 25 Sep 2019 06:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWmNOzJx7r5Dye9C9HIH0fNSv2YxMODD9DtwUooioH0=;
        b=ruQzoHdTMWwmnAsnSkl57AoGCobZlq1wl23YTT3mgE4LDlXSLcph5VpE2ryVudfP6F
         6+/q2f4691F8mZbKyH/LI2LDnHIyANY/mk+wShyMZf//FIfa2Is4EWpX7rhSyjL7rmCL
         04l8aiFmxcyyLL/XkaQpCCGby56HyRcL7ZbLZ4BaGtsjud46+peqRCqPI1SxPswFUwBF
         QEcO7rf9Xl/0Er2Yncv3Y67qXt+5N9mDQyv0MU//oLK6sQQV0DznvFlwcAAfWNtO0Wn7
         aStPZ2z0EcL0I0VCBtY/DnxVui/sbBulZK6MqW8RZdZrs5sbEDzz66mcMojBpgiMgWck
         Hsyw==
X-Gm-Message-State: APjAAAVSvuc2K1QOfMkqSB86AXK3CfQ9iupfXvOXq+t85OEsJ1hDgW43
        lg8qmCtd9CtA/jpc5tVYNw==
X-Google-Smtp-Source: APXvYqyRNeRQsJUXICdwZXRKjWmcbdmyDUjLs3J1t5NtgQFrB53QCFp+8qBs1OaZ1ObrHbQTOmgU9g==
X-Received: by 2002:aca:59c6:: with SMTP id n189mr4519258oib.127.1569417174055;
        Wed, 25 Sep 2019 06:12:54 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 11sm1628329otg.62.2019.09.25.06.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 06:12:53 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2] dt-bindings: riscv: Fix CPU schema errors
Date:   Wed, 25 Sep 2019 08:12:52 -0500
Message-Id: <20190925131252.19359-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the errors in the RiscV CPU DT schema:

Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property
Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@1: 'timebase-frequency' is a required property
Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible:0: 'riscv' is not one of ['sifive,rocket0', 'sifive,e5', 'sifive,e51', 'sifive,u54-mc', 'sifive,u54', 'sifive,u5']
Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible: ['riscv'] is too short
Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property

Fixes: 4fd669a8c487 ("dt-bindings: riscv: convert cpu binding to json-schema")
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Add timebase-frequency to simulator example.

 .../devicetree/bindings/riscv/cpus.yaml       | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index b261a3015f84..eb0ef19829b6 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -24,15 +24,17 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - sifive,rocket0
-          - sifive,e5
-          - sifive,e51
-          - sifive,u54-mc
-          - sifive,u54
-          - sifive,u5
-      - const: riscv
+    oneOf:
+      - items:
+          - enum:
+              - sifive,rocket0
+              - sifive,e5
+              - sifive,e51
+              - sifive,u54-mc
+              - sifive,u54
+              - sifive,u5
+          - const: riscv
+      - const: riscv    # Simulator only
     description:
       Identifies that the hart uses the RISC-V instruction set
       and identifies the type of the hart.
@@ -67,8 +69,6 @@ properties:
       lowercase to simplify parsing.
 
   timebase-frequency:
-    type: integer
-    minimum: 1
     description:
       Specifies the clock frequency of the system timer in Hz.
       This value is common to all harts on a single system image.
@@ -102,9 +102,9 @@ examples:
     cpus {
         #address-cells = <1>;
         #size-cells = <0>;
-        timebase-frequency = <1000000>;
         cpu@0 {
                 clock-frequency = <0>;
+                timebase-frequency = <1000000>;
                 compatible = "sifive,rocket0", "riscv";
                 device_type = "cpu";
                 i-cache-block-size = <64>;
@@ -120,6 +120,7 @@ examples:
         };
         cpu@1 {
                 clock-frequency = <0>;
+                timebase-frequency = <1000000>;
                 compatible = "sifive,rocket0", "riscv";
                 d-cache-block-size = <64>;
                 d-cache-sets = <64>;
@@ -153,6 +154,7 @@ examples:
                 device_type = "cpu";
                 reg = <0>;
                 compatible = "riscv";
+                timebase-frequency = <1000000>;
                 riscv,isa = "rv64imafdc";
                 mmu-type = "riscv,sv48";
                 interrupt-controller {
-- 
2.20.1

