Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569AEC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B00217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WT2Pxo9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbfISH3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:29:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39462 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388567AbfISH3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:29:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id x6so1189388plv.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OFOaylH6u5pbrPHCYuJfQmib6XY1jyUZj3KgxSUlnf8=;
        b=WT2Pxo9+vdqo+cFeBngcdvpi/70AZ90ZQaQMGg5JQjt+rxT2ODU+n9g4ZmXKtXKH82
         PhGmkNWBY/WNJICfL3iDv1Rq9a1KHX0HSP804LwIiZN5fotqQQnQM/TkebS5E7x40fl/
         Sh33Iwz4ftxRxh+Lzb9q/nSa985dmZDZ9nj2rtEJ4emyA+OT6csvZJQATB9i83PMrHFi
         eFv2O9xdHjfmbAA6yQtsPDWgi2KfduxhvnSaaHkA975eaknOLaprO3aHEIjBre3eW3yF
         nEKHrIsLWEdXM4Rm9tGK+f4jdFQ3DzWjU46mKBh/DDKZRuBeYDkuknAOvdg3912sQwtf
         sFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OFOaylH6u5pbrPHCYuJfQmib6XY1jyUZj3KgxSUlnf8=;
        b=A0TvIKMCweG3RKkhuwH3wZ9Wwc5YcQfRc711nGbtLpknDBpmNeZMw574Q74tOvcJ3+
         yjyOUVfSjPiic7kCx3rTrXSEp+3e5QPks2b9ccDyAbw2Ek1ugBr3T4ZYx8nCZWSUpKxq
         5GbnPfmYx0Z37ts7AB3GhJEalshCM6rOZhwiMEBEFbtGnxzOp5JzDduVV+VMWV5lcL5T
         gi2SHL3t1nUFnH3EsAp2odZSkK4cusBDB3HDMAKuUjGlQBfb0Mh3xUMWGkIkHcPhFbv0
         eZU9wTdx7bvhAL5mJNOHDp9IpCjrEl/7tJVRpos9CHjgv1R8eSKBOff3J74MWWz6Eyfo
         HNbg==
X-Gm-Message-State: APjAAAWtpxHvLFM+ygQidmD4FQOj83q/7PAX+jfNvrAn+ObN9TspezGn
        KnRKkumAQBuGTYVwNi/tHjg+HA==
X-Google-Smtp-Source: APXvYqwsapyHm6wAGVWo7hnSXqyZwiK5M1XVWSUnIBQGDny0XMJWzBKktws1pfvK6npX5ze1JEqclw==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr8386982plb.286.1568878160122;
        Thu, 19 Sep 2019 00:29:20 -0700 (PDT)
Received: from localhost.localdomain (36-228-113-219.dynamic-ip.hinet.net. [36.228.113.219])
        by smtp.gmail.com with ESMTPSA id d20sm13029211pfq.88.2019.09.19.00.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 00:29:19 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Green Wan <green.wan@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] riscv: dts: add support for PDMA device of HiFive Unleashed Rev A00
Date:   Thu, 19 Sep 2019 15:28:59 +0800
Message-Id: <20190919072903.2083-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDMA support to (arch/riscv/boot/dts/sifive/fu540-c000.dtsi)

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 42b5ec223100..d3030d7fb45c 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -164,6 +164,13 @@
 			clocks = <&prci PRCI_CLK_TLCLK>;
 			status = "disabled";
 		};
+		dma: dma@3000000 {
+			compatible = "sifive,fu540-c000-pdma";
+			reg = <0x0 0x3000000 0x0 0x8000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <23 24 25 26 27 28 29 30>;
+			#dma-cells = <1>;
+		};
 		uart1: serial@10011000 {
 			compatible = "sifive,fu540-c000-uart", "sifive,uart0";
 			reg = <0x0 0x10011000 0x0 0x1000>;
-- 
2.17.1

