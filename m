Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2966C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 11:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA7B2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sq/HNP5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfJMLkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 07:40:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45485 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfJMLky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 07:40:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so7230928pgj.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 04:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P585Wb4GdNSdANLbtZBTejDHy0hzt6pLG6Y0SHAZ9bU=;
        b=Sq/HNP5QsB5o9F9tBTKX7L0Z4FVLC9h6ADI4RXKZarXPk/p/8UNkZ86I+L11wvyGVV
         WW8lS+FpIJyO77xwLrV2x1AfGD6yZENx63WR/afl2Tyt4GVgcX6zmS/G67iyJNlikhf4
         s+R/CfgSkBDkP+rEZhiDL3NLFfwyKzzfmUMd6ekeh0dVZER5Ro6A9nJ/dVS9craL7b1M
         WDfkcbovDfQ+6LC95Cl4ViIvZxDEAHrsGpeZsmnj4t4etr4FLdjkcFuzOnaFw/LzkjzP
         U8wiHmqErCnk7duw39vPp9nejXK5KcCFcbZQIVf01CsY/HkWyagT7sBFbM0wjaosBS4y
         jJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P585Wb4GdNSdANLbtZBTejDHy0hzt6pLG6Y0SHAZ9bU=;
        b=YqhrONHmeefjVLk8KfpszhehY7VmI3Q0pQy0K8CyNh72ALPe2WrBc0U3zzexGX/5Fn
         6qmQ+SUsE+h1DA673KeIjBghT//XJzkfXnXRq+gqTW3LU+KjwCnobxCbqV5zQAy1kVmx
         oTPWhD7xdu2SS8ZOcuT4E27UajLnh3J5JPnXtD8wHH5wk9N1uTuqwV9LwaylShooCkq6
         iS+KlYetaaE86/Rb1NaJKeKgMd0ROGbL61FtujRRjdClDkPtQpdxdscv7STDhLBXeWBT
         CJp/l9LOxVOwIPzxh95VCEDFNdDlQqNCAsCdKehxa3xZh29eeHtqvG/sB2rzXPjbx4dX
         wR0g==
X-Gm-Message-State: APjAAAW8dX2beQVmZTi6HlkTj4SJ4YFVQbIOfoXV5dTH0+IUGJXyIvUe
        IjSPUmwNsMntS6XxUWBZBZb/
X-Google-Smtp-Source: APXvYqyMXRTeohc8dPr4H7XQBAdVm22v+b+6KvEJVppA+/URrgFtQ3sqxCvRnoWI0vBfzbygNAih/w==
X-Received: by 2002:a65:6408:: with SMTP id a8mr27308726pgv.357.1570966853733;
        Sun, 13 Oct 2019 04:40:53 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:8e:4f53:b957:652b:7622:f311])
        by smtp.gmail.com with ESMTPSA id g12sm23165736pfb.97.2019.10.13.04.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 04:40:53 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/4] dt-bindings: gpio: Add devicetree binding for RDA Micro GPIO controller
Date:   Sun, 13 Oct 2019 17:10:34 +0530
Message-Id: <20191013114037.9845-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013114037.9845-1-manivannan.sadhasivam@linaro.org>
References: <20191013114037.9845-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for RDA Micro GPIO controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/gpio/gpio-rda.yaml    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-rda.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-rda.yaml b/Documentation/devicetree/bindings/gpio/gpio-rda.yaml
new file mode 100644
index 000000000000..6ece555f074f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-rda.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-rda.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RDA Micro GPIO controller
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+properties:
+  compatible:
+    const: rda,8810pl-gpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  ngpios:
+    description:
+      Number of available gpios in a bank.
+    minimum: 1
+    maximum: 32
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+  - ngpios
+  - interrupt-controller
+  - "#interrupt-cells"
+  - interrupts
+
+additionalProperties: false
+
+...
-- 
2.17.1

