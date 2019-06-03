Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06553C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B902724E04
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="g8VMLm1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFCURu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 16:17:50 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52365 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFCURu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:17:50 -0400
Received: by mail-it1-f195.google.com with SMTP id l21so7798799ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 13:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tE8ZvQ793ioxSGN7ljLAbUX0SEmm8IkMIDQGFixa9Y8=;
        b=g8VMLm1JOpHJ9dtp/q2hTw06Lqf2nLs1nc/2mC4233i6YVCfeM4G8hLpHmH2Xw9Sb+
         C9SxRjyTZ2/wQuYR22lyq4rezt0mAbNRQfWsXFku2Io8RT8yao8bqM/tWr1HCDmZQVpY
         kouqWN6jH4XXPXCXzhCPMsyclMgox7H9lVixqkxjgrOdJ58SVT/nH/FJvUQgrUShyclR
         IXR4hM87sgk3xZ82lnzm1SL7FwP9dtSpE48njZt+NtcZP0G4CNl47xCJIb0ixigzUdts
         KpZG84JsFl66AcEhNa307V1XhL/XmzAheKv+8Z0X8UiVhvsUGEzlFiLwNqNkHnz4skg/
         1LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tE8ZvQ793ioxSGN7ljLAbUX0SEmm8IkMIDQGFixa9Y8=;
        b=MMesweFqpz8RzkTbxVhTHcD8NUQur/t7tg3+Blb3TLzQ3BnS+T2SndE0uKNuJXIne9
         fI/LFWjx59Zt6d6fiy2EWNDlynMrbsEFpRH0fida35M5Z8XowL1Tjk28vN+65/88AFp/
         SyvPc2mr2es3aYfk7EpZC/f+XgGfIzKRjm/+v9afjK9Vgn9FOHmbCWOe3QRGtHpJ3MU9
         +4IGIfDq6+J/BsGjwv9rLkjTiC496bv2epLl+rzO9C2h+GpvdjkHwZTXnKwYdV8BHEVn
         itUKFI7bQVIqj2UiLpaHotmsCaUyF6EOgkOXXah5k+YJWP9PTt6OTiPRRaSXVqvnVBiB
         s36g==
X-Gm-Message-State: APjAAAVdoNAmqyD8g3aUbH/WXRmlfh1A9J4bh2QcuOaxuCe/Xqs/nQ1v
        EfTQbH6mSdVja0b0Jv2Idf/49A==
X-Google-Smtp-Source: APXvYqw1etx/ZHTsfMnueSCEnl3h3kPLq6v4eMcr+t53a4vcXgj1Zwd328kEU6KsjjpRQ2IzdtHDNA==
X-Received: by 2002:a02:a384:: with SMTP id y4mr18255340jak.77.1559593068821;
        Mon, 03 Jun 2019 13:17:48 -0700 (PDT)
Received: from [192.168.1.138] ([216.160.37.230])
        by smtp.gmail.com with ESMTPSA id i141sm6469654ite.20.2019.06.03.13.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:17:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Testing the recent RISC-V DT patchsets
From:   Troy Benjegerdes <troy.benjegerdes@sifive.com>
In-Reply-To: <8636krhubp.fsf@baylibre.com>
Date:   Mon, 3 Jun 2019 15:17:46 -0500
Cc:     Atish Patra <atish.patra@wdc.com>,
        Karsten Merker <merker@debian.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <038A3CC1-B970-4B1B-83C1-59992F609888@sifive.com>
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

Please take a look at =
https://github.com/tmagik/freedom-u-sdk/tree/functional_test

When I booted the original 4.19 vmlinux.bin, I got this:

Booting kernel in
2
1
0
## Starting application at 0x80200000 ...
[    0.000000] Linux version 4.19.0-sifive-1+ (troyb@epsilon09) (gcc =
version 8.3.0 (Buildroot 29
[    0.000000] bootconsole [early0] enabled

With the 5.2 kernel, I get know output, which I assume is expected =
behavior using the
current DTS provided by the S-mode Uboot.

Booting kernel in
2
1
0
## Starting application at 0x80200000 ...=
