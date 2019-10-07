Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66633C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 00:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFB220862
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 00:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="StpyWWgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfJGAnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 20:43:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55885 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfJGAno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 20:43:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id a6so10669359wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 17:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=fQOEfRQoy/pcyTLI4fTFGvUUjpgVNx4G+Kw/9xbGrIE=;
        b=StpyWWghbg5+qigi+PXQ79YlBBRdvEcdNHMUOepdgoOrdJLYVmozYC25BcmEW0igXc
         h6zpZcAF3c6+hICYE6URHtb8CRMSE7Wk9EzgU/rm2nXWUMs+97+X5tSulIEshUKxaM6T
         b3o5zhQAVAUTSXS5EjLNggrmtgABxtkrzJHfMK7QXq/+zwv3zfHU6UmZO5eOug00avaW
         Bjx0xrIFYy/B3PM4QfJApeqvy2Hs0VHeRe+nF7+FuJZYec0iSocdwBJ9ztIc/GgUDnR0
         RVY1qWaQsxEgcdcmYm4AAcXJ162bdG3O8iw1CvUOjdbCKfWw4Ti4O1kQpLQZ+iCTsfZ3
         bauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=fQOEfRQoy/pcyTLI4fTFGvUUjpgVNx4G+Kw/9xbGrIE=;
        b=KzVf+KbAdIV9Pj+8YOsi9MKmJF/yIq8dMvBnaNZFEqeaNbGvYM0lkzD9QGnxoyuiyl
         QApt6CUH0pNXvX5RUf8dOf3ROUiTLobd52bOlVp9SSKEtQwIHFONksMnW3OrE8SeX38T
         Cu1JH63xQ8kQtf7EtrTGdVALVgA+3Am+/Jm1nTR7UAtT9AOXfHOAQ3aINbKfnVQETkxs
         z0WyBJwuQvcTfmzeWCdOTkiMXHlPMKAsTfUhN1oi4+dVhTjWL902xwLNP900fYtFRSMG
         nNr8a5mFT+7PWhufkhsgC7ZuNt7RCNNgNHWTLscpIxn7x9HrA6c9JZwmW3puWaBSIdpM
         NHbw==
X-Gm-Message-State: APjAAAXdDJI+tEYMAcyartJTUh5pUANWuhVG3FKlqfgttA0ZFi/HfZe+
        bpTmHLX7R7d1Hq1CYG3bnbymrA==
X-Google-Smtp-Source: APXvYqy1RUExx0LprFcaXh1JMN2lSMQwUqt5qKkBkFusoMa1FCqZI/PiueBG5fDfQiYrIF2OCp7RLg==
X-Received: by 2002:a1c:9c85:: with SMTP id f127mr13526617wme.28.1570409021143;
        Sun, 06 Oct 2019 17:43:41 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id z9sm14474627wrp.26.2019.10.06.17.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 17:43:40 -0700 (PDT)
Message-ID: <5d9a8a3c.1c69fb81.14b6f.10d1@mx.google.com>
Date:   Sun, 06 Oct 2019 17:43:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.4-rc1-48-g0bc9c79979ea
X-Kernelci-Tree: krzysztof
X-Kernelci-Branch: for-next
X-Kernelci-Lab-Name: lab-collabora
Subject: krzysztof/for-next boot bisection: v5.4-rc1-48-g0bc9c79979ea on
 peach-pi
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

krzysztof/for-next boot bisection: v5.4-rc1-48-g0bc9c79979ea on peach-pi

Summary:
  Start:      0bc9c79979ea Merge branch 'for-v5.5/memory-samsung-dmc-dt' in=
to for-next
  Details:    https://kernelci.org/boot/id/5d9a50af59b5141ce5857c07
  Plain log:  https://storage.kernelci.org//krzysztof/for-next/v5.4-rc1-48-=
g0bc9c79979ea/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-exynos5800-pe=
ach-pi.txt
  HTML log:   https://storage.kernelci.org//krzysztof/for-next/v5.4-rc1-48-=
g0bc9c79979ea/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-exynos5800-pe=
ach-pi.html
  Result:     0899a480ac65 ARM: dts: exynos: Add initial data for coupled r=
egulators for Exynos5422/5800

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       krzysztof
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
  Branch:     for-next
  Target:     peach-pi
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     multi_v7_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 0899a480ac658144b1fa351bb880c2858d43f824
Author: Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Thu Oct 3 12:08:14 2019 +0200

    ARM: dts: exynos: Add initial data for coupled regulators for Exynos542=
2/5800
    =

    Declare Exynos5422/5800 voltage ranges for opp points for big cpu core =
and
    bus wcore and couple their voltage supllies as vdd_arm and vdd_int shou=
ld
    be in 300mV range.
    =

    Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
    [k.konieczny: add missing patch description]
    Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
    Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
    Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos54=
