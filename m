Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D6FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E4320873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VW6x9cF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfEBKfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:35:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34092 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEBKfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:35:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so916498pfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 03:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y8299RwRcUp2oS13ZRZK7TA/HszNxbKnoI7RGJSnP08=;
        b=VW6x9cF7vcuTuR6WhIa79BZi8nH6IZ0iIoc/Yt98Tp5SavOySYwFfLmiTSz3F8atNk
         Bx4GfARB5YL+R9Vz4bqE4AyZDgYmzEqcnlUhpQZt0Amuggr7SWzBQ0f8/WxPFQA89DsJ
         0RcBTPwyj+qPPKvFMViolH2KdmkZUb/FcScCWtQpJRa9oneM7UK/Pjj7irmmr2+NErPH
         Tyyw8NY8IjSECx2rbjv0Tlai46ION1VZydHHiVG8Wli7agAI3cmf+9S25eGj/RqnzGaL
         BzvA6z1VktO/XuulHBXMsmfGTV8fWhkkMZIBVM1FByMxL9Al4TdwGwJtE6bCWQakW3M1
         ZOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y8299RwRcUp2oS13ZRZK7TA/HszNxbKnoI7RGJSnP08=;
        b=buVytX5n3kaHX2lqOGkdSSNi7pr76PdzF7MuCQJHnZDN/hZeLrt/dFtUvLRMYfj2Or
         VGaqcjdfl8Cayp9HvAX3XnGqkuOb5YiSJko3sidFZcjY5tI1fuR3N3EEGifvyb79mAiy
         mUsQgq1e2Cq6kEI5JpfH2OlRixjnHUtS1FnxyNk2jNW2XEzVyBQG16svo1vqxpjJWHOf
         woIXHCZguJiwi7rw1VX0MtmYcF3hx5/ETW6UZrC0FwX0RkBoY23d0NLCqAINGKWstuHd
         rmt/M9qS4FE7eYOnYnKg23UMYCawdSS1L5OxuJe96f7/uBgGWH04addxP8uz7DLKD+Li
         rDvg==
X-Gm-Message-State: APjAAAX8MyonHKPY18q46DBEugUEmtatZvmKBXQc6BGsbNS1kL34Gj8a
        29gy13X7vtbOL/amRmkwP0++xw==
X-Google-Smtp-Source: APXvYqzQU1/MMFsvo7NWB+bEk3YJ2XCTwbT4XUtAR/cCVn6WJzMQQXtcEBR1FnqzrGAkeeuesPlU6A==
X-Received: by 2002:aa7:8212:: with SMTP id k18mr3355979pfi.50.1556793317446;
        Thu, 02 May 2019 03:35:17 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id h187sm69141133pfc.52.2019.05.02.03.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 May 2019 03:35:16 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        palmer@sifive.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, mark.rutland@arm.com, robh+dt@kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2 1/2] RISC-V: Add DT documentation for SiFive L2 Cache Controller
Date:   Thu,  2 May 2019 16:04:52 +0530
Message-Id: <1556793293-21019-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556793293-21019-1-git-send-email-yash.shah@sifive.com>
References: <1556793293-21019-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for SiFive FU540 L2 cache controller driver

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
new file mode 100644
index 0000000..73d8f19
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
@@ -0,0 +1,51 @@
+SiFive L2 Cache Controller
+--------------------------
+The SiFive Level 2 Cache Controller is used to provide access to fast copies
+of memory for masters in a Core Complex. The Level 2 Cache Controller also
+acts as directory-based coherency manager.
+All the properties in ePAPR/DeviceTree specification applies for this platform
+
+Required Properties:
+--------------------
+- compatible: Should be "sifive,fu540-c000-ccache" and "cache"
+
+- cache-block-size: Specifies the block size in bytes of the cache.
+  Should be 64
+
+- cache-level: Should be set to 2 for a level 2 cache
+
+- cache-sets: Specifies the number of associativity sets of the cache.
+  Should be 1024
+
+- cache-size: Specifies the size in bytes of the cache. Should be 2097152
+
+- cache-unified: Specifies the cache is a unified cache
+
+- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals)
+
+- reg: Physical base address and size of L2 cache controller registers map
+
+Optional Properties:
+--------------------
+- next-level-cache: phandle to the next level cache if present.
+
+- memory-region: reference to the reserved-memory for the L2 Loosely Integrated
+  Memory region. The reserved memory node should be defined as per the bindings
+  in reserved-memory.txt
+
+
+Example:
+
+	cache-controller@2010000 {
+		compatible = "sifive,fu540-c000-ccache", "cache";
+		cache-block-size = <64>;
+		cache-level = <2>;
+		cache-sets = <1024>;
+		cache-size = <2097152>;
+		cache-unified;
+		interrupt-parent = <&plic0>;
+		interrupts = <1 2 3>;
+		reg = <0x0 0x2010000 0x0 0x1000>;
+		next-level-cache = <&L25 &L40 &L36>;
+		memory-region = <&l2_lim>;
+	};
-- 
1.9.1

