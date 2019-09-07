Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A25C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 01:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42E720854
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 01:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWfEuh3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393713AbfIGBFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 21:05:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37581 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfIGBFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 21:05:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so2948168pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 18:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqepLaTSTfQY83HVDfCAAUaqMIJ3Bo3dybU2p4C5Hp4=;
        b=oWfEuh3BjFLuGBzvrm8GMxwk5xuOl02jnw707fpvcMBuA1Ao4YT0q739mNaVz/6wo4
         Ahb07EbEdF6SeKJLRI2h6BXlcoGCH/ikg7kAaO+Hnlj7fqtN7++QdkwO9ZIgK+wiz8Cd
         Dz7z6VAC/rA0S0ZDMC5BraPexgtvJuBXZgaGunBxJ/Kfmv6gXWYLeksWCfcmZB63vF/j
         VpZw8PqV+TtpM0EQ8lNi9wll2pCU/W/pfGjEB2FljdwSIdaatV3c9+gLH417KxdW1kOj
         217fUPm7g1HviMjqxGKwyKgDdxBCJjfkSi2s0LavVh0qtYsaSSaAgKfE8Cw8hg7Oc1d/
         rJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqepLaTSTfQY83HVDfCAAUaqMIJ3Bo3dybU2p4C5Hp4=;
        b=gAq4UzaMp+2ROpWUzoQXhIfPOBEww3W2It+uVF8+QDbGfbpO7cazSBxITYpZPiKvIM
         v1yWkszqEBGL2oIjG70Z6TX/X7urcnCy6oLGQSpnDQzcBtHRcDODcuLEjShgC/Z3pBNd
         uEhaqAz0WOtSbmhfUaV1c/33SZSyuGgCB9SmC9RKgsFHznn7jhNKPZexUjfebXcjutYj
         3MJYTGLCl9PM1iJW3X96ChblQWg905wkQirOVZg3lFZgbAYbGYDtQa1Vf1pg6Im5CXM3
         tDnep3a8CEk3FhZMHrUT8rgWoxWrp/cTRCoK2CXMvVfoEADAJ3O0ab0Kngqx79D6qlb+
         bhqg==
X-Gm-Message-State: APjAAAVRlXr+ZGpJ0KeHoe+/8fAFwtifVJMin1JtGz94OQZhXzqAbA72
        FIjHzyqV+3CXAuNC7ou0KW5xSskN1mcLvJWMS7G3iw==
X-Google-Smtp-Source: APXvYqzU6E28NErMRYf8vVBDI+EDjukMhBEwKjftHwbhNh5BfxYBSDuFx5e9+K99DknJuEGOswT6nmHBANMJbYbfRAU=
X-Received: by 2002:a63:6193:: with SMTP id v141mr10638089pgb.263.1567818306938;
 Fri, 06 Sep 2019 18:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com>
 <20190906122349.GZ9749@gate.crashing.org> <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com>
 <20190906163028.GC9749@gate.crashing.org> <20190906163918.GJ2120@tucnak>
 <CAKwvOd=MT_=U250tR+t0jTtj7SxKJjnEZ1FmR3ir_PHjcXFLVw@mail.gmail.com>
 <20190906220347.GD9749@gate.crashing.org> <CAKwvOdnWBV35SCRHwMwXf+nrFc+D1E7BfRddb20zoyVJSdecCA@mail.gmail.com>
 <20190906225606.GF9749@gate.crashing.org> <CAKwvOdk-AQVJnD6-=Z0eUQ6KPvDp2eS2zUV=-oL2K2JBCYaOeQ@mail.gmail.com>
 <20190907001411.GG9749@gate.crashing.org>
In-Reply-To: <20190907001411.GG9749@gate.crashing.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Sep 2019 18:04:54 -0700
Message-ID: <CAKwvOdnaBD3Dg3pmZqX2-=Cd0n30ByMT7KUNZKhq0bsDdFeXpg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 5:14 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Fri, Sep 06, 2019 at 04:42:58PM -0700, Nick Desaulniers via gcc-patches wrote:
> > Just to prove my point about version checks being brittle, it looks
> > like Rasmus' version check isn't even right.  GCC supported `asm
> > inline` back in the 8.3 release, not 9.1 as in this patch:
>
> Yes, I backported it so that it is available in 7.5, 8.3, and 9.1, so
> that more users will have this available sooner.  (7.5 has not been
> released yet, but asm inline has been supported in GCC 7 since Jan 2
> this year).

Ah, ok that makes sense.

How would you even write a version check for that?

Which looks better?

#if __GNU_MAJOR__ > 9 || __GNU_MAJOR__ == 8 && __GNU_MINOR__ >= 3 ||
__GNU_MAJOR__ == 7 && __GNU_MINOR__ >= 5 || __CLANG_MAJOR__ == 42
// make use of `asm inline`
#endif

or

#ifdef __CC_HAS_ASM_INLINE__
// make use of `asm inline`
#endif

>
> > Or was it "broken" until 9.1?  Lord knows, as `asm inline` wasn't in
> > any release notes or bug reports I can find:
>
> https://gcc.gnu.org/ml/gcc-patches/2019-02/msg01143.html
>
> It never was accepted, and I dropped the ball.

Ah, ok, that's fine, so documentation was at least written.  Tracking
when and where patches land (or don't) is difficult when patch files
are emailed around.  I try to keep track of when and where our kernel
patches land, but I frequently drop the ball there.

> > Segher, next time there's discussion about new C extensions for the
> > kernel, can you please include me in the discussions?
>
> You can lurk on gcc-patches@ and/or gcc@?

Please "interrupt" me when you're aware of such discussions, rather
than me "polling" a mailing list.  (I will buy you a tasty beverage of
your preference).  I'm already subscribed to more mailing lists than I
have time to read.

> But I'll try to remember, sure.
> Not that I am involved in all such discussions myself, mind.

But you _did_ implement `asm inline`. ;)
-- 
Thanks,
~Nick Desaulniers
