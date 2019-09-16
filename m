Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E32C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E2B2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDPJlRmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389410AbfIPPqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:46:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43502 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389380AbfIPPq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:46:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so52004pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vkOxPRaPbuf2u6O5EgSQilbhBs4SLuHStjl2F1LwBbA=;
        b=fDPJlRmmgIKRQu7QCJ3d1Kb5Fym9YQrGLxIh/dIN3cAXauC78bXRhNcXqn74YNPDuF
         XGwPyevw1I44l8G1G37uXqHnV6+psOCpszvbIq2UeEVsX23BNHJ9Fus9TKIhU76evWgz
         XP8gfq+FKoamM07ZDJqK9wWNFXBOJEcOCX1x0R7JFHB7y3F4T5/yhQ3mRGYwmAlMrdVi
         noZlQdjE4nwMbPTPLk2X87xZrzL76qnuLvJiAMyIu61ONdAHJOpEIyyqQWL+nN6MT1p3
         KgKxiWYVbZUQegIR/bddVubqiIRIK3d7wzXWi69Eq50qsquOpeE8sBlo29BHxQp/Jqhr
         nzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vkOxPRaPbuf2u6O5EgSQilbhBs4SLuHStjl2F1LwBbA=;
        b=j9+er6wrJadF2xE7HkzfkkQM7YosI+/RjJYDNCE9Y+gRLbUhAdyDLf++J1+jLkNscX
         tSCyIC9CS0qNaRs4islUCuzPodtjLn0DoTzexbZMPktpwYuhjxpvgDJKbd82kvZqBvTr
         TZKPb0SH1a9MPkgMEgax1AWW2GUwwk7wOFzawQ3p6VlGKDay1HbNL/4iCkyzlz1lz0Xr
         hPTt7dOyjXO3uOoaosnwAt+ZoCRgClUd/kbdKRijNooTBd9yOozihpzod+YJhU+mZhX/
         gV27kCiU5RwCb4DgDRrpq1rIDryZaPDEIzCYFKyn7hBbJCcuEw9NvS9bSJu1Xex/TGig
         TDDw==
X-Gm-Message-State: APjAAAVpr4G7xAMcrQMsmMevELo0+Qw6vQCm4I++hhCp/xwaLM1+P9HU
        xcoDfcMa0+JpOw5+nxUVzFm2
X-Google-Smtp-Source: APXvYqwG8QYB0xH19JOO6JX58tqc6H/Nw8aRpTCGSdpSDatwlC/PKSBX6+O66kwvZzS1XRP3joG+Ug==
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr487701plk.132.1568648787774;
        Mon, 16 Sep 2019 08:46:27 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:90b:91ce:94c2:ef93:5bd:cfe8])
        by smtp.gmail.com with ESMTPSA id s5sm36227670pfe.52.2019.09.16.08.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 08:46:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO controller binding
Date:   Mon, 16 Sep 2019 21:15:41 +0530
Message-Id: <20190916154546.24982-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree YAML binding for Actions Semi Owl SoC's SD/MMC/SDIO
controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/mmc/owl-mmc.yaml      | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
new file mode 100644
index 000000000000..12b40213426d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/owl-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl SoCs SD/MMC/SDIO controller
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+properties:
+  compatible:
+    const: actions,owl-mmc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: mmc
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - dmas
+  - dma-names
+
+examples:
+  - |
+    mmc0: mmc@e0330000 {
+        compatible = "actions,owl-mmc";
+        reg = <0x0 0xe0330000 0x0 0x4000>;
+        interrupts = <0 42 4>;
+        clocks = <&cmu 56>;
+        resets = <&cmu 23>;
+        dmas = <&dma 2>;
+        dma-names = "mmc";
+        bus-width = <4>;
+    };
+
+...
-- 
2.17.1

