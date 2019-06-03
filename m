Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51937C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19587251AF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JAdMMiNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfFCPkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:40:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39899 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfFCPkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:40:09 -0400
Received: by mail-it1-f195.google.com with SMTP id j204so21955075ite.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hphZdPDGzesxi4f2dxYOudDZgbilETjRvECx0n0Na+I=;
        b=JAdMMiNO9SjXS91lV/fi2ndWJrz1B3Hv1MWUlELlP+3hk8oGwHjUtUkFlz9n46WEoN
         /jeazPQS5TgsGVsHaVfsCJAYA2aU0b1yd1OjWOf2AgpFkfxYM2KEbVNuUDTbUmyN5Vx3
         BEiSPt2/8NQ2UwQPvQg091yZY6MMfJ2QatKz0NNK2QzkGLCkhH54Kf3erU+s+ZkewAwJ
         JFNRzC0wNCRGiH13mBZ3QauDK977fwSWe+J2++AfK/YwvCAsvb5QX/mdFB1vERCg9a61
         iegnWARo95doPvGzhyp6/K+7c6In+K9/0kwDwF4WOGiXjDl7dLLvn1y7zPGKVWHc1hvD
         JR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hphZdPDGzesxi4f2dxYOudDZgbilETjRvECx0n0Na+I=;
        b=NOzorVDzdwgRTaIQjeWuJNG/5/LyA4uBXJsJgU92SHmhPRghmM+hUxhn8a+jy7bQku
         N2yk3F4eyAuZStTq1chBSog2ZLchOnO9thPPhRruxkCf+AVKyQWRY5ecKHZosPaN37E+
         Z89PP88kHfg1fs7lKuOSYVNHkFhrlYdgDzE/QLYtYXf+qKyyIhxhlh070BtxJsDk2SuY
         yt1SXMXFfxeyVkrya7YTIPwf72ZLs/iglIc7ftvkkrSK+dk1c/zmw9ZBU379i9clDWiQ
         AiU7JJLYTF0n7bqKkbf+OWMnGaSkQh9/qSjKoT6OeS7ni1RHrIEK/Af61Bvfw4EGY9Q6
         E5Wg==
X-Gm-Message-State: APjAAAUDupyfBL2RgZeR07PyQHeQFT9IyYumSUmdN/B8ozQGeRmewvsL
        +oJwSutZP38ZQ3E3UGJPJRVK/Q==
X-Google-Smtp-Source: APXvYqzFRzrf8pbkPLniK+9urxmazdco7UifRkGkVTBU+kVcaRqrl5SB984246cmkSU5ppgLriumlw==
X-Received: by 2002:a05:660c:546:: with SMTP id w6mr17465962itk.27.1559576408582;
        Mon, 03 Jun 2019 08:40:08 -0700 (PDT)
Received: from [192.168.1.138] ([216.160.37.230])
        by smtp.gmail.com with ESMTPSA id y18sm4922259iob.64.2019.06.03.08.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 08:40:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Testing the recent RISC-V DT patchsets
From:   Troy Benjegerdes <troy.benjegerdes@sifive.com>
In-Reply-To: <8636krhubp.fsf@baylibre.com>
Date:   Mon, 3 Jun 2019 10:40:06 -0500
Cc:     Atish Patra <atish.patra@wdc.com>,
        Karsten Merker <merker@debian.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4999B8C1-C968-4E46-8BE8-72C2907C041B@sifive.com>
References: <alpine.DEB.2.21.9999.1904221705170.18377@viisi.sifive.com>
 <alpine.DEB.2.21.9999.1905280105110.20842@viisi.sifive.com>
 <86o93mpqbx.fsf@baylibre.com>
 <20190528153542.jfkkwycyc3vu6hld@excalibur.cnev.de>
 <081611ea-a0d3-b0c9-3e08-8946513f2174@wdc.com> <86woi94lvs.fsf@baylibre.com>
 <BC002AAE-7EE6-404D-9204-D10263BEA5C9@sifive.com>
 <8636krhubp.fsf@baylibre.com>
