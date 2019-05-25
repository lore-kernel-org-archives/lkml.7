Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5290C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 01:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A4A2184E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 01:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="I0Go90WH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfEYBAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 21:00:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33114 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfEYBAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 21:00:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so2274483wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 18:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=mOz/uzoZ8Qq/01C38MyE2pll+zK9QQHgk5S4tOoKkeM=;
        b=I0Go90WH2ayMMN403h5jEjNJssF9yIo9WmYHlS85dA3rNDOu6qzN4V5iBjqwwGq3HS
         jead8J+QAD2i06izMX5BXqXKHoJAu1mM5XcNsFmxHKUsFvABKIAiL4dPumEsjKLJbqMh
         XGvj+hN8LzZevfr98yQ8tV9LaX2pY5Y9fGjtEVoFDs6w78hu32wTH5TfjLc6B3+AUph5
         TXkFxkRam/AE8KCZ23Ru7Q37hbrDu12SYZn3jGW5nevPOg2ip9Tp1F1YF7537fw1A5CM
         wpv5KQSD50MFYOUJ86n1v+Ek1HaBsvdOLbHURsaGX+TwRzuNofuBo1WNzj9ykbdCB1L+
         ebCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=mOz/uzoZ8Qq/01C38MyE2pll+zK9QQHgk5S4tOoKkeM=;
        b=YqwclfoLSmxpTRLklPqkKtz8k1iVJlVX3dsFvcv9XicFU2HXCdhwOKaezRUkh4p2K4
         KsKeVmPXfeHLuJXFUmwg/wG3PTFV56CBExfbFniq8Yo+m3pHSJlhz71qLjtN24sxYx4z
         SfnmygbGGYkRGMV9gFV+gjnObeDbf9PnGn7KT3SbuqFhxtFf2TI8W5NjAG2QZC2simDF
         +CqSzqogGFIjy10DodrV/flX6LroIQSE9mZlkEHZQ98PoLdsg4v6Hbd/N2fFjk9hIz5t
         O5v1iPxsrosNmIrmg5fqxpQUg/3AFJdzRuaoxPtAdxOTSPg+aBH0zWWSYpgFoRUqUA3s
         V8Og==
X-Gm-Message-State: APjAAAUiFzzU6OzmDjdTb/h7DK4C4b2aRGcp88m9CUxT+IU4QuiwzC5J
        5VFWNqm5yxSA9hB/c/WX7Svl3A==
X-Google-Smtp-Source: APXvYqz+d5B1uhbeZFmzCKr8tLpKRfnQnchVdM5lugUMtvpcsjrJqEChi+nfW/oijKLRaXuyKzf0EQ==
X-Received: by 2002:a7b:ca44:: with SMTP id m4mr1572416wml.160.1558746006753;
        Fri, 24 May 2019 18:00:06 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id h14sm3343469wrt.11.2019.05.24.18.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 18:00:06 -0700 (PDT)
Message-ID: <5ce89396.1c69fb81.16e3d.2c5c@mx.google.com>
Date:   Fri, 24 May 2019 18:00:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: clk
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Branch: clk-next
X-Kernelci-Kernel: v5.2-rc1-4-gf191a146bcee
Subject: clk/clk-next boot bisection: v5.2-rc1-4-gf191a146bcee on
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

clk/clk-next boot bisection: v5.2-rc1-4-gf191a146bcee on meson-g12a-x96-max

Summary:
  Start:      f191a146bcee Merge branch 'clk-fixes' into clk-next
  Details:    https://kernelci.org/boot/id/5ce8391259b514c80a7a362c
  Plain log:  https://storage.kernelci.org//clk/clk-next/v5.2-rc1-4-gf191a1=
46bcee/arm64/defconfig+CONFIG_RANDOMIZE_BASE=3Dy/gcc-8/lab-baylibre/boot-me=
son-g12a-x96-max.txt
  HTML log:   https://storage.kernelci.org//clk/clk-next/v5.2-rc1-4-gf191a1=
46bcee/arm64/defconfig+CONFIG_RANDOMIZE_BASE=3Dy/gcc-8/lab-baylibre/boot-me=
son-g12a-x96-max.html
  Result:     11a7bea17c9e arm64: dts: meson: g12a: add pinctrl support con=
trollers

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       clk
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
  Branch:     clk-next
  Target:     meson-g12a-x96-max
  CPU arch:   arm64
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     defconfig+CONFIG_RANDOMIZE_BASE=3Dy
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
# good: [62e59c4e69b3cdbad67e3c2d49e4df4cfe1679e3] clk: Remove io.h from cl=
k-provider.h
git bisect good 62e59c4e69b3cdbad67e3c2d49e4df4cfe1679e3
# bad: [f191a146bcee3dfd62a501432d22a55ef67858b4] Merge branch 'clk-fixes' =
into clk-next
git bisect bad f191a146bcee3dfd62a501432d22a55ef67858b4
# good: [e7a1414f9dc3498c4c35b9ca266d539e8bccab53] Merge tag 'media/v5.1-2'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good e7a1414f9dc3498c4c35b9ca266d539e8bccab53
# good: [cccd559e98c05b669bdc37b01802f920cff1d6dd] Merge tag 'fbdev-v5.2' o=
f git://github.com/bzolnier/linux
git bisect good cccd559e98c05b669bdc37b01802f920cff1d6dd
# good: [a455eda33faafcaac1effb31d682765b14ef868c] Merge branch 'linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
git bisect good a455eda33faafcaac1effb31d682765b14ef868c
# bad: [e8a1d70117116c8d96c266f0b99e931717670eaf] Merge tag 'armsoc-dt' of =
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad e8a1d70117116c8d96c266f0b99e931717670eaf
# bad: [64f32d9d30063149eb10d7be3a23b5e1f44247c8] Merge tag 'renesas-arm64-=
dt2-for-v5.2' of https://git.kernel.org/pub/scm/linux/kernel/git/horms/rene=
sas into arm/dt
git bisect bad 64f32d9d30063149eb10d7be3a23b5e1f44247c8
# bad: [da9a4c3d32eb699db68dd8f3e633ec035879d818] Merge tag 'omap-for-v5.2/=
dt-ti-sysc-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/=
linux-omap into arm/dt
git bisect bad da9a4c3d32eb699db68dd8f3e633ec035879d818
# bad: [bbf7499dc033831ae91125a88a062910cdc62cf2] Merge tag 'aspeed-5.2-dev=
icetree' of git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed into =
arm/dt
git bisect bad bbf7499dc033831ae91125a88a062910cdc62cf2
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
