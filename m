Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB04C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3DA24A91
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="v/sZW7sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFDGM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:12:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38327 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfFDGM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:12:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id t5so13340862wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 23:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TMXweKhrysV0Lzk8TuE66Re5i67xMIHF0nwyCke3TcA=;
        b=v/sZW7sn93EUziShXhsWoRWr7XFOZBlcpGR7sJW0biaOwKo7XVJjuHeCk6k+AaBe4q
         r/ogk1R2GsJK7khxbcddQLtiN2s+w8XbtpgZM7tovMTZTsrtULBRmVhUWXK7fopJeTSn
         ooy+u1fUv8NVFGozaNBRrUBMJqsD34Rh/J0FDcPqvCV6LOH6MSWxjd21oI1VcZpfsjsU
         vkzzRQ3ydewUO8W23vT2P74AmHzc8sB/OtXS8bBcCw4481/5YCyGqiMI+E3OLmJlsNDT
         xiQYxwZLYJU6hm2bMiBYuIzNalz1pptC2O9US6I3FxjXbUnyr7CIqh+wI5n/jHbNP6FY
         RIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TMXweKhrysV0Lzk8TuE66Re5i67xMIHF0nwyCke3TcA=;
        b=LjomW4JpD1/VTTPlDkU+3sE7JF46GMwfKRGc3mUnEp9RZc+ZNFZQGbF+FrIuy2thtb
         aNcfV+HkI1hZV9hmiVkGqAB+vMHqmCrDJKRpAK67Kk61m136BIZ7mBXz4f1JCSHkkdBM
         HDlN22zCdq0IiH+Eax+HGtc2Vh0XK3GLlM3QalnuUiJmTRgCOR0GERfb6ggxXJjBzOgF
         2lgzbWywE1SVkAcWc8ADFHHjSzLvwXZAfH7AR61BCgFk1V2JE5pz6Dwm6FBEK6Pjrwx2
         jlnr+4TUNjalddDsILqKJ3BUlP2xewX2vNYIZ/QAwL+VaOvCmcRaVto4P5GdSiTnFvaE
         H8HQ==
X-Gm-Message-State: APjAAAU3N5cGzrKMDBksyKPcu3OXeeeBQSIsqNMjFaOKWLlHuCaBZgSq
        e20eF5+dP4a5yeXBFs/GWfCOk+UOlbNHCwPd5tnvNw==
X-Google-Smtp-Source: APXvYqyEcrMAXJ7qpGDgd1TS6ZmTaegLMO7DNvYMY2xrFIoVSWvKDYLrzltLde+qKbng/azGKPqxeKHx/oFxny23F7w=
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr7662388wmg.177.1559628746172;
 Mon, 03 Jun 2019 23:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1904221705170.18377@viisi.sifive.com>
 <alpine.DEB.2.21.9999.1905280105110.20842@viisi.sifive.com>
 <86o93mpqbx.fsf@baylibre.com> <20190528153542.jfkkwycyc3vu6hld@excalibur.cnev.de>
 <081611ea-a0d3-b0c9-3e08-8946513f2174@wdc.com> <86woi94lvs.fsf@baylibre.com>
 <BC002AAE-7EE6-404D-9204-D10263BEA5C9@sifive.com> <8636krhubp.fsf@baylibre.com>
 <038A3CC1-B970-4B1B-83C1-59992F609888@sifive.com>
In-Reply-To: <038A3CC1-B970-4B1B-83C1-59992F609888@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 4 Jun 2019 11:42:15 +0530
Message-ID: <CAAhSdy3qgqdz+XPsBWZSfYZhMTA2Py+M9OuD=K1Yo=yDwwdJkQ@mail.gmail.com>
Subject: Re: Testing the recent RISC-V DT patchsets
To:     Troy Benjegerdes <troy.benjegerdes@sifive.com>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Atish Patra <atish.patra@wdc.com>,
        Karsten Merker <merker@debian.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 1:47 AM Troy Benjegerdes
