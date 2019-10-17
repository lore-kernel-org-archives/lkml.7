Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29812FA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D6C20869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="m7MNOAAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407499AbfJQDLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 23:11:01 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48892 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404445AbfJQDLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 23:11:00 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2DC4C891AB;
        Thu, 17 Oct 2019 16:10:58 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571281858;
        bh=RSNYgN3xa7Wn9y39HNKCBoTixs9Vyw+6lp44Vh1/gxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=m7MNOAARevCrchHDWRurTIPyJPZa82fuDTngXhggE7Lis79i0qwy1kVwTRTYFpOaB
         kMQgjLKd37/93Ys2iI5BmZ7SpmI20DYGD2W55nFh9dGhK1z1CsZQD+VFbsSm30JLNO
         hYQj8TRt7dFefXQEQxSxhx893/dmQCkpLFQWgME+Bf5GmO91SAZ1JIP90GYQjbEXqC
         64CQzEgFLH3c6jdf4lsXH7oDGEB801k1CMKWh/DZdw2k8wW07CRRXNPkk6mvlo4x6Q
         mIn7d6XK1fjlMhvyZRlhIdEAOk5rHwhEO0RbGLiK4ToWU57vuS6OKBkEcIBoQJsssT
         yWdOGw7qSHkOQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5da7dbc20001>; Thu, 17 Oct 2019 16:10:58 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 1BC8D13EEB6;
        Thu, 17 Oct 2019 16:11:02 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 08B05280059; Thu, 17 Oct 2019 16:10:58 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] dt-bindings: gpio: brcm: Add bindings for xgs-iproc
Date:   Thu, 17 Oct 2019 16:10:50 +1300
Message-Id: <20191017031051.20366-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017031051.20366-1-chris.packham@alliedtelesis.co.nz>
References: <20191017031051.20366-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This GPIO controller is present on a number of Broadcom switch ASICs
with integrated SoCs. It is similar to the nsp-gpio and iproc-gpio
blocks but different enough to require a separate driver.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Document as DT schema
    - Include ngpios, #gpio-cells and gpio-controller properties

 .../bindings/gpio/brcm,xgs-iproc.yaml         | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/brcm,xgs-iproc=
.yaml

diff --git a/Documentation/devicetree/bindings/gpio/brcm,xgs-iproc.yaml b=
/Documentation/devicetree/bindings/gpio/brcm,xgs-iproc.yaml
new file mode 100644
index 000000000000..71998551209e
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/brcm,xgs-iproc.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/brcm,xgs-iproc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom XGS iProc GPIO controller
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+description: |
+  This controller is the Chip Common A GPIO present on a number of Broad=
com
+  switch ASICs with integrated SoCs.
+
+properties:
+  compatible:
+    enum:
+      - brcm,iproc-gpio-cca
+
+  reg:
+    minItems: 2
+    maxItems: 2
+    description:
+      The first region defines the base I/O address containing
+      the GPIO controller registers. The second region defines
+      the I/O address containing the Chip Common A interrupt
+      registers.
+
+  gpio-controller: true
+
+  '#gpio-cells':
+      const: 2
+
+  ngpios:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 32
+
+  interrupt-controller:
+    type: boolean
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#gpio-cells"
+  - gpio-controller
+
+allOf:
+ - if:
+     properties:
+       interrupt-controller:
+         contains:
+           const: true
+   then:
+     required:
+       - interrupts
+       - '#interrupt-cells'
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    gpio@18000060 {
+        compatible =3D "brcm,iproc-gpio-cca";
+        #gpio-cells =3D <2>;
+        reg =3D <0x18000060 0x50>,
+              <0x18000000 0x50>;
+        ngpios =3D <12>;
+        gpio-controller;
+        interrupt-controller;
+        #interrupt-cells =3D <2>;
+        interrupts =3D <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+
+...
--=20
2.23.0

