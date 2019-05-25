Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9182C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973C22168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="arDkbo+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfEYOz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 10:55:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52822 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfEYOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 10:55:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so12092118wmm.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=EuYIB6cW2iyL4GLrUb+ErE4HZQ0an8nT6D+WzTs0wj4=;
        b=arDkbo+ddHrJkuxsGH5jgsnxZX1bB6hh0JtUZoGqILsdaqzNYjFCoEVzZ/BiEJ/cS5
         DkVVzTIvFux2OYnmgBo2hKGgdftqu1c26sypBZiie2p0G2y7tKoRRtJs4I9brTGz1CFQ
         soxQGM3PHrSEljL7v2gz8SP0thrvVE4QivtCOwNI7aRS4p27FrjJL8iGCKvB4/U4Ha2M
         +fv5EY8w6OskUYyZSwKojyo/urWrxq4hRfdG2PHv/Pr2waFzarRncQ8lRzfL5ZSZC3Tp
         zkm/ysRhVS7MSnyWRjn0U7SkXEyaZl2MgA7yT4PbKdCg+tyBLocdF3oWJS1PbxwBF90R
         lVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=EuYIB6cW2iyL4GLrUb+ErE4HZQ0an8nT6D+WzTs0wj4=;
        b=Mp5mZjSOsjjlNpzdUVU5Eo0oNPiXcbRZla5+o3MG3urlWA+yVszpRgg7IBX1lzJUg7
         BRim/Dgd7yyUPmteGZw+BjYJqfCfuWR4qsczFJ/zClrdqzZxWB3h+IcI3yxe/7FMGRZO
         Bd5MFQPH5Z+4b5DYQzqSfcD4d5Z2K2/YSATjZi3BbZmVYXVbPjpa3W+0o4GzanffzLub
         wY7V62vW14WOJpFTmIgAKtg7X9QW68nkoLMF6ngutHDvi+Egb6anoUbXgDtLyn9VlWAB
         exg3MmA92idX4WZxfraWAfppiaP/PCYEFKoYGP6+6J8hiBMOZCDFO2KkKvOsJaaNd2X8
         O1OA==
X-Gm-Message-State: APjAAAWaKzwXrQreIzyvHm0vkIg4SjiTSG41Q4BEoXxoav3VYKJwtDzx
        whN/u3/1WgEMZuMc7wFUuB+H2A==
X-Google-Smtp-Source: APXvYqxXR7WXZZ1TwOzelpEfXavjk8aSfM4cLDNK9nnX/lJskdY6r5plLpg7Y0tmuGpLGMB2tNPVqQ==
X-Received: by 2002:a1c:1bc9:: with SMTP id b192mr3719972wmb.27.1558796154553;
        Sat, 25 May 2019 07:55:54 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id p10sm2028727wrw.6.2019.05.25.07.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 07:55:53 -0700 (PDT)
Message-ID: <5ce95779.1c69fb81.df149.ac4a@mx.google.com>
Date:   Sat, 25 May 2019 07:55:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: mainline
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Branch: master
X-Kernelci-Kernel: v5.2-rc1-357-g7fbc78e3155a
Subject: mainline/master boot bisection: v5.2-rc1-357-g7fbc78e3155a on
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

mainline/master boot bisection: v5.2-rc1-357-g7fbc78e3155a on meson-g12a-x9=
6-max

Summary:
  Start:      7fbc78e3155a Merge tag 'for-linus-20190524' of git://git.kern=
el.dk/linux-block
  Details:    https://kernelci.org/boot/id/5ce8a65059b51433287a363c
  Plain log:  https://storage.kernelci.org//mainline/master/v5.2-rc1-357-g7=
fbc78e3155a/arm64/defconfig/gcc-8/lab-baylibre/boot-meson-g12a-x96-max.txt
  HTML log:   https://storage.kernelci.org//mainline/master/v5.2-rc1-357-g7=
fbc78e3155a/arm64/defconfig/gcc-8/lab-baylibre/boot-meson-g12a-x96-max.html
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
# bad: [7fbc78e3155a0c464bd832efc07fb3c2355fe9bd] Merge tag 'for-linus-2019=
0524' of git://git.kernel.dk/linux-block
git bisect bad 7fbc78e3155a0c464bd832efc07fb3c2355fe9bd
# bad: [311f71281ff4b24f86a39c60c959f485c68a6d36] Merge tag 'for-5.2/dm-cha=
nges-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/lin=
ux-dm
git bisect bad 311f71281ff4b24f86a39c60c959f485c68a6d36
# bad: [be058ba65d9e43f40d31d9b16b99627f0a20de1b] Merge tag 'imx-dt-5.2' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/dt
git bisect bad be058ba65d9e43f40d31d9b16b99627f0a20de1b
# bad: [7996313656b83ba516a1546d51f08f1a0fab4e06] Merge tag 'omap-for-v5.2/=
dt-am3-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linu=
x-omap into arm/dt
git bisect bad 7996313656b83ba516a1546d51f08f1a0fab4e06
# bad: [2140eaf2f46faf2627ec030d7cabf2dda2cb546b] Merge tag 'stm32-dt-for-v=
5.2-1' of git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32 into =
arm/dt
git bisect bad 2140eaf2f46faf2627ec030d7cabf2dda2cb546b
# bad: [1a88083b9349b8310b25d9a9a96802ee4447e6b9] Merge tag 'v5.2-rockchip-=
dts64-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockc=
hip into arm/dt
git bisect bad 1a88083b9349b8310b25d9a9a96802ee4447e6b9
# bad: [1c93235a6d92deaab38bbb1cfc764b0757331ebb] Merge tag 'amlogic-dt' of=
 https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic into=
 arm/dt
git bisect bad 1c93235a6d92deaab38bbb1cfc764b0757331ebb
# bad: [ff4f8b6cab5885ebc2c6b21fd058db8544e2eebb] arm64: dts: meson: g12a: =
Add UART A, B & C nodes and pins
git bisect bad ff4f8b6cab5885ebc2c6b21fd058db8544e2eebb
# good: [965c827ac37e71f76d3ac55c75ac08909f2a4eed] arm64: dts: meson: g12a:=
 add efuse
git bisect good 965c827ac37e71f76d3ac55c75ac08909f2a4eed
# bad: [11a7bea17c9e0a36daab934d83e15a760f402147] arm64: dts: meson: g12a: =
add pinctrl support controllers
git bisect bad 11a7bea17c9e0a36daab934d83e15a760f402147
# good: [b019f4a4199f865b054262ff78f606ca70f7b981] arm64: dts: meson: g12a:=
 Add AO Clock + Reset Controller support
git bisect good b019f4a4199f865b054262ff78f606ca70f7b981
# first bad commit: [11a7bea17c9e0a36daab934d83e15a760f402147] arm64: dts: =
meson: g12a: add pinctrl support controllers
---------------------------------------------------------------------------=
----
