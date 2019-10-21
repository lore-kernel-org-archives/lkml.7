Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C09CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49A020700
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2UCcVa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfJUGoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:44:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34822 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJUGob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:44:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id c8so2340371pgb.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 23:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P585Wb4GdNSdANLbtZBTejDHy0hzt6pLG6Y0SHAZ9bU=;
        b=o2UCcVa98LWeVYND0PE/v8hZfB6qvv7otuszYHpwOafbshMElcl2fopVc68goHvkSU
         4osSwuadu1/VmaP0pLtxQKWtvAHZjAbwXkJelhOa3PgwYAHDSwuEH9Ggv1L6RW1qguu1
         FWyVBRvOZbpj9GlVvA40GiIUh8M0+AJVzBXrFHzz9zAU1HElW1NHOHZctsx/WFe/jdQI
         3MjIj195CY/+vzsde3JHST48qEYNuagUXETObyQdmtnR6EfpH5aEy8B0HvhyYmbPmVgS
         9Ppwb539dHA3fbb/ONOn8qyo0Asm7y4sNhwbi6Eotg5qRu5+H/iYKdxJ7OsyHlLKFRc1
         V/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P585Wb4GdNSdANLbtZBTejDHy0hzt6pLG6Y0SHAZ9bU=;
        b=l5rn8djppkjRes6ZbJ6FDuHkz9JzyMUYOlht2ZkR76gdoIacOD6wp306wPBv9bX/ao
         R1bLr1rzMxiZLjP+2UcnHBxad16DBQL1xev6mGT6Oduo/cZOboUhFJ6AF/FiucBaiBQ8
         bggMZYaOjr6JOWFrafigNcwuye0IHb4n6z1ynfrPJRISjQYPx6txW2qxM1b92Iq/ZnUb
         CdahzMrnkGVrprfLIeUPMa/EvcgiWBD/vJzkH3Mmz6Kj4sYaiRzsQu/brJ/je1zFoF6P
         eyUO6iw9d9KHl8BXCVbG3vrgyptgO68XRFikJGFZB/TsKUasAfzuPqgwQQEwxqhDzoVi
         BqQw==
X-Gm-Message-State: APjAAAU7lGKDsCqwcZw/cpnnmvYLSaPAEPhVABOxQNuSLmY7Ve4lSAwg
        jDBqvsgwD0sNNASuKoEMGZ5Khrl2Vg==
X-Google-Smtp-Source: APXvYqzT1XpwNz5+vlVRLju+CTTRBtcnDqb2C9zsWzuD9d6oV4fIlpTWzzYHcDfIgijryYQagwybBA==
X-Received: by 2002:a63:a02:: with SMTP id 2mr106677pgk.389.1571640269210;
        Sun, 20 Oct 2019 23:44:29 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:700f:8db6:2442:890f:ac37:8127])
        by smtp.gmail.com with ESMTPSA id d4sm13156624pjs.9.2019.10.20.23.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 23:44:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: gpio: Add devicetree binding for RDA Micro GPIO controller
Date:   Mon, 21 Oct 2019 12:14:10 +0530
Message-Id: <20191021064413.19840-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021064413.19840-1-manivannan.sadhasivam@linaro.org>
References: <20191021064413.19840-1-manivannan.sadhasivam@linaro.org>
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

