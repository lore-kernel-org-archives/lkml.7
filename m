Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC42C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A7020651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f16NV0P9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfC0RkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:40:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40151 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfC0RkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:40:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so15207803ljq.7;
        Wed, 27 Mar 2019 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=VgzStw81OpeYsrcSyrvYdNj+RtSSVzM62vsRpY1n4ts=;
        b=f16NV0P9nKq/VuqvFvfmWSzCBgdlwblE2uAf3AhTH7cofUvU9DvrpJbBA/ka1EI4Gf
         wVlcfDB77pArofBL66j2wBugOsM8/l5F10fRrs9AJ2a+i0I02avAIxuHHm8aLFhLzrBV
         M9jcQ/JskZrErX6NCvolXf1gozSY6921JkhYVutg+OcndXt3jyZzDINtOL9GONa2X95E
         4vOywVHhDClrlDp8zWSAOzv3d3azbqlBj2ma+WDcO6zRh/gaZenLtQYZlXxKEqsYl0mG
         mO6mIDFxZY0i5Tst/ym6gCC5CW4aXQYeujOAt659z7/Z7M6NCsnbCOA88a9RsdJfSh8a
         CfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=VgzStw81OpeYsrcSyrvYdNj+RtSSVzM62vsRpY1n4ts=;
        b=qnqEkcDbxqQWH+/EYXBNxftDoeHPpoJs5Jal7ZPaUTHAMRnCA1oG8NtFXfOIkKDyqx
         VV2Dr0xeCpmvDYo4doSihlfj6vVW5cUxpEZJi+HkHxMFsJcsJwjgzh6rHq2b8m08C3Jn
         Yf9vlDbAByp4oHwk3pqVbrLh99fFGLuRLDjFCXuOXEFIjv04FdzOGY4bZr0gHmrOxzuA
         p/HXe4bck6rgucJyZzwmM7ptyHokzV06SGwYhNL3JaL/nVQ6dSa3uE61q1Z+sNya15dM
         CvzWLRkVc7p1MusOk0AH1+ZgY36eCUtlaCIYJFBgr3baC+v1lEhQ+a7CvjWBYg2l5NSI
         k7Eg==
X-Gm-Message-State: APjAAAUiJPTU4FePN+VENEm3vuTR+fxIGD+pnBA/unY0j0W6zerxM2DV
        69REoW5ZAatwWGYzKjIIib8=
X-Google-Smtp-Source: APXvYqzXPSH4OAYNMrjJGLO0gw5Hz0c3S+VeDtg1EIPkL10XuQT64uDtSktvMpCFyHwXMc/6JHC4tg==
X-Received: by 2002:a2e:8582:: with SMTP id b2mr6102819lji.24.1553708403352;
        Wed, 27 Mar 2019 10:40:03 -0700 (PDT)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id v11sm2048455lfb.68.2019.03.27.10.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 10:40:02 -0700 (PDT)
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Duan <fugang.duan@nxp.com>
From:   Igor Plyatov <plyatov@gmail.com>
Subject: Issues with i.MX SPI DMA transfers
Message-ID: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
Date:   Wed, 27 Mar 2019 20:40:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developers,

please, help to resolve two issues with SPI DMA transfers at i.MX6Q 
platform.

First issue is
  [ 4465.008003] spi_master spi0: I/O Error in DMA RX

Second issue is duplication for one of received bytes.

Probably, these issues related to each one.

I think suspicious code is one of files linux/drivers/spi/spi-imx.c, 
linux/drivers/dma/imx-sdma.c, /lib/firmware/imx/sdma/sdma-imx6q.bin.


My environment
--------------

Linux kernel: 5.1.0-rc2 from Linus mainline master branch, where last 
commit is 14c741de93861749dfb60b4964028541f5c506ca from Tue Mar 26 
14:25:48 2019 -0700.

File "drivers/dma/imx-sdma.c" has been patched by me, because I have 
kernel errors "imx-sdma 20ec000.sdma: Timeout waiting for CH0 ready".
Where patch was taken from email of Andy Duan with Subject "[PATCH v2 
dmaengine 1/1] dmaengine: imx-sdma: revert: add clock ratio 1:1 check"
E-mail can be found at https://marc.info/?l=dmaengine&m=155322581416268&w=2.

