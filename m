Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C15DC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5522221738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSM0NSvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfDVRoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:44:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39436 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfDVRoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:44:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so6039739pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYlhFUYKuJrNEmSIpZKgtWr/JLFZnE1mxkqqRshiCT4=;
        b=aSM0NSvHIKbVLBChY4mdEqF/BagpCa7gbPEVis5tvlfZmhmHd8Vwip7zDVuaYhrP+8
         BS1olMGInQx2S6l6mzRLr8nhIgZqyS3MsafIC/fI0hbUoDkHlQY+YwHfeanJ5t45/bkO
         dl5QvjhNFvLNF15doZm8r6y/UOK6a+Vd10sVOo/4dgWnTfj9Jiw0NS7Z1pwBr5Mi6gDm
         Rnb6V+8uOQjtmBtKgU7yFNzo4EJKOfzhOiJh+5knAJTtNI3Tlt518l+YwaHshu9iYR/W
         Qk8frl/Xe0a8HWqeTeZKtLjQOdXy53euyGInLeVe24FcASItZSppu7IuXO134Ew5quDT
         kTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYlhFUYKuJrNEmSIpZKgtWr/JLFZnE1mxkqqRshiCT4=;
        b=ht3kTTz12PoF6qZtfjwuimJk9osWz6BzrJDq6DDWwtO5gNA7t9Ee+mD4Y0ykJ7YJ+a
         zXAdGoTOIl/MGLjg1KL+WszHrSg03C9n9HJ3Jqs2t3kWIIP9J++YTYrU6iDnbVdemvHX
         BS+xvLZbw5ozzZpXDE4EWooE5CgQiL6NoMXb6ptIEnouNiokB+pnjhVVnvo6WgzBoIP2
         PpLpeXrdRtj6cMF4mivEMfpLQ020FG/1qZV6R+KRi0zc7kQyO4APVp8GLeUc94lIJDS2
         OH1wpC74S+wg33IMPtkUejTDJ59RNyiD6QpOJsWkHXU5IMkkpzxbYEwuhyzgEXaw55mk
         b4rg==
X-Gm-Message-State: APjAAAWSkXpaTOgPK2cLvsnnkmrwOeiqhDUMxRQ0UT8C66/lWHlcGLRq
        5SJP/sN/VYSTttQ4p5O/Q6GKi/ezIJwCSWA4n1eYUA==
X-Google-Smtp-Source: APXvYqzJtoGWlTclcLjLSODT3dU69BBN+WKRforkdeMqQGA/kEMkriszau6b8LMpYeLrpydoOzQBh3Bc+gokPGECN0I=
X-Received: by 2002:a62:e80f:: with SMTP id c15mr21688266pfi.93.1555955062092;
 Mon, 22 Apr 2019 10:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190415143821.GA46880@beast> <20190415170604.GA44415@lakrids.cambridge.arm.com>
 <CAKwvOdk_jFQKW2C2=925So_dvZ6dm03AXMZ9Nk+O1J2xyhE2EA@mail.gmail.com>
 <20190416170808.GC54708@lakrids.cambridge.arm.com> <CAGXu5jKJ4_uY45xJV_Fy=Q7cJzmJz9pZVRFJG0U-C3h95OiZzA@mail.gmail.com>
In-Reply-To: <CAGXu5jKJ4_uY45xJV_Fy=Q7cJzmJz9pZVRFJG0U-C3h95OiZzA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Apr 2019 10:44:10 -0700
Message-ID: <CAKwvOdn-MGokV0vsGq2GdRK-eGHdyC6+vVHYSfwOfpqNWwQzXw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
To:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
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

On Tue, Apr 16, 2019 at 9:03 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Apr 16, 2019 at 12:08 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Mon, Apr 15, 2019 at 10:22:27AM -0700, Nick Desaulniers wrote:
> > > On Mon, Apr 15, 2019 at 10:06 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > It would be nice if we could simply rely on a more recent binutils these
> > > > days, which supports the generic S<op0>_<op1>_<cn>_<Cm>_<op2> sysreg
> > > > definition. That would mean we could get rid of the whole msr_s/mrs_s
> > > > hack by turning that into a CPP macro which built that name.

Mark, can you give me a test case for this? I'd like to check if
clang's integrated assembler supports this or not, so we can file an
issue and fix it if not.

> > > >
> > > > It looks like binutils has been able to do that since September 2014...
> > > >
> > > > Are folk using toolchains older than that to compile kernels?
> > >
> > > Do you have a link to a commit?  If we can pinpoint the binutils
> > > version, that might help.
> >
> > IIUC any version of binutils with commit:
> >
> >   df7b4545b2b49572 ("[PATCH/AArch64] Generic support for all system registers using mrs and msr")
> >
> > ... should be sufficent.
>
> This appears to be binutils 2.25:
>
> $ git describe --match 'binutils-2_*' --contains df7b4545b2b49572
> binutils-2_25~418
>
> Documentation/process/changes.rst lists 2.20 as current minimum for binutils.
>
> Ubuntu's old LTS (Trusty, Apr 2014) has 2.24, and that release is
> about to exit support this month.
>
> Debian's old-stable (Apr 2015) has 2.25. It's about to exit support
> when Debian Buster releases.
>
> RHEL6 (2010) has 2.20. RHEL7 (2014) has 2.25.
>
> It seems not unreasonable to require 2.25 at least for arm64 builds?

+ Arnd who has a really good feel for which distros ship what.
-- 
Thanks,
~Nick Desaulniers
