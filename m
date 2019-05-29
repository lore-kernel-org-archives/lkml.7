Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC6EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7E723F6E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Wp8okvQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfE2RZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 13:25:13 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50964 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfE2RZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 13:25:13 -0400
Received: by mail-it1-f194.google.com with SMTP id a186so5277449itg.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=05/fn13tWdkuP2jbzLdgGVw/WPVOyHa3JR8tLqwyzyg=;
        b=Wp8okvQG49treFUvGf307mQ1udyHalrmXpAQuVspFNU50zTFPafRYWLfO5nwUiqLaz
         Oun3HWQHuyee5LnlISk6joiiD3rAlhIvQp3djdac3Lwo7wSKovbpPyU6nqNjQg2A1hu+
         YA83HwvXibsJ/e0fJcWwegfNwyMzIFWvLd4bhcbKQgPH88L+gEjdS7VNvapKmWzC+LzZ
         seulKXe0qOyWe5hJD6IwPJqGLzMRAQ8FjrdzehcqkmS7LDoqfWet0tBBcNoAOqC32EZG
         Fs8gtwLZGivn8GKBEJiybu97uGZOvP2r8JrgMlKtg5tmZSUfi3fOomiK/aD7OiHbQZFO
         hvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=05/fn13tWdkuP2jbzLdgGVw/WPVOyHa3JR8tLqwyzyg=;
        b=jlmJdZJNsNepNjyJarfe52ObJYDGvCH2ruYTjPqUbUkUOzx+AwbJ/SOOEG//AS2+jk
         TFX3b2oSuNtl9WC/QehIQbjs0dg2aAwdoCCiPQjIGBT0omQXBLGr4dMr4kso+i5/3IzD
         pyyG4IY+3TpxQOSEyuN1F76Rh67OHNZYakDrfCV30dLxq2gsKC8W3f1UXqnRa43Rp3GP
         kDNEu0xFhv1otEzPuRrqxnr8cVGnZOl5+5RceNDlIbKddUjJB7C0pL/naUBYUEthPeQq
         UBXeut8WbA4i64H7YkK7eM7nazv5OImxAxSE3Bt50Lt0aVdxvNmf4gu7Lhr/o7fhi+xE
         jKGA==
X-Gm-Message-State: APjAAAXKO1siAGzDJhwUjqY+Cv5cGhN/8DqZJcnebz4HUyELdCbS6t13
        4pkJalZVNDAKv8nkJqHs1NB5ccAXXlQ=
X-Google-Smtp-Source: APXvYqyJcEh6gRkxs2XmEjUhT7WtpVbEXsThoueWrn+2AeABP7BMNTr46Xt4OseylbuSsPp92cCbEQ==
X-Received: by 2002:a24:29cd:: with SMTP id p196mr8834303itp.116.1559150711673;
        Wed, 29 May 2019 10:25:11 -0700 (PDT)
Received: from [192.168.1.196] ([216.160.37.230])
        by smtp.gmail.com with ESMTPSA id k18sm1255341itb.0.2019.05.29.10.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:25:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Testing the recent RISC-V DT patchsets
From:   Troy Benjegerdes <troy.benjegerdes@sifive.com>
In-Reply-To: <86woi94lvs.fsf@baylibre.com>
Date:   Wed, 29 May 2019 12:25:09 -0500
Cc:     Atish Patra <atish.patra@wdc.com>,
        Karsten Merker <merker@debian.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC002AAE-7EE6-404D-9204-D10263BEA5C9@sifive.com>
References: <alpine.DEB.2.21.9999.1904221705170.18377@viisi.sifive.com>
 <alpine.DEB.2.21.9999.1905280105110.20842@viisi.sifive.com>
 <86o93mpqbx.fsf@baylibre.com>
 <20190528153542.jfkkwycyc3vu6hld@excalibur.cnev.de>
 <081611ea-a0d3-b0c9-3e08-8946513f2174@wdc.com> <86woi94lvs.fsf@baylibre.com>