Issues exists in Linux kernel 4.9 too.

SOM (System On Module) is from Toradex and called "Apalis iMX6 Quad 2GB 
IT V1.1C". It is installed onto custom carrier board. I think, type of 
carrier board is not important, because issue happens even without real 
SPI slaves (with SPI loopback enabled).
root@cr7:~# cat /proc/cpuinfo
processor    : 0
model name    : ARMv7 Processor rev 10 (v7l)
BogoMIPS    : 6.00
Features    : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
CPU implementer    : 0x41
CPU architecture: 7
CPU variant    : 0x2
CPU part    : 0xc09
CPU revision    : 10

processor    : 1
model name    : ARMv7 Processor rev 10 (v7l)
BogoMIPS    : 6.00
Features    : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
CPU implementer    : 0x41
CPU architecture: 7
CPU variant    : 0x2
CPU part    : 0xc09
CPU revision    : 10

processor    : 2
model name    : ARMv7 Processor rev 10 (v7l)
BogoMIPS    : 6.00
Features    : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
CPU implementer    : 0x41
CPU architecture: 7
CPU variant    : 0x2
CPU part    : 0xc09
CPU revision    : 10

processor    : 3
model name    : ARMv7 Processor rev 10 (v7l)
BogoMIPS    : 6.00
Features    : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
CPU implementer    : 0x41
CPU architecture: 7
CPU variant    : 0x2
CPU part    : 0xc09
CPU revision    : 10

Hardware    : Freescale i.MX6 Quad/DualLite (Device Tree)
Revision    : 0000
Serial        : 05154315

Linux host acts as SPI master, where different /dev/spidevX.Y files used 
for testing.

The tools/spi/spidev_test.c from Linux kernel sources, compiled and used 
to test SPI driver from user-space.
I use latest spidev_test.c (it does not change from 4.20.17 up to 
5.1.0-rc2).

My custom Device Tree contains description for spidev devices at 3 SPI 
bus, with 3 Chip Selects each:
  &ecspi1 { // SPI C for Option boards.
     status = "okay";
     pinctrl-names = "default";
     pinctrl-0 = <&pinctrl_ecspi1>;
     cs-gpios = <&gpio5 25 GPIO_ACTIVE_HIGH>,
            <&gpio4 11 GPIO_ACTIVE_HIGH>,
            <&gpio3 25 GPIO_ACTIVE_HIGH>;

     spidev0_0: spidev@0_0 {
         status = "okay";
         compatible = "rohm,dh2228fv";
         reg = <0>;
         spi-max-frequency = <40000000>;
     };
     spidev0_1: spidev@0_1 {
         status = "okay";
         compatible = "rohm,dh2228fv";
         reg = <1>;
         spi-max-frequency = <40000000>;
     };
     spidev0_2: spidev@0_2 {
         status = "okay";
         compatible = "rohm,dh2228fv";
         reg = <2>;
         spi-max-frequency = <40000000>;
     };
  };
  &ecspi2 { // SPI A for DSP.
     status = "okay";
     pinctrl-names = "default";
     pinctrl-0 = <&pinctrl_ecspi2>;
     cs-gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>,
            <&gpio2 27 GPIO_ACTIVE_HIGH>,
            <&gpio3 24 GPIO_ACTIVE_HIGH>;

     spidev1_0: spidev@1_0 {
         status = "okay";
         compatible = "rohm,dh2228fv";
         reg = <0>;
         spi-max-frequency = <40000000>;
     };
     spidev1_1: spidev@1_1 {
         status = "okay";
         compatible = "rohm,dh2228fv";
         reg = <1>;
         spi-max-frequency = <40000000>;
     };
     spidev1_2: spidev@1_2 {
         status = "okay";
         compatible = "rohm,dh2228fv";
         reg = <2>;
         spi-max-frequency = <40000000>;
     };
  };
  &ecspi5 { // SPI B for DSP.
     status = "okay";
     pinctrl-names = "default";
     pinctrl-0 = <&pinctrl_ecspi5>;
     cs-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>,
            <&gpio1 19 GPIO_ACTIVE_HIGH>,
            <&gpio1 21 GPIO_ACTIVE_HIGH>;

     spidev4_0: spidev@4_0 {
         status = "okay";
         compatible = "rohm,dh2228fv";
         reg = <0>;
         spi-max-frequency = <40000000>;
     };
     spidev4_1: spidev@4_1 {
         status = "okay";
         compatible = "rohm,dh2228fv";
         reg = <1>;
         spi-max-frequency = <40000000>;
     };
     spidev4_2: spidev@4_2 {
         status = "okay";
         compatible = "rohm,dh2228fv";
         reg = <2>;
         spi-max-frequency = <40000000>;
     };
  };

