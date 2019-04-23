Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2927C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDE8217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfDWSjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:39:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41512 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWSjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:39:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id k8so1890688lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoiJeyfn2JDjoLr/hsiqivn27AQGiJVv9wLuHEsyIzg=;
        b=EK8wfndVdpAZ20neyu7DAQxLAgu59cqUSLp3vKcr/5FIvfplYYIlm78AlWCOaJ5kum
         d9xUGU7ds8uK8z7FQhJ0jqAM7XsRNVmiiCV2aC4jMovORSTfSRE2SvjUfBQHrta8zdzW
         CkBCX3PtNHgvds336H8nFZKmlpGJgAe1Iz39l7VeyuRXJEfr3MFomV15nODMh9E5tqN9
         syMDKmQn4Y+6djSouixlk2A7NoJ95rcB6BNpz7cOdqAD7eV8cFNjcte7f9SMXv+16Izu
         IAGuSupxHj1TdTGZPM9pbp+hJyxYHCL9MF/YVvhtjm3QFA1Q6QkraNIZsZLp9CKjnYHd
         VU2g==
X-Gm-Message-State: APjAAAUmHmA0AS4RofVlDic4FJ9QSKOEI4vxdiomtG3VGNsMrbaziVFt
        hO+sMzC1fVnjjk8HZeKO/jM9zNZPyVJhbeMbvUw=
X-Google-Smtp-Source: APXvYqzAFacOM4nxY0hGgMkeR3gzB3hsfu5zFzm0ofB0RnYomdWS/pCDWyvxo19vkP6u1X3tGXSWivosQG9kLA3hYWc=
X-Received: by 2002:a2e:9010:: with SMTP id h16mr14741984ljg.16.1556044783087;
 Tue, 23 Apr 2019 11:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190415143821.GA46880@beast> <20190415170604.GA44415@lakrids.cambridge.arm.com>
 <CAKwvOdk_jFQKW2C2=925So_dvZ6dm03AXMZ9Nk+O1J2xyhE2EA@mail.gmail.com>
 <20190416170808.GC54708@lakrids.cambridge.arm.com> <CAGXu5jKJ4_uY45xJV_Fy=Q7cJzmJz9pZVRFJG0U-C3h95OiZzA@mail.gmail.com>
 <CAKwvOdn-MGokV0vsGq2GdRK-eGHdyC6+vVHYSfwOfpqNWwQzXw@mail.gmail.com>
 <20190423141240.GC56999@lakrids.cambridge.arm.com> <CAKwvOdmQWSO9w5WqsC0RYG-KuRjC2RWGuyckEd-VB14Pie=Osg@mail.gmail.com>
 <CAGXu5jKjtgiViG2yd5AZnJ++=0USDo2JeZDa5GBZdK5nFumBmA@mail.gmail.com>
In-Reply-To: <CAGXu5jKjtgiViG2yd5AZnJ++=0USDo2JeZDa5GBZdK5nFumBmA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 23 Apr 2019 20:39:26 +0200
Message-ID: <CAK8P3a0etMY732bhnjCvARhPwQdutuFP3ezb+8pZPgZqj7oPEg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 8:25 PM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Apr 23, 2019 at 11:15 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > On Tue, Apr 23, 2019 at 7:12 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Mon, Apr 22, 2019 at 10:44:10AM -0700, Nick Desaulniers wrote:
> > > > On Tue, Apr 16, 2019 at 9:03 PM Kees Cook <keescook@chromium.org> wrote:
> > > > >
> > > > > On Tue, Apr 16, 2019 at 12:08 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 15, 2019 at 10:22:27AM -0700, Nick Desaulniers wrote:
> > > > > > > On Mon, Apr 15, 2019 at 10:06 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > > > > It would be nice if we could simply rely on a more recent binutils these
> > > > > > > > days, which supports the generic S<op0>_<op1>_<cn>_<Cm>_<op2> sysreg
> > > > > > > > definition. That would mean we could get rid of the whole msr_s/mrs_s
> > > > > > > > hack by turning that into a CPP macro which built that name.
> > > >
> > > > Mark, can you give me a test case for this? I'd like to check if
> > > > clang's integrated assembler supports this or not, so we can file an
> > > > issue and fix it if not.
> > >
> > > The below is a smoke test. The entire op0:op1:cn:cm:op2 space is 14
> > > bits, so it should be feasible to generate and run an exhautive test for
> > > all encodings.
> > >
> > > I've included SYS and SYSL here too, since I strongly suspect we'll need
> > > those going forward.
> > >
> > > Thanks
> > > Mark.
> > >
> > > ---->8----
> > > /*
> > >  * ${CC} -c test.c
> > >  *
> > >  * OLD_* encodings already exist, NEW_* encodings haven't yet be
> > >  * allocated (per ARM DDI 0487D.a), but should assemble. All encodings
> > >  * chosen arbitrarily.
> > >  */
> > >
> > > // OSDTRRX_EL1
> > > #define OLD_DBG_REG     "s2_0_c0_c0_2"
> > > #define NEW_DBG_REG     "s2_7_c0_c15_0"
> > >
> > > // MIDR_EL1
> > > #define OLD_SYS_REG     "s3_0_c0_c0_0"
> > > #define NEW_SYS_REG     "s3_6_c1_c0_7"
> > >
> > > #define REG(r)                                  \
> > >         asm volatile("msr " r ", xzr\n");       \
> > >         asm volatile("mrs xzr, " r "\n")
> > >
> > > // DC IVAC, XZR
> > > #define OLD_SYS "#0, c7, c6, #1"
> > > #define NEW_SYS "#7, c15, c15, #7"
> > >
> > > #define NEW_SYSL_MIN    "#0, c0, c0, #0"
> > > #define NEW_SYSL_MAX    "#7, c15, c15, #7"
> > >
> > > #define SYS(s)  asm volatile("sys " s ", xzr\n")
> > > #define SYSL(s) asm volatile("sysl xzr, " s "\n")
> > >
> > > void test(void)
> > > {
> > >         REG(OLD_DBG_REG);
> > >         REG(NEW_DBG_REG);
> > >
> > >         REG(OLD_SYS_REG);
> > >         REG(NEW_SYS_REG);
> > >
> > >         SYS(OLD_SYS);
> > >         SYS(NEW_SYS);
> > >
> > >         SYSL(NEW_SYSL_MIN);
> > >         SYSL(NEW_SYSL_MAX);
> > > }
> >
> > Hmmm...yes looks like Clang's integrated assembler is missing support.
> > https://godbolt.org/z/wDBpz4

It looks like you forgot to pass --target=aarch64-linux-gnu to clang here,
which produces a build failure. This is the output with the added flag:

https://godbolt.org/z/HYoEH1

> > https://bugs.llvm.org/show_bug.cgi?id=41573
> > https://github.com/ClangBuiltLinux/linux/issues/453
> > We'll follow up on getting that fixed.
> >
> > Kees, are you able to respin the patch with the above requested
> > changes from Mark to the macros?  Let me know what I can do to help.
>
> Doesn't this mean arm64 must raise their minimum binutils to 2.25? Is
> that acceptable? I hadn't seen that question answered yet. (Maybe I
> missed it?)

Generally I'd say that's a bit too new for a minimum version. On the other
hand, most distros I could find for arm64 have at least 2.25 or later,
the oldest
one I found being Debian Jessie. Ubuntu Trusty (14.04) was using 2.24 but
has its end of support date this month, after five years.

However, there are probably still cross-compile toolchains around that use
older aarch64-binutils, so it probably hurts someone.

       Arnd
