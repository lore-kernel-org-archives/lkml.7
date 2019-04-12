Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36247C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00F82184B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D5Fi8mbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfDLACE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:02:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34374 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfDLACE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 20:02:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so4182636plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 17:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CBrXfahcrBFEuBwWPHCafCU3+H7O4tvEDowgXbhEK6U=;
        b=D5Fi8mbOCSkrQfJXjSCpDWQqcV7dm8ryqhwcqsasuSdKzRyh9K3aR7qnvpyvxtoff3
         oczbvp1H+Wg/qACYaPZqbLBIepUNRmlKzBabcqg6qE6rvPAJqNNjWfzWJ0Zw455u6Y7T
         1lYmVne3UKodqGbXUr8kqunA6yoN1h+Rm90Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CBrXfahcrBFEuBwWPHCafCU3+H7O4tvEDowgXbhEK6U=;
        b=Ms/xSrkkXUiLCGWUcwStxJjIHP1Mkz12V4nnELyTjZhpB7ktT6tvtTatS2vQGgj8sQ
         HRllMona+lKGWAcxZxctrBjPTRV+Pmm7736QPM9cTeZ8xVO4gIHg9l8DEjJzCOPIgAvV
         FKK53G8dO2KgIsGS1CROG/pgxYUsNkiu5CkmlJSLEjwXb/98Z82ckAGqDgw+tXaFWWCa
         /CDTvF/imRSgsgHGj+QYnYV1P15DAY7XMJF34x7Nxmv6Jdi8PQH3tL8ir8Hv4awWVnJr
         rznSrqtosb5GmuWECJXEnMy5i5pC2l1BD3O28RbNk98IJECTypnWfV3dI672O2M26bav
         /JgA==
X-Gm-Message-State: APjAAAVNvx1gUWWrnRPCLNb/OQLRJ20nOLCtbx75lM0VBtoJixl1F+qj
        qgDegQTwIOGYvn/58b29lHjaWg==
X-Google-Smtp-Source: APXvYqziWqnQWMDp7tTMmr/NmtdDsC1Uxc8Wsojj9LnVi+iw4SkqKwTXyY1TIqkwxJJFCAdRh4U/Mw==
X-Received: by 2002:a17:902:aa85:: with SMTP id d5mr54113352plr.251.1555027323186;
        Thu, 11 Apr 2019 17:02:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g5sm21081011pfo.53.2019.04.11.17.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 17:02:02 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ARM: dts: rockchip: Add dynamic-power-coefficient for rk3288
Date:   Thu, 11 Apr 2019 17:01:58 -0700
Message-Id: <20190412000158.248080-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value was determined with the following method:

- take CPUs 1-3 offline
- for each OPP
  - set cpufreq min and max freq to OPP freq
  - start dhrystone benchmark
  - measure CPU power consumption during 10s
  - calculate Cx for OPPx
    - Cx = (Px - P1) / (Vx²fx - V1²f1)          [1]
      using the following units: mW / Ghz / V   [2]
- C = avg(C2, ..., Cn)

[1] see commit 4daa001a1773 ("arm64: dts: juno: Add cpu
     dynamic-power-coefficient information")
[2] https://patchwork.kernel.org/patch/10493615/#22158551

FTR, these are the values for the different OPPs:

freq (kHz)   	mV		Px (mW)		Cx

126000		900		39
216000		900		66		370
312000		900		95		372
408000		900		122		363
600000		900		177		359
696000		950		230		363
816000		1000		297		361
1008000		1050		404		362
1200000		1100		528		362
1416000		1200		770		377
1512000		1300		984		385
1608000		1350		1156		394

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
I couldn't find any really comprehensive information on determining
the dynamic-power-coefficient, the method used is my understanding
mostly derived from the sources mentioned above, the resulting value
is within a reasonable range and the range of the intermediate Cx
values is consistent. If someone knows better and things should be
done differently please share your knowledge :)
---
 arch/arm/boot/dts/rk3288.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 23e9c5253019..f0d92b045c57 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -61,6 +61,7 @@
 			reg = <0x500>;
 			resets = <&cru SRST_CORE0>;
 			operating-points-v2 = <&cpu_opp_table>;
+			dynamic-power-coefficient = <370>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
@@ -71,6 +72,7 @@
 			reg = <0x501>;
 			resets = <&cru SRST_CORE1>;
 			operating-points = <&cpu_opp_table>;
+			dynamic-power-coefficient = <370>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
@@ -81,6 +83,7 @@
 			reg = <0x502>;
 			resets = <&cru SRST_CORE2>;
 			operating-points = <&cpu_opp_table>;
+			dynamic-power-coefficient = <370>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
@@ -91,6 +94,7 @@
 			reg = <0x503>;
 			resets = <&cru SRST_CORE3>;
 			operating-points = <&cpu_opp_table>;
+			dynamic-power-coefficient = <370>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
-- 
2.21.0.392.gf8f6787159e-goog

