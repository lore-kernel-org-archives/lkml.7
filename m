Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C535C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B68214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569354430;
	bh=N7UNJp2aLm/KoYwPhl0kJKwJrfEikSSiNIClM9H0hYo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=08tgkpnX1FtvZRadcJ71SigLX8O9QBKJHhUEXlPIJcq+7HV7mufljsNlx9FGXNwKN
	 jjqeRx5TYd0c34dt5ZUBvkxFnzfgsQjM+GeFHC5VTqqikiGlW7Mwj9FiGxALMTSA5V
	 iUXe0S+IMl4eA8PpMRr1b6p6pbSIbnBI2bvKG0Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404416AbfIXTrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:47:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36087 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfIXTrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:47:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id 67so2612064oto.3;
        Tue, 24 Sep 2019 12:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHPQMpVO9op7Vu0vGkUhBj5SViO1WuLEbRF6XVcQOi4=;
        b=XMCjfiHw9rCPPMVdqspV9asYROMEz+icTyxy8n4ElaKWz/n2RJFsGVewttWItYJF24
         WtIbmNR+hGjziFoJspGcp+IocxW6MrH65ebwL3vxhgJnDvJ1jCILD0dzZjI96j5sFl9s
         L3c469l9FK8e7JKm68lA0ZD9wGKIoizT4/PakDKQKRd60fPBSoC0LU/7a+1ZLoo3ISs2
         hw85pijJnypNqR3hhiqlUP3sQ4yYhOCjV09X4ccHWIfoTNbC2Cx/YfwWjvQBORSVky/R
         trBVwVk7hcPBdGqse6FM3QzGS36+mJdL4FguRbkaR/qJ7qcsJZmNqJVSt1QcEV1Ezp0G
         8sAw==
X-Gm-Message-State: APjAAAUQe8y2Nd9eZHioBdgmjsjliuG7rB+dS7roBdmIBixjENox+NGk
        SvSFy9Mp6ychIXlwut3rHMHNQ+o=
X-Google-Smtp-Source: APXvYqzq/V8n0w/j43BKO8sETLatIuXKrfBSN9UzNEGxdt2zAohbFjRF2fosDLt5LIb+wo7rpBbC2w==
X-Received: by 2002:a9d:6405:: with SMTP id h5mr839756otl.115.1569354427442;
        Tue, 24 Sep 2019 12:47:07 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e18sm868660oib.57.2019.09.24.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 12:47:06 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] dt-bindings: riscv: Fix CPU schema errors
Date:   Tue, 24 Sep 2019 14:47:05 -0500
Message-Id: <20190924194705.32240-1-robh@kernel.org>
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
 .../devicetree/bindings/riscv/cpus.yaml       | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index c899111aa5e3..e7321688f7b9 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -12,15 +12,17 @@ maintainers:
 
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
@@ -51,8 +53,6 @@ properties:
       https://riscv.org/specifications/
 
   timebase-frequency:
-    type: integer
-    minimum: 1
     description:
       Specifies the clock frequency of the system timer in Hz.
       This value is common to all harts on a single system image.
@@ -86,9 +86,9 @@ examples:
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
@@ -104,6 +104,7 @@ examples:
         };
         cpu@1 {
                 clock-frequency = <0>;
+                timebase-frequency = <1000000>;
                 compatible = "sifive,rocket0", "riscv";
                 d-cache-block-size = <64>;
                 d-cache-sets = <64>;
-- 
2.20.1

