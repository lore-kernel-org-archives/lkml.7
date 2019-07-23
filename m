Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E552C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B550218F0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D4Od1ODz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389379AbfGWVzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:55:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44840 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731468AbfGWVzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:55:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so19777376pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GELoU9XiZhFLm6fpKMEDwBHe5alnevMpWO4v+e2SQo0=;
        b=D4Od1ODzoGNKw5Oqko/FK3ztJtKy5NGxNj2DTiE8mciVAdTv1YJVUhrQuLY6nBGLqv
         Risgd7XCNOKJGj+CRmQ5uWEMwlIXBUiCC/N+e7E7e/BQ7qz0ngToBXRAUcU2YR16Mwnc
         saZdbDGB+PtiLrvtGBmnv1sGlKscLyhw62Iu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GELoU9XiZhFLm6fpKMEDwBHe5alnevMpWO4v+e2SQo0=;
        b=SPSKWUgDghRp/7Sqsr0mgfJypaWYSy5Dsm9LTih14xAF0aSb3rVq9CAVvDSG4TwwD+
         onidY1YtmT8GeeYK2wN/tAD+TDDMG7+8/9iwDq/d1J51hFDf324b4K/JAjkX0T8CINTp
         OX0xhSnYPO2kLZ6LwRIco72R3YkTtmz1I8Hlvi1eihQQBU70Rmti3jzRshXZpcGQFLim
         IsiPvo3Iks/DncTZzwb8mdVIb5+jWMhwPHAk/vGlr25zlhqIWYU2XwzeuYjUXWxuMGRY
         DeSB/HRDkepBTEtfdWLjPM9G2PBww2EY6L+1EqoBheUucmplu1azPWmIKiEbEOzoW5Eb
         4qoQ==
X-Gm-Message-State: APjAAAVz6ujdRnBLHu6om5gMVzCB7XOi6+CoLeaR4sbnYM3a0BAEW8Vj
        FIcYgmnVX0rQ22Gay7TtSAbR6Q==
X-Google-Smtp-Source: APXvYqyA2M5EORuzBr1d1HLmyi55aVn5GJKBmkmyVZeMjqtWm//c2eWlDptJFnOeLDWtcqoEErd+2g==
X-Received: by 2002:a63:f452:: with SMTP id p18mr52506711pgk.373.1563918913649;
        Tue, 23 Jul 2019 14:55:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g4sm55929160pfo.93.2019.07.23.14.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 14:55:12 -0700 (PDT)
Date:   Tue, 23 Jul 2019 14:55:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
Message-ID: <201907231437.DB20BEBD3@keescook>
References: <20190719170343.GA13680@linux.intel.com>
 <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net>
 <201907221012.41504DCD@keescook>
 <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
 <201907221135.2C2D262D8@keescook>
 <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
 <201907221620.F31B9A082@keescook>
 <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:47:36PM -0700, Andy Lutomirski wrote:
> On Mon, Jul 22, 2019 at 4:28 PM Kees Cook <keescook@chromium.org> wrote:
> > I've built a straw-man for this idea... but I have to say I don't
> > like it. This can lead to really unexpected behaviors if someone
> > were to have differing filters for the two syscalls. For example,
> > let's say someone was doing a paranoid audit of 2038-unsafe clock usage
> > and marked clock_gettime() with RET_KILL and marked clock_gettime64()
> > with RET_LOG. This aliasing would make clock_gettime64() trigger with
> > RET_KILL...
> 
> This particular issue is solvable:
> 
> > +       /* Handle syscall aliases when result is not SECCOMP_RET_ALLOW. */
> > +       if (unlikely(action != SECCOMP_RET_ALLOW)) {
> > +               int alias;
> > +
> > +               alias = seccomp_syscall_alias(sd->arch, sd->nr);
> > +               if (unlikely(alias != -1)) {
> > +                       /* Use sd_local for an aliased syscall. */
> > +                       if (sd != &sd_local) {
> > +                               sd_local = *sd;
> > +                               sd = &sd_local;
> > +                       }
> > +                       sd_local.nr = alias;
> > +
> > +                       /* Run again, with the alias, accepting the results. */
> > +                       filter_ret = seccomp_run_filters(sd, &match);
> > +                       data = filter_ret & SECCOMP_RET_DATA;
> > +                       action = filter_ret & SECCOMP_RET_ACTION_FULL;
> 
> How about:
> 
> new_data = ...;
> new_action = ...;
> if (new_action == SECCOMP_RET_ALLOW) {
>   data = new_data;
>   action = new_action;
> }

Spelling it out for myself: this means that if both syscalls have
non-RET_ALLOW results, the original result is kept. But if the alias
is allowed, allow it. That solves my particular example, but I don't
think it's enough. (And it might be just as bad.) What if someone wants
to RET_TRACE clock_gettime64 and other syscalls are RET_ALLOWed. Now
clock_gettime64 cannot be traced since clock_gettime gets RET_ALLOW and
replaces the results.

> It might also be nice to allow a filter to say "hey, I want to set
> this result and I do *not* want compatibility aliases applied", but
> I'm not quite sure how to express that.

Especially since we're working on "old" filters.

> I don't love this whole concept, but I also don't have a better idea.

How about we revert the vDSO change? :P

I keep coming back to using the vDSO return address as an indicator.
Most vDSO calls don't make syscalls, yes? So they're normally
unfilterable by seccomp.

What was the prior vDSO behavior?

-- 
Kees Cook