To:     Loys Ollivier <lollivier@baylibre.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 29, 2019, at 5:04 AM, Loys Ollivier <lollivier@baylibre.com> =
wrote:
>=20
> On Wed 29 May 2019 at 00:50, Atish Patra <atish.patra@wdc.com> wrote:
>=20
>> On 5/28/19 8:36 AM, Karsten Merker wrote:
>>> On Tue, May 28, 2019 at 05:10:42PM +0200, Loys Ollivier wrote:
>>>> On Tue 28 May 2019 at 01:32, Paul Walmsley =
<paul.walmsley@sifive.com> wrote:
>>>>=20
>>>>> An update for those testing RISC-V patches: here's a new branch of
>>>>> riscv-pk/bbl that doesn't try to read or modify the DT data at =
all, which
>>>>> should be useful until U-Boot settles down.
>>> [...]
>>>>> Here is an Linux kernel branch with updated DT data that can be =
booted
>>>>> with the above bootloader:
>>>>>=20
>>>>>    =
https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1-experime=
ntal
>>>>>=20
>>>>> A sample boot log follows, using a 'defconfig' build from that =
branch.
>>>>=20
>>>> Thanks Paul, I can confirm that it works.
>>>>=20
>>>> Something is still unclear to myself.
>>>> Using FSBL + riscv-pk/bbl the linux kernel + device tree boots.
>>>> Neither FSBL nor riscv-pk/bbl are modifying the DT.
>>>>=20
>>>> Using FSBL + OpenSBI + U-Boot the same kernel + device tree hangs =
on
>>>> running /init.
>>>>=20
>>>> Would you have any pointer on what riscv-pk does that =
OpenSBI/U-boot doesn't ?
>>>> Or maybe it is the other way around - OpenSBI/U-boot does something =
that
>>>> extra that should not happen.
>>>=20
>>> Hello,
>>>=20
>>> I don't know which version of OpenSBI you are using, but there is
>>> a problem with the combination of kernel 5.2-rc1 and OpenSBI
>>> versions before commit
>>>=20
>>>   =
https://github.com/riscv/opensbi/commit/4e2cd478208531c47343290f15b577d40c=
82649c
>>>=20
>>> that can result in a hang on executing init, so in case you
>>> should be using an older OpenSBI build that might be the source
>>> of the problem that you are experiencing.
>>>=20
>>> Regards,
>>> Karsten
>>>=20
>>=20
>> I verified the updated DT with upstream kernel for the boot flow =
OpenSBI=20
>> + U-Boot + Linux or OpenSBI + Linux.
>>=20
>> OpenSBI should be compiled for sifive platform with following =
additional=20
>> argument
>>=20
>> FW_PAYLOAD_FDT_PATH=3D<linux kernel=20
>> source>/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dtb
>>=20
>> FYI: It will only work when kernel is given a payload to =
U-Boot/OpenSBI=20
>> directly.
>>=20
>=20
> Hum, I am surprised by this statement.
> I was able to verify the latest DT patch serie from Paul with:
> OpenSBI + U-Boot + Linux & DT.
>=20
> Following the OpenSBI documentation [0] with U-Boot payload:
> FW_PAYLOAD_PATH=3D<u-boot_build_dir>/u-boot.bin
>=20
> I get an U-Boot prompt and then I can just load the linux kernel and
> device tree from the network.
>=20
> [0]: =
https://github.com/riscv/opensbi/blob/master/docs/platform/sifive_fu540.md=
#building-sifive-fu540-platform
>=20

Could you confirm which git hash of U-boot you are building, and that =
the .config matches
the defconfig (or send me the .config you used)?

I=E2=80=99d like to get everything that=E2=80=99s working integrated in =
one place into a freedom-u-sdk test branch.


>> Network booting is still not working as the clock driver probe =
doesn't=20
>> happen because of the updated DT.
>>=20
>> --=20
>> Regards,
>> Atish
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