20.dtsi
index 2c131ad78c09..d08101b1018c 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -48,62 +48,62 @@
 =

 		opp-1800000000 {
 			opp-hz =3D /bits/ 64 <1800000000>;
-			opp-microvolt =3D <1250000>;
+			opp-microvolt =3D <1250000 1250000 1500000>;
 			clock-latency-ns =3D <140000>;
 		};
 		opp-1700000000 {
 			opp-hz =3D /bits/ 64 <1700000000>;
-			opp-microvolt =3D <1212500>;
+			opp-microvolt =3D <1212500 1212500 1500000>;
 			clock-latency-ns =3D <140000>;
 		};
 		opp-1600000000 {
 			opp-hz =3D /bits/ 64 <1600000000>;
-			opp-microvolt =3D <1175000>;
+			opp-microvolt =3D <1175000 1175000 1500000>;
 			clock-latency-ns =3D <140000>;
 		};
 		opp-1500000000 {
 			opp-hz =3D /bits/ 64 <1500000000>;
-			opp-microvolt =3D <1137500>;
+			opp-microvolt =3D <1137500 1137500 1500000>;
 			clock-latency-ns =3D <140000>;
 		};
 		opp-1400000000 {
 			opp-hz =3D /bits/ 64 <1400000000>;
-			opp-microvolt =3D <1112500>;
+			opp-microvolt =3D <1112500 1112500 1500000>;
 			clock-latency-ns =3D <140000>;
 		};
 		opp-1300000000 {
 			opp-hz =3D /bits/ 64 <1300000000>;
-			opp-microvolt =3D <1062500>;
+			opp-microvolt =3D <1062500 1062500 1500000>;
 			clock-latency-ns =3D <140000>;
 		};
 		opp-1200000000 {
 			opp-hz =3D /bits/ 64 <1200000000>;
-			opp-microvolt =3D <1037500>;
+			opp-microvolt =3D <1037500 1037500 1500000>;
 			clock-latency-ns =3D <140000>;
 		};
 		opp-1100000000 {
 			opp-hz =3D /bits/ 64 <1100000000>;
-			opp-microvolt =3D <1012500>;
+			opp-microvolt =3D <1012500 1012500 1500000>;
 			clock-latency-ns =3D <140000>;
 		};
 		opp-1000000000 {
 			opp-hz =3D /bits/ 64 <1000000000>;
-			opp-microvolt =3D < 987500>;
+			opp-microvolt =3D < 987500 987500 1500000>;
 			clock-latency-ns =3D <140000>;
 		};
 		opp-900000000 {
 			opp-hz =3D /bits/ 64 <900000000>;
-			opp-microvolt =3D < 962500>;
+			opp-microvolt =3D < 962500 962500 1500000>;
 			clock-latency-ns =3D <140000>;
 		};
 		opp-800000000 {
 			opp-hz =3D /bits/ 64 <800000000>;
-			opp-microvolt =3D < 937500>;
+			opp-microvolt =3D < 937500 937500 1500000>;
 			clock-latency-ns =3D <140000>;
 		};
 		opp-700000000 {
 			opp-hz =3D /bits/ 64 <700000000>;
-			opp-microvolt =3D < 912500>;
+			opp-microvolt =3D < 912500 912500 1500000>;
 			clock-latency-ns =3D <140000>;
 		};
 	};
@@ -1097,23 +1097,23 @@
 =

 			opp00 {
 				opp-hz =3D /bits/ 64 <84000000>;
-				opp-microvolt =3D <925000>;
+				opp-microvolt =3D <925000 925000 1400000>;
 			};
 			opp01 {
 				opp-hz =3D /bits/ 64 <111000000>;
-				opp-microvolt =3D <950000>;
+				opp-microvolt =3D <950000 950000 1400000>;
 			};
 			opp02 {
 				opp-hz =3D /bits/ 64 <222000000>;
-				opp-microvolt =3D <950000>;
+				opp-microvolt =3D <950000 950000 1400000>;
 			};
 			opp03 {
 				opp-hz =3D /bits/ 64 <333000000>;
-				opp-microvolt =3D <950000>;
+				opp-microvolt =3D <950000 950000 1400000>;
 			};
 			opp04 {
 				opp-hz =3D /bits/ 64 <400000000>;
-				opp-microvolt =3D <987500>;
+				opp-microvolt =3D <987500 987500 1400000>;
 			};
 		};
 =

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/=
dts/exynos5422-odroid-core.dtsi
index 829147e320e0..9b8de61b0385 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -524,6 +524,8 @@
 				regulator-max-microvolt =3D <1400000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with =3D <&buck2_reg>;
