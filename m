Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390E1C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CBD22CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfIDLyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:54:08 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38532 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfIDLyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:54:07 -0400
Received: by mail-oi1-f174.google.com with SMTP id 7so7402187oip.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 04:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T69bo+UrOlt2glBHGVe76qsO1FE/ClOTc1fP/qn3ly4=;
        b=W3ap7cN9ijp/DkBSlnKcYR6YPGQF1UeiamznjEyKcPhlnz3WWsIuadKeEzWUbetwB8
         SrElHTCgQ6b5XbPmFOMYPN7T/Wia3nazVs+2X/fPTVW7QSFx+WznPjBjUL+Q7lXiLrmd
         cPQAO+s5kyICH5JHj96AqkPDy6WStjjXCJIRxfpsBa1WNEEEM/1ldKgmX/98n9DQARbW
         g5tta/DsMJacUt1pqkshVSIUsMDmM3K5ynitGA9vYw6507A+axhu3/ebBr8jkgAG8ej3
         W//uelN+Q8MPcCzw1UzWqF270eiAARQp42zHEwjk3HSC8Do3RA8uKkatEIHb5z9K8Zfp
         1edA==
X-Gm-Message-State: APjAAAUPXfR4b6p9nPKTJFPYfpFoJ9E5rbFLpRXQB4OcJGVwrOunJkxD
        eUiziFKNTcBxvTNMbtOvw3ULOIwhaP324DRfREQ=
X-Google-Smtp-Source: APXvYqwmRo6Essn/dIx2ugiIINngyVTsRr8G0kgxKgSD/D0rdmTTJq3MCnTl1RvAdyabnhGii94Sh7c+PeENUo3O4mI=
X-Received: by 2002:aca:f305:: with SMTP id r5mr2841597oih.131.1567598046606;
 Wed, 04 Sep 2019 04:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble> <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <20190829173458.skttfjlulbiz5s25@treble> <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
In-Reply-To: <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Sep 2019 13:53:55 +0200
Message-ID: <CAMuHMdWvD37CQmDcDQAFtxSGv+vXw_dzPMOv_mLVpiQ3EniFtg@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Aug 29, 2019 at 8:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Aug 29, 2019 at 10:35 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > Peter suggested to try WRITE_ONCE for the two zero writes to see if that
> > "fixes" it.
>
> I'm sure it "fixes" it.
>
> .. and then where else will we hit this?
>
> It's one thing to turn a structure zeroing into "memset()", but some
> places really can't do it.
>
> We use "-ffreestanding" in some places to make sure that gcc doesn't
> start calling random libc routines. I wonder if we need to make it a
> general rule that it's done unconditionally.
>
> Sadly, I think that ends up also disabling things like
> "__builtin_memcpy()" and friends. Which we _do_ want to have access
> to, because then gcc can inline the memcpy() when we _do_ use
> memcpy().
>
> We used to do all of those heuristics by hand, but wanted to let the
> compiler do them for us.
>
> So:
>
>  - we do want "memcpy()" to become "__builtin_memcpy()" which can then
> be optimized to either individual inlined assignments _or_ to an
> out-of-line call to memcpy().

You can do

    #define memcpy(d, s, n) __builtin_memcpy(d, s, n)

Alpha, m68k, sparc, and x86 already do.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