This gives spidev files:
* /dev/spidev0.0;
* /dev/spidev0.1;
* /dev/spidev0.2;
* /dev/spidev1.0;
* /dev/spidev1.1;
* /dev/spidev1.2;
* /dev/spidev4.0;
* /dev/spidev4.1;
* /dev/spidev4.2


Testing method
--------------

insmod /virt-dma.ko
insmod /imx-sdma.ko
insmod /spi-bitbang.ko
insmod /spi-imx.ko
insmod /spidev.ko

Kernel says
  [  310.818010] fsl-ssi-dai 2028000.ssi: No cache defaults, reading 
back from HW
  [  310.830859] imx-sdma 20ec000.sdma: loaded firmware 3.3
  [  310.865237] imx-sgtl5000 sound: sgtl5000 <-> 2028000.ssi mapping ok
  [  310.875560] spi_imx 2008000.spi: probed
  [  310.883855] spi_imx 200c000.spi: probed
  [  310.899010] spi_imx 2018000.spi: probed

Real SPI slave devices unused, because SPI loopback enabled.
SPI mode: 0;
Bits per word: 8;
Transfer size: 512 bytes;
SPI speeds: 100 kHz and 10 MHz;

Test commands are
  spidev_test -D /dev/spidevX.Y -s 10000000 -b 8 -S 512 -I 1000000 -l
where different devices used.


Description of issues
---------------------


Issue #1
========

Sometimes, during test I see error

  root@cr7:~# spidev_test -D /dev/spidev0.1 -s 100000 -b 8 -S 512 -I 1 -v -l
  spi mode: 0x20
  bits per word: 8
  max speed: 100000 Hz (100 KHz)
  [ 4465.008003] spi_master spi0: I/O Error in DMA RX
  [ 4465.012681] spidev spi0.1: SPI transfer failed: -110
  [ 4465.017676] spi_master spi0: failed to transfer one message from queue
  can't send spi message: Connection timed out
  Aborted (core dumped)

Issue is hard to reproduce, because it can arise after unpredictable 
period of time.
Once, issue was catched immediately after start of test.
It is unclear - what can increase repeatability of issue.


Issue #2
========

Periodically, I see distortion of received data. One of received bytes 
is duplicated and it shifts next bytes and throws last byte.
Probability to catch this issue increase if parallel test commands 
executed for different SPI devices.
Also, probability increase with increase of SPI speed.

If testing command execute alone, then issue arise after ~2 minutes.
If 2 testing commands execute in parallel for two /dev/spidev files, 
then issue can arise after some seconds.

Issue looks as following:

  root@cr7:~# spidev_test -D /dev/spidev4.2 -s 10000000 -b 8 -S 512 -I 
1000000 -l
  spi mode: 0x20
  bits per word: 8
  max speed: 10000000 Hz (10000 KHz)
  transfer error !
  TX | 85 5F 56 44 65 DD A9 4B B0 9E D1 B4 EE F8 8C 70 91 DB EB E7 83 D4 
65 5E 46 D4 8E 1E 56 09 38 DC  |._VDe..K.......p......e^F...V.8.|
  TX | 69 8E 20 CE 6B C9 1A 1B 68 EB CF 56 E4 5B C6 75 37 B1 5C BA 85 C1 
