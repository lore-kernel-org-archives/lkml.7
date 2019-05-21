Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F95C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA1E21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIHFm7Hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfEUJgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:36:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33043 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfEUJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:35:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so8318966pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dTr1UCKgplI1VGB/ZytO9oL3rPosZf7DuDvgJME+3jg=;
        b=AIHFm7Hp4l+4xNPyW1cX8dxq1awTwXVWdpBPVIR3sn4SXcSKSHlVgGImRIW5bXDUa4
         lo0tOlSuFOBUL1R3fbgd7cJUHoMk3my3qscAJTjjlf/AViZ3Vv/IgzxGSayFt4cE7Uu2
         0yWa5KvdgnE3+HdLj8ccnl1VQk3XVLm0yogjlk4FzbxrTC6hy9u35nLQCSB1cl/ytpsd
         AyPweRXFYA029GowWgM4Ql7lqa32mdbC2QzGMEhwG3atEB8r1k6aNOXYlrFd2IWMEY7F
         yCU6/Fy2CcxuhHznLygRhUT09LrZukpgH9Ftt7fSNGiz7zcuSZqAYVm6a2dVYdDQE1Lf
         s2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dTr1UCKgplI1VGB/ZytO9oL3rPosZf7DuDvgJME+3jg=;
        b=GLhlmhCjIvz4/5kxABjNiM6vDK4Z4vYamaAjjEsqs9kAl31gVi7v0LL7J/vRh0/3ks
         kGgRFOrnYJoP/KR0+aVo/SkyhoGGVkD/AcBG24o+Lmg4qraGcB56BSc518Dp3BHfEPev
         MPvUhQ9kDXEnzlhelHUNcIU/4b5XhazPH7WRKfXVZR3bfHj8bY1uZ7iOILkg5kd9yEFJ
         zvcWSlW1P8zy7dHzc5SFCdzeKyPKEDthLCwArhsGP5VvhpkHUFyeFiSjaUSD7D+muPR1
         zijDmSskreAD4WX2QG2QJ/x5WraUxqESAle0kz/KVt6Dz8DL07WjCyPuy6mFNa0L3Vwu
         Tz4w==
X-Gm-Message-State: APjAAAUoh2icCa/837sNmGEkDLnH8SbsXujipOKs2Z+XrXP+nW6w1MRT
        bRD5qIpbE+7Yyzk0yQXT5VVKyanHt90BiQ==
X-Google-Smtp-Source: APXvYqzQdvlEjQclsKdTI02SGo59gbciI+RW4++t5Gve8xz66BCTyu7A7ZIpVyC7VmIiuxCVrOmnzw==
X-Received: by 2002:a63:4c06:: with SMTP id z6mr80149345pga.296.1558431356498;
        Tue, 21 May 2019 02:35:56 -0700 (PDT)
Received: from localhost ([49.248.189.249])
        by smtp.gmail.com with ESMTPSA id q20sm22215653pgq.66.2019.05.21.02.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 02:35:55 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        niklas.cassel@linaro.org, marc.w.gonzalez@free.fr,
        sibis@codeaurora.org, daniel.lezcano@linaro.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 9/9] arm64: dts: msm8996: Add proper capacity scaling for the cpus
Date:   Tue, 21 May 2019 15:05:19 +0530
Message-Id: <5224535a7ef5b257e3baa698991bf6deeefccc36.1558430617.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1558430617.git.amit.kucheria@linaro.org>
References: <cover.1558430617.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1558430617.git.amit.kucheria@linaro.org>
References: <cover.1558430617.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8996 features 4 cpus - 2 in each cluster. However, all cpus implement
the same microarchitecture and the two clusters only differ in the
maximum frequency attainable by the CPUs.

Add capacity-dmips-mhz property to allow the topology code to determine
the actual capacity by taking into account the highest frequency for
each CPU.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 4f2fb7885f39..e0e8f30ce11a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -96,6 +96,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
@@ -109,6 +110,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_0>;
 		};
 
@@ -118,6 +120,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 			      compatible = "cache";
@@ -131,6 +134,7 @@
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_1>;
 		};
 
-- 
2.17.1

