Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E26C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BC52086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPBPbkqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405751AbfFKQmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:42:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38229 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405697AbfFKQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:42:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id b11so9822911lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9ZNAv59f40CG0/uv7rXh/uSMAgb1GDNS6rT6AHe4V0=;
        b=MPBPbkqOsdx6Pgbk2vEFmxS5Pr880M9VCzpqIHdZhtmyBG/0cIrysoqL5qR3okl18m
         Yewt/oQAkaKm9tdPLdgZShNqbf6GQw3NdF8b2KRS6lOnxvlHayU+ipYY+be+4ktyxrK+
         84TKjJfHcoJBUwBhLhAhHVxHiq6UHoAkBJj9MByuCArn0WXBhxbHpBzeRjv9abYHIwIc
         xSjPmIauD3/MkeS9lAcYpeCFVy4J/Z0cVkZqR5X0ZfH77F6PifP648MLw0cKq9vSYHD1
         6FnoNTcmSnRHAkqM/0qe1TujvS5o9o1qs6syuDfI4Q/qQw3Awa9qUwalv2yRA3e0i4Xz
         Sn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9ZNAv59f40CG0/uv7rXh/uSMAgb1GDNS6rT6AHe4V0=;
        b=VMkp+9uu6HRELIzjzp7c40oASEoKo3/jkJvOmzVxAzaWuHBfUTjN/Cn3IpwNU8q+k6
         aKvMA6TFMqpmJvtwXKUC+79TRbKSTpFE5vaGmZ7qZavsGmvqpUY5NWTaiXFytfX+579q
         xmdkg3DdOWYViHU7gKD3UENdmk6h8HguO/nPHX6dUoAKhVOXV29GK1g/DYPeqlDRov9D
         kaDnai9gMl0LTjP74FXxH3iwnJPOcqFdBKNhPd13CMIPLFh6v95w/S5vcmO8Bf2WDBae
         +wcjaK+NdfGOJtrtuS/maeeIT4kcvqsBZOuefTViVjkt+8iytoFjmt7ZOpxSxIOilgsb
         Puow==
X-Gm-Message-State: APjAAAV8LxKy8tI7rkVKN0m3e77aJM/XtHW55KzQMjszN8xCsBdeJg9h
        ZI2SGyqFGRDKk/Hf+IKsc2SqKg==
X-Google-Smtp-Source: APXvYqycwmxnoSVnWNq3Dg51LluxipGxNUXj8qojZFmb2wWWZLGvVF1+NYMNmjxgnVC8lZZnSVvJsQ==
X-Received: by 2002:a19:f20d:: with SMTP id q13mr33978637lfh.65.1560271333633;
        Tue, 11 Jun 2019 09:42:13 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r14sm2616772lff.44.2019.06.11.09.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 09:42:13 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 5/5] arm64: dts: qcs404: Add interconnect provider DT nodes
Date:   Tue, 11 Jun 2019 19:41:57 +0300
Message-Id: <20190611164157.24656-6-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611164157.24656-1-georgi.djakov@linaro.org>
References: <20190611164157.24656-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT nodes for the network-on-chip interconnect buses found
on qcs404-based platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v3:
- Updated according to the new binding: added reg property and moved under the
  "soc" node.

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index ffedf9640af7..07ff592233b6 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018, Linaro Limited
 
+#include <dt-bindings/interconnect/qcom,qcs404.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
@@ -411,6 +412,33 @@
 			#interrupt-cells = <4>;
 		};
 
+		bimc: interconnect@400000 {
+			reg = <0x00400000 0x80000>;
+			compatible = "qcom,qcs404-bimc";
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				<&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+
+		pcnoc: interconnect@500000 {
+			reg = <0x00500000 0x15080>;
+			compatible = "qcom,qcs404-pcnoc";
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+				<&rpmcc RPM_SMD_PNOC_A_CLK>;
+		};
+
+		snoc: interconnect@580000 {
+			reg = <0x00580000 0x23080>;
+			compatible = "qcom,qcs404-snoc";
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				<&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
 		sdcc1: sdcc@7804000 {
 			compatible = "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
