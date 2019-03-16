Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E30C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 00:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEE621871
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 00:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552694981;
	bh=pCPKEC8TA+kCdKJGHEcdvYfUDY+4ffjOeZDZ1UCV9zk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=St3mOYE9vojZF4F+AxCzKUxmdXWZO3gFgwhNxP2gksU1VdLpz2H4CR1S2ME8AM1Vh
	 nLsRz/xvz5egv807NmIwfmIWo2Dd8Wk94D0pkbfKocc03f/lAZ+2XJapkBaGvmpyQF
	 wrH4f8K6KFnNZ8vhQB1hi/ApVQAWzeJJC29Xgsg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCPAJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 20:09:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40312 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfCPAJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 20:09:38 -0400
Received: by mail-oi1-f196.google.com with SMTP id k11so8759967oic.7;
        Fri, 15 Mar 2019 17:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zTQ4+t+5aJnEJ4AvsSgpOwjprXX4tWJ4MsYTe171fmA=;
        b=f4mWQnnaFxgdYl1KPXVsnYOSdWbGaAI3XrrL3GziAK7di90tuCoMy7YhM8+hvwJEkk
         nxeuY2EtoWNLnU+wcVvXBofx7lwxXUC0NAhGaaJSr2m105nf5lie7QIyZz5bK+1xRYSa
         ZfXFtHdLfGw0xEx1ZoAPP1CdrWecijJlRo5l4pdBER8HZwvQSEazu8Qbk8dbKWR4b3D4
         ZRF2agK3u+85nmGLDaBwZvICEaS/Pr1L+2Mo4UonLT5iZ3K/vTIovi+mTILmoy+H7egx
         k6wkkaMn39sBrruBVTfrh+S5J0ks3QwBkvc8xSag0bzPwtFQIZYaM1xNm092wI6pA36j
         SxGQ==
X-Gm-Message-State: APjAAAVjW2AvN369Z/ndgPvAFfrCyC9jkhTkkXxgdfFr4PO/Efe11qnz
        pHKRlv8zYvoDkuWuC1c1soox3gM=
X-Google-Smtp-Source: APXvYqx97xZjagF68v1A3vc58SK4/0NEXyq+Sf3IT9FAkY+xVr4UA0c6TC9IVEqzMKLC+aNfK9XOWA==
X-Received: by 2002:aca:bb83:: with SMTP id l125mr3192520oif.23.1552694976803;
        Fri, 15 Mar 2019 17:09:36 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:1cd3:6836:59ce:35b2:628:2365])
        by smtp.googlemail.com with ESMTPSA id n2sm1221236otq.33.2019.03.15.17.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 17:09:35 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] dt-bindings: Require child nodes type to be 'object'
Date:   Fri, 15 Mar 2019 19:09:34 -0500
Message-Id: <20190316000934.30776-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A node is always an object (aka a dictionary), so make that explicit for
child node schemas.

A meta-schema update will enforce having 'type' specified.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml                  | 1 +
 .../devicetree/bindings/interrupt-controller/arm,gic.yaml        | 1 +
 Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 298c17b327c6..de30466a399d 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -67,6 +67,7 @@ properties:
 
 patternProperties:
   '^cpu@[0-9a-f]+$':
+    type: object
     properties:
       device_type:
         const: cpu
diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
index 758fbd7128e7..54838d4ea44c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
@@ -129,6 +129,7 @@ required:
 
 patternProperties:
   "^v2m@[0-9a-f]+$":
+    type: object
     description: |
       * GICv2m extension for MSI/MSI-x support (Optional)
 
diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
index c4ab59550fc2..b3f0fe96ff0d 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
@@ -59,6 +59,7 @@ properties:
 
 patternProperties:
   '^frame@[0-9a-z]*$':
+    type: object
     description: A timer node has up to 8 frame sub-nodes, each with the following properties.
     properties:
       frame-number:
-- 
2.19.1

