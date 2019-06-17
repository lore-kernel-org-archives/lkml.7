Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B22C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDBF2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ingREZ1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfFQO74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:59:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38074 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQO7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:59:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so9476985wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ghbiEfQ6eCAvNR3r+RTqQOdACpqT5ffcn6cO7EYSCQI=;
        b=ingREZ1HqUKGlmG/guNYSpiJDuTNDsJ0go8J5yZCMurHP+Uu7wXwE1G75cLSbhlL3v
         qLsZT+UPiey6CH1QT59tUW9FgGrUOe0UToIOB9AnuRaqf/W+WIKzVgmH/FkL7ZdB1AAe
         c44+xWbOLjf2mCDY2E1y7GRWm4xvzmsDS1U7bROepRkLzIzbhaV09+ylFsWix8vF6Te3
         pgopenGGUoCzG9iMGp3U3HZLVESHEdn3nZtBbKOCAWf60sP6cmtDtsvf6bmezTktY4/8
         yZSfXxvOaE7uX9/+5O3mUiOz/ExnSgNpxTlwWz2JXVRiBgvq4Wch/RUA3yO7VaG3PELG
         Bk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ghbiEfQ6eCAvNR3r+RTqQOdACpqT5ffcn6cO7EYSCQI=;
        b=gV210R/VdfdhajOIomrC0/i8YEKRk3KVnGaH47Bbz0mBP+HsbrdFdDT6f9EAgMu3Pc
         wLc8/vR1agGGSP0NukXWwWdYSv7TEn8Ddnl4lMrwzpI1IDZ6Py+iFU3vTdPsgl7dp22q
         175UGpdSkbJjnxGA/CXFFxKFNNZ8bdJTEkXdgfoPG+QCrjoIna+44+OnXVAm1lSuODNw
         sXaUYCRF3rlZnfB37cHHvjnxdPNwiykNXO8TrKixq0PHu7xr6nCZGzRFA/AN4UZyyKnX
         ZlvmL3BA0MAjLx04Bf4c0im+0esTgDI/NKXSsCFFBuI1NRgWrp8CPX3X51Z3DNJZiQB5
         fKuA==
X-Gm-Message-State: APjAAAUbn61zjVxJmCni7+UjAsfvuZ4HP5J9fJq0f5JZ3YAvV7Zc/LYp
        C3m9Bog0okR/ABCohryIZBIE6Q==
X-Google-Smtp-Source: APXvYqzyEjO+Stva9Hk5FhGPLNeui4HWadt++cOLvSfgor8T/7IhZMEgLGDRVw8RCUNOBQHGwAp6pw==
X-Received: by 2002:a1c:f918:: with SMTP id x24mr12940842wmh.132.1560783592558;
        Mon, 17 Jun 2019 07:59:52 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r2sm16240349wma.26.2019.06.17.07.59.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 07:59:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 993AE1FF87;
        Mon, 17 Jun 2019 15:59:51 +0100 (BST)
References: <20190617104237.2082388-1-arnd@arndb.de> <20190617112652.GB30800@fuggles.cambridge.arm.com> <CAK8P3a2aJNiLTyfRDqazJa2sAc-Jf-QShSZ7+4-whHSxKbLUVQ@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64/sve: fix genksyms generation
In-reply-to: <CAK8P3a2aJNiLTyfRDqazJa2sAc-Jf-QShSZ7+4-whHSxKbLUVQ@mail.gmail.com>
Date:   Mon, 17 Jun 2019 15:59:51 +0100
Message-ID: <87a7eg9s0o.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd Bergmann <arnd@arndb.de> writes:

> On Mon, Jun 17, 2019 at 1:26 PM Will Deacon <will.deacon@arm.com> wrote:
>>
>> Hi Arnd,
>>
>> On Mon, Jun 17, 2019 at 12:42:11PM +0200, Arnd Bergmann wrote:
>> > genksyms does not understand __uint128_t, so we get a build failure
>> > in the fpsimd module when it cannot export a symbol right:
>>
>> The fpsimd code is builtin, so which module is actually failing? My
>> allmodconfig build succeeds, so I must be missing something.
>
> It happened for me on randconfig builds, you can find one such configurat=
ion
> at https://pastebin.com/cU8iQ4ta now. I was building this with clang
> rather than gcc, which may affect the issue, but I assumed not.
>
>> > WARNING: EXPORT symbol "kernel_neon_begin" [vmlinux] version generatio=
n failed, symbol will not be versioned.
>> > /home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-lin=
ux-ld: arch/arm64/kernel/fpsimd.o: relocation R_AARCH64_ABS32 against `__cr=
c_kernel_neon_begin' can not be used when making a shared object
>> > arch/arm64/kernel/fpsimd.o:(.data+0x0): dangerous relocation: unsuppor=
ted relocation
>> > arch/arm64/kernel/fpsimd.o:(".discard.addressable"+0x0): dangerous rel=
ocation: unsupported relocation
>> > arch/arm64/kernel/fpsimd.o:(".discard.addressable"+0x8): dangerous rel=
ocation: unsupported relocation
>> >
>> > We could teach genksyms about the type, but it's easier to just
>> > work around it by defining that type locally in a way that genksyms
>> > understands.
>> >
>> > Fixes: 41040cf7c5f0 ("arm64/sve: Fix missing SVE/FPSIMD endianness con=
versions")
>>
>> I can't see which part of that patch causes the problem, so I'm a bit wa=
ry
>> of the fix. We've been using __uint128_t for a while now, and I see ther=
e's
>> one in the x86 kvm code as well, so it would be nice to understand what's
>> happening here so that we can avoid running into it in future as well.
>
> The problem is only in files that export a symbol. This is also the
> case in arch/x86/kernel/kvm.c, but it may be lucky because the
> type only appears /after/ the last export in that file.
>
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > ---
>> >  arch/arm64/kernel/fpsimd.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> > index 07f238ef47ae..2aba07cccf50 100644
>> > --- a/arch/arm64/kernel/fpsimd.c
>> > +++ b/arch/arm64/kernel/fpsimd.c
>> > @@ -400,6 +400,9 @@ static int __init sve_sysctl_init(void) { return 0=
; }
>> >  #define ZREG(sve_state, vq, n) ((char *)(sve_state) +                \
>> >       (SVE_SIG_ZREG_OFFSET(vq, n) - SVE_SIG_REGS_OFFSET))
>> >
>> > +#ifdef __GENKSYMS__
>> > +typedef __u64 __uint128_t[2];
>> > +#endif
>>
>> I suspect I need to figure out what genksyms is doing, but I'm nervous
>> about exposing this as an array type without understanding whether or
>> not that has consequences for its operation.
>
> The entire point is genksyms is to ensure that types of exported symbols
> are compatible. To do this, it has a limited parser for C source code that
> understands the basic types (char, int, long, _Bool, etc) and how to
> aggregate them into structs and function arguments. This process has
> always been fragile, and it clearly breaks when it fails to understand a
> particular type.

Shouldn't the solution for this be to fix genksyms to be less fragile
and more understanding? The code base doesn't seem to be full of these
sorts of ifdef workarounds.

>
>           Arnd


--
Alex Benn=C3=A9e
