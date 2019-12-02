Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A001BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7345F20718
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfLBOEP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:04:15 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:54379 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfLBOEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 09:04:14 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MsrV2-1hnNVj2pjc-00tFFV for <linux-kernel@vger.kernel.org>; Mon, 02 Dec
 2019 15:04:11 +0100
Received: by mail-qt1-f171.google.com with SMTP id p5so10705853qtq.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 06:04:11 -0800 (PST)
X-Gm-Message-State: APjAAAWHaiNMmSX5Q7EuQlsvZ4sY5rYZtUDtOmpqQ8HEPPdvw00RSvNt
        doUCqf/MZjx+JZFwiRKGtDKcRaPcRAIsW8CnglU=
X-Google-Smtp-Source: APXvYqzY2KEySxcGaO1R0Ld5UfDskq+N3EoKgH5LDEY9SHFisuuB6M4zP0b90vsGoCLiwhc3LVgsBhBPXEnHoaHQQbs=
X-Received: by 2002:ac8:27ab:: with SMTP id w40mr15859502qtw.18.1575295450496;
 Mon, 02 Dec 2019 06:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108210824.1534248-7-arnd@arndb.de>
 <4faa78cd0a86cf5d0aea9bb16d03145c5745450b.camel@codethink.co.uk>
 <CAK8P3a1nRq98ngfKnR2Du+7_vOxSRFD9AyjHyUCsAtk_gLR_Uw@mail.gmail.com>
 <20191121172529.Horde.0uDMS4xQ-xexjp4a2mIoXQ5@messagerie.si.c-s.fr>
 <CAK8P3a1UmAYTx=Vv06xP=O-oYD8_HzNqMG0-p7GPP2xgzs+75w@mail.gmail.com> <85ba697d-1a09-f1b0-b6b6-a511a2920f93@c-s.fr>
In-Reply-To: <85ba697d-1a09-f1b0-b6b6-a511a2920f93@c-s.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 2 Dec 2019 15:03:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3-LCvF_V50k9Mwzc1coUjKc9kqVzYuD6bS6pg71hRJXQ@mail.gmail.com>
Message-ID: <CAK8P3a3-LCvF_V50k9Mwzc1coUjKc9kqVzYuD6bS6pg71hRJXQ@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 07/23] y2038: vdso: powerpc: avoid timespec references
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Allison Randal <allison@lohutok.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:tlbt82ceCDDgY/Q8SkQlUuu3CXZtAY8sfxP/XKvCwdcqI2M+pPz
 ae9qvjkzAXQKTWoAYFCKsozFjlV5YsXW0q+oH6NpDxaZG3M98eOGIHRdOuRdSABdq2AgIY2
 il0476EKlGRNnBB6F9USY8F6KzND1rvbjnfveOs8iTn2F6g7p7TRRlPyo3+MEobRs67oOJ5
 KAi58oN/YqVaxH18wqKIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mvgPR5nTy/Y=:ffm5WI0/r1toJUuiZNx8TD
 h3cVTVeAhP94UqpNO857OTSWaXE5ehs1C9PQ6wdjgXZajBjUnI2sAFdzxlgLjlflgetU5FpaF
 nhXYUAq+bBl1Us3S0C2rGQjt6wrK+uY1cZI2SwciJx2vy80nY5ioG27fwiqJj7xTyXYoEKic+
 /YC2G8bbUcmPYwXpLB0vUazSztDR+v8YMAAumbENe28eSlLZZ1Df9BzX0QA8Fuc21v4iEQ7xZ
 6S6C+KqQ00bkEK0XyYBSr0ZDc/On90fpnzH67DHjIF0MdRtU8qBGFnsK5booo9IF5DWqN/GzO
 sP3FNOFRrMyYymCEDoxhb/3Xfdxj6DRFL2VWXDQFYPRqWe0WyJ3syyGDWbzozDRkNGTsm6P0F
 U2dN5eMPKBdhUybeRrCQiTDuFbPqrYGMpZ2IuIcZ0SKI76e2g6ahctjG8Ri6RGI3gY1FKAc2T
 8gw8fiIgfNI7G5JeWfGe4Cjotgp/N7yp0NJlGQ1rv4HzmN4Jva2kXApQPuCSQC5M7LOkhbLt9
 hzUJWWR0+5yp75KYlD9n98l5uz4FazG+vpAhhG31tv3fzf1sN2Hd4fLyYgC1DplPpdYzlYLux
 pWDLIICdTnBxj9nm7RSsCDiO9TMejepIGEOqv0+2ZH1GGqPsWLqJqIKP/4+g8hSbEpEf+BcT6
 8mIwtISlDGxKg9QaSevVVG06URz8ENutppGYmrMXLYBMIgS305n6Z29wA0gse3sTkUg38K0SC
 o0EHtF+h4Agf4/gUS9qgFEmXjO5WIPYkoVrNL5COEQ4Tpntf1ITlSr6mQnuh8D277JwETWCwG
 cqGK0cpf8w3T3CTB7X8G4ChpcDDNbNbqDXdGspDn596X1SH5cXje/5dnuAy0+/oJRJMzqF5LB
 yQ7IQrnPRcv0BiXQJF8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 1:55 PM Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> Le 27/11/2019 à 12:03, Arnd Bergmann a écrit :
