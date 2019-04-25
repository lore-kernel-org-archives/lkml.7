Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52FFC282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D267214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ux2gd/pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfDYFzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:55:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43256 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDYFzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:55:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id e67so2693341pfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 22:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YaYDQDcCmsf6X5YiAjwhcu4gT8l58g/qvU6lg855U9k=;
        b=Ux2gd/plLuwYUgdPTDiuOasGP6nVzQPLIJXLAioJaUoXM4y8KntrU8EHrDfCNhqSYI
         cd+byvH3owt6wMKSuP0dwAmMmDVZHFXkVgFIoM5xKfChPcDko2W+inLwbip619c3owve
         wV+0H5bVO3Vd2wPLlROaQNj0z6/4JSZELm9ZzCsLnjOm/9WJ7ZT/fq3ewXD+MRfxOxf1
         hSkZuM4ndYWqQn7O2CxJynCTh1cQHcV2n5s0PiMWrSUQxggjqWiSGaFysG5MkwjLuUgi
         D646VhzZijPVR/JBMOfip859XMnNixAIQm+P5bJMFiSybVXCdcvBFdySAjUtwkkNNpRs
         g7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YaYDQDcCmsf6X5YiAjwhcu4gT8l58g/qvU6lg855U9k=;
        b=OdhS0tMTHER++EtYA9wkhy9NgsnWAozqG31zgjS+yWYny6grpzlpzVQLkbLjoRlYUX
         1v5UCUcgwx7O8Eq4OYe/cRdudL6zxo084PpFOUxnihI5JJIGmXIzu0sEcnEnyvBMZghw
         5LyH8COTIe9ALWVqDh0eaByxaqaBn+0LTNeww/8Q6yWII/Xn7CtkdXwx9hYJX4fkzY1e
         HlKxnl96YdC/dfm4aJMgA7J5o6IQ59fXfq8xPXWrzKb8AwaKcZ+W6gJ2elnSszByKxXe
         d9JHTUNa0/+S2Jz6yjCAnhCe80M689xGDnHTU0itBqO7CjDKLA5jBVxFMAxvZzhk0OXq
         XCFQ==
X-Gm-Message-State: APjAAAWemOPXzqO/xchT/bgO5JITDi/Kss6aZHGBJTz7y9p4+QZNzd9f
        vLicTVBdOGK1xsbxoo2ztFDkYw==
X-Google-Smtp-Source: APXvYqwjtZwaxfvqrhUita0yd99RZtr81g2DROY5MuMykfNIEkKP3LhIQvkBesB4YHt2jsYkANEK2A==
X-Received: by 2002:a65:63cb:: with SMTP id n11mr3184865pgv.236.1556171721463;
        Wed, 24 Apr 2019 22:55:21 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id m16sm46332170pfi.29.2019.04.24.22.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Apr 2019 22:55:20 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        palmer@sifive.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, mark.rutland@arm.com, robh+dt@kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 1/2] RISC-V: Add DT documentation for SiFive L2 Cache Controller
Date:   Thu, 25 Apr 2019 11:24:55 +0530
Message-Id: <1556171696-7741-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556171696-7741-1-git-send-email-yash.shah@sifive.com>
References: <1556171696-7741-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for SiFive FU540 L2 cache controller driver

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
new file mode 100644
index 0000000..15132e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
@@ -0,0 +1,53 @@
+SiFive L2 Cache Controller
+--------------------------
+The SiFive Level 2 Cache Controller is used to provide access to fast copies
+of memory for masters in a Core Complex. The Level 2 Cache Controller also
+acts as directory-based coherency manager.
+
+Required Properties:
+--------------------
+- compatible: Should be "sifive,fu540-c000-ccache"
+
+- cache-block-size: Specifies the block size in bytes of the cache
+
+- cache-level: Should be set to 2 for a level 2 cache
+
+- cache-sets: Specifies the number of associativity sets of the cache
+
+- cache-size: Specifies the size in bytes of the cache
+
+- cache-unified: Specifies the cache is a unified cache
+
+- interrupt-parent: Must be core interrupt controller
+
+- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals)
+
+- reg: Physical base address and size of L2 cache controller registers map
+
+- reg-names: Should be "control"
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
+		compatible = "sifive,fu540-c000-ccache";
+		cache-block-size = <0x40>;
+		cache-level = <0x2>;
+		cache-sets = <0x400>;
+		cache-size = <0x100000>;
+		cache-unified;
+		interrupt-parent = <&plic0>;
+		interrupts = <1 2 3>;
+		reg = <0x0 0x2010000 0x0 0x1000>;
+		reg-names = "control";
+		next-level-cache = <&L25 &L40 &L36>;
+		memory-region = <&l2_lim>;
+	};
-- 
1.9.1

