Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BD0C2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 05:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB95220828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 05:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9TRMYLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfL0Fcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 00:32:55 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52857 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfL0Fcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 00:32:53 -0500
Received: by mail-pj1-f65.google.com with SMTP id a6so4275644pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 21:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhIB3J48uWNcyBCDKSxDbyte5ZCMNiiAYIqCxmaTVF8=;
        b=D9TRMYLRO0qmQ6tzR+00FFi922Pf7WqH7oQS//ctW8vn+qc3XIO3rLm0lB7tNoyqCi
         krg1l9HwON48ELklqViMesQEmrckOA2OXC6n3ZEW/hR4AUVQCqbb37Vz9nKeSsPsleSB
         rkOggHA20LBrijMn+F4xV28LeXWK6aQ9VRXk8LQV/26RnVSHApcm5a1ea9M9d9okkqTJ
         cipzvRT4XPWhvzsuhQ5C7Rg/dasMWro3SODOBKj+hFhVPl4uXMGgQXw5H7YiPTo4fQ1Z
         pD7OmuBKX2TibrC5sY/zZZrQSPItOFbu6q1Aa3gYAr+693rAja2eroa9jdHxaQIzL2e9
         LCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhIB3J48uWNcyBCDKSxDbyte5ZCMNiiAYIqCxmaTVF8=;
        b=LLs/ZXPep8J5v2oGPsPr6OCLEXGONOaEF7LvCzZu41zSc4kNLj0fu9jfXvrxZwrO3R
         +mxI0m8hg8t+K2rWyYKfbXA+s/kPR7XyjF3hqnEsuYvLCjSbSSCWyNeT4TtwLK+p1yyf
         KapQJrJwN60jsMXyos2+HlxhpUFQeHtoCzvSztc2NkysLDsH7PBDspDWpt3c9nSVlW9w
         c8Wv/IJbjSnGxFzFiLqbUMdtfWaS9YnAQoqLH/lF8QsXlZh2TuZwk/9bsxKTntvUM8Uo
         tyirUcyBxjahORz9o1vQ/ntIT2IU67KjQYN4INeKbVWOqNK3+VbvVfkDLWPlpuXzlG3H
         cCMA==
X-Gm-Message-State: APjAAAVDxv5HVXNIooRaiHTt/a0yV7uG7dT50FvHeNCMqws3TUx/q9ab
        YgrmqEGbX2tk6MwVD1vepLTieMmar08=
X-Google-Smtp-Source: APXvYqxbwQ4iG7Pe49JtDgZwfxbh9CvzkbEyHE9tg12cbFs17Pur6LNjISOplN4QjyIyv7Q29RTndA==
X-Received: by 2002:a17:90b:1110:: with SMTP id gi16mr23080226pjb.110.1577424772331;
        Thu, 26 Dec 2019 21:32:52 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c22sm16789196pfo.50.2019.12.26.21.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 21:32:51 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v2 1/8] dt-bindings: remoteproc: Add Qualcomm PIL info binding
Date:   Thu, 26 Dec 2019 21:32:08 -0800
Message-Id: <20191227053215.423811-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191227053215.423811-1-bjorn.andersson@linaro.org>
References: <20191227053215.423811-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree binding for the Qualcomm periperal image loader
relocation info region found in the IMEM.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- New patch

 .../bindings/remoteproc/qcom,pil-info.yaml    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
new file mode 100644
index 000000000000..715945c683ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/remoteproc/qcom,pil-info.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm peripheral image loader relocation info binding
+
+description:
+  This document defines the binding for describing the Qualcomm peripheral
+  image loader relocation memory region, in IMEM, which is used for post mortem
+  debugging of remoteprocs.
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,pil-reloc-info
+
+  offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Offset in the register map for the memory region
+
+examples:
+  - |
+    imem@146bf000 {
+      compatible = "syscon", "simple-mfd";
+      reg = <0 0x146bf000 0 0x1000>;
+
+      pil-reloc {
+        compatible ="qcom,pil-reloc-info";
+        offset = <0x94c>;
+      };
+    };
-- 
2.24.0