> > On Thu, Nov 21, 2019 at 5:25 PM Christophe Leroy
> > <christophe.leroy@c-s.fr> wrote:
> >> Arnd Bergmann <arnd@arndb.de> a écrit :
> >>> On Wed, Nov 20, 2019 at 11:43 PM Ben Hutchings
> >>> <ben.hutchings@codethink.co.uk> wrote:
> >>>>
> >>>> On Fri, 2019-11-08 at 22:07 +0100, Arnd Bergmann wrote:
> >>>>> @@ -192,7 +190,7 @@ V_FUNCTION_BEGIN(__kernel_time)
> >>>>>        bl      __get_datapage@local
> >>>>>        mr      r9, r3                  /* datapage ptr in r9 */
> >>>>>
> >>>>> -     lwz     r3,STAMP_XTIME+TSPEC_TV_SEC(r9)
> >>>>> +     lwz     r3,STAMP_XTIME_SEC+LOWPART(r9)
> >>>>
> >>>> "LOWPART" should be "LOPART".
> >>>>
> >>>
> >>> Thanks, fixed both instances in a patch on top now. I considered folding
> >>> it into the original patch, but as it's close to the merge window I'd
> >>> rather not rebase it, and this way I also give you credit for
> >>> finding the bug.
> >>
> >> Take care, might conflict with
> >> https://github.com/linuxppc/linux/commit/5e381d727fe8834ca5a126f510194a7a4ac6dd3a
> >
> > Sorry for my late reply. I see this commit and no other variant of it has
> > made it into linux-next by now, so I assume this is not getting sent for v5.5
> > and it's not stopping me from sending my own pull request.
> >
> > Please let me know if I missed something and this will cause problems.
> >
> > On a related note: are you still working on the generic lib/vdso support for
> > powerpc? Without that, future libc implementations that use 64-bit time_t
> > will have to use the slow clock_gettime64 syscall instead of the vdso,
> > which has a significant performance impact.
>
> I have left this generic lib/vdso subject aside for the moment, because
> performance is disappointing and its architecture doesn't real fit with
> powerpc ABI.
>
>  From a performance point of view, it is manipulating 64 bits vars where
> is could use 32 bits vars. Of course I understand that y2038 will anyway
> force the use of 64 bits for seconds, but at the time being powerpc32
> VDSO is using 32 bits vars for both secs and ns, it make the difference.

Do you think we could optimize the common code? This sounds like
it could improve things for other architectures as well.

> Also, the generic VDSO is playing too much with data on stacks and
> associated memory read/write/copies, which kills performance on RISC
> processors like powerpc. Inlining do_hres() for instance significantly
> improves that as it allow handling the 'struct __kernel_timespec ts' on
> registers instead of using stack.

That should be easy enough to change in the common code, as
long as adding 'inline' does not cause harm on x86 and arm.

> Regarding powerpc ABI, the issue is that errors shall be reported by
> setting the SO bit in CR register, and this cannot be done in C.
> This means:
> - The VDSO entry point must be in ASM and the generic VDSO C function
> must be called from there, it cannot be the VDSO entry point.
> - The VDSO fallback (ie the system call) cannot be done from the generic
> VDSO C function, it must be called from the ASM as well.

As far as I can tell, both the VDSO entry point and the fallback are
in architecture specific code on all architectures, so this does not
seem to be a show-stopper.

It also seems that they might be combined as long the current
powerpc code could be changed to use the generic vdso_data
structure definition: the existing code can keep being used for
gettimeofday(), clock_gettime(CLOCK_MONOTONIC, ...) and
clock_gettime(CLOCK_REALTIME), while the generic implementation
can be called for clock_gettime64(), clock_getres() and clock_gettime()
with other time clock IDs.

> Last point/question, what's the point in using 64 bits for nanoseconds
> on 32 bits arches ?

The __kernel_timespec structure is defined with two 64-bit members so
it has the same layout on both 32-bit and 64-bit architectures, which
lets us share the implementation of the compat syscall handlers
even on big-endian architectures, and it avoids accidentally leaking four
bytes of stack data when copying a timespec from kernel to user
space. The high 32 bits of the nanosecond are expected to always
be zero when copying to user space, and to be ignored when copied
into the kernel (see get_timespec64()).

Note that C99 and POSIX require tv_nsec to be 'long', so 64-bit
architectures have to make it 64-bit wide, and 32-bit architectures
end up including padding for it.

In the vdso_data, the "nsec" value is shifted, so it actually needs
more bits. I don't know if this is a strict requirement, or if we could
change it to be 32 bits non-shifted during the update at the cost
of losing 1 nanosecond of accuracy.

      Arnd
