Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD854C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A0821582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB3OuaCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfLRUWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:22:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43276 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfLRUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:22:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so3583619ljm.10;
        Wed, 18 Dec 2019 12:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xq9tBk/6KoDVPMtQ/rhYvGgBAgv98Cu3SgI5vW4OCek=;
        b=jB3OuaCFCK5Ifk236GYC+fbvPOyNs8iGFfyx3NlzXicqkbNjIsW/RMg/V4BhoBRdeg
         wQMERb+UWWUuHf3ZAwW3svLD6dz3MV9Aoq3uQlRiUV02R26ionnNDFvIAuUkjKrDXLJM
         Xcx8bCfYuvIccOMQmYc3imSHZAkryPeAWAJcmmiKed3frWXcDCb0ZuWStA7yyAIR1cAD
         Hbe8MQiWTmB9eQfMp6jpyskMnl7Vn06hbsHifxzvbIwgQBu/t3cuT2skcZMVsEyx6jLc
         KRyeRBRDlj58q6Twodi8IQbVo9HDKFKeoB4O9Tp9DNQrRXbpb/VMqnjYvLgmS85Pj6Pd
         yuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xq9tBk/6KoDVPMtQ/rhYvGgBAgv98Cu3SgI5vW4OCek=;
        b=AslLAIg7VatqJ1Xq+6gOT25xUK6vrW55QsfAjwYNyH6boioOF9Ucu0dHOYmUDy1Gff
         UhKI+SkZ4iDrx23Wr+AdhDZyMVExcMP7EdyE3WlgzHQ1ewdCRlRzQjyyj83TNKFDrlrw
         4Kxl6Yt/6VqoOL3rE3VmA2kOUxOOSP9M8UV8adXYO+nQlMHylQpZQoYXtgOWIWpfCC9P
         BgREoTAXVlc7/o15nUDpcQSmGHSb0a3/55v/5wee0RM52gVqKo0jc+XHgi4k+kZYyi/o
         kpFwoSPRepY5eZ2ae0CThIJxBYSeQ0j30g5ToSbj5DzdMXsVk2w2Xwfvj+tmC75ZOgsK
         zqPA==
X-Gm-Message-State: APjAAAXADa+R7D+IJ6PKgy2UpHbXv9Sn9A74jbYM4S6ghr0cBE55uG9U
        Xdi3jOF40DYcsXSncVnC2M8=
X-Google-Smtp-Source: APXvYqzOJNV0yRI5YX/93LUSa2Vp+PjxX/hUPns3o/zSB+Md7fjo0zKesJXLYhC0ISfd5UHRllhb6g==
X-Received: by 2002:a2e:9d85:: with SMTP id c5mr3290070ljj.51.1576700529912;
        Wed, 18 Dec 2019 12:22:09 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m15sm1766993ljg.4.2019.12.18.12.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:22:09 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/12] ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
Date:   Wed, 18 Dec 2019 23:21:41 +0300
Message-Id: <20191218202142.11717-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218202142.11717-1-digetx@gmail.com>
References: <20191218202142.11717-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set min/max voltage and couple CPU/CORE regulators.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-beaver.dts | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index a3b0f3555cd2..6ebb3105af9e 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -1806,9 +1806,14 @@ vdd2_reg: vdd2 {
 
 				vddctrl_reg: vddctrl {
 					regulator-name = "vdd_cpu,vdd_sys";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
+					regulator-min-microvolt = <800000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-coupled-with = <&core_vdd_reg>;
+					regulator-coupled-max-spread = <300000>;
+					regulator-max-step-microvolt = <100000>;
 					regulator-always-on;
+
+					nvidia,tegra-cpu-regulator;
 				};
 
 				vio_reg: vio {
@@ -1868,17 +1873,22 @@ ldo8_reg: ldo8 {
 			};
 		};
 
-		tps62361@60 {
+		core_vdd_reg: tps62361@60 {
 			compatible = "ti,tps62361";
 			reg = <0x60>;
 
 			regulator-name = "tps62361-vout";
 			regulator-min-microvolt = <500000>;
 			regulator-max-microvolt = <1500000>;
+			regulator-coupled-with = <&vddctrl_reg>;
+			regulator-coupled-max-spread = <300000>;
+			regulator-max-step-microvolt = <100000>;
 			regulator-boot-on;
 			regulator-always-on;
 			ti,vsel0-state-high;
 			ti,vsel1-state-high;
+
+			nvidia,tegra-core-regulator;
 		};
 	};
 
-- 
2.24.0