18 CB 95 A6 E9 EB B0 22 C7 19  |i. .k...h..V.[.u7.\.........."..|
  TX | B0 E7 E7 1C B1 01 37 19 ED 07 6F D1 62 35 46 99 E6 A2 54 6C 63 6C 
37 F8 13 21 E3 C3 43 AB DC F3  |......7...o.b5F...Tlcl7..!..C...|
  TX | 92 C3 0F 43 C5 47 5C B2 4E CB 83 B0 00 C9 4A E7 6B 9E 53 CE 0A 8A 
C6 1D AB A9 E0 EE 54 BC E2 E7  |...C.G\.N.....J.k.S.........T...|
  TX | 80 F1 2A 45 38 87 F7 86 52 7A 37 53 43 81 3A AE 1F 8D 7C 29 17 42 
47 C3 EB 27 B1 40 E4 93 27 64  |..*E8...Rz7SC.:...|).BG..'.@..'d|
  TX | 85 51 A9 BD D8 A0 44 2B 1A 7B 7E 5D FC B8 0B 1B 45 87 44 5C C9 8B 
1F B4 B3 D1 F4 97 64 1B FB E9  |.Q....D+.{~]....E.D\........d...|
  TX | 6D A4 A7 45 44 EB 70 5E 66 EE BB 62 A6 C6 7D EB 4D C1 48 16 4D 67 
CA 00 38 BF 97 9D DA 92 86 47  |m..ED.p^f..b..}.M.H.Mg..8......G|
  TX | 36 2D 8D 7A 18 FD D8 7E EC 93 E0 92 59 5D 7E A6 1F C6 BC 6C 2D 86 
6C 66 45 03 03 20 95 89 67 CB  |6-.z...~....Y]~....l-.lfE.. ..g.|
  TX | B7 F4 45 CF F2 1D 4E DE B0 2E 70 09 8C EE AF AB B4 6B 17 E2 F1 83 
48 37 86 4B 57 1B D4 BE E6 8B  |..E...N...p......k....H7.KW.....|
  TX | B3 2B 5B A5 48 A9 83 F8 D7 F3 01 63 E2 B0 0E 96 1B 25 78 0C A8 C0 
43 2E 0B 9A 49 E0 59 2F 6B 0C  |.+[.H......c.....%x...C...I.Y/k.|
  TX | 5A C6 B1 A2 6F 34 9A 47 27 9B AA 09 4B B9 A0 66 DE 18 73 87 D9 B6 
B5 E4 51 FF C4 AA 2E 30 B6 89  |Z...o4.G'...K..f..s.....Q....0..|
  TX | F6 67 2B 66 9B C6 AD C2 61 57 CC AD 10 6C 13 EF 84 86 76 5D 3D 2B 
42 8E 2A 06 38 59 36 EE E2 2D  |.g+f....aW...l....v]=+B.*.8Y6..-|
  TX | 55 0D 93 F0 D3 40 B2 35 97 7E E2 A8 EA F5 97 6F 7C 0D CC B9 38 0E 
47 63 15 7F BC 4B 6D 9E 78 C2  |U....@.5.~.....o|...8.Gc...Km.x.|
  TX | AB 0B B2 7F 4B 64 B4 E3 E3 96 8B CD 8B 22 3C 07 2F 09 C0 67 17 07 
CA 2C 86 86 78 F3 24 F0 B5 D0 |....Kd......."<./..g...,..x.$...|
  TX | FC 67 4F 47 CC 03 2A AF 99 B5 7C 24 D7 B9 2C 06 C2 EC 6E D9 F4 38 
06 7A BF 7E 6E E3 6E 23 B3 6A  |.gOG..*...|$..,...n..8.z.~n.n#.j|
  TX | 8B 02 B2 57 05 DC 06 9E 92 82 C3 69 3B EF 70 FD DB DE D7 CF 16 DD 
