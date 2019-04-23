Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F49C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CAC208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IYXkbO/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfDWSZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:25:13 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36863 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:25:12 -0400
Received: by mail-vs1-f68.google.com with SMTP id n4so8860759vsm.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=if3aREtpyX0FNMps2Zv3zre79UuMsiGAazfiBrvr3d0=;
        b=IYXkbO/NwTx1pT07MY2pIIYLqMB3EKDOOUr/49SV93hwBGYx5heJ3hdEG/YWbBC43I
         3lnRVWcUsGts9XPWgH1OcUXcfFQyq7A5037uuHL70CUAXRiw6n8ueRCmLuJwDC7uE4v+
         H490CsJ7kh46Q1qgfx3Ni83YwQttZ41reDHbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=if3aREtpyX0FNMps2Zv3zre79UuMsiGAazfiBrvr3d0=;
        b=Zm8DqElGQGW5JM8/ng6fCeWws4d6Ix5enNrCGBrnwSUCl9CvMMGZ3aFfGefuNI45rj
         NSWzatodeA4gdcDkxEiZTWm+/z2Ls7dARtjT47MKaFB14WGlrhsrWxoF5nl2dxkt68rW
         JRBloFW332iGETuXU49Guyyn//qqOnMkQwa0QfA9s1qLvKYZnMAsMOKkouk0elqMUV31
         XUMXIKQlZl4/OI//dWzbbir9AmduKMPVS6tRHW2H5Z3m2V/Ig8omJNMifDlAnXgnZR0G
         vP86qwuGdNLMTPRTXAbnuKXCI8iQAxr+OqXW3iTbWmkGq9TvO/kzxYEy6yVFquSRP30B
         1/NQ==
X-Gm-Message-State: APjAAAUBceYp4igNxGRWQdRal9NdQAV/bRigf50sDZBxe/Onqv7RvL75
        IT4F5s457AUz+HrvjFdM+SXEtmxWpmU=
X-Google-Smtp-Source: APXvYqx0y+Xgv+HAYL3fvmOdF/OQeQJqhbI901m6FMgaFF9hqtYJ0ykFdousLyUy5qpPcQKby2VtUg==
X-Received: by 2002:a67:ce8f:: with SMTP id c15mr13991387vse.213.1556043908183;
        Tue, 23 Apr 2019 11:25:08 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id k65sm4797532vkk.40.2019.04.23.11.25.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 11:25:07 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id j184so8830250vsd.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:25:06 -0700 (PDT)
X-Received: by 2002:a67:7c8a:: with SMTP id x132mr14284684vsc.172.1556043906228;
 Tue, 23 Apr 2019 11:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190415143821.GA46880@beast> <20190415170604.GA44415@lakrids.cambridge.arm.com>
 <CAKwvOdk_jFQKW2C2=925So_dvZ6dm03AXMZ9Nk+O1J2xyhE2EA@mail.gmail.com>
 <20190416170808.GC54708@lakrids.cambridge.arm.com> <CAGXu5jKJ4_uY45xJV_Fy=Q7cJzmJz9pZVRFJG0U-C3h95OiZzA@mail.gmail.com>
 <CAKwvOdn-MGokV0vsGq2GdRK-eGHdyC6+vVHYSfwOfpqNWwQzXw@mail.gmail.com>
 <20190423141240.GC56999@lakrids.cambridge.arm.com> <CAKwvOdmQWSO9w5WqsC0RYG-KuRjC2RWGuyckEd-VB14Pie=Osg@mail.gmail.com>
In-Reply-To: <CAKwvOdmQWSO9w5WqsC0RYG-KuRjC2RWGuyckEd-VB14Pie=Osg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 11:24:53 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKjtgiViG2yd5AZnJ++=0USDo2JeZDa5GBZdK5nFumBmA@mail.gmail.com>
Message-ID: <CAGXu5jKjtgiViG2yd5AZnJ++=0USDo2JeZDa5GBZdK5nFumBmA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
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

On Tue, Apr 23, 2019 at 11:15 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Apr 23, 2019 at 7:12 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Mon, Apr 22, 2019 at 10:44:10AM -0700, Nick Desaulniers wrote:
> > > On Tue, Apr 16, 2019 at 9:03 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Tue, Apr 16, 2019 at 12:08 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > >
> > > > > On Mon, Apr 15, 2019 at 10:22:27AM -0700, Nick Desaulniers wrote:
> > > > > > On Mon, Apr 15, 2019 at 10:06 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > > > It would be nice if we could simply rely on a more recent binutils these
> > > > > > > days, which supports the generic S<op0>_<op1>_<cn>_<Cm>_<op2> sysreg
> > > > > > > definition. That would mean we could get rid of the whole msr_s/mrs_s
> > > > > > > hack by turning that into a CPP macro which built that name.
> > >
> > > Mark, can you give me a test case for this? I'd like to check if
> > > clang's integrated assembler supports this or not, so we can file an
> > > issue and fix it if not.
> >
> > The below is a smoke test. The entire op0:op1:cn:cm:op2 space is 14
> > bits, so it should be feasible to generate and run an exhautive test for
> > all encodings.
> >
> > I've included SYS and SYSL here too, since I strongly suspect we'll need
> > those going forward.
> >
> > Thanks
> > Mark.
> >
> > ---->8----
> > /*
> >  * ${CC} -c test.c
> >  *
> >  * OLD_* encodings already exist, NEW_* encodings haven't yet be
> >  * allocated (per ARM DDI 0487D.a), but should assemble. All encodings
> >  * chosen arbitrarily.
> >  */
> >
> > // OSDTRRX_EL1
> > #define OLD_DBG_REG     "s2_0_c0_c0_2"
> > #define NEW_DBG_REG     "s2_7_c0_c15_0"
> >
> > // MIDR_EL1
> > #define OLD_SYS_REG     "s3_0_c0_c0_0"
> > #define NEW_SYS_REG     "s3_6_c1_c0_7"
> >
> > #define REG(r)                                  \
> >         asm volatile("msr " r ", xzr\n");       \
> >         asm volatile("mrs xzr, " r "\n")
> >
> > // DC IVAC, XZR
> > #define OLD_SYS "#0, c7, c6, #1"
> > #define NEW_SYS "#7, c15, c15, #7"
> >
> > #define NEW_SYSL_MIN    "#0, c0, c0, #0"
> > #define NEW_SYSL_MAX    "#7, c15, c15, #7"
> >
> > #define SYS(s)  asm volatile("sys " s ", xzr\n")
> > #define SYSL(s) asm volatile("sysl xzr, " s "\n")
> >
> > void test(void)
> > {
> >         REG(OLD_DBG_REG);
> >         REG(NEW_DBG_REG);
> >
> >         REG(OLD_SYS_REG);
> >         REG(NEW_SYS_REG);
> >
> >         SYS(OLD_SYS);
> >         SYS(NEW_SYS);
> >
> >         SYSL(NEW_SYSL_MIN);
> >         SYSL(NEW_SYSL_MAX);
> > }
>
> Hmmm...yes looks like Clang's integrated assembler is missing support.
> https://godbolt.org/z/wDBpz4
> https://bugs.llvm.org/show_bug.cgi?id=41573
> https://github.com/ClangBuiltLinux/linux/issues/453
> We'll follow up on getting that fixed.
>
> Kees, are you able to respin the patch with the above requested
> changes from Mark to the macros?  Let me know what I can do to help.

Doesn't this mean arm64 must raise their minimum binutils to 2.25? Is
that acceptable? I hadn't seen that question answered yet. (Maybe I
missed it?)

-- 
Kees Cook
