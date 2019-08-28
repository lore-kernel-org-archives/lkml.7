Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6DAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A867622DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXn6+gJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfH1WQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:16:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38452 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfH1WQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:16:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id e11so447823pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cI7lPiUMiKomeyCUPJV8+wea36GrOdMvUW16YwohpL4=;
        b=jXn6+gJpaxbVNRJosKVFyJhneE9YA5zZwsY8f08DrvC0jdN8yLLcVGCWMK2MI3asR4
         mR/w63vTs01x2zv23z7+ENGGZQxl5lP0L7IswMDFJOeF+PfFa5XufKp3POnqA+d+T6gY
         iU+oHtm3aswQz2vouOHL+N524tw8/MB11zHdlBgBdRzuAh47R8nLGjf1MN97LAs8TJRe
         t/WglKh0C6Rjvv9Re03vW31Joo/EvEeqi4mSkOvC7ypSmqITd1jZJvKuBnm7iaOIvEcf
         ItToIAbDhJ7/bc4XNow2l99yUWnAB+lmrvfN0Ccw9w/MiRJ2uXkTq0B2GJ7+NypqqmIG
         MYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cI7lPiUMiKomeyCUPJV8+wea36GrOdMvUW16YwohpL4=;
        b=idtzqDq3oc4vrLEnE3q+ZWat3C/zlCt36xBaIy3RMmn5zswKjxxTDAm41sEuXkZDia
         RAxTa6TsTFoQaWy3HJwikOt9gbJpUZ7QjEYkRjSQ/TUoIVPfplo1C3RZ92E+cuL3KKvp
         zoLb2VtajfBxPrj2l9yeWNIC1Qn011rAkOwJwdqaAioqGOqbefM/HvhQxs3/NeiDwB6h
         RfDiV5rw7tMspDOZNwClMG2FYCsAKd2O3JL+jsFmHQELV+ufL/QJjX7lqKtX7COJ/LX6
         LoIHvx43kZ2HHHBOme6vVmeJpaIoCnelwzsW+HuzziFOjX6d8WomSA7yvze/QZFov5pS
         l5iQ==
X-Gm-Message-State: APjAAAUqGOpaslpYtp1rV5YP1LTohe9eIWVe692VPqPeXuRmrj4U7NCx
        pBjmqRBDHtm1hJQRcc1XvbTNhQ7ngVrOrLEUH3A1Wg==
X-Google-Smtp-Source: APXvYqzuyqHfthUYWwSiGUlecSwGfmshq015FiqdVWTRGOTXZRuEO4B0tLgZTFnI+YVgOwfSzB5KTyCLaEyT79V8AoY=
X-Received: by 2002:a65:690b:: with SMTP id s11mr3546456pgq.10.1567030590292;
 Wed, 28 Aug 2019 15:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190812023214.107817-1-natechancellor@gmail.com>
 <878srdv206.fsf@mpe.ellerman.id.au> <20190828175322.GA121833@archlinux-threadripper>
 <CAKwvOdmXbYrR6n-cxKt3XxkE4Lmj0sSoZBUtHVb0V2LTUFHmug@mail.gmail.com> <20190828184529.GC127646@archlinux-threadripper>
In-Reply-To: <20190828184529.GC127646@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 15:16:19 -0700
Message-ID: <CAKwvOd=wdscd7smcKZk40zD_n1OUVkhYYd7ZnoK8r1Y+pkvYVg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Avoid clang warnings around setjmp and longjmp
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:45 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Aug 28, 2019 at 11:01:14AM -0700, Nick Desaulniers wrote:
> > On Wed, Aug 28, 2019 at 10:53 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Yes, I don't think this would be unreasonable. Are you referring to the
> > > cc-disable-warning flags or the -fno-builtin flags? I personally think
> > > the -fno-builtin flags convey to clang what the kernel is intending to
> > > do better than disabling the warnings outright.
> >
> > The `-f` family of flags have dire implications for codegen, I'd
> > really prefer we think long and hard before adding/removing them to
> > suppress warnings.  I don't think it's a solution for this particular
> > problem.
>
> I am fine with whatever approach gets this warning fixed to the
> maintainer's satisfaction...
>
> However, I think that -fno-builtin-* would be appropriate here because
> we are providing our own setjmp implementation, meaning clang should not
> be trying to do anything with the builtin implementation like building a
> declaration for it.

That's a good reason IMO.  IIRC, the -fno-builtin-* flags don't warn
if * is some unrecognized value, so -fno-builtin-setjmp may not
actually do anything, and you may need to scan the source (of clang or
llvm).

-- 
Thanks,
~Nick Desaulniers