4A D5 5B B8 B9 C9 DB 6C 34 66  |...W.......i;.p.......J.[....l4f|
  RX | 85 5F 56 44 65 DD A9 4B B0 9E D1 B4 EE F8 8C 70 91 DB EB E7 83 D4 
65 5E 46 D4 8E 1E 56 09 38 DC  |._VDe..K.......p......e^F...V.8.|
  RX | 69 8E 20 CE 6B C9 1A 1B 68 EB CF 56 E4 5B C6 75 37 B1 5C BA 85 C1 
18 CB 95 A6 E9 EB B0 22 C7 19  |i. .k...h..V.[.u7.\.........."..|
  RX | B0 E7 E7 1C B1 B1 01 37 19 ED 07 6F D1 62 35 46 99 E6 A2 54 6C 63 
6C 37 F8 13 21 E3 C3 43 AB DC  |.......7...o.b5F...Tlcl7..!..C..|
  RX | F3 92 C3 0F 43 C5 47 5C B2 4E CB 83 B0 00 C9 4A E7 6B 9E 53 CE 0A 
8A C6 1D AB A9 E0 EE 54 BC E2  |....C.G\.N.....J.k.S.........T..|
  RX | E7 80 F1 2A 45 38 87 F7 86 52 7A 37 53 43 81 3A AE 1F 8D 7C 29 17 
42 47 C3 EB 27 B1 40 E4 93 27  |...*E8...Rz7SC.:...|).BG..'.@..'|
  RX | 64 85 51 A9 BD D8 A0 44 2B 1A 7B 7E 5D FC B8 0B 1B 45 87 44 5C C9 
8B 1F B4 B3 D1 F4 97 64 1B FB  |d.Q....D+.{~]....E.D\........d..|
  RX | E9 6D A4 A7 45 44 EB 70 5E 66 EE BB 62 A6 C6 7D EB 4D C1 48 16 4D 
67 CA 00 38 BF 97 9D DA 92 86  |.m..ED.p^f..b..}.M.H.Mg..8......|
  RX | 47 36 2D 8D 7A 18 FD D8 7E EC 93 E0 92 59 5D 7E A6 1F C6 BC 6C 2D 
86 6C 66 45 03 03 20 95 89 67  |G6-.z...~....Y]~....l-.lfE.. ..g|
  RX | CB B7 F4 45 CF F2 1D 4E DE B0 2E 70 09 8C EE AF AB B4 6B 17 E2 F1 
83 48 37 86 4B 57 1B D4 BE E6  |...E...N...p......k....H7.KW....|
  RX | 8B B3 2B 5B A5 48 A9 83 F8 D7 F3 01 63 E2 B0 0E 96 1B 25 78 0C A8 
C0 43 2E 0B 9A 49 E0 59 2F 6B  |..+[.H......c.....%x...C...I.Y/k|
  RX | 0C 5A C6 B1 A2 6F 34 9A 47 27 9B AA 09 4B B9 A0 66 DE 18 73 87 D9 
B6 B5 E4 51 FF C4 AA 2E 30 B6  |.Z...o4.G'...K..f..s.....Q....0.|
  RX | 89 F6 67 2B 66 9B C6 AD C2 61 57 CC AD 10 6C 13 EF 84 86 76 5D 3D 
2B 42 8E 2A 06 38 59 36 EE E2  |..g+f....aW...l....v]=+B.*.8Y6..|
  RX | 2D 55 0D 93 F0 D3 40 B2 35 97 7E E2 A8 EA F5 97 6F 7C 0D CC B9 38 
0E 47 63 15 7F BC 4B 6D 9E 78  |-U....@.5.~.....o|...8.Gc...Km.x|
  RX | C2 AB 0B B2 7F 4B 64 B4 E3 E3 96 8B CD 8B 22 3C 07 2F 09 C0 67 17 
07 CA 2C 86 86 78 F3 24 F0 B5 |.....Kd......."<./..g...,..x.$..|
  RX | D0 FC 67 4F 47 CC 03 2A AF 99 B5 7C 24 D7 B9 2C 06 C2 EC 6E D9 F4 
38 06 7A BF 7E 6E E3 6E 23 B3  |..gOG..*...|$..,...n..8.z.~n.n#.|
  RX | 6A 8B 02 B2 57 05 DC 06 9E 92 82 C3 69 3B EF 70 FD DB DE D7 CF 16 
