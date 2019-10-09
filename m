Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1CEECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEB2206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570664812;
	bh=LEW3i9tlHR9BuIsSdrCFscA3vwMWH2GPnyi04rwzJio=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KgPKX4z85OAFx++w7zWTuYqeh/Msm8QOVRZtCGks8KUdfCpH5v0Hx2qRxCAM2JaaJ
	 ex6dNP4ePxzHFBHUQzokvYFZvuGh0NtbTy8WCbXZ2YjIn1wA2/pN1MwDL4ZJiKnhUt
	 BI/qQgXs3PNkoz5uz8WrBgBaU2aU4OWdq4WPd9MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbfJIXqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:46:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41473 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbfJIXqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:46:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id g13so3272306otp.8;
        Wed, 09 Oct 2019 16:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+uVx1qcCdR79o4ofc5CjZQotxG1TWVUh9rieCuJiEc=;
        b=MyTdxP8T69PGLNcz4kuZlHzZrSfGeRAPLH9SMKDdwXaIiFuMVEPbdxtqnVrq5Ahonl
         r3ebusLU/X+5S1U5Zz74SaiXtMSHy3vnlqPQcofc5eLAZuap4Z8v2QUqiIfhl0LCgaZ2
         o1UOVpfniJc3F+zLAxcfQH8087daeb8IRmCMZazrFRRPYdwAEpA4Da8Xw5FmTCLsFcgT
         QREN6r1BFqHDFMnOjaDXb+JIyvvbOa3jE7IBlKB88xBsF6qaHJpVqKWdSw1gg+jSK20L
         XtJjavI5/pIHL88uCx6s/yshKG/vcFXhoXL7340l84W1aMSPNpJZS9UPTl7vs+q6m3ho
         7kzQ==
X-Gm-Message-State: APjAAAU2jze7LGAiI9BBq1+6Xee+E4MTbC5Mpx9ewsnkq6Yct+J2AAy/
        JEY8DxrUqipbFJSnJuIXIg==
X-Google-Smtp-Source: APXvYqz/n9SkOtrSQgnGTu0lp4Ci0m5qmetwpMSOC3+wUQp2ustrBx5tiex0ZXLUntj3+cQeHQ4Fqg==
X-Received: by 2002:a9d:4902:: with SMTP id e2mr5132554otf.263.1570664810148;
        Wed, 09 Oct 2019 16:46:50 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t22sm1205672otc.9.2019.10.09.16.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 16:46:49 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2] dt-bindings: riscv: Fix CPU schema errors
Date:   Wed,  9 Oct 2019 18:46:48 -0500
Message-Id: <20191009234648.2271-1-robh@kernel.org>
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

The DT spec allows for 'timebase-frequency' to be in 'cpu' or 'cpus' node
and RiscV is doing nothing special with it, so just drop the definition
here and don't make it required.

Fixes: 4fd669a8c487 ("dt-bindings: riscv: convert cpu binding to json-schema")
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/riscv/cpus.yaml       | 28 ++++++++-----------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index b261a3015f84..925b531767bf 100644
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
@@ -66,13 +68,6 @@ properties:
       insensitive, letters in the riscv,isa string must be all
       lowercase to simplify parsing.
 
-  timebase-frequency:
-    type: integer
-    minimum: 1
-    description:
-      Specifies the clock frequency of the system timer in Hz.
-      This value is common to all harts on a single system image.
-
   interrupt-controller:
     type: object
     description: Describes the CPU's local interrupt controller
@@ -93,7 +88,6 @@ properties:
 
 required:
   - riscv,isa
-  - timebase-frequency
   - interrupt-controller
 
 examples:
-- 
2.20.1

