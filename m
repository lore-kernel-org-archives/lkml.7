Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4525FC2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D001214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwRLioQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLWJal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 04:30:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39824 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfLWJaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 04:30:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id q10so8888073pfs.6;
        Mon, 23 Dec 2019 01:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0PAkFn9zoMouugxeRSrbgzuXq1FaZx49kjzBfMutLw=;
        b=dwRLioQR6RiTr9TfH4DsBbrWip7Wa+pltvgf/1CcXEzUt4rWqpdW32yLqiXOSbiEhW
         9fp3ykVdQSravFC/+NYwZ8OMilUe51z/eRyJ9A4zs0urv6CDkr/NcM5qogJTiPTgTMc9
         KjO2WMkUVjKh5zki868f2Wd2rzpiFLCjMtGEwreY/O5OwJfiQY9s/+YCGnX89zurB43w
         DnaVpYtoVSdXcqnQ4e+z/idnm+rh2k5oiKTTpXd5rJkVAn16Tq7d3FLlbawVDsBXf0tH
         mOYIkpNtw1n4k3qvWZ5WyHY8OatVRkxthhf+H4Cv8rgZ/Q4K+z8TKyxV1dRsGku/7/nt
         CBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0PAkFn9zoMouugxeRSrbgzuXq1FaZx49kjzBfMutLw=;
        b=A2xArUtDSUuC0XLPDvE64oC8lsEQRAppyACAuiJNCerwWVvywciMIWzIJelBVnKu8Q
         WIEwV2F4LGMTNALuWT6RUAvCgZESlBhd01YnnhSUI7yRVslXLLl4dRZGzWIHj9O+mqf+
         FwDEdFG3S1hss6zm6fY3Nntqn7rPHFjmITQ3ppMvZyAj19yUajL8K9GLJFyqC5J8VLAi
         ix8QqNwUQUXkMK5Dp1sIG5U2AEDhPEAcc/El3g5nGkAR6xOKcc59758k3wO0UlzHlgSL
         DpulaKApPVTGz+Pwn7x/oYV+PSLZwjKcXlLVJH2XUVNd3tvgiuLpkprIi2t9XSSI+lte
         tJFg==
X-Gm-Message-State: APjAAAUmu8PXN8nxg4+h3GduAEF27QprZFxzTH3Xb5mIjPmMHF2QkNAf
        62T2ER9zsZE9v4NwWlz4X/4=
X-Google-Smtp-Source: APXvYqza5MD792QT+nyRwcyGu7WT8kB0fIjU+ImLq/F0W/YGH+avcbTNUD3sHcm/TzClUblK7TUxQA==
X-Received: by 2002:a63:f202:: with SMTP id v2mr29843658pgh.420.1577093438868;
        Mon, 23 Dec 2019 01:30:38 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id i127sm24625970pfc.55.2019.12.23.01.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:30:38 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v5 1/3] dt-bindings: arm: sprd: add global registers bindings
Date:   Mon, 23 Dec 2019 17:29:46 +0800
Message-Id: <20191223092948.24824-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191223092948.24824-1-zhang.lyra@gmail.com>
References: <20191223092948.24824-1-zhang.lyra@gmail.com>
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

