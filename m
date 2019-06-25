Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA782C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90266214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lkRwaw1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfFYJcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:32:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36259 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbfFYJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:32:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id f21so8682882pgi.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rpStZmf35igMxqzLeEFybCYnhueTgWtLq21mpmx87uQ=;
        b=lkRwaw1IUMjbuUdyCAHnbKBURaBkrUi37P3tS5gdfFTLedE3E79iT3ke2SHKBg9PZm
         uweWcx3f9W4ua0SkJy+FupZMmVyBSYFKPFi9TcCe0MkoPpHZbR5dmglZFXbAhYkSrmnb
         BHcQbrIRPav9Z2p0iJVqRb4I77GZkvtwdUJa+IrkhY/+rI/YTiDQRIydfn+QT2sa4JZc
         Dk9+PbIY9ZlIFXzHVy8A6FjkvRx+e3nPJdDfvuVSdtFy31mZ52P7vlfrcEy3LJP1+C/6
         Qpmw3cWv3L4O+jzdx8M0fqy32+Glba3bvb7tPgX4rwZktSZTJVoY7oGY3jC81O9tQTJP
         TJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rpStZmf35igMxqzLeEFybCYnhueTgWtLq21mpmx87uQ=;
        b=j+8PwCUr1XTCj7aulWjgKVWqLgd1jCqb7BcmwxiD2bvU3i1JzijmXPlqPqV4ynqvlR
         oI9nldz7FD7T92TopVMRTNNkW56f/QCHXPiyGDgDNe/XY7UGjGt7SYUTCY9TbFO4JINW
         cmsi9NQBqLed+89+/gBFwEZpboSJhmYV7P9qervzollUrGHsuTHra2394pAzjPv1K1Vo
         ufCaX89WiG0Mnnz+Xxc7vgNZ4tOLXlv8teC8orKEoOvAbNrtjg9ncJwf8FcMj9urjHo8
         /PLMAVYANdzS/vmgu9SaMR8reD/R025YOnvzAGQU3I3OnU9IdRYgRCrz32QzeD0UyNTK
         oUFg==
X-Gm-Message-State: APjAAAVD2MJd1NrA8ogLofsi17kccf1yP+TwMpxump8mZenhKC31qQJB
        r2RsROCiaIQPTuoNl99UHkrQfg==
X-Google-Smtp-Source: APXvYqzbAg5MBG2Xe6ojTiLwa+O3LoQWCgWKX7EW8u/iOuynr270+kNo1TQksKvvhwhqxIO76r/FpQ==
X-Received: by 2002:a63:d218:: with SMTP id a24mr38650537pgg.419.1561455125207;
        Tue, 25 Jun 2019 02:32:05 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id q19sm16634877pfc.62.2019.06.25.02.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 02:32:04 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH] riscv: dts: Re-organize the DT nodes
Date:   Tue, 25 Jun 2019 15:01:31 +0530
Message-Id: <1561455091-29488-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the convention for any SOC device with external connection,
define only device DT node in SOC DTSi file with status = "disabled"
and enable device in Board DTS file with status = "okay"

Reported-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi          |  6 ++++++
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 4e8fbde..cc73522 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -177,6 +177,7 @@
 			interrupt-parent = <&plic0>;
 			interrupts = <4>;
 			clocks = <&prci PRCI_CLK_TLCLK>;
+			status = "disabled";
 		};
 		uart1: serial@10011000 {
 			compatible = "sifive,fu540-c000-uart", "sifive,uart0";
@@ -184,6 +185,7 @@
 			interrupt-parent = <&plic0>;
 			interrupts = <5>;
 			clocks = <&prci PRCI_CLK_TLCLK>;
+			status = "disabled";
 		};
 		i2c0: i2c@10030000 {
 			compatible = "sifive,fu540-c000-i2c", "sifive,i2c0";
@@ -195,6 +197,7 @@
 			reg-io-width = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 		qspi0: spi@10040000 {
 			compatible = "sifive,fu540-c000-spi", "sifive,spi0";
@@ -205,6 +208,7 @@
 			clocks = <&prci PRCI_CLK_TLCLK>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 		qspi1: spi@10041000 {
 			compatible = "sifive,fu540-c000-spi", "sifive,spi0";
@@ -215,6 +219,7 @@
 			clocks = <&prci PRCI_CLK_TLCLK>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 		qspi2: spi@10050000 {
 			compatible = "sifive,fu540-c000-spi", "sifive,spi0";
@@ -224,6 +229,7 @@
 			clocks = <&prci PRCI_CLK_TLCLK>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 	};
 };
diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 4da8870..0b55c53 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -42,7 +42,20 @@
 	};
 };
 
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
 &qspi0 {
+	status = "okay";
 	flash@0 {
 		compatible = "issi,is25wp256", "jedec,spi-nor";
 		reg = <0>;
-- 
1.9.1

