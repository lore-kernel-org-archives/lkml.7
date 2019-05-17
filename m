Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80967C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415FC2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="w1FyLLhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfEQDvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 23:51:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33197 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfEQDvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 23:51:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so5555441wrx.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=DdVR87Z6W71pfOZ9P0FpXBOiYmKNFBCn+LbvQzi7wlQ=;
        b=w1FyLLhpMw881IOcASEaUGIdwSeVjjeUpmN6yCOffrsAUamFbjBQP0AfGgBcVoqBFc
         ZfA0dJG1nP3k3iNR8TfTaRpKT81Ga/DjhFHOqTUtz6NxarbpgRBOlyngCOVwH+LueCvx
         bFqN7ytdmAzSxQtlMtMbVapKAvHm96lq+Q9s6b0cXQMp92dJIhvIpNGqC7ZOhL0U3ybn
         i3gn292MF7jkhlq+ghIuR5gXeMX6OrUtO3/FH3Ti9CdwvqAqkSCel8Td8gnYwDhdJt0e
         X8BxN9zrwVqCIEfsC9xg8kon/FwYJFizq3n+8zENJj78X35eL4+E1Cl79AN+e8xWryst
         an4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=DdVR87Z6W71pfOZ9P0FpXBOiYmKNFBCn+LbvQzi7wlQ=;
        b=eApymbgTeCqEVyjrx6fNTJT4pkathQ7NzVjMbkIU1Vko1ohAYV4fLukTEq0VxUz8MN
         lCDw0x3XKOFhn2igQnOMXFeuvvab7FnJpSLiA7W9Hy4jOnRTu//3BAeT9OCcrzjgCo6o
         zsZcEhCNrfjtZqx9/U0d9r53ljdbxOOYJWLixs2DxRbdneFnibJp/5N9GHqkQ+3GrRdw
         De5MLNYWy0k5e5W/LCUowVr0iL0uwktjnHZEtyqQcSkU3xcB06TT5UOYQKbN8dk79+fL
         r4Netaz0wanZg6L1fc/QLRfKGVOhsYIeCNua1MIUIwN/u8lrLMDPc4ARCcXnPqbm0WeF
         2HEA==
X-Gm-Message-State: APjAAAXYzXaYKotUeBABamA32ofGCL6yf1dvwQBlM1iW3KTnR2RWjpfB
        Mompph9L56zA6a/BDIKal8qBWA==
X-Google-Smtp-Source: APXvYqzyfhaTEuEHD7b4qavb2NnY+aWioXWHYEipSR9Qye9wu3iFt5gT+TIKeBtfEgyF6JOBfMlrEw==
X-Received: by 2002:a5d:62c2:: with SMTP id o2mr13569428wrv.254.1558065112562;
        Thu, 16 May 2019 20:51:52 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id v1sm7371785wrd.47.2019.05.16.20.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 20:51:52 -0700 (PDT)
Message-ID: <5cde2fd8.1c69fb81.8f42e.b6dc@mx.google.com>
Date:   Thu, 16 May 2019 20:51:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: mainline
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Branch: master
X-Kernelci-Kernel: v5.1-12065-g8c05f3b965da
Subject: mainline/master boot bisection: v5.1-12065-g8c05f3b965da on
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

mainline/master boot bisection: v5.1-12065-g8c05f3b965da on meson-g12a-x96-=
max

Summary:
  Start:      8c05f3b965da Merge tag 'for-linus' of git://git.armlinux.org.=
uk/~rmk/linux-arm
  Details:    https://kernelci.org/boot/id/5cddbf2e59b51487157a362b
  Plain log:  https://storage.kernelci.org//mainline/master/v5.1-12065-g8c0=
5f3b965da/arm64/defconfig/gcc-8/lab-baylibre/boot-meson-g12a-x96-max.txt
  HTML log:   https://storage.kernelci.org//mainline/master/v5.1-12065-g8c0=
5f3b965da/arm64/defconfig/gcc-8/lab-baylibre/boot-meson-g12a-x96-max.html
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
# bad: [8c05f3b965da14e7790711026b32cc10a4c06213] Merge tag 'for-linus' of =
git://git.armlinux.org.uk/~rmk/linux-arm
git bisect bad 8c05f3b965da14e7790711026b32cc10a4c06213
# bad: [b45da609a02460c6a34c395f03f891f1fb2a021a] Merge tag 'imx-bindings-5=
.2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into ar=
m/dt
git bisect bad b45da609a02460c6a34c395f03f891f1fb2a021a
# bad: [a41332dd5e2ac56b0b6eb0959d8828bfe0d6a4ad] Merge tag 'socfpga_dts_up=
dates_for_v5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/l=
inux into arm/dt
git bisect bad a41332dd5e2ac56b0b6eb0959d8828bfe0d6a4ad
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
