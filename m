Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930A8C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674702072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+5f07YL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfKOQ3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:29:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39373 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfKOQ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:29:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id x28so6928947pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y6Dgg0LHIAz3laO+y1ntUkl0I7eVRTHEz+QlpqCcJzM=;
        b=F+5f07YLpe5ouKmkTbFGbDdunX/KCt+dKybIeWw2uN5evbh0B2Mr32f1AUvREsXuZd
         6E6zV+NRXkT9IOcKo/StVi+ubHWxgRq0aKA1QVvfmhUIjn7Y+UrHouPMWcNfSnZHUBry
         1K+Fbtj/qFLphLnaT5CNC89x1uJ8AEPgZQPqzG+xjmlpJUMixmXCXvBJ/XPW0xharZQ5
         3e886sJBoYHcRyzfI6WNwY+P3TxKtI0TXSx4SOLGnb2RVr+gK6/g3omS8MYBxe9PlpG9
         om+syucI14CmPGDiUayqgNtOMu9H5CYyGtFl7Pbn7WREgCnbNGr3zpJELaucvUmNgs/W
         2yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y6Dgg0LHIAz3laO+y1ntUkl0I7eVRTHEz+QlpqCcJzM=;
        b=O5PoJU8E2wd2vWK2kKrKv4vQIOT7zSyzSUXETtwan2ANGeNReIyrKAoDngu/lNhyJI
         cVWtfn3QkalJEn1Ws3iS+DxHlZ23wfFDyCU8qGE98X1Sk31zW3qntOoR1ZZyl7ucHgVA
         3tGs9y41LrUm5rB35zGRMHZ9WKTDlMjV4EfAjJ4yqYYsY9XzrILZab3hZmrSzmeUoK/N
         MAzUNeJnt4QpjwWdumc9z3G9gGARZpVmIPNDPZtQdgcf7fsppOHqUlo4eaOYM5D7zgSg
         i9hM3aisTbyF43r8u1BAOg41rPZHGx6VnB20k+m9abI3b5SvTxJM17PmnozlyQ/vRALd
         RN8g==
X-Gm-Message-State: APjAAAXasamyLHf4mqyqzjbXACnWLpwWm1GuYIg9sGggp40DlUsorQzP
        WX52LS7SB45Y3IcufgBWlI5Z
X-Google-Smtp-Source: APXvYqwDZwTI7WAkduLMSH+eqssbv8GB1QaGVtH8A8kWnBO9K2P2qfEHIyrK9Cb+ZIfueyohjNBsxg==
X-Received: by 2002:a62:e119:: with SMTP id q25mr18667948pfh.161.1573835378452;
        Fri, 15 Nov 2019 08:29:38 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6183:6d55:8418:2bbc:e6d8:2b4])
        by smtp.gmail.com with ESMTPSA id y24sm12295288pfr.116.2019.11.15.08.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 08:29:37 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 4/7] arm64: dts: bitmain: Add clock controller support for BM1880 SoC
Date:   Fri, 15 Nov 2019 21:58:58 +0530
Message-Id: <20191115162901.17456-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org>
References: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock controller support for Bitmain BM1880 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/bitmain/bm1880.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
index d65453f99a99..8471662413da 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880.dtsi
+++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
@@ -4,6 +4,7 @@
  * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
  */
 
+#include <dt-bindings/clock/bm1880-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/bitmain,bm1880-reset.h>
 
@@ -66,6 +67,12 @@
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 
+	osc: osc {
+		compatible = "fixed-clock";
+		clock-frequency = <25000000>;
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -94,6 +101,15 @@
 				reg = <0x400 0x120>;
 			};
 
+			clk: clock-controller@e8 {
+				compatible = "bitmain,bm1880-clk";
+				reg = <0xe8 0x0c>, <0x800 0xb0>;
+				reg-names = "pll", "sys";
+				clocks = <&osc>;
+				clock-names = "osc";
+				#clock-cells = <1>;
+			};
+
 			rst: reset-controller@c00 {
 				compatible = "bitmain,bm1880-reset";
 				reg = <0xc00 0x8>;
-- 
2.17.1

