Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D64C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3EE21850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GMyx2w/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfDKIno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:43:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36588 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfDKInn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:43:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so3194378pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1Mmh7OGKm/PRc5pJu5Gszy2fIMXgE1qUHdEGxScwKk=;
        b=GMyx2w/2b5SWo6Vyco8wuPkJ66Yb0hcLhxngw13gDDK4dK6NiCD2WRK0FeqhkqPrDA
         Dpd+dTuwtq+XzSzCl/TT/XxBrnC1mLqBt/BGbJwxkjoOKRy7NvvDMl5FU4YV14Y0my37
         q/QtkOBUSUHf3dsBJMv5FQ8VfIVG3SfbSH2sRQ3ZavaAQqkb83iGzd+hiHIxMSz3iVQH
         0DjBxsoeaZVoylw985TLnq1m4ajOhslG37k/4vIIUWOshzzWqKOPCnIxAU08207PvdRM
         Ake0RtycgxxdiajuspDPmpXHh8ILeeiYFZ7DlaodTnhu6Rcu1xQwBsZHA8OGRmcSVjNc
         bQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1Mmh7OGKm/PRc5pJu5Gszy2fIMXgE1qUHdEGxScwKk=;
        b=gm/YHlxs51CA9ke7OTLlddj573QAZrBS8apgI3rAivluCBmYumxHyloiuzLbDdLZ03
         OABSCa3bkCWUtTMQ2lRxGNJ3RbVrBL3wplyX9u6xJPyEFEpVvzsI1/mANm2pMj7g45Py
         qO4TKuCpdG6b334j2d3+22h9j00YgmEVK4wT7akmCu5Gyc0aW74v7pUPzfog+hudEojQ
         h2bNpjCKUul/yjhONNiU+t99cgpS7LRQvMktTESeY0DrNYbaGEVA30qvJYv1JiQ7gfv0
         8PVwcKf4V3q+Av/y9hFhasDDIf31STkEBRLXs/D4+rsfsKwR1zH8HfpjKxRWGdOpRWHY
         nw2Q==
X-Gm-Message-State: APjAAAUym81SbBj8tjpJBQv2n/5D46R73xyLCQYvLVgbCnyl/IT/C2CU
        xErhSNIIEPTj/PEAvFYjEKJDB0EzGqA=
X-Google-Smtp-Source: APXvYqzOeAuuDXc4Y3XlkKgBDv/UbsxtQDE7aTptRh5fQwCIquG5DsSuZ4aPn2plqRc3axpaWCO3gg==
X-Received: by 2002:a63:7885:: with SMTP id t127mr44318864pgc.338.1554972222245;
        Thu, 11 Apr 2019 01:43:42 -0700 (PDT)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a3sm61699456pfn.182.2019.04.11.01.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 01:43:41 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 4/6] riscv: dts: add initial support for the SiFive FU540-C000 SoC
Date:   Thu, 11 Apr 2019 01:43:02 -0700
Message-Id: <20190411084304.5072-5-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411084304.5072-2-paul.walmsley@sifive.com>
References: <20190411084304.5072-2-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the SiFive FU540-C000 SoC.  This is a 28nm SoC
based around the SiFive U54-MC core complex and a TileLink
interconnect.

This file is expected to grow as more device drivers are added to the
kernel.

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
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 207 +++++++++++++++++++++
 1 file changed, 207 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sifive/fu540-c000.dtsi

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
new file mode 100644
index 000000000000..dd3b9395cedf
--- /dev/null
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: (Apache-2.0 OR GPL-2.0+)
+/* Copyright (c) 2018-2019 SiFive, Inc */
+
+/dts-v1/;
+
+#include <dt-bindings/clock/sifive-fu540-prci.h>
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	compatible = "sifive,fu540-c000", "sifive,fu540";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <1000000>;
+		cpu0: cpu@0 {
+			compatible = "sifive,e51", "sifive,rocket0", "riscv";
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <16384>;
+			reg = <0>;
+			riscv,isa = "rv64imac";
+			status = "okay";
+			cpu0_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+		cpu1: cpu@1 {
+			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <1>;
+			riscv,isa = "rv64imafdc";
+			status = "okay";
+			tlb-split;
+			cpu1_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+		cpu2: cpu@2 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <2>;
+			riscv,isa = "rv64imafdc";
+			status = "okay";
+			tlb-split;
+			cpu2_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+		cpu3: cpu@3 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <3>;
+			riscv,isa = "rv64imafdc";
+			status = "okay";
+			tlb-split;
+			cpu3_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+		cpu4: cpu@4 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <4>;
+			riscv,isa = "rv64imafdc";
+			status = "okay";
+			tlb-split;
+			cpu4_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+	};
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "sifive,fu540-c000", "sifive,fu540", "simple-bus";
+		ranges;
+		plic0: interrupt-controller@c000000 {
+			#interrupt-cells = <1>;
+			compatible = "sifive,plic-1.0.0";
+			reg = <0x0 0xc000000 0x0 0x4000000>;
+			interrupt-controller;
+			interrupts-extended = <
+				&cpu0_intc 11
+				&cpu1_intc 11 &cpu1_intc 9
+				&cpu2_intc 11 &cpu2_intc 9
+				&cpu3_intc 11 &cpu3_intc 9
+				&cpu4_intc 11 &cpu4_intc 9>;
+		};
+		prci: clock-controller@10000000 {
+			compatible = "sifive,fu540-c000-prci";
+			reg = <0x0 0x10000000 0x0 0x1000>;
+			clocks = <&hfclk>, <&rtcclk>;
+			#clock-cells = <1>;
+		};
+		uart0: serial@10010000 {
+			compatible = "sifive,fu540-c000-uart", "sifive,uart0";
+			reg = <0x0 0x10010000 0x0 0x1000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <4>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+		};
+		uart1: serial@10011000 {
+			compatible = "sifive,fu540-c000-uart", "sifive,uart0";
+			reg = <0x0 0x10011000 0x0 0x1000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <5>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+		};
+		qspi0: spi@10040000 {
+			compatible = "sifive,fu540-c000-spi", "sifive,spi0";
+			reg = <0x0 0x10040000 0x0 0x1000
+			       0x0 0x20000000 0x0 0x10000000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <51>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		qspi2: spi@10050000 {
+			compatible = "sifive,fu540-c000-spi", "sifive,spi0";
+			reg = <0x0 0x10050000 0x0 0x1000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <6>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		qspi1: spi@10140000 {
+			compatible = "sifive,fu540-c000-spi", "sifive,spi0";
+			reg = <0x0 0x10140000 0x0 0x1000
+			       0x0 0x30000000 0x0 0x10000000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <52>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
-- 
2.20.1