DD 4A D5 5B B8 B9 C9 DB 6C 34  |j...W.......i;.p.......J.[....l4|

  root@cr7:~# spidev_test -D /dev/spidev4.2 -s 10000000 -b 8 -S 512 -I 
1000000 -l
  spi mode: 0x20
  bits per word: 8
  max speed: 10000000 Hz (10000 KHz)
  transfer error !
  TX | B1 5F DB DA 56 B7 B3 33 E0 AC F0 51 46 C4 33 57 58 A8 7F 20 21 D4 
11 25 F3 26 27 A0 24 10 7F D5  |._..V..3...QF.3WX.. !..%.&'.$...|
  TX | 6F 5A B0 C5 11 63 F9 F1 10 E9 42 56 AD 76 AD 05 1E 2D 25 3F 01 36 
64 F4 5C 8C 95 80 9C 14 56 0B  |oZ...c....BV.v...-%?.6d.\.....V.|
  TX | 6F 06 D1 80 69 CA 72 79 B3 B4 CF 61 2A 7D 66 48 AA 8C 88 AB C2 EC 
9F 1F 78 34 9F 14 49 F5 20 B8  |o...i.ry...a*}fH........x4..I. .|
  TX | FB F1 38 65 BB AA DE 6E 5F AE CF 89 2B 36 D2 D5 C2 5A 80 84 46 1F 
A3 BF 54 43 D3 9D 38 F3 55 34  |..8e...n_...+6...Z..F...TC..8.U4|
  TX | E4 8D 99 9F 38 77 0E 97 25 DD 20 50 13 F2 25 D5 4C A5 5A 93 C5 FD 
52 19 40 25 B6 79 19 0B AD FD  |....8w..%. P..%.L.Z...R.@%.y....|
  TX | 98 46 9D D0 BD AB 67 E3 88 88 33 9C 7A 59 71 C7 FE CB 5A C3 C9 AC 
DC 09 D1 92 82 EA 9D 2F E8 36  |.F....g...3.zYq...Z........../.6|
  TX | 75 85 06 33 30 6E 16 B8 F6 49 54 70 A2 C6 37 A1 91 91 64 5A 3D 41 
64 0F D3 E6 F9 71 16 E1 A7 8B  |u..30n...ITp..7...dZ=Ad....q....|
  TX | 66 AD BE 96 1B D4 4F 11 1E A3 82 C0 69 B9 61 FB 4B C6 55 88 07 B9 
97 DA A0 91 4B B6 72 F2 41 D9  |f.....O.....i.a.K.U.......K.r.A.|
  TX | A0 00 6F BB D4 BE CD F2 62 4F B3 CB 08 14 C6 53 DA 1C DC E1 D5 73 
BC 75 04 07 2B 77 FA 6D 50 9A  |..o.....bO.....S.....s.u..+w.mP.|
  TX | 6D BF 55 41 7E 22 34 E0 71 E7 AB 7A FB 72 CD D6 8E A9 B7 63 1D 73 
D9 21 7B 04 98 75 71 E8 0F DE  |m.UA~"4.q..z.r.....c.s.!{..uq...|
  TX | A8 64 20 26 87 54 06 F8 3B B1 72 36 23 40 0C B1 E9 C4 15 06 37 EE 
28 B2 F2 C0 27 64 A9 36 42 51  |.d &.T..;.r6#@......7.(...'d.6BQ|
  TX | 9B 62 77 22 B6 7D 1A F1 2E 8D 28 52 CD 34 03 B6 F8 18 BD 30 06 E5 
E2 F9 A5 0A 5D 4E 40 9F 9F DB  |.bw".}....(R.4.....0......]N@...|
  TX | 02 16 FD B8 93 18 AA C2 A5 D2 14 72 06 17 28 FF 30 E5 2F 36 CA 11 
2F 70 1B 8C BE 5C 2C 5E 37 2E  |...........r..(.0./6../p...\,^7.|
  TX | 74 35 E6 08 4D 90 CA F2 62 DE 64 69 F5 8C 68 25 72 97 5C 3C A8 8B 
AC C4 18 6B 20 44 C9 57 72 3D  |t5..M...b.di..h%r.\<.....k D.Wr=|
  TX | 8C 58 45 D9 E9 0F CB 4B ED 2F B4 E3 BC 1C 08 2E B3 64 6A 5C F0 17 
20 08 82 40 4C 4B 97 BE 88 24  |.XE....K./.......dj\.. ..@LK...$|
  TX | 16 CE FD FF DD C9 4B CB F8 FF AE B4 1C B6 E2 CF 1B 4D 2B 0B 64 4B 
13 E6 8B 5F 31 23 1D B9 47 33  |......K..........M+.dK..._1#..G3|
  RX | B1 5F DB DA 56 B7 B3 33 E0 AC F0 51 46 C4 33 57 58 A8 7F 20 21 D4 
11 25 F3 26 27 A0 24 10 7F D5  |._..V..3...QF.3WX.. !..%.&'.$...|
  RX | 6F 5A B0 C5 11 63 63 F9 F1 10 E9 42 56 AD 76 AD 05 1E 2D 25 3F 01 
36 64 F4 5C 8C 95 80 9C 14 56  |oZ...cc....BV.v...-%?.6d.\.....V|
  RX | 0B 6F 06 D1 80 69 CA 72 79 B3 B4 CF 61 2A 7D 66 48 AA 8C 88 AB C2 
EC 9F 1F 78 34 9F 14 49 F5 20  |.o...i.ry...a*}fH........x4..I. |
  RX | B8 FB F1 38 65 BB AA DE 6E 5F AE CF 89 2B 36 D2 D5 C2 5A 80 84 46 
