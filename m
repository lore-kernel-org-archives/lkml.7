Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0FEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E83217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pVqmtHMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfH1BHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:07:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38493 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfH1BHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:07:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id q64so1139897qtd.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 18:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=swyKWCdFIdJtO8JPMoHRDo+8t4IfVauN96cB1sxTR9A=;
        b=pVqmtHMRG20NEOtaXbc9xkIabV73MjCxZ4kk8DC4MW152qTMtD8YMDVDBb15w2tgpp
         EjC/OG0c7ZAQEsRm3grpZ6vmllwpQ8YADMuFVFyxNIWjHsh5jZqV1ZH5PloqqnBR8SuK
         4V2ZFUhZB1USAR649cktJpECErwSk1zmG4/b66fWhTkPo2zxJFptP0GwKbtuy7SVTqT0
         WMVMTBC/MBNaArp30Rneg0rEQwIvmGKHvW7IZd+IpxZoGiVee1RIETFUt2xzgGTnr/LH
         V/KsV0NBE660P/2L9hVp0KsdE4GdX52rqE3ogokLi/eeJf+OkYV8zj50UPYjp3HNKH3R
         1ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=swyKWCdFIdJtO8JPMoHRDo+8t4IfVauN96cB1sxTR9A=;
        b=lQaFdeCHozc01m4nvfDZBhBw60Gc8xOezgMK2nMFPln+Z7a9AI2/4Wjnhcp4jdHjS6
         kQ2Q1GR83RePMo6h3VJHjCQGJM4IDTvY9/6CcvgN3m1n+SCOoSfKGzMiyvdipS06Fn5X
         CWVX8tK18ZXzYl/xcREBsUsvnxNPCpACPvRaTIE8K6odYXp+GvCg4+wdhbFWE1XhvY0A
         Zqt/xJUvRNVDMGscP6/48pZg+WGUFq0t5nI/h5XoFCdHSr3+Itrgt742x1aX5NdiUx0g
         9k0Yyez+UC8UsHLhSSNhz3Gu7/8LvQRVb2AcewrtJLZWnZNVqAVaA00r2ZNBnNGNNziU
         /3PQ==
X-Gm-Message-State: APjAAAUknluq0w4FpF9JZ+7n7QBjRKi7NW7Q67I7utk7gxA7YnbsuJMM
        KD5dRx5T7CiisdauSIBNn9lIwMICjgDGuQ==
X-Google-Smtp-Source: APXvYqyfQo8m7y17h4bRIZhvvcBgdg9k4gYgm5FqehVOsl8ZJQ4f+0i4UOIybK2YhA8XUIlPJTHmUw==
X-Received: by 2002:aed:2fe6:: with SMTP id m93mr1900722qtd.114.1566954467184;
        Tue, 27 Aug 2019 18:07:47 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k74sm600020qke.53.2019.08.27.18.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 18:07:46 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] mm: silence -Woverride-init/initializer-overrides
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CAKwvOdmEZ6ADQyquRYmr+uNFXyZ0wpBZxNCrQnn8qaRZADzjRw@mail.gmail.com>
Date:   Tue, 27 Aug 2019 21:07:45 -0400
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3806CFC8-24DF-4CEC-8AFF-98FAF15CFCF6@lca.pw>
References: <1566920867-27453-1-git-send-email-cai@lca.pw>
 <CAKwvOdmEZ6ADQyquRYmr+uNFXyZ0wpBZxNCrQnn8qaRZADzjRw@mail.gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 27, 2019, at 7:25 PM, Nick Desaulniers =
