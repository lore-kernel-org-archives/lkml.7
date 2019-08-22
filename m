Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF04C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05400214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdCFi7GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfHVCdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:33:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44184 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfHVCdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:33:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id c81so2794752pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 19:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tDasAzwNiV2HiRhPGR1ntFxNV2BKl3GP2YTPs2bTao=;
        b=FdCFi7GWOi0sBNctiSyST5JgiXFc3Dpm4Ny9r0Z8N6YB1RGX4IGNdRSGDqXckQLFiP
         kP41+izIX1OKcH3u/ztOWxFdyj4NNtvjgdKMMZdMcwRcLwAzWfRnEtq3kQbenMlQFwuM
         ByhsEOohxtooyNcFYI9nrAsc9n/4HVDoK/Eo2eZ0f869f60fP4KBgjSrN/n/79Kol50B
         NAVSKjMgtGXrrJeh9fiX/PJg8E1gtuVMK3I/3ZJhREsqOnOmwtX0NGSafNXqjQjk8z1P
         FaN57WfagrT/k8a88PaMBOG6M2dxJ0KzK5GN1gENWohFwhBq3GhckEjAK4qYbZuuy1Iy
         m0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tDasAzwNiV2HiRhPGR1ntFxNV2BKl3GP2YTPs2bTao=;
        b=s1Wm0aWbcWLPdJF/vZyWdhhqkTE7igAk6IHHzjN6oFw7jpIWoNef7QJTzlr9mAQsQP
         2KTZg+B27uN8NJLBbQwGqsBXDfwZVxSrAUqfrQxnl/Ju/N35sOYJZ5ySBMzYboB7aJFx
         r95/7hg/wt4JV9ZgKMN3/zbcqj2EFnzj9msAwqksXrXSImp04bma+yE+x9vb9xbAH2JV
         wPiNZPoROcXTkRs9FNRz+dg1Tx9rKilsGGHW/g7OGlJ4pTfTvfxViF4HCmI4jW/g9d9a
         /6rjHjeErptU64T0gFqY7XnQJcgbUeRIduS4ypTWx6kkDyDfeV09rnAzVYFPDzCz2psK
         izQQ==
X-Gm-Message-State: APjAAAX6TP1isUzRid1UheTSbM9kLlAmn8Tj7UHRj/zgM4tJZin1vYvD
        xHagqaqKPk5rcXSaeLiQG+gGxn0mbr7vFv83BNPvvA==
X-Google-Smtp-Source: APXvYqz3Wvbr27kKwSLKzNFjnFQjspOUDKGv55jK/OXyb9guHXmQpT5LPH9sicMq4DgljVSA6U/iNJtBNCDviS3stlw=
X-Received: by 2002:aa7:8085:: with SMTP id v5mr39314885pff.165.1566441194307;
 Wed, 21 Aug 2019 19:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190820194351.107486-1-nhuck@google.com> <CAKwvOdm+sGyKfAMNbL10ME=DrG5=4d5kvzdMxjNC22JLLr1h=g@mail.gmail.com>
 <CAJkfWY4cHz+i8kYg2i1Krs-32nh7-WQU+psT=DRGYnTje6yj4Q@mail.gmail.com>
In-Reply-To: <CAJkfWY4cHz+i8kYg2i1Krs-32nh7-WQU+psT=DRGYnTje6yj4Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 21 Aug 2019 19:33:02 -0700
Message-ID: <CAKwvOd=Uvzw5_azQuSjUovSEDTNAaB=pTht1-zMiA8mqfmJ0zw@mail.gmail.com>
Subject: Re: [PATCH] ARM: UNWINDER_FRAME_POINTER implementation for Clang
To:     Nathan Huckleberry <nhuck@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <miles.chen@mediatek.com>, Tri Vo <trong@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 10:43 AM Nathan Huckleberry <nhuck@google.com> wrote:
>
> On Tue, Aug 20, 2019 at 2:39 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, Aug 20, 2019 at 12:44 PM Nathan Huckleberry <nhuck@google.com> wrote:
...snip...
> > > +tst    r1, #0x10               @ 26 or 32-bit mode?
> > > +moveq  mask, #0xfc000003
> >
> > Should we be using different masks for ARM vs THUMB as per the
> > reference implementation?
> The change that introduces the arm/thumb code looked like a script
> that was run over all arm in the kernel. Neither this code nor the
> reference solution is compatible with arm, so there's no need for the
> change.

Looks like you're referring to commit 8b592783a2e8 ("Thumb-2:
Implement the unified arch/arm/lib functions").

Currently, arch/arm/Kconfig.debug has:
  57 config UNWINDER_FRAME_POINTER
  58   bool "Frame pointer unwinder"
  59   depends on !THUMB2_KERNEL && !CC_IS_CLANG

So it looks like UNWINDER_FRAME_POINTER and THUMB2_KERNEL are mutually
exclusive.  Probably could send a patch cleaning that up. (ie.
removing the different masks; essentially removing the hunk from
arch/arm/lib/backtrace.S from 8b592783a2e8).

> > > +for_each_frame:        tst     frame, mask             @ Check for address exceptions
> > > +               bne     no_frame
> > > +
> > > +/*
> > > + * sv_fp is the stack frame with the locals for the current considered
> > > + *     function.
> > > + * sv_pc is the saved lr frame the frame above. This is a pointer to a
> > > + *     code address within the current considered function, but
> > > + *     it is not the function start. This value gets updated to be
> > > + *     the function start later if it is possible.
> > > + */
> > > +1001:          ldr     sv_pc, [frame, #4]      @ get saved 'pc'
> > > +1002:          ldr     sv_fp, [frame, #0]      @ get saved fp
> >
> > The reference implementation applies the mask to sv_pc and sv_fp.  I
> > assume we want to, too?
> The mask is already applied to both. See for_each_frame:

ah, under the finished_setup label.
-- 
Thanks,
~Nick Desaulniers
