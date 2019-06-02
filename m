Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B16C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A979E2785B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="D1YagV2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfFBIBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 04:01:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40023 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfFBIBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 04:01:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so4356463wre.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 01:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19JHlpBM08NaaoHMsfAWuVL8kWvPtpcvA1ACdpeOftw=;
        b=D1YagV2wbPbvYWZG6MzOREWRKQGhvSfaNMR6MaRpuTG3+iRMDz8IOAruUW8V/2CsOV
         dWr/OLZLPLXOS1ERStSTQ19mZ53xlDQFlCJOUKK8RJwaNcJpCG+KarzUiCyGZMQXpEIu
         FrBKvFBcPrSGmn+reOALH9WfV1FPfwlGjHpjwpBngwFOMGCXiQBEKv5uQkawr3ERKQdC
         /qUujjIVeGUijZJ+vZVg5y/1BqUbnG5ZHp4iAUZp0E30WUPtCT7Hb3CzQFd7FOATQ1wJ
         4drT05q/92szPLAyQN6niHi0Skv8EP3tySB0tavCnhXN1cXgLJpaPi7XM/05hHIDrWaj
         +3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19JHlpBM08NaaoHMsfAWuVL8kWvPtpcvA1ACdpeOftw=;
        b=p/u5/aS5jGpqIkeYF3XKmAIVWsq4cjeQGdqZTilvocyTxj1IDMewis+Mc+Dg92yRmt
         KSAfbXNK9NVsjsGGipa9yfUjyFJlhMwA592PeSDFCHpSWafKApEIqdqkVAx8SSjs/oqu
         kk5vtS7kMF/gSGdU17ISe/zh1Hjr5+MvNJL03Q8y+wT006IN+x2gMb+iLt68VC62Bjd5
         6UpRRNrHTdAQvzE/FQtyeKyreAVdIoOfSuRkCoRiL7ufmKajpNF8SLMmTR9Vwng7jOc/
         4oZDEbHJ5Bc6tbMwYbpmTLNX2PuZjOyd1E77Vo6obMffjjKPwbC9McPSOHrNTLkUuK+A
         7U8g==
X-Gm-Message-State: APjAAAVrzbmlVxwpF6LIpWVUjl/gruGSYi+PFH28GyIddJPbLQHEjnpQ
        YENGkUhayM+wKwpI9BbHCD62fxB75OE=
X-Google-Smtp-Source: APXvYqxIdhhZ2JdruuDE0wVdfP3W+Q1cj5pKLGr8tiWIFLeuCifPv8CGC4QztbWIeJssrrKzi3Ds7A==
X-Received: by 2002:adf:c98f:: with SMTP id f15mr12552255wrh.279.1559462493346;
        Sun, 02 Jun 2019 01:01:33 -0700 (PDT)
Received: from viisi.fritz.box (217-76-161-89.static.highway.a1.net. [217.76.161.89])
        by smtp.gmail.com with ESMTPSA id y133sm4868583wmg.5.2019.06.02.01.01.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 01:01:32 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul@pwsan.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: riscv: sifive: add YAML documentation for the SiFive FU540
Date:   Sun,  2 Jun 2019 01:01:23 -0700
Message-Id: <20190602080126.31075-3-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602080126.31075-1-paul.walmsley@sifive.com>
References: <20190602080126.31075-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML DT binding documentation for the SiFive FU540 SoC.  This
SoC is documented at:

    https://static.dev.sifive.com/FU540-C000-v1.0.pdf

Passes dt-doc-validate, as of yaml-bindings commit 4c79d42e9216.

This second version incorporates review feedback from Rob Herring
<robh@kernel.org>.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 .../devicetree/bindings/riscv/sifive.yaml     | 25 +++++++++++++++++++
 MAINTAINERS                                   |  9 +++++++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sifive.yaml b/Documentation/devicetree/bindings/riscv/sifive.yaml
new file mode 100644
index 000000000000..ce7ca191789e
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sifive.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive SoC-based boards
+
+maintainers:
+  - Paul Walmsley <paul.walmsley@sifive.com>
+  - Palmer Dabbelt <palmer@sifive.com>
+
+description:
+  SiFive SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - sifive,freedom-unleashed-a00
+      - const: sifive,fu540-c000
+      - const: sifive,fu540
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4ce575..8a64051cf5fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14322,6 +14322,15 @@ S:	Supported
 K:	sifive
 N:	sifive
 
+SIFIVE FU540 SYSTEM-ON-CHIP
+M:	Paul Walmsley <paul.walmsley@sifive.com>
+M:	Palmer Dabbelt <palmer@sifive.com>
+L:	linux-riscv@lists.infradead.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pjw/sifive.git
+S:	Supported
+K:	fu540
+N:	fu540
+
 SILEAD TOUCHSCREEN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-input@vger.kernel.org
-- 
2.20.1

