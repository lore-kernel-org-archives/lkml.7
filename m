Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2402C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 07:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D2F2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 07:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="LCHDHE9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfERHcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 03:32:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51125 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfERHco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 03:32:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id f204so8828160wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 00:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=F7rW9WR+hkCVM8z35uvk7p1boAzUi+cOuWV+wfxrZHg=;
        b=LCHDHE9Gb2lzCFWTyFebacpMQftGQo+veVRAK9HIA5heN6aUKqGXbkTiqAYCvHWF6w
         CesFpgTq8tzMOUNw034xpKljI5L34idjQvfSJdY9DODpq/S7qtWviNQeaRwYIlWf1mNC
         8hLghlWeRjJXbv4Ct0ev5fu/IgSNKMrNpBLsLn2amNBA/U8GYyyhK95rMiZHnGmtXJWW
         LOoIpej/L5DpTsL7dhgj2nwfpZ0yXv/QC04EJaIaYTPftJS4+ImI3rI5zNobLLwhR8Z5
         iGZeIMz2mv/iDovAuhasxRcRWphwIPNJF1hZIg11niQsp94uEjZ1zclQDk2Svxwahn3K
         GmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=F7rW9WR+hkCVM8z35uvk7p1boAzUi+cOuWV+wfxrZHg=;
        b=o75iydz4T9Xud1yOHmv+tEeF9rJlMa8o+x51E+oeXF2xX51cVsOYHHa0M3RJf87bjJ
         5IJWxcLlcpHijlwBeabER7OnUz2XDbs9ovMtC19/PCwNeIKXQdOMX/kZN1hht6KqOmol
         98JLLS3Iu/3Q2YmK8YRO5fA8DJq+MbDL5FC08WDJf9OBoSIhSJqdL3Al20bH/+4Nujt/
         pItYQpEvMtNyxJCX3hAOmYnmEnGqCL1SNZog9+V3oNiTkHTTd/V2qig1IONOU2ppPisc
         rBgdgX4/3vqaWOHpF5X+84iBsEAT8yO5MV8/UlVh1VsgSxvc9tcQo/JlZGqm6i9r3Nd4
         y77A==
X-Gm-Message-State: APjAAAUKyh8mEq8FoQmQK7tgOU3tUc7E6xAn/gTyaEE2XngebIOLqU/4
        mVlDUrz/Lt8fvUUpfEfp5m90Xg==
X-Google-Smtp-Source: APXvYqwzOs9zWoOynUSNBQBi9WKTk4BqTL3+X4aIZAQv2sWvAzSx6S0uTZK4di0cFT5VaCDV/Pu3Yg==
X-Received: by 2002:a1c:3d87:: with SMTP id k129mr8365984wma.21.1558164761492;
        Sat, 18 May 2019 00:32:41 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id c131sm11669555wma.31.2019.05.18.00.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 00:32:40 -0700 (PDT)
Message-ID: <5cdfb518.1c69fb81.7d28c.30a0@mx.google.com>
Date:   Sat, 18 May 2019 00:32:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: mainline
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Branch: master
X-Kernelci-Kernel: v5.1-12511-g72cf0b07418a
Subject: mainline/master boot bisection: v5.1-12511-g72cf0b07418a on
 meson-g12a-x96-max
To:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>, broonie@kernel.org,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com, Jerome Brunet <jbrunet@baylibre.com>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org,
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
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

mainline/master boot bisection: v5.1-12511-g72cf0b07418a on meson-g12a-x96-=
max

Summary:
  Start:      72cf0b07418a Merge tag 'sound-fix-5.2-rc1' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/tiwai/sound
  Details:    https://kernelci.org/boot/id/5cdf4cc359b514ce467a362a
  Plain log:  https://storage.kernelci.org//mainline/master/v5.1-12511-g72c=
f0b07418a/arm64/defconfig/gcc-8/lab-baylibre/boot-meson-g12a-x96-max.txt
  HTML log:   https://storage.kernelci.org//mainline/master/v5.1-12511-g72c=
f0b07418a/arm64/defconfig/gcc-8/lab-baylibre/boot-meson-g12a-x96-max.html
  Result:     11a7bea17c9e arm64: dts: meson: g12a: add pinctrl support con=
trollers

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       mainline
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git
  Branch:     master
  Target:     meson-g12a-x96-max
  CPU arch:   arm64
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 11a7bea17c9e0a36daab934d83e15a760f402147
Author: Jerome Brunet <jbrunet@baylibre.com>
Date:   Mon Mar 18 10:58:45 2019 +0100

    arm64: dts: meson: g12a: add pinctrl support controllers
    =

    Add the peripheral and always-on pinctrl controllers to the g12a soc.
    =

    Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
    Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
    Signed-off-by: Kevin Hilman <khilman@baylibre.com>

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/=
dts/amlogic/meson-g12a.dtsi
index abfa167751af..5e07e4ca3f4b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -104,6 +104,29 @@
 				#address-cells =3D <2>;
 				#size-cells =3D <2>;
 				ranges =3D <0x0 0x0 0x0 0x34400 0x0 0x400>;
