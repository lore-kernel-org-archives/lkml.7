Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D11C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716F12080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="naECvcLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbfFLHzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:55:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33021 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfFLHzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:55:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so15081plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ddmyf9yTEwlfHCzubut1+DzdJc/PcrZsJL5uTZc4yfE=;
        b=naECvcLA5b+ikhmyDk1YLXvhPLPCup9xIr0OEPfNZq/YqaOQKD1US6XtcnKca3PyrX
         bS4UZiBYiQmNmGgQ0PHd0Pc5zsJFZJte92oiMsouZ/6hZL5caUyz5JVsLCSMfcMwekA5
         W8GFIeuttEZGufRFlCDfOWDY6meAbjQfHmhtnqmKMl97G8fpOsIGpMdAr2Sx2or9umrH
         HGKJLY2DI7pkC2v9OSawkWU+Q8oq9CyE39MCKWWLqQEW17vncFA7PjIeEAyeF5vORafF
         +eTbVWyCkWrnw7G2YeduVn3IGEasK2w9lxkHgo8d5n/wtLwv0f3frqGhWVK86HxSmRZ0
         UgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ddmyf9yTEwlfHCzubut1+DzdJc/PcrZsJL5uTZc4yfE=;
        b=jMZa3CeGSaWwg1atYA86OGtHmgNkXgDkhAqtxgN23UnTD55MQa4DqKZa0fMaPwRLoh
         Z53V4bCUyJVrtCC4Sn51QanciDtPEB4toPhbp7Lpl9Q7khq6/PjEEM4XISowh4OT0nkj
         q+VqJv8VD0QDMOZ9mu/sfedE81WbOD4e17HOF4EpCGLIlAZ0IN1hp1tYr7IiQB9HH7Ji
         8eiwyimW0kBitLxfmL8mP0y+uF+0ycVm2BQeulp4gwkIDDtXrtMSIJzprwrOvLb721mq
         iHCXg7skxNNV+BrVcAxC3fL/+fd9L2BU4ZfUvM7mZUDDLo2wGQpB9+nwcRf09pil5cpT
         wacA==
X-Gm-Message-State: APjAAAWX6mSucnE+9WI0KUSqfsNJ7pU5fhUj1xQS4feEC8VoKdDcMvut
        ScLZ30Y1chnJ7jbr8nRBdUNQ
X-Google-Smtp-Source: APXvYqx7tmatLIV5lw0AoibaBm7aPYmU16s1G88Rxa+htlmSOMrfzpqbjFDCivcdIqj+XjXUxs362Q==
X-Received: by 2002:a17:902:b905:: with SMTP id bf5mr80896870plb.155.1560326114920;
        Wed, 12 Jun 2019 00:55:14 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:894:d456:15b5:9ca9:e3ec:c06a])
        by smtp.gmail.com with ESMTPSA id b15sm16846399pfi.141.2019.06.12.00.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 00:55:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        robh+dt@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 2/4] dt-bindings: arm: stm32: Convert STM32 SoC bindings to DT schema
Date:   Wed, 12 Jun 2019 13:24:49 +0530
Message-Id: <20190612075451.8643-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612075451.8643-1-manivannan.sadhasivam@linaro.org>
References: <20190612075451.8643-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit converts STM32 SoC bindings to DT schema using jsonschema.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/arm/stm32/stm32.txt   | 10 -------
 .../devicetree/bindings/arm/stm32/stm32.yaml  | 29 +++++++++++++++++++
 2 files changed, 29 insertions(+), 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.txt
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.yaml

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.txt b/Documentation/devicetree/bindings/arm/stm32/stm32.txt
deleted file mode 100644
index 6808ed9ddfd5..000000000000
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-STMicroelectronics STM32 Platforms Device Tree Bindings
-
-Each device tree must specify which STM32 SoC it uses,
-using one of the following compatible strings:
-
-  st,stm32f429
-  st,stm32f469
-  st,stm32f746
-  st,stm32h743
-  st,stm32mp157
diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
new file mode 100644
index 000000000000..f53dc0f2d7b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/stm32/stm32.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Platforms Device Tree Bindings
+
+maintainers:
+  - Alexandre Torgue <alexandre.torgue@st.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: st,stm32f429
+
+      - items:
+          - const: st,stm32f469
+
+      - items:
+          - const: st,stm32f746
+
+      - items:
+          - const: st,stm32h743
+
+      - items:
+          - const: st,stm32mp157
+...
-- 
2.17.1