To:     Loys Ollivier <lollivier@baylibre.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 3, 2019, at 4:49 AM, Loys Ollivier <lollivier@baylibre.com> =
wrote:
>=20
> On Wed 29 May 2019 at 12:25, Troy Benjegerdes =
<troy.benjegerdes@sifive.com> wrote:
>=20
>>> On May 29, 2019, at 5:04 AM, Loys Ollivier <lollivier@baylibre.com> =
wrote:
>>>=20
>>> On Wed 29 May 2019 at 00:50, Atish Patra <atish.patra@wdc.com> =
wrote:
>>>=20
>>>> On 5/28/19 8:36 AM, Karsten Merker wrote:
>>>>> On Tue, May 28, 2019 at 05:10:42PM +0200, Loys Ollivier wrote:
>>>>>> On Tue 28 May 2019 at 01:32, Paul Walmsley =
<paul.walmsley@sifive.com> wrote:
>>>>>>=20
>>>>>>> An update for those testing RISC-V patches: here's a new branch =
of
>>>>>>> riscv-pk/bbl that doesn't try to read or modify the DT data at =
all, which
>>>>>>> should be useful until U-Boot settles down.
>>>>> [...]
>>>>>>> Here is an Linux kernel branch with updated DT data that can be =
booted
>>>>>>> with the above bootloader:
>>>>>>>=20
>>>>>>>   =
https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1-experime=
ntal
>>>>>>>=20
>>>>>>> A sample boot log follows, using a 'defconfig' build from that =
branch.
>>>>>>=20
>>>>>> Thanks Paul, I can confirm that it works.
>>>>>>=20
>>>>>> Something is still unclear to myself.
>>>>>> Using FSBL + riscv-pk/bbl the linux kernel + device tree boots.
>>>>>> Neither FSBL nor riscv-pk/bbl are modifying the DT.
>>>>>>=20
>>>>>> Using FSBL + OpenSBI + U-Boot the same kernel + device tree hangs =
on
>>>>>> running /init.
>>>>>>=20
>>>>>> Would you have any pointer on what riscv-pk does that =
OpenSBI/U-boot doesn't ?
>>>>>> Or maybe it is the other way around - OpenSBI/U-boot does =
something that
>>>>>> extra that should not happen.
>>>>>=20
>>>>> Hello,
>>>>>=20
>>>>> I don't know which version of OpenSBI you are using, but there is
>>>>> a problem with the combination of kernel 5.2-rc1 and OpenSBI
>>>>> versions before commit
>>>>>=20
>>>>>  =
https://github.com/riscv/opensbi/commit/4e2cd478208531c47343290f15b577d40c=
82649c
>>>>>=20
>>>>> that can result in a hang on executing init, so in case you
>>>>> should be using an older OpenSBI build that might be the source
>>>>> of the problem that you are experiencing.
>>>>>=20
>>>>> Regards,
>>>>> Karsten
>>>>>=20
>>>>=20
>>>> I verified the updated DT with upstream kernel for the boot flow =
OpenSBI=20
>>>> + U-Boot + Linux or OpenSBI + Linux.
>>>>=20
>>>> OpenSBI should be compiled for sifive platform with following =
additional=20
>>>> argument
>>>>=20
>>>> FW_PAYLOAD_FDT_PATH=3D<linux kernel=20
>>>> source>/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dtb
>>>>=20
>>>> FYI: It will only work when kernel is given a payload to =
U-Boot/OpenSBI=20
>>>> directly.
>>>>=20
>>>=20
>>> Hum, I am surprised by this statement.
>>> I was able to verify the latest DT patch serie from Paul with:
>>> OpenSBI + U-Boot + Linux & DT.
>>>=20
>>> Following the OpenSBI documentation [0] with U-Boot payload:
>>> FW_PAYLOAD_PATH=3D<u-boot_build_dir>/u-boot.bin
>>>=20
>>> I get an U-Boot prompt and then I can just load the linux kernel and
>>> device tree from the network.
>>>=20
>>> [0]: =
https://github.com/riscv/opensbi/blob/master/docs/platform/sifive_fu540.md=
#building-sifive-fu540-platform
>>>=20
>>=20
>> Could you confirm which git hash of U-boot you are building, and that =
the .config matches
>> the defconfig (or send me the .config you used)?
>=20
> Sure,
>=20
> OpenSBI: a6395acd6cb2c35871481d3e4f0beaf449f8c0fd
> U-Boot: (origin/master) 344a0e4367d0820b8eb2ea4a90132433e038095f
> Kernel: from Paul from this thread [1]
>=20
> I use the sifive_fu540_defconfig of U-Boot with no additional changes.
>=20
> [1] =
https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1-experime=
ntal
>=20
>>=20
>> I=E2=80=99d like to get everything that=E2=80=99s working integrated =
in one place into a freedom-u-sdk test branch.
>>=20
>>=20
>=20
> Let me know the test branch when it's up :)
>=20
> Loys
>=20


Have a look at https://github.com/tmagik/freedom-u-sdk/tree/dev/u-boot

I need to fill in the makefiles (and set up our lab TFTP server) so=20
=E2=80=98make test=E2=80=99 builds and runs everything.

The first time I tried I got an endless string of exceptions, and how I =
get this:

OpenSBI v0.3 (Jun  3 2019 08:04:44)
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name          : SiFive Freedom U540
Platform HART Features : RV64ACDFIMSU
Platform Max HARTs     : 5
Current Hart           : 4
Firmware Base          : 0x80000000
Firmware Size          : 92 KB
Runtime SBI Version    : 0.1

PMP0: 0x0000000080000000-0x000000008001ffff (A)
PMP1: 0x0000000000000000-0x0000007fffffffff (A,R,W,X)


U-Boot 2019.07-rc3-00047-ga8a796e (Jun 03 2019 - 07:54:59 -0700)

CPU:   rv64imafdc
Model: sifive,hifive-unleashed-a00
DRAM:  8 GiB
In:    serial@10010000
Out:   serial@10010000
Err:   serial@10010000
Net:  =20




>>>> Network booting is still not working as the clock driver probe =
doesn't
>>>> happen because of the updated DT.
>>>>=20
>>>> --=20
>>>> Regards,
>>>> Atish
>>>=20
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv

