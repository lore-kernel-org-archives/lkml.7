Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D476C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72017208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lonelycoder.com header.i=@lonelycoder.com header.b="iU4GU7M+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbfIEFeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 01:34:25 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36955 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfIEFeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:34:25 -0400
Received: by mail-oi1-f193.google.com with SMTP id v7so781336oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 22:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lonelycoder.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDeL1H8rDxfUHOLv70GUO77M1psIvXCkWkx60/Nsrkc=;
        b=iU4GU7M+14QxcU0lK5lK/o/Ss6KqjXSdFosvRlvOe2pX9s2IaiAhVQwOWKIkRGK6Wo
         e6V6TI+A3vRzT9iCDrn0av1tGCJnVdGPX3ryovJ8aW7K/c3smGptIUOgjLI9pdXAYuTS
         WekNyAv7QolsvCPnks95C+ytwEYrnbMrIsdi/lR4q8C+9Dz16pLgCw3F4OL8HALABLrg
         mk6YpJPGmRdlh/CQ3mvMnkoSJrKKDLYekARHuwFN1a0qsXrlVbUMK+m0XCHngrq2fZEm
         Enu0IJ4jO1XKClQDcvjquj/CcX+EZxybLRcU39jLh10btv3gmmSPE3OU+nIl00P8MCL8
         L2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDeL1H8rDxfUHOLv70GUO77M1psIvXCkWkx60/Nsrkc=;
        b=dKpDYyMCZWJt3+4fROi5hZiRrmVsRhN/UixaiHTb8i4i+2vor7Kv5NzqTUR4Hg9XQ9
         GV9ODh472KYzTg7cKwi892S1e5RkGrZrLWWMakhOI+GS+eCYRIfRdb74WCQ7EEV0FAC5
         k1du1uB/0iob2feBkBQWBnqETOhqKUq0/Dr1Bs19gwpIipP9YkmXKVHhIeNJYvxKp8qz
         B0GUYTIx66IMZYgQ52KDZ1cNcBqblM1B0ATDv8mo2/Kvd5pla/OP0IAS7XsnsvvejRAj
         qMoBIB5MAdl78RU8kd87KyLahNbzrFnAAiYdzdH7Brjfi+NqQEV2S7z4u0V1hYKMMrPe
         YOzQ==
X-Gm-Message-State: APjAAAVPIgYwweiOs4GYLg5jHmEq9leThbCVM+eUfiaSnJ03d+sM8DlC
        XzAwu0WIXE0Wt8J7ALXFFYU1or74sL8lfPcgH5xYqA==
X-Google-Smtp-Source: APXvYqwkNHFG+LnJAQduX/5I5AwDfYbut71OtxrmvJ+SvyuERbOXjtrzJFVTNZQfwtIJoLRmFaFMhmgV914/HbUwylc=
X-Received: by 2002:aca:fc91:: with SMTP id a139mr1143435oii.173.1567661663983;
 Wed, 04 Sep 2019 22:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190904214505.GA15093@swahl-linux> <CAKwvOdnX3qVq1wGovViyGJSnySKzCATU4SU_ASsL-9XfDZ8+Eg@mail.gmail.com>
In-Reply-To: <CAKwvOdnX3qVq1wGovViyGJSnySKzCATU4SU_ASsL-9XfDZ8+Eg@mail.gmail.com>
From:   Andreas Smas <andreas@lonelycoder.com>
Date:   Wed, 4 Sep 2019 22:34:13 -0700
Message-ID: <CAObFT-RqSa+8re=jLfM-=yyFH38dz89jRjrwGjnhHhGszKxXmQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/purgatory: Change compiler flags to avoid
 relocation errors.
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
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

On Wed, Sep 4, 2019 at 3:19 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> + (folks recommended by ./scripts/get_maintainer.pl <patchfile>)
> (See also, step 7:
> https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/)
>
> On Wed, Sep 4, 2019 at 2:45 PM Steve Wahl <steve.wahl@hpe.com> wrote:
> >
> > The last change to this Makefile caused relocation errors when loading
>
> It's good to add a fixes tag like below when a patch fixes a
> regression, so that stable backports the fix as far back as the
> regression:
> Fixes: b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than
> reset KBUILD_CFLAGS")
>
> > a kdump kernel.  This change restores the appropriate flags, without
> > reverting to the former practice of resetting KBUILD_CFLAGS.
> >
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > ---
> >  arch/x86/purgatory/Makefile | 35 +++++++++++++++++++----------------
> >  1 file changed, 19 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> > index 8901a1f89cf5..9f0bfef1f5db 100644
> > --- a/arch/x86/purgatory/Makefile
> > +++ b/arch/x86/purgatory/Makefile
> > @@ -18,37 +18,40 @@ targets += purgatory.ro
> >  KASAN_SANITIZE := n
> >  KCOV_INSTRUMENT := n
> >
> > +# These are adjustments to the compiler flags used for objects that
> > +# make up the standalone porgatory.ro
> > +
> > +PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> > +PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
>
> Thanks for confirming the fix.  While it sounds like -mcmodel=large is
> the only necessary change, I don't object to -ffreestanding of
> -fno-zero-initialized-in-bss being readded, especially since I think
> what you've done with PURGATORY_CFLAGS_REMOVE is more concise.

Without -ffreestanding this results in undefined symbols (as before this patch)

$ readelf -a arch/x86/purgatory/purgatory.ro|grep UND
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
    51: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __stack_chk_fail

I just bumped into this issue as I discovered that kexec() no longer works after
the x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS -commit
was merged.