1F A3 BF 54 43 D3 9D 38 F3 55  |...8e...n_...+6...Z..F...TC..8.U|
  RX | 34 E4 8D 99 9F 38 77 0E 97 25 DD 20 50 13 F2 25 D5 4C A5 5A 93 C5 
FD 52 19 40 25 B6 79 19 0B AD  |4....8w..%. P..%.L.Z...R.@%.y...|
  RX | FD 98 46 9D D0 BD AB 67 E3 88 88 33 9C 7A 59 71 C7 FE CB 5A C3 C9 
AC DC 09 D1 92 82 EA 9D 2F E8  |..F....g...3.zYq...Z........../.|
  RX | 36 75 85 06 33 30 6E 16 B8 F6 49 54 70 A2 C6 37 A1 91 91 64 5A 3D 
41 64 0F D3 E6 F9 71 16 E1 A7  |6u..30n...ITp..7...dZ=Ad....q...|
  RX | 8B 66 AD BE 96 1B D4 4F 11 1E A3 82 C0 69 B9 61 FB 4B C6 55 88 07 
B9 97 DA A0 91 4B B6 72 F2 41  |.f.....O.....i.a.K.U.......K.r.A|
  RX | D9 A0 00 6F BB D4 BE CD F2 62 4F B3 CB 08 14 C6 53 DA 1C DC E1 D5 
73 BC 75 04 07 2B 77 FA 6D 50  |...o.....bO.....S.....s.u..+w.mP|
  RX | 9A 6D BF 55 41 7E 22 34 E0 71 E7 AB 7A FB 72 CD D6 8E A9 B7 63 1D 
73 D9 21 7B 04 98 75 71 E8 0F  |.m.UA~"4.q..z.r.....c.s.!{..uq..|
  RX | DE A8 64 20 26 87 54 06 F8 3B B1 72 36 23 40 0C B1 E9 C4 15 06 37 
EE 28 B2 F2 C0 27 64 A9 36 42  |..d &.T..;.r6#@......7.(...'d.6B|
  RX | 51 9B 62 77 22 B6 7D 1A F1 2E 8D 28 52 CD 34 03 B6 F8 18 BD 30 06 
E5 E2 F9 A5 0A 5D 4E 40 9F 9F  |Q.bw".}....(R.4.....0......]N@..|
  RX | DB 02 16 FD B8 93 18 AA C2 A5 D2 14 72 06 17 28 FF 30 E5 2F 36 CA 
11 2F 70 1B 8C BE 5C 2C 5E 37  |............r..(.0./6../p...\,^7|
  RX | 2E 74 35 E6 08 4D 90 CA F2 62 DE 64 69 F5 8C 68 25 72 97 5C 3C A8 
8B AC C4 18 6B 20 44 C9 57 72  |.t5..M...b.di..h%r.\<.....k D.Wr|
  RX | 3D 8C 58 45 D9 E9 0F CB 4B ED 2F B4 E3 BC 1C 08 2E B3 64 6A 5C F0 
17 20 08 82 40 4C 4B 97 BE 88  |=.XE....K./.......dj\.. ..@LK...|
  RX | 24 16 CE FD FF DD C9 4B CB F8 FF AE B4 1C B6 E2 CF 1B 4D 2B 0B 64 
4B 13 E6 8B 5F 31 23 1D B9 47  |$......K..........M+.dK..._1#..G|

Best wishes.
--
Igor Plyatov
