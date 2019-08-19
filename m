Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FEAC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73BA20989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oUuNpnyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfHSNCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:02:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32891 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfHSNCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:02:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so1151869pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 06:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y6Dgg0LHIAz3laO+y1ntUkl0I7eVRTHEz+QlpqCcJzM=;
        b=oUuNpnyzcfdqKYcffE+4dkTe7aZEcILFVqNYBqgS31D2oB9ZdNMSzqH3x9M8VIlV04
         1Upc1YdIcPe1dVxazZwZKLbp9SpwjHA2LYfKWqd+5fjyE/8SU1hZqDQP/VXsalwyyCbw
         9hlqtvSre+Ha34CmHb5r6Jhm0IubTiHR6lRKAOX7wdPcXIkC7sUp5JkIgY+EOIudE3WG
         +kw6w7hLqVXGd7EhgluRQpjoap2kzXtxlBY5C6+OR8ZiAuE5yrj46CoNxC3NHXRO8/Yn
         ejdUdKCTPHIPyTnA2+PHcnzUmVnir/ovoYNwoy87fQdj9xrO+bWCuc5dOn9CCTnkwBnY
         hKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y6Dgg0LHIAz3laO+y1ntUkl0I7eVRTHEz+QlpqCcJzM=;
        b=sdv2HtOuNIc8HXDxiJMQEz932LrSwsAhYHC+Xwj4rO/Wc2PGnKHo4phATngih4Dyl0
         uXCELaBJ4r8Q9rJ96weSKEvZEfJX4TGLFyYS59YAqO5RkYxRjnJEIQj1IWVnfwwfkjbd
         4gwyzg2/eG3IFM7u/y+HrT2I6uUNO9ms6DwJHbAYRNLYj7mAunVtqoMZKYk0+JPyXVTW
         JVoPA7K/lAvgbQy72ZeQC3/JBZ3yzqcwCLuUl6NGMV09LH30kEcwi2SZXDm8sAHQ+bKY
         vV5zbKA8o+q1s5KcFAEQMYSQGTYfFXZohLRa13hROeHaRy1jeVrwxskgFgRqac7kfZZ6
         HB4Q==
X-Gm-Message-State: APjAAAXaBre4k/ThWmtKhjcnV11rQdK3sE7+jO1bwgdTxjzlTLfEMu0m
        P3F3aTx43nxBN0aUFWux8E4o
X-Google-Smtp-Source: APXvYqxoz5vqs+kPpeQc0ASPsmVB2/qitpzmhueGxst/kcbfKnB65wPKIF40VAc9jqd224Gxj6uEeA==
X-Received: by 2002:aa7:9591:: with SMTP id z17mr24134756pfj.215.1566219737275;
        Mon, 19 Aug 2019 06:02:17 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id l123sm20626464pfl.9.2019.08.19.06.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 06:02:16 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 5/8] arm64: dts: bitmain: Add clock controller support for BM1880 SoC
Date:   Mon, 19 Aug 2019 18:31:40 +0530
Message-Id: <20190819130143.18778-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819130143.18778-1-manivannan.sadhasivam@linaro.org>
References: <20190819130143.18778-1-manivannan.sadhasivam@linaro.org>
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

