Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D1C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B260E25D4C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4TnIUkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfEaGjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:39:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42902 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfEaGjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:39:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id go2so3577509plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Zaxe7WowXS+tN6OY6tghQ3pLhHizFEDpbSLAZpdnRg=;
        b=N4TnIUkxiVbXVBUuLUyXc77DqUW0yRp/CDgiP4Z3u4EhJO7EcOHsLbxtQjS+sBGPYk
         P5m9ONZByW3aWJc1Pd4cPu4Yt4x+jaHMS1NOf/T5sH/XAm4BtSPCPu2B2mKUFbGtHUuP
         kCzDxGG8ixvoBg1pp5neHY4V3l3CIOmNL/sKSU8MsH8HmAgI1+KsCmNrrfhdFTl+4V9d
         MjinZVMfc+KC7xWv5zaXrdPI5kuBCANojdGvZOF9E2LqzGPwmp2mT9+OwgCgEFoaqSV1
         +I+PDnJcuTWe+vKFct/t7hqJmjkvY9vb3Af9xihu+v5G2nHP7GOUPd7mLK5l0J0DfveY
         ac/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Zaxe7WowXS+tN6OY6tghQ3pLhHizFEDpbSLAZpdnRg=;
        b=cMKeRjtio4hnxcmFDv9aZTFaPS0JBon1zyIJLowkAMHFTDazQ4qMyKGQlZJlR4lzU1
         RtaQUivebeOxVf2GVpVumS43Sbyx8s/Q1YA4bEmHwuiKjSxzP8er+3I/S/SVBgs4qKM5
         khC1Y9iVOD403AZ222H+nnLiddUp4DdIr3atkRRMNsbORDvoVKlmFFrpQs3BgbL5feM7
         IdyD5SJ8LxypCd+O951bJvcMkJ8+lZ4ziAp+rmnsduoqK1SfDL74JeMBLk+mGhF7xGdh
         7TXmiNZggewtn/TcaI7UI6rL5Qq8l6Il/nvullGo7lJvb66jfnaDpWIJMteD/tYiNLVr
         8VVQ==
X-Gm-Message-State: APjAAAVmLsuZAk6w7OyECp5RMZcssKzWOw+aw1rKFsbkjr+HU1iufukJ
        cqTbGjSA/GCeMkbmF/thmePX
X-Google-Smtp-Source: APXvYqxYW8y1jCKVZRirPI/B5luN9o425I5N7LJBpsnHfKuxOaZcxylkOO38lbFHQEddlwRGmLlemQ==
X-Received: by 2002:a17:902:2869:: with SMTP id e96mr7152214plb.203.1559284764503;
        Thu, 30 May 2019 23:39:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:72cb:ebf2:a51d:3877:feab:5634])
        by smtp.gmail.com with ESMTPSA id y12sm4644158pgp.63.2019.05.30.23.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:39:23 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        robh+dt@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/4] dt-bindings: arm: stm32: Convert STM32 SoC bindings to DT schema
Date:   Fri, 31 May 2019 12:08:47 +0530
Message-Id: <20190531063849.26142-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531063849.26142-1-manivannan.sadhasivam@linaro.org>
References: <20190531063849.26142-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit converts STM32 SoC bindings to DT schema using jsonschema.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/arm/stm32/stm32.yaml  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.yaml

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

