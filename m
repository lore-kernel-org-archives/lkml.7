Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305F4C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA81F20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NTYweWIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfDHJbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:31:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33985 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDHJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:31:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id r186so14778311wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuCh+SuKhECtlhXkLgX0ABjHIJEelEdglkUNy443sVE=;
        b=NTYweWIYmXhepqAvfuqaTi2ccgIw8ICI/bQqVj9sr+LR3VXUOQS64ZTsSLuCKgnMk5
         WTG1LicN3ZYJzZetFJ9LD9LyCP+CtLMEsBoRR95VcnWV/XpMwyWzJBeQTHR/fqqd0fTP
         hoJQ8pghHdN/JkPPnA9mAw7yAzNFr0DD6Ff3qo4k5DCNwNEkdIwPCobCJR20WW8Fmcx2
         QYW2+au0nQt7pkLof20cwmR++z7Glw/if7IXQVfDMCGRPMHNHbj6Bb430ZlQgNNpzAh0
         sw8//cHjFHVRzr43EoO0B8EnItpNYkrz5t9uQhjJ7V4hxxsyh15xAlGm1ONm98DMyQGI
         Rdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuCh+SuKhECtlhXkLgX0ABjHIJEelEdglkUNy443sVE=;
        b=WG1Mc+uMLCitlj68cn4UjpMTAuYC1SLBnUg/aZyVAAcRovmOxEWhkXmIk8YHIW6CDA
         5v6xgChzgqDkdIFLvn8I48sC6pNz7M+QvvMIQvjQlDMLwKWDr883SEIAHNhjnzSXqIhR
         Lq/PRzhcjmoRjtPXp2g3SIxU5ppouAOCuo/VEimC62C77ItdNsX47HFnu8yWwtvupkXq
         rZMYd7shApwCVxWB6Bvuc956wd+esYRHiLtygk1MWnVSdpWX2Sp6yrImBAcw6ogcNXpL
         Sg3T0gW2iW085DOjKgBDFJfklteF5ZcIVZ1BGRIy97aVyUmNnqHfE8pbMeTo1BIrJvAS
         U7dw==
X-Gm-Message-State: APjAAAXNvkS88N8exGSQkYoeCGVFW8zSVJolMdmjioogepe+ZnE4d/1w
        rlv7geCk7/OpBTlgZuM8d5SwkZ+EEe9KGA==
X-Google-Smtp-Source: APXvYqwwgFSHs9/3+G824dWffRmJ+HBhlvNc420O8SlQjxOOzcOcXRSSqD3ofmaagP8PnWoXvLmHKw==
X-Received: by 2002:a1c:f909:: with SMTP id x9mr15941264wmh.18.1554715902802;
        Mon, 08 Apr 2019 02:31:42 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c10sm36777427wru.83.2019.04.08.02.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 02:31:42 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] arm64: dts: meson-g12a: Add AO-CEC nodes
Date:   Mon,  8 Apr 2019 11:31:36 +0200
Message-Id: <20190408093139.27161-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408093139.27161-1-narmstrong@baylibre.com>
References: <20190408093139.27161-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic G12A embeds 2 CEC controllers :
- AO-CEC-A the same controller as in GXBB, GXL & GXM SoCs
- AO-CEC-B is a new controller

Note, the two controller can work simultanously since 2 Pads can
handle CEC, thus this SoC can handle 2 distinct CEC busses.

This patch adds the nodes for the AO-CEC-A and AO-CEC-B controllers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 34 +++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index a696612f8f44..9f72396ba710 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -169,6 +169,22 @@
 						gpio-ranges = <&periphs_pinctrl 0 0 86>;
 					};
 
+					cec_ao_a_h_pins: cec_ao_a_h {
+						mux {
+							groups = "cec_ao_a_h";
+							function = "cec_ao_a_h";
+							bias-disable;
+						};
+					};
+
+					cec_ao_b_h_pins: cec_ao_b_h {
+						mux {
+							groups = "cec_ao_b_h";
+							function = "cec_ao_b_h";
+							bias-disable;
+						};
+					};
+
 					hdmitx_ddc_pins: hdmitx_ddc {
 						mux {
 							groups = "hdmitx_sda",
@@ -405,12 +421,30 @@
 				};
 			};
 
+			cec_AO: cec@100 {
+				compatible = "amlogic,meson-gx-ao-cec";
+				reg = <0x0 0x00100 0x0 0x14>;
+				interrupts = <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_AO CLKID_AO_CEC>;
+				clock-names = "core";
+				status = "disabled";
+			};
+
 			sec_AO: ao-secure@140 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x140 0x0 0x140>;
 				amlogic,has-chip-id;
 			};
 
+			cecb_AO: cec@280 {
+				compatible = "amlogic,meson-g12a-ao-cec";
+				reg = <0x0 0x00280 0x0 0x1c>;
+				interrupts = <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_AO CLKID_AO_CTS_OSCIN>;
+				clock-names = "oscin";
+				status = "disabled";
+			};
+
 			uart_AO: serial@3000 {
 				compatible = "amlogic,meson-gx-uart",
 					     "amlogic,meson-ao-uart";
-- 
2.21.0

