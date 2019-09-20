Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBCDC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9902054F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="geMkPK++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405610AbfITJBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:01:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43581 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404617AbfITJBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:01:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so4061486pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 02:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OFOaylH6u5pbrPHCYuJfQmib6XY1jyUZj3KgxSUlnf8=;
        b=geMkPK++2NxPNSnmpOGduupMKkufm5T/M8nF6PuFXqeKFmKvmO7SOx7AiRg29Sh+Zw
         bE2+b61XguyAIPhtLuevPhdQKHkD0gnpcGCIDr/5VxjVn0qwfkzRS8oeJsSweMfubOUI
         51Ae42I3YIyHj+67hhcgBTRlO7VNB0ZvhYlCPZ8eyqgn4pheo7whsoqsyFoGGRNl+zEk
         1RJLi0FTXVKI4nis8ZBUUSa8eaj0rAe/B9ZwnkO+NdAvM+u4qGYvbVZvcG/ZnLdclCJJ
         Tml4zUga1fLcwzb0f2bpvXYwYgvvUYTZ0xK9yfWXZkd5coVE6b8lyATEjjv6GF+5SJ1H
         zSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OFOaylH6u5pbrPHCYuJfQmib6XY1jyUZj3KgxSUlnf8=;
        b=iZbVHQAaStB2d1NRqDv7JZ4dh6P3Q8peEDyJCmLkq2GRq3xMTF511GogAdnEbxGuto
         FKa0U6p8iPsVOg0kzp9PVX54Goztk8Z3DIF2VudvTxsfbfffh8hL2H5HEp5RwUETDon6
         txiCSxoUTYv60aMmYhuSBLGBeoMfA85fh1TYFvuthQnl/kB4YHIUB/fmW/Ys3ZMWsELu
         jzABkb+QTPWQ3+13fRk9hBzAtl171I7DoFzL+8KwupNbfw7pQTnkyMLlf5CEva46x+JY
         zzlqGWHTBnF09K7Bo7h1o3ppPj88Xa/zxGgFDhhO/UxZmNKPbXWt8MQC5xJrTwGEqK3a
         u/IA==
X-Gm-Message-State: APjAAAUZr0iwBxlotOKz+4KByFSSg3RXUuDYD2uuxbIl98n2UPij25TT
        sur5kSYq7wnrLSzSoxHFtlkB6A==
X-Google-Smtp-Source: APXvYqzP1roOJQzoODru6z/0qnw5j0kK1cdX/zA1pBREoXB8IBmgLBubBqrD44a8WKXdzYy5S8wYZQ==
X-Received: by 2002:a62:583:: with SMTP id 125mr16746466pff.69.1568970074846;
        Fri, 20 Sep 2019 02:01:14 -0700 (PDT)
Received: from localhost.localdomain (36-228-113-219.dynamic-ip.hinet.net. [36.228.113.219])
        by smtp.gmail.com with ESMTPSA id q30sm1645425pja.18.2019.09.20.02.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 02:01:14 -0700 (PDT)
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
Subject: [PATCH v3 2/3] riscv: dts: add support for PDMA device of HiFive Unleashed Rev A00
Date:   Fri, 20 Sep 2019 17:01:00 +0800
Message-Id: <20190920090105.19496-1-green.wan@sifive.com>
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