+				regulator-coupled-max-spread =3D <300000>;
 =

 				regulator-state-mem {
 					regulator-off-in-suspend;
@@ -544,6 +546,8 @@
 				regulator-max-microvolt =3D <1500000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with =3D <&buck3_reg>;
+				regulator-coupled-max-spread =3D <300000>;
 =

 				regulator-state-mem {
 					regulator-off-in-suspend;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/=
exynos5800-peach-pi.dts
index 60ca3d685247..c1e38139ce4f 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -257,6 +257,8 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-ramp-delay =3D <12500>;
+				regulator-coupled-with =3D <&buck3_reg>;
+				regulator-coupled-max-spread =3D <300000>;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -269,6 +271,8 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-ramp-delay =3D <12500>;
+				regulator-coupled-with =3D <&buck2_reg>;
+				regulator-coupled-max-spread =3D <300000>;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos58=
00.dtsi
index de639eecc5c9..27789f5f9798 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -22,61 +22,61 @@
 =

 &cluster_a15_opp_table {
 	opp-1700000000 {
-		opp-microvolt =3D <1250000>;
+		opp-microvolt =3D <1250000 1250000 1500000>;
 	};
 	opp-1600000000 {
-		opp-microvolt =3D <1250000>;
+		opp-microvolt =3D <1250000 1250000 1500000>;
 	};
 	opp-1500000000 {
-		opp-microvolt =3D <1100000>;
+		opp-microvolt =3D <1100000 1100000 1500000>;
 	};
 	opp-1400000000 {
-		opp-microvolt =3D <1100000>;
+		opp-microvolt =3D <1100000 1100000 1500000>;
 	};
 	opp-1300000000 {
-		opp-microvolt =3D <1100000>;
+		opp-microvolt =3D <1100000 1100000 1500000>;
 	};
 	opp-1200000000 {
-		opp-microvolt =3D <1000000>;
+		opp-microvolt =3D <1000000 1000000 1500000>;
 	};
 	opp-1100000000 {
-		opp-microvolt =3D <1000000>;
+		opp-microvolt =3D <1000000 1000000 1500000>;
 	};
 	opp-1000000000 {
-		opp-microvolt =3D <1000000>;
+		opp-microvolt =3D <1000000 1000000 1500000>;
 	};
 	opp-900000000 {
-		opp-microvolt =3D <1000000>;
+		opp-microvolt =3D <1000000 1000000 1500000>;
 	};
 	opp-800000000 {
-		opp-microvolt =3D <900000>;
+		opp-microvolt =3D <900000 900000 1500000>;
 	};
 	opp-700000000 {
-		opp-microvolt =3D <900000>;
+		opp-microvolt =3D <900000 900000 1500000>;
 	};
 	opp-600000000 {
 		opp-hz =3D /bits/ 64 <600000000>;
-		opp-microvolt =3D <900000>;
+		opp-microvolt =3D <900000 900000 1500000>;
 		clock-latency-ns =3D <140000>;
 	};
 	opp-500000000 {
 		opp-hz =3D /bits/ 64 <500000000>;
-		opp-microvolt =3D <900000>;
+		opp-microvolt =3D <900000 900000 1500000>;
 		clock-latency-ns =3D <140000>;
 	};
 	opp-400000000 {
 		opp-hz =3D /bits/ 64 <400000000>;
-		opp-microvolt =3D <900000>;
+		opp-microvolt =3D <900000 900000 1500000>;
 		clock-latency-ns =3D <140000>;
 	};
 	opp-300000000 {
 		opp-hz =3D /bits/ 64 <300000000>;
-		opp-microvolt =3D <900000>;
+		opp-microvolt =3D <900000 900000 1500000>;
 		clock-latency-ns =3D <140000>;
 	};
 	opp-200000000 {
 		opp-hz =3D /bits/ 64 <200000000>;
-		opp-microvolt =3D <900000>;
+		opp-microvolt =3D <900000 900000 1500000>;
 		clock-latency-ns =3D <140000>;
 	};
 };
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [2924a93b4c2b1934c0ec59d28f46814a83259f11] Merge branch 'for-v5.5/m=
emory-samsung-dmc-dt' into for-next
git bisect good 2924a93b4c2b1934c0ec59d28f46814a83259f11
# bad: [0bc9c79979ea0b607a0751968840483fd296f6ef] Merge branch 'for-v5.5/me=
mory-samsung-dmc-dt' into for-next
git bisect bad 0bc9c79979ea0b607a0751968840483fd296f6ef
# bad: [0899a480ac658144b1fa351bb880c2858d43f824] ARM: dts: exynos: Add ini=
tial data for coupled regulators for Exynos5422/5800
git bisect bad 0899a480ac658144b1fa351bb880c2858d43f824
# good: [56c126e87e2980d5e2ca5d77b28899f8521af9d7] ARM: dts: exynos: Rename=
 SysRAM node to "sram"
git bisect good 56c126e87e2980d5e2ca5d77b28899f8521af9d7
# first bad commit: [0899a480ac658144b1fa351bb880c2858d43f824] ARM: dts: ex=
ynos: Add initial data for coupled regulators for Exynos5422/5800
---------------------------------------------------------------------------=
----
