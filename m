Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90642C3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EF72070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="aHKkuUpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbfHZTBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:01:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41595 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387638AbfHZTBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:01:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id g17so14924086qkk.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=akAei/7tOU3d191zec9Xi+sZBY39XbiNq2fhlUSUGK8=;
        b=aHKkuUpclP5IMt7wAHzBt9Sc8X4Or7WoFatBAPGA1CH1KYaZWAevUa/XBG1UeD+BiE
         CuxaGUZR5K1uB/VS2dvay75flTkQXz6bh07bAv/u9Qscje6ZQNLAY0a3RjWlN485tVZy
         b4bH4m2ELjpF70da/5WIqrJJVF/TA9aaj1ZKQWRXQs4RwJ3NvZlrgGPsgn1DVPqyNY1Y
         lP7gjWsw5oQgquGCVVGrZTq5l4DaQj8LiJW1jsUNPeMEV0Z4bp6/kkU6UoG9xFgEFmcT
         s5mW9o4SuGsusoVxrGMX6dZs89KvC4+2cyyABuNj6g/3YvkJyeufYRLhWz+86jrOXIyL
         7iLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akAei/7tOU3d191zec9Xi+sZBY39XbiNq2fhlUSUGK8=;
        b=qYKziAdntFWYsiCC/qoB5cwT89s14VBrFEecI31I2IMbVkAYbF2dDfTotOumYm/5e/
         BgvZg5wNFNeXh0Gfe603y7Wsc1j+TYu9orFc9MM6qF/gTkUrZJ3dr5jV+vS/3eJZBKQF
         mQClWMslVYJUZy7cgvCVJrVLmYCt/1pY6cgrcdS8w1awbpI5Frvt6ewE4+fUhSNTP5K5
         LRitV2f61/4X1l0DwUyMKixIrAIoMdHkYgDAKUvLprTwzBlqXVE9MPDissg81pNDyd2i
         GL9SkoHd5mueGhwt0ZASgpYMMTiS0KpxOTywrR06Uneezy9a3zhT3mid4fNLxLmXwAxb
         V5Ag==
X-Gm-Message-State: APjAAAUjSwwwjKvD3ccx6+XZ68NxDg7d84yTKUys3z8YZQceRJva6hcw
        0dmt6h2y/l8YE7GvMjudVswqcA==
X-Google-Smtp-Source: APXvYqzJXd38pO3iRXZK6ansWFKaAVK7wUwsU2qQ/q6b8pl+RREguA3Jc5PkLVuOG86V0Rto3oaz1Q==
X-Received: by 2002:a37:c206:: with SMTP id i6mr17410846qkm.384.1566846066175;
        Mon, 26 Aug 2019 12:01:06 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o45sm8614377qta.65.2019.08.26.12.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 12:01:05 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com
Subject: [PATCH v1 6/6] dt-bindings: interrupt-controller: add optional memory-region
Date:   Mon, 26 Aug 2019 15:00:56 -0400
Message-Id: <20190826190056.27854-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190826190056.27854-1-pasha.tatashin@soleen.com>
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow pre-reserve memory in device tree that can be used in interrupt
controller tabes. This memory is required when kexec functionality is needed
with GICv3 controler and device trees.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 .../bindings/interrupt-controller/arm,gic-v3.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index c34df35a25fc..7640aaa97302 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -102,6 +102,13 @@ properties:
       - $ref: /schemas/types.yaml#/definitions/uint32
       - maximum: 4096   # Should be enough?
 
+  memory-region:
+    description:
+      Memory used to allocate property and pending tables.
+      Required if kexec functionality is needed.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint64
+
   msi-controller:
     description:
       Only present if the Message Based Interrupt functionnality is
-- 
2.23.0

