Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBF5C04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51DE21726
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558106852;
	bh=oFjpq0koawU5RQDeEyRTrugC+G2JKJVD7batPR9FgRM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zvjYWPA6XhKV5tjZsfqjn/1ZtIV8ov/rUY7hd3TrciPVFnMIw7jebwWtQRf7R6KoF
	 mtfhN7+1QJWMu+Wiwdfhx9WCMZe72S/MTh7KYzVblNb8ic6dzkIXMCxHf1Q87Wq4QE
	 SAc5cBUt3wA+sFC7zQAo00XQT7nkCElm0KHKvQA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfEQP1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:27:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47007 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbfEQP12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:27:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id j49so7029239otc.13;
        Fri, 17 May 2019 08:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXjo2WzK/l3uzu16XWx7AJkZlf1BIoz+FJUDL45vLwg=;
        b=IuZKKZaNgBzSw6omT9FJ3zwT7N04zjcywCHo6ifBYUZcTERMNFiF7WIQczfUyHNSY7
         CcIdIOtihMZAZBJWRqa8vVPkyhPoov2T4aFBSIyEVFuMCcx9/TvRZ0gKMBCCItuGGti7
         bV6dccW62uiMP6JlzrkQJuOYQYpxsZlM0xZFvL0gRMlIYL7etqFlKuJrkoElMRx2PyDj
         TT+zbIh5p+tYCwfmQPnzdGySAnQeQk80huXZxKLY3AqpCVlwRKcLNtFyrI1oo14OXMZ3
         0kAl8fS+AXEK5uVHKAtjHuXtJQKIqIyDXRuLaUuVTEfjUpB7lYfnjGoRv0qlsXrgAos8
         2MlA==
X-Gm-Message-State: APjAAAUHa4eAj1mKA7OJEj2ZwPesMlKpi+5QygiUK90njs3bly879/CU
        70iuaE1HE5X9BpUQu83peg==
X-Google-Smtp-Source: APXvYqzMjh1uN1x7bYZO0lOLW1zGnpUtEQcPyOFHVuAQp9QvmrFCWuPkkhC8UMdrSn6icT5FC87sEw==
X-Received: by 2002:a9d:6856:: with SMTP id c22mr11882936oto.24.1558106845465;
        Fri, 17 May 2019 08:27:25 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id i13sm2186859otl.27.2019.05.17.08.27.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 08:27:24 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: arm: amlogic: Move 'amlogic,meson-gx-ao-secure' binding to its own file
Date:   Fri, 17 May 2019 10:27:22 -0500
Message-Id: <20190517152723.28518-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is best practice to have 1 binding per file, so board level bindings
should be separate for various misc SoC bindings.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
It seems this one fell thru the cracks and didn't get applied.

 .../devicetree/bindings/arm/amlogic.txt       | 29 -------------------
 .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 ++++++++++++++++++
 2 files changed, 28 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 061f7b98a07f..5f650248b18e 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -111,32 +111,3 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amlogic,u200" (Meson g12a s905d2)
   - "amediatech,x96-max" (Meson g12a s905x2)
   - "seirobotics,sei510" (Meson g12a s905x2)
-
-Amlogic Meson Firmware registers Interface
-------------------------------------------
-
-The Meson SoCs have a register bank with status and data shared with the
-secure firmware.
-
-Required properties:
- - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-ao-secure", "syscon"
-
-Properties should indentify components of this register interface :
-
-Meson GX SoC Information
-------------------------
-A firmware register encodes the SoC type, package and revision information on
-the Meson GX SoCs.
-If present, the following property should be added :
-
-Optional properties:
-  - amlogic,has-chip-id: If present, the interface gives the current SoC version.
-
-Example
--------
-
-ao-secure@140 {
-	compatible = "amlogic,meson-gx-ao-secure", "syscon";
-	reg = <0x0 0x140 0x0 0x140>;
-	amlogic,has-chip-id;
-};
diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
new file mode 100644
index 000000000000..c67d9f48fb91
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
@@ -0,0 +1,28 @@
+Amlogic Meson Firmware registers Interface
+------------------------------------------
+
+The Meson SoCs have a register bank with status and data shared with the
+secure firmware.
+
+Required properties:
+ - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-ao-secure", "syscon"
+
+Properties should indentify components of this register interface :
+
+Meson GX SoC Information
+------------------------
+A firmware register encodes the SoC type, package and revision information on
+the Meson GX SoCs.
+If present, the following property should be added :
+
+Optional properties:
+  - amlogic,has-chip-id: If present, the interface gives the current SoC version.
+
+Example
+-------
+
+ao-secure@140 {
+	compatible = "amlogic,meson-gx-ao-secure", "syscon";
+	reg = <0x0 0x140 0x0 0x140>;
+	amlogic,has-chip-id;
+};
-- 
2.20.1