<ndesaulniers@google.com> wrote:
>=20
> On Tue, Aug 27, 2019 at 8:49 AM Qian Cai <cai@lca.pw> wrote:
>>=20
>> When compiling a kernel with W=3D1, there are several of those =
warnings
>> due to arm64 override a field by purpose. Just disable those warnings
>> for both GCC and Clang of this file, so it will help dig "gems" =
hidden
>> in the W=3D1 warnings by reducing some noises.
>>=20
>> mm/init-mm.c:39:2: warning: initializer overrides prior =
initialization
>> of this subobject [-Winitializer-overrides]
>>        INIT_MM_CONTEXT(init_mm)
>>        ^~~~~~~~~~~~~~~~~~~~~~~~
>> ./arch/arm64/include/asm/mmu.h:133:9: note: expanded from macro
>> 'INIT_MM_CONTEXT'
>>        .pgd =3D init_pg_dir,
>>               ^~~~~~~~~~~
>> mm/init-mm.c:30:10: note: previous initialization is here
>>        .pgd            =3D swapper_pg_dir,
>>                          ^~~~~~~~~~~~~~
>>=20
>> Note: there is a side project trying to support explicitly allowing
>> specific initializer overrides in Clang, but there is no guarantee it
>> will happen or not.
>>=20
>> https://github.com/ClangBuiltLinux/linux/issues/639
>>=20
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> mm/Makefile | 3 +++
>> 1 file changed, 3 insertions(+)
>>=20
>> diff --git a/mm/Makefile b/mm/Makefile
>> index d0b295c3b764..5a30b8ecdc55 100644
>> --- a/mm/Makefile
>> +++ b/mm/Makefile
>=20
> Hi Qian, thanks for the patch.
> Rather than disable the warning outright, and bury the disabling in a
> directory specific Makefile, why not move it to W=3D2 in
> scripts/Makefile.extrawarn?

It could still be useful to have -Woverride-init/initializer-overrides =
in W=3D1
for people only running W=3D1 to catch some real developer mistakes. W=3D2=

might be too noisy to start with.

>=20
>=20
> I think even better would be to use pragma's to disable the warning in
> mm/init.c.  Looks like __diag support was never ported for clang yet
> from include/linux/compiler-gcc.h to include/linux/compiler-clang.h.
>=20
> Then you could do:
>=20
> 28 struct mm_struct init_mm =3D {
> 29   .mm_rb    =3D RB_ROOT,
> 30   .pgd    =3D swapper_pg_dir,
> 31   .mm_users =3D ATOMIC_INIT(2),
> 32   .mm_count =3D ATOMIC_INIT(1),
> 33   .mmap_sem =3D __RWSEM_INITIALIZER(init_mm.mmap_sem),
> 34   .page_table_lock =3D
> __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
> 35   .arg_lock =3D  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
> 36   .mmlist   =3D LIST_HEAD_INIT(init_mm.mmlist),
> 37   .user_ns  =3D &init_user_ns,
> 38   .cpu_bitmap =3D { [BITS_TO_LONGS(NR_CPUS)] =3D 0},
> __diag_push();
> __diag_ignore(CLANG, 4, "-Winitializer-overrides")
> 39   INIT_MM_CONTEXT(init_mm)
> __diag_pop();
> 40 };

The pragma might be fine for Clang, although it seems a bit overkill.
Then, it needs to add something for GCC=E2=80=99s "override-init" as =
well.
If that mm_init.c grows in the future to have more structs, it may =
become
more desirable to use =E2=80=9Cpragma=E2=80=9D to only disable this =
particular struct.

>=20
> I mean, the arm64 case is not a bug, but I worry about turning this
> warning off.  I'd expect it to only warn once during an arm64 build,
> so does the warning really detract from "W=3D1 gem finding?=E2=80=9D

I am running this every day and seeing this every time, so definitely
appreciate disabling it in the kernel itself if not adding too much work
for maintainers. See the end of this file for my current filtering,

https://github.com/cailca/linux-mm/blob/master/compile.sh

>=20
>> @@ -21,6 +21,9 @@ KCOV_INSTRUMENT_memcontrol.o :=3D n
>> KCOV_INSTRUMENT_mmzone.o :=3D n
>> KCOV_INSTRUMENT_vmstat.o :=3D n
>>=20
>> +CFLAGS_init-mm.o +=3D $(call cc-disable-warning, override-init)
>=20
> -Woverride-init isn't mentioned in the commit message, so not sure if
> it's meant to ride along?

Yes, I did also mention GCC will also warn those (from -Woverride-init) =
but
did not include in the warning output which seems redundant.