<troy.benjegerdes@sifive.com> wrote:
>
>
>
> > On Jun 3, 2019, at 4:49 AM, Loys Ollivier <lollivier@baylibre.com> wrot=
e:
> >
> > On Wed 29 May 2019 at 12:25, Troy Benjegerdes <troy.benjegerdes@sifive.=
com> wrote:
> >
> >>> On May 29, 2019, at 5:04 AM, Loys Ollivier <lollivier@baylibre.com> w=
rote:
> >>>
> >>> On Wed 29 May 2019 at 00:50, Atish Patra <atish.patra@wdc.com> wrote:
> >>>
> >>>> On 5/28/19 8:36 AM, Karsten Merker wrote:
> >>>>> On Tue, May 28, 2019 at 05:10:42PM +0200, Loys Ollivier wrote:
> >>>>>> On Tue 28 May 2019 at 01:32, Paul Walmsley <paul.walmsley@sifive.c=
om> wrote:
> >>>>>>
> >>>>>>> An update for those testing RISC-V patches: here's a new branch o=
f
> >>>>>>> riscv-pk/bbl that doesn't try to read or modify the DT data at al=
l, which
> >>>>>>> should be useful until U-Boot settles down.
> >>>>> [...]
> >>>>>>> Here is an Linux kernel branch with updated DT data that can be b=
ooted
> >>>>>>> with the above bootloader:
> >>>>>>>
> >>>>>>>   https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-r=
c1-experimental
> >>>>>>>
> >>>>>>> A sample boot log follows, using a 'defconfig' build from that br=
anch.
> >>>>>>
> >>>>>> Thanks Paul, I can confirm that it works.
> >>>>>>
> >>>>>> Something is still unclear to myself.
> >>>>>> Using FSBL + riscv-pk/bbl the linux kernel + device tree boots.
> >>>>>> Neither FSBL nor riscv-pk/bbl are modifying the DT.
> >>>>>>
> >>>>>> Using FSBL + OpenSBI + U-Boot the same kernel + device tree hangs =
on
> >>>>>> running /init.
> >>>>>>
> >>>>>> Would you have any pointer on what riscv-pk does that OpenSBI/U-bo=
ot doesn't ?
> >>>>>> Or maybe it is the other way around - OpenSBI/U-boot does somethin=
g that
> >>>>>> extra that should not happen.
> >>>>>
> >>>>> Hello,
> >>>>>
> >>>>> I don't know which version of OpenSBI you are using, but there is
> >>>>> a problem with the combination of kernel 5.2-rc1 and OpenSBI
> >>>>> versions before commit
> >>>>>
> >>>>>  https://github.com/riscv/opensbi/commit/4e2cd478208531c47343290f15=
b577d40c82649c
> >>>>>
> >>>>> that can result in a hang on executing init, so in case you
> >>>>> should be using an older OpenSBI build that might be the source
> >>>>> of the problem that you are experiencing.
> >>>>>
> >>>>> Regards,
> >>>>> Karsten
> >>>>>
> >>>>
> >>>> I verified the updated DT with upstream kernel for the boot flow Ope=
nSBI
> >>>> + U-Boot + Linux or OpenSBI + Linux.
> >>>>
> >>>> OpenSBI should be compiled for sifive platform with following additi=
onal
> >>>> argument
> >>>>
> >>>> FW_PAYLOAD_FDT_PATH=3D<linux kernel
> >>>> source>/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dtb
> >>>>
> >>>> FYI: It will only work when kernel is given a payload to U-Boot/Open=
SBI
> >>>> directly.
> >>>>
> >>>
> >>> Hum, I am surprised by this statement.
> >>> I was able to verify the latest DT patch serie from Paul with:
> >>> OpenSBI + U-Boot + Linux & DT.
> >>>
> >>> Following the OpenSBI documentation [0] with U-Boot payload:
> >>> FW_PAYLOAD_PATH=3D<u-boot_build_dir>/u-boot.bin
> >>>
> >>> I get an U-Boot prompt and then I can just load the linux kernel and
> >>> device tree from the network.
> >>>
> >>> [0]: https://github.com/riscv/opensbi/blob/master/docs/platform/sifiv=
e_fu540.md#building-sifive-fu540-platform
> >>>
> >>
> >> Could you confirm which git hash of U-boot you are building, and that =
the .config matches
> >> the defconfig (or send me the .config you used)?
> >
> > Sure,
> >
> > OpenSBI: a6395acd6cb2c35871481d3e4f0beaf449f8c0fd
> > U-Boot: (origin/master) 344a0e4367d0820b8eb2ea4a90132433e038095f
> > Kernel: from Paul from this thread [1]
> >
> > I use the sifive_fu540_defconfig of U-Boot with no additional changes.
> >
> > [1] https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1-e=
xperimental
> >
> >>
> >> I=E2=80=99d like to get everything that=E2=80=99s working integrated i=
n one place into a freedom-u-sdk test branch.
> >>
> >>
> >
> > Let me know the test branch when it's up :)
> >
> > Loys
>
> Please take a look at https://github.com/tmagik/freedom-u-sdk/tree/functi=
onal_test
>
> When I booted the original 4.19 vmlinux.bin, I got this:
>
> Booting kernel in
> 2
> 1
> 0
> ## Starting application at 0x80200000 ...
> [    0.000000] Linux version 4.19.0-sifive-1+ (troyb@epsilon09) (gcc vers=
ion 8.3.0 (Buildroot 29
> [    0.000000] bootconsole [early0] enabled
>
> With the 5.2 kernel, I get know output, which I assume is expected behavi=
or using the
> current DTS provided by the S-mode Uboot.
>
> Booting kernel in
> 2
> 1
> 0
> ## Starting application at 0x80200000 ...

The earlyprintk support has been removed from latest kernel. Instead of
earlyprintk we now use generic earlycon support.

To use earlycon, just add "earlycon=3Dsbi" parameter in your kernel bootarg=
s.

On U-Boot, kernel bootargs can be changed by changing "bootargs" U-Boot
environment variable.

Regards,
Anup
