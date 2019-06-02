Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E88C28CC6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7ABB2787C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KnMJLtBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFBIBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 04:01:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33883 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfFBIBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 04:01:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so1691799wmd.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 01:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QmaqjHAcXNQW/qmNDVGvURxfu0pBpsioEB7U9HBButg=;
        b=KnMJLtBsseT1bxIDzuc1GshNCeheeDB9wYClyyns9MbVkCybtiy2J0a0RNmM3mdc3W
         D/7uBtIjzz1fNraYryAaUaP4zSqwZOuSgDMDicUDJau+mFTVNnb8ZZNEg/+tTwBdIJ3N
         2upGBHuzAR7XhNRngSEr24PS9VivSIld/8cW/yJ23NyFilUeGz7X581Urh7PJCfluDsy
         E/w4NjIa2lHJEMCjF5Nvt3xX3AEV0QPmjcEpAQxNmm7tndSl2Im5R2T3bgfEeCGOqdc8
         nVlh6Ww0ci+9iaP/cTyCyi5ny2lsITh8YI4pomOaOaIkVyocy0bmzmcq47a6MYiuMQTX
         AY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmaqjHAcXNQW/qmNDVGvURxfu0pBpsioEB7U9HBButg=;
        b=gnZTCjTdeBPr31ZLtpgv9cGWLkF4VnjRGZol4TLPjzGhqus+X6tg3WOLoCBlAwDMVQ
         TMwPsKfO9VSfDAqAYcN0nJXpLKRvROf+G8kab/pdJSKBC9SQLb9Oq8CiCVyC4io1ZuGS
         kc7ne9hHYgUQ4Twbh/Xm/vEmAIPmy/rYATQfrLWsQoiRwSP7/IGK2sxT2tvJn4ll8XLd
         ITraIMi8+Z/u9fczOHNSqDQ4V/5XFkP6mMdTUK79wz9or/kNbZCqjYRXBOK154eUKLnE
         fdM5qcnDUTfCQKs7Uh8oogyqL+kPaFp5TCxT8NLA71qBnuUZsO6a1Gc0UW9QFUbDbVL2
         xP1Q==
X-Gm-Message-State: APjAAAVO6+t0baJinItfmcnBOqwrdblruT+/7PDOqKbrbAT8qZk6NqAV
        unokzqFHCuyZse9DhFi+Jb27Hoqx+0k=
X-Google-Smtp-Source: APXvYqyggDZuulV0HbBw/YlqrgIXUoR9PW2bG61t21dH3kwKrBuNkRZall/GUJyHL7C4aF3TiEsDJA==
X-Received: by 2002:a1c:2c41:: with SMTP id s62mr715294wms.8.1559462498010;
        Sun, 02 Jun 2019 01:01:38 -0700 (PDT)
Received: from viisi.fritz.box (217-76-161-89.static.highway.a1.net. [217.76.161.89])
        by smtp.gmail.com with ESMTPSA id y133sm4868583wmg.5.2019.06.02.01.01.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 01:01:37 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul@pwsan.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org
Subject: [PATCH 5/5] riscv: dts: add initial board data for the SiFive HiFive Unleashed
Date:   Sun,  2 Jun 2019 01:01:26 -0700
Message-Id: <20190602080126.31075-6-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602080126.31075-1-paul.walmsley@sifive.com>
References: <20190602080126.31075-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial board data for the SiFive HiFive Unleashed A00.

Currently the data populated in this DT file describes the board
DRAM configuration and the external clock sources that supply the
PRCI.

This third version incorporates changes based on more comments from
Rob Herring <robh+dt@kernel.org>.

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
 arch/riscv/boot/dts/sifive/Makefile           |  2 +
 .../boot/dts/sifive/hifive-unleashed-a00.dts  | 67 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sifive/Makefile
 create mode 100644 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts

diff --git a/arch/riscv/boot/dts/sifive/Makefile b/arch/riscv/boot/dts/sifive/Makefile
new file mode 100644
index 000000000000..baaeef9efdcb
--- /dev/null
+++ b/arch/riscv/boot/dts/sifive/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-y += hifive-unleashed-a00.dtb
diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
new file mode 100644
index 000000000000..1de4ea1577d5
--- /dev/null
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2018-2019 SiFive, Inc */
+
+/dts-v1/;
+
+#include "fu540-c000.dtsi"
+
+/* Clock frequency (in Hz) of the PCB crystal for rtcclk */
+#define RTCCLK_FREQ		1000000
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "SiFive HiFive Unleashed A00";
+	compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000";
+
+	chosen {
+	};
+
+	cpus {
+		timebase-frequency = <RTCCLK_FREQ>;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x2 0x00000000>;
+	};
+
+	soc {
+	};
+
+	hfclk: hfclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <33333333>;
+		clock-output-names = "hfclk";
+	};
+
+	rtcclk: rtcclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <RTCCLK_FREQ>;
+		clock-output-names = "rtcclk";
+	};
+};
+
+&qspi0 {
+	flash@0 {
+		compatible = "issi,is25wp256", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&qspi2 {
+	status = "okay";
+	mmc@0 {
+		compatible = "mmc-spi-slot";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+		voltage-ranges = <3300 3300>;
+		disable-wp;
+	};
+};
-- 
2.20.1

