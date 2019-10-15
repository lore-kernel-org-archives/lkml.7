Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01E7ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B8C20650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpDLdyz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfJORar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:30:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37806 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbfJORaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:30:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so12554541pgi.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P585Wb4GdNSdANLbtZBTejDHy0hzt6pLG6Y0SHAZ9bU=;
        b=lpDLdyz6gnJaWTKjbVWSVfNBu6KMNSTe2jzE7hfZCBE/yhgGo3bcfsuo4VE0UxQoWT
         H75k5eMOlfLtO8A5ocoGCBC7WwIrGu5NhtVp7sU2OSO24qCzmwJDv9mjbf2XfFIjl7AP
         o0S59xqf2//C6qUa9OfgSXewKWN/9kN7P7YL82zLiYeepojPRIAT70xwjfgaY7nVRaaq
         MD5K5/WkIIMWT6vpdY5VfZPa9lGszMYcM9U188QDbEmSIifvhXo6ozxs2zk6P00wavPd
         x2Mtub+9nA8TRjOg44JFhRheRbLuOWlMlpV1hlNq3nE6bqeO8B0DoDLFYO+gjSMX4vyS
         W9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P585Wb4GdNSdANLbtZBTejDHy0hzt6pLG6Y0SHAZ9bU=;
        b=XmID0SyIwjgSw8dx9cyY+6EN71MH51Jg6hUDWPBaLUlL4ziMQ/CShktcOfeA99eVYq
         Q/kzAvRGD9ostBZzCHTBGyo3Y/wQihbV0UEJhPbxBIqxWuyESWk1qdmXaHlMTasa2fZM
         XmHQwLeU6DQJF6r6xwpWbQUGAC050AYAj7+xGutbZOJCUrLGJ9gI3g2zuyRbl806Ff+I
         5KHseqZ9kAwUY8Vq9c29yQa0DG+QxDaZ0E7l3XKN7GQ263ICisXazM1/Vpo68poYPheG
         JRNwdsJu5CCPDYgNvy5ye2K/xWZ33L6EJzflm7OCMa+DXZ2swqXHfzocFck8XSktDFwh
         hJcQ==
X-Gm-Message-State: APjAAAWO3AUSOWDH3hhrxOJwhjWUzx7eCOuk2pMmppji6opuAKu5OGpB
        qE5fv7YiRQSWIIb12wX8WbpI
X-Google-Smtp-Source: APXvYqwbCLpdmWKTZmSl1oTdfCb2flyajMLs6QMZwE38ftfHAg1sNcGjH12xadW0vkB52MaxPKYLhA==
X-Received: by 2002:aa7:8249:: with SMTP id e9mr38929777pfn.46.1571160645036;
        Tue, 15 Oct 2019 10:30:45 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6003:7cb8:25e8:2c45:fab2:b0c7])
        by smtp.gmail.com with ESMTPSA id w11sm28033563pfd.116.2019.10.15.10.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:30:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/4] dt-bindings: gpio: Add devicetree binding for RDA Micro GPIO controller
Date:   Tue, 15 Oct 2019 23:00:23 +0530
Message-Id: <20191015173026.9962-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015173026.9962-1-manivannan.sadhasivam@linaro.org>
References: <20191015173026.9962-1-manivannan.sadhasivam@linaro.org>
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

