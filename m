Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F180C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143FD20726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt6S7+mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfLILpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:45:05 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37858 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfLILpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:45:04 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep17so5795846pjb.4;
        Mon, 09 Dec 2019 03:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0PAkFn9zoMouugxeRSrbgzuXq1FaZx49kjzBfMutLw=;
        b=Yt6S7+mimnrv0qpJwjBMxmMOWE49TxI1xq5JJlBSzMOglWUgg6h0cUnH6veuPsDzJx
         XeOyCKBcj0ja8Viz8cRZb2bX2vGDrE68Ao1gX2OFRzjOiRGV5AC7JfIGkQis4d2MV3CI
         8G+TMqjSkQYYl3uJTOXyHIimToBDLEwvUNXofpSOIknKmfUjw4LMXLXqZbk+95JNGK4b
         V55Mkwikiy58NNSVkDtnf3aurksEg9U5T8kbFuY2gzNKHRJALMUebaDQnJHjNoeVb2PF
         Q/RMVIjbT1kx7rXbLnuO/zPxge8aGeVRi8Vg5WVdGvxlQDmDMXLHBcSQiiW4xIDCAyI4
         Gd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0PAkFn9zoMouugxeRSrbgzuXq1FaZx49kjzBfMutLw=;
        b=VZSJ2iIutNOwiXZpgMtcc+QsDBbFSFSvCSPw/F9zLwvYSjoY12KgDJmUvUfVoVaKXQ
         ogRhagqnDuPVqK49MJsftQ34hpKdBrmU0H4ub9GgIILb44yDgKE3E6kis7fwaxuO36fH
         TjeQ1sW42DJtixK6UnjpSfK4KHuuNYGAz5rKGVVySOm29l683YUaFTl/Iani0w/DCwc3
         nSSNbUkpyP+afVM4scnrk5CUByuUuu4RzBucbRwmiWDfBuYHRTbuK8pfMQo1Ky5D2FLz
         7AjGj3KRCELgGSC+qzsKLBzTbQLnXEXi20bn1hiwGL4td3uyoK7kIC0UYcfyTJEHP4Vc
         sU7A==
X-Gm-Message-State: APjAAAVs7SnLfYtZO2JeOkwH6wfayxhqc+ffpvhN/5XpSOgUJZvbaAPg
        oYc0LMt39nvzkvKvaWW7DFI=
X-Google-Smtp-Source: APXvYqycQYwAYmqn/ClsH/V275ospaIry1KVDthbiCvKSCRo1bbCoVnhBDtZtnMM9evtC3TvnKs8mw==
X-Received: by 2002:a17:90a:3243:: with SMTP id k61mr30237050pjb.55.1575891903761;
        Mon, 09 Dec 2019 03:45:03 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c8sm27805289pfj.106.2019.12.09.03.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 03:45:03 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v4 1/3] dt-bindings: arm: sprd: add global registers bindings
Date:   Mon,  9 Dec 2019 19:44:02 +0800
Message-Id: <20191209114404.22483-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191209114404.22483-1-zhang.lyra@gmail.com>
References: <20191209114404.22483-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The global registers would be used by different peripheral devices which
we can see them as syscon clients which can use regmap interface that
syscon driver provides.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../bindings/arm/sprd/global-regs.yaml        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sprd/global-regs.yaml

diff --git a/Documentation/devicetree/bindings/arm/sprd/global-regs.yaml b/Documentation/devicetree/bindings/arm/sprd/global-regs.yaml
new file mode 100644
index 000000000000..012207166116
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sprd/global-regs.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2019 Unisoc Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/sprd/global-regs.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Unisoc Global Registers
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - sprd,sc9860-glbregs
+              - sprd,sc9863a-glbregs
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+examples:
+  - |
+    apb_regs: syscon@402e0000 {
+      compatible = "sprd,sc9863a-glbregs", "syscon";
+      reg = <0x402e0000 0x4000>;
+    };
+
+...
-- 
2.20.1

