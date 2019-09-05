Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41168C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA8A20828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JIHX+RDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfIEATy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 20:19:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43981 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfIEATx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:19:53 -0400
Received: by mail-io1-f67.google.com with SMTP id u185so598825iod.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 17:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8FjvM+xZTfjefVntC7Dkwl+p61IeCQldrgQjZXcaMg=;
        b=JIHX+RDghUdIkvnOdsM/PY8Y7heFzotLjcftXFtKBpKuB4dz/K/XDAKxzWaKg2I1XC
         Vz6sMON5ZX1+8KMKoRoviWAlzywzbYUMen6tQnECNBUudaP2dmUn0fO0cZ/xzXG/JEYy
         XzjJog43uBwHAuzDACxL6soXKKxy24vzAA8ngXf+U4mCsy+Nm5e+I415ka9/O++sPGSe
         fnNZytDBJGmQWy2v6LF4iQ00F1c6A5ZBf+AgDGwSvz2dKQnhghssnjXyk2pM9qfvWKZv
         Zn3ukQ2GzcoYmz3jm59o1v8fRDjqYxeTBQ6tqje9/9gpM71maD+qdtJiiX/vOjAxDI00
         19Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8FjvM+xZTfjefVntC7Dkwl+p61IeCQldrgQjZXcaMg=;
        b=ixZbZa+6JQS6TJXeY2/2cf2KNfP0xrUo2XYqMAWn/Bxl0RQ/VbxBUhRcg67xXRpUE7
         0rDtne9msrUvz+CcYwGJATmYNGT9brz6HnSZ57F4565YIymVupumdmueD8aNFAjPC1Eb
         G++jwJEo1+hbOCofpS+DZ32/bR2IoVoiH9pgdKq/FnqFvw0p96LePAIH2pOdOcmTvERc
         SgnhpnL86vU9//ADP8regVxAlBiDlT0eQpVRrc1kmeh9HERz1RpJ4zTKPoTun5s0x/2Q
         cu+yDJj9DQEDHhbtPMU4wYMBO8jx0KZ89pEsgJjsrJFlJ1ZhqtK5GahIP/oG7R5uXBue
         Y8DA==
X-Gm-Message-State: APjAAAU/85/sCvVkdKuvvTacEx2Jricy/CguEFCHSzGeEoQl54Cv9bch
        bGPRGlTnlgHvKlqWzxLcP8bqgNbOkUgYXLy7fTRHLQ==
X-Google-Smtp-Source: APXvYqx9xqc2bk9SyNoy04T4d/UrBaK+colXw+QVDalT4kFoA0/MgtWHqJfi7ZY+6elUnmiRCt3C3nCSUIGJ9hBpR7o=
X-Received: by 2002:a5d:9696:: with SMTP id m22mr936477ion.14.1567642792697;
 Wed, 04 Sep 2019 17:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190904214505.GA15093@swahl-linux> <CAKwvOdnX3qVq1wGovViyGJSnySKzCATU4SU_ASsL-9XfDZ8+Eg@mail.gmail.com>
 <CAMVonLiOB4PnbnLGo9gP8MK8kGd_e9vW_t+GOPuHMO_RqmkKNA@mail.gmail.com>
In-Reply-To: <CAMVonLiOB4PnbnLGo9gP8MK8kGd_e9vW_t+GOPuHMO_RqmkKNA@mail.gmail.com>
From:   Vaibhav Rustagi <vaibhavrustagi@google.com>
Date:   Wed, 4 Sep 2019 17:19:41 -0700
Message-ID: <CAMVonLjBcJm2DqyhybLjCDsm8P9jqSybvq0geDAfvbVn=P0N-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/purgatory: Change compiler flags to avoid
 relocation errors.
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        mike.travis@hpe.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 3:28 PM Vaibhav Rustagi
<vaibhavrustagi@google.com> wrote:
>
> On Wed, Sep 4, 2019 at 3:19 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > + (folks recommended by ./scripts/get_maintainer.pl <patchfile>)
> > (See also, step 7:
> > https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/)
> >
> > On Wed, Sep 4, 2019 at 2:45 PM Steve Wahl <steve.wahl@hpe.com> wrote:
> > >
> > > The last change to this Makefile caused relocation errors when loading
> >
> > It's good to add a fixes tag like below when a patch fixes a
> > regression, so that stable backports the fix as far back as the
> > regression:
> > Fixes: b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than
> > reset KBUILD_CFLAGS")
> >
> > > a kdump kernel.  This change restores the appropriate flags, without
> > > reverting to the former practice of resetting KBUILD_CFLAGS.
> > >
> > > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > > ---
> > >  arch/x86/purgatory/Makefile | 35 +++++++++++++++++++----------------
> > >  1 file changed, 19 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> > > index 8901a1f89cf5..9f0bfef1f5db 100644
> > > --- a/arch/x86/purgatory/Makefile
> > > +++ b/arch/x86/purgatory/Makefile
> > > @@ -18,37 +18,40 @@ targets += purgatory.ro
> > >  KASAN_SANITIZE := n
> > >  KCOV_INSTRUMENT := n
> > >
> > > +# These are adjustments to the compiler flags used for objects that
> > > +# make up the standalone porgatory.ro
> > > +
> > > +PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> > > +PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
> >
> > Thanks for confirming the fix.  While it sounds like -mcmodel=large is
> > the only necessary change, I don't object to -ffreestanding of
> > -fno-zero-initialized-in-bss being readded, especially since I think
> > what you've done with PURGATORY_CFLAGS_REMOVE is more concise.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Vaibhav, do you still have an environment setup to quickly test this
> > again w/ Clang builds?
>
> I will setup the environment and will try the changes.
>
I tried the changes and kdump was working.