+
+				periphs_pinctrl: pinctrl@40 {
+					compatible =3D "amlogic,meson-g12a-periphs-pinctrl";
+					#address-cells =3D <2>;
+					#size-cells =3D <2>;
+					ranges;
+
+					gpio: bank@40 {
+						reg =3D <0x0 0x40  0x0 0x4c>,
+						      <0x0 0xe8  0x0 0x18>,
+						      <0x0 0x120 0x0 0x18>,
+						      <0x0 0x2c0 0x0 0x40>,
+						      <0x0 0x340 0x0 0x1c>;
+						reg-names =3D "gpio",
+							    "pull",
+							    "pull-enable",
+							    "mux",
+							    "ds";
+						gpio-controller;
+						#gpio-cells =3D <2>;
+						gpio-ranges =3D <&periphs_pinctrl 0 0 86>;
+					};
+				};
 			};
 =

 			hiu: bus@3c000 {
@@ -150,6 +173,25 @@
 					clocks =3D <&xtal>, <&clkc CLKID_CLK81>;
 					clock-names =3D "xtal", "mpeg-clk";
 				};
+
+				ao_pinctrl: pinctrl@14 {
+					compatible =3D "amlogic,meson-g12a-aobus-pinctrl";
+					#address-cells =3D <2>;
+					#size-cells =3D <2>;
+					ranges;
+
+					gpio_ao: bank@14 {
+						reg =3D <0x0 0x14 0x0 0x8>,
+						      <0x0 0x1c 0x0 0x8>,
+						      <0x0 0x24 0x0 0x14>;
+						reg-names =3D "mux",
+							    "ds",
+							    "gpio";
+						gpio-controller;
+						#gpio-cells =3D <2>;
+						gpio-ranges =3D <&ao_pinctrl 0 0 15>;
+					};
+				};
 			};
 =

 			sec_AO: ao-secure@140 {
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [a455eda33faafcaac1effb31d682765b14ef868c] Merge branch 'linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
git bisect good a455eda33faafcaac1effb31d682765b14ef868c
# bad: [72cf0b07418a9c8349aa9137194b1ccba6e54a9d] Merge tag 'sound-fix-5.2-=
rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect bad 72cf0b07418a9c8349aa9137194b1ccba6e54a9d
# bad: [89f4f128ea535acaabf7d5bddc30ddda0fb7a70a] Merge tag 'imx-dt64-5.2' =
of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/dt
git bisect bad 89f4f128ea535acaabf7d5bddc30ddda0fb7a70a
# bad: [f5d6e8c077915c84d8b544bc02e3df2f0910c193] Merge tag 'sunxi-dt-for-5=
.2' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into arm=
/dt
git bisect bad f5d6e8c077915c84d8b544bc02e3df2f0910c193
# bad: [6d918e09331e63593b7827ea1a718f0da03b7fb0] Merge tag 'omap-for-v5.2/=
dt-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-om=
ap into arm/dt
git bisect bad 6d918e09331e63593b7827ea1a718f0da03b7fb0
# bad: [2fe743c27f064d637df7f989333c153f8d4b0e65] Merge tag 'renesas-arm64-=
dt-for-v5.2' of https://git.kernel.org/pub/scm/linux/kernel/git/horms/renes=
as into arm/dt
git bisect bad 2fe743c27f064d637df7f989333c153f8d4b0e65
# bad: [f6f9683c5aedff214433fa130e67a79f08a47fdb] Merge tag 'v5.2-rockchip-=
dts32-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockc=
hip into arm/dt
git bisect bad f6f9683c5aedff214433fa130e67a79f08a47fdb
# bad: [e2cffeb398f4830b004774444809ee256b9bc653] arm64: dts: meson-g12a: A=
dd CMA reserved memory
git bisect bad e2cffeb398f4830b004774444809ee256b9bc653
# bad: [11a7bea17c9e0a36daab934d83e15a760f402147] arm64: dts: meson: g12a: =
add pinctrl support controllers
git bisect bad 11a7bea17c9e0a36daab934d83e15a760f402147
# good: [7e09092aee006b21d830b99f8498b5640b8711f6] arm64: dts: meson-gxl-s9=
05d-phicomm-n1: add status LED
git bisect good 7e09092aee006b21d830b99f8498b5640b8711f6
# good: [965c827ac37e71f76d3ac55c75ac08909f2a4eed] arm64: dts: meson: g12a:=
 add efuse
git bisect good 965c827ac37e71f76d3ac55c75ac08909f2a4eed
# good: [b019f4a4199f865b054262ff78f606ca70f7b981] arm64: dts: meson: g12a:=
 Add AO Clock + Reset Controller support
git bisect good b019f4a4199f865b054262ff78f606ca70f7b981
# first bad commit: [11a7bea17c9e0a36daab934d83e15a760f402147] arm64: dts: =
meson: g12a: add pinctrl support controllers
---------------------------------------------------------------------------=
----
