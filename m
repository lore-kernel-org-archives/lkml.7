Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0517C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C139A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lYP8wvoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfEFKtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:49:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37114 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfEFKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:49:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so6274500pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y8299RwRcUp2oS13ZRZK7TA/HszNxbKnoI7RGJSnP08=;
        b=lYP8wvoE19ZYmyOYZuDXJacfw4A1+502jqMeNzNiJgTCyc+IuOMjro6yztuhqU9C2K
         Qc7qJbMc912ZkDQFYKSLGf3HOuEYDcRnsUVCpdRjLIZeOoV2Dg3icuVZz/jYVo2gaRVw
         bUCD7F6VsxUV/Rm6A9ez5Nt1IMv3pJPJyRIFs+EPFxqT3wyVthFzDxLfiXhUY63lZejf
         KSkBq/LbvZBxPBD3GBpBvwak7tT13Xv6rtjTqE4fpU7P5s+qZsJVneb5/Qv4IZ6t942K
         /ny6byUOkjhK9Ce68vnHM0KVfEbZoKC49VZn/d0BGw39MhI/DTnbUf8cwFvreCYN5O15
         WRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y8299RwRcUp2oS13ZRZK7TA/HszNxbKnoI7RGJSnP08=;
        b=ITlLVisncBGcQ2ePYGvH+xY2vPWi1L7chSHfxG6Y3ppI1nyGv8XnllfQP67USIu8+M
         P3oQMOgI8t3jMHEjVL6HV68vg9nFNypJseB5+0Yg8wtDyDqGOkqUu51ekHwEwGfB9itz
         m2gJCBWTBHQBELAjJb3rpTjuhKgRzPWR3pkS8PeHltuSGFyxhIhQCSq4+yPn/5+KpfZ/
         5H5uPoa7cIYJyBxGjB6W5SxoeMW+yogI2SJd+KuEOYF8I6fUJFNJXBhjYTFJwEwfA+2R
         28xsOeu/CqocHSRpr3LPUxNpwz4vmT0iQQqcpsnn5UE7TLhQxe9TEgmY2wISxwwtFtDl
         jSrw==
X-Gm-Message-State: APjAAAXsFSnyLdNyuXtR6R1P47WldqPwj30RfCyx2hgL6BkdetZ9AmjH
        RjwKl2ZgBPzuVzjLhLNurCEphQ==
X-Google-Smtp-Source: APXvYqx3bcXFZvHNp3BOLXeUXt0/2CVp+dpci37goTgDm1+WEAz/uPfvxVtLr+d0yHLCyi5ZM1OU0A==
X-Received: by 2002:a63:c104:: with SMTP id w4mr30672242pgf.409.1557139752529;
        Mon, 06 May 2019 03:49:12 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id p67sm21662257pfi.123.2019.05.06.03.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 03:49:11 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        palmer@sifive.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, mark.rutland@arm.com, robh+dt@kernel.org,
        sachin.ghadi@sifive.com, afd@ti.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v3 1/2] RISC-V: Add DT documentation for SiFive L2 Cache Controller
Date:   Mon,  6 May 2019 16:18:39 +0530
Message-Id: <1557139720-12384-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557139720-12384-1-git-send-email-yash.shah@sifive.com>
References: <1557139720-12384-1-git-send-email-yash.shah@sifive.com>
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