> > Tglx, we'll likely want to get this into 5.3 if it's not too late (I
> > saw Miguel Ojeda mention there might be an -rc8)?
> >
> > > +
> > >  # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
> > >  # in turn leaves some undefined symbols like __fentry__ in purgatory and not
> > >  # sure how to relocate those.
> > >  ifdef CONFIG_FUNCTION_TRACER
> > > -CFLAGS_REMOVE_sha256.o         += $(CC_FLAGS_FTRACE)
> > > -CFLAGS_REMOVE_purgatory.o      += $(CC_FLAGS_FTRACE)
> > > -CFLAGS_REMOVE_string.o         += $(CC_FLAGS_FTRACE)
> > > -CFLAGS_REMOVE_kexec-purgatory.o        += $(CC_FLAGS_FTRACE)
> > > +PURGATORY_CFLAGS_REMOVE                += $(CC_FLAGS_FTRACE)
> > >  endif
> > >
> > >  ifdef CONFIG_STACKPROTECTOR
> > > -CFLAGS_REMOVE_sha256.o         += -fstack-protector
> > > -CFLAGS_REMOVE_purgatory.o      += -fstack-protector
> > > -CFLAGS_REMOVE_string.o         += -fstack-protector
> > > -CFLAGS_REMOVE_kexec-purgatory.o        += -fstack-protector
> > > +PURGATORY_CFLAGS_REMOVE                += -fstack-protector
> > >  endif
> > >
> > >  ifdef CONFIG_STACKPROTECTOR_STRONG
> > > -CFLAGS_REMOVE_sha256.o         += -fstack-protector-strong
> > > -CFLAGS_REMOVE_purgatory.o      += -fstack-protector-strong
> > > -CFLAGS_REMOVE_string.o         += -fstack-protector-strong
> > > -CFLAGS_REMOVE_kexec-purgatory.o        += -fstack-protector-strong
> > > +PURGATORY_CFLAGS_REMOVE                += -fstack-protector-strong
> > >  endif
> > >
> > >  ifdef CONFIG_RETPOLINE
> > > -CFLAGS_REMOVE_sha256.o         += $(RETPOLINE_CFLAGS)
> > > -CFLAGS_REMOVE_purgatory.o      += $(RETPOLINE_CFLAGS)
> > > -CFLAGS_REMOVE_string.o         += $(RETPOLINE_CFLAGS)
> > > -CFLAGS_REMOVE_kexec-purgatory.o        += $(RETPOLINE_CFLAGS)
> > > +PURGATORY_CFLAGS_REMOVE                += $(RETPOLINE_CFLAGS)
> > >  endif
> > >
> > > +CFLAGS_REMOVE_purgatory.o      += $(PURGATORY_CFLAGS_REMOVE)
> > > +CFLAGS_purgatory.o             += $(PURGATORY_CFLAGS)
> > > +
> > > +CFLAGS_REMOVE_sha256.o         += $(PURGATORY_CFLAGS_REMOVE)
> > > +CFLAGS_sha256.o                        += $(PURGATORY_CFLAGS)
> > > +
> > > +CFLAGS_REMOVE_string.o         += $(PURGATORY_CFLAGS_REMOVE)
> > > +CFLAGS_string.o                        += $(PURGATORY_CFLAGS)
> > > +
> > >  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
> > >                 $(call if_changed,ld)
> > >
> > > --
> > > 2.12.3
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
