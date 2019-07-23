Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B4CC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D712238C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563922533;
	bh=TbrU37cIgVknUDN3eT4rxXv1UjD9mrPPOVWac90XS54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=g0b6FoPJOBWPBTghFZWnMKhGwO6n1XtNEcjf7taAkhYfTW4gpCf4XyT+LjdFoYd3n
	 4h3UE6aJdvbVE14ElTdMn43JXjgkdQXiBro8MSzsp9HoddswacZtgdFfbO5K5QXguT
	 +97OpkVcvTTqNm6iASEeWDRRI8dBM9+ua3iirELU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392478AbfGWWzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfGWWzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:55:31 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D1D52238C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 22:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563922530;
        bh=TbrU37cIgVknUDN3eT4rxXv1UjD9mrPPOVWac90XS54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MYCOGZ5FTwvoxAe6aG/9SzxjB/bWawNqHdRtx2LOH7i3cVwTA2pvnMd01kHkSs4b9
         oNMg+2PRbD8lCYr6IiXMFzf5YNRwCSRAcgt0GAPoFWxCn8qUmNlGQ0Sj0C08HjIaDh
         cOLse67OCywv/lWK1EQKjtCsJTKcExqWV5IwFQfI=
Received: by mail-wm1-f49.google.com with SMTP id s3so40000139wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:55:30 -0700 (PDT)
X-Gm-Message-State: APjAAAXVzeE0us4TfQf3yWvaqQyurPQjbL7dfMMfelPnjIF0kSlqA5Vh
        WNyTfZCdTA/jRXBqqI0Ayqmj58qWkea0bcrbNphwVg==
X-Google-Smtp-Source: APXvYqxclzhKMYIyuWJUBW1H9z9vkqW+NvCuo+3cXCkdq6p3XJWKC3yHkMw0akbR0McTNfFDXPwwYAmxP+e0NF3wj58=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr11669186wme.173.1563922529083;
 Tue, 23 Jul 2019 15:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190719170343.GA13680@linux.intel.com> <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net>
 <201907221012.41504DCD@keescook> <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
 <201907221135.2C2D262D8@keescook> <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
 <201907221620.F31B9A082@keescook> <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
 <201907231437.DB20BEBD3@keescook>
In-Reply-To: <201907231437.DB20BEBD3@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 23 Jul 2019 15:55:17 -0700
X-Gmail-Original-Message-ID: <CALCETrUsMjqmWDoHuSwMggYhq--UqUWOAmV=V3xFEhsOuiOHdw@mail.gmail.com>
Message-ID: <CALCETrUsMjqmWDoHuSwMggYhq--UqUWOAmV=V3xFEhsOuiOHdw@mail.gmail.com>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace on i386
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 2:55 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jul 22, 2019 at 04:47:36PM -0700, Andy Lutomirski wrote:
> > On Mon, Jul 22, 2019 at 4:28 PM Kees Cook <keescook@chromium.org> wrote:
> > > I've built a straw-man for this idea... but I have to say I don't
> > > like it. This can lead to really unexpected behaviors if someone
> > > were to have differing filters for the two syscalls. For example,
> > > let's say someone was doing a paranoid audit of 2038-unsafe clock usage
> > > and marked clock_gettime() with RET_KILL and marked clock_gettime64()
> > > with RET_LOG. This aliasing would make clock_gettime64() trigger with
> > > RET_KILL...
> >
> > This particular issue is solvable:
> >
> > > +       /* Handle syscall aliases when result is not SECCOMP_RET_ALLOW. */
> > > +       if (unlikely(action != SECCOMP_RET_ALLOW)) {
> > > +               int alias;
> > > +
> > > +               alias = seccomp_syscall_alias(sd->arch, sd->nr);
> > > +               if (unlikely(alias != -1)) {
> > > +                       /* Use sd_local for an aliased syscall. */
> > > +                       if (sd != &sd_local) {
> > > +                               sd_local = *sd;
> > > +                               sd = &sd_local;
> > > +                       }
> > > +                       sd_local.nr = alias;
> > > +
> > > +                       /* Run again, with the alias, accepting the results. */
> > > +                       filter_ret = seccomp_run_filters(sd, &match);
> > > +                       data = filter_ret & SECCOMP_RET_DATA;
> > > +                       action = filter_ret & SECCOMP_RET_ACTION_FULL;
> >
> > How about:
> >
> > new_data = ...;
> > new_action = ...;
> > if (new_action == SECCOMP_RET_ALLOW) {
> >   data = new_data;
> >   action = new_action;
> > }
>
> Spelling it out for myself: this means that if both syscalls have
> non-RET_ALLOW results, the original result is kept. But if the alias
> is allowed, allow it. That solves my particular example, but I don't
> think it's enough. (And it might be just as bad.) What if someone wants
> to RET_TRACE clock_gettime64 and other syscalls are RET_ALLOWed. Now
> clock_gettime64 cannot be traced since clock_gettime gets RET_ALLOW and
> replaces the results.

Fair enough.

>
> > It might also be nice to allow a filter to say "hey, I want to set
> > this result and I do *not* want compatibility aliases applied", but
> > I'm not quite sure how to express that.
>
> Especially since we're working on "old" filters.
>
> > I don't love this whole concept, but I also don't have a better idea.
>
> How about we revert the vDSO change? :P
>
> I keep coming back to using the vDSO return address as an indicator.
> Most vDSO calls don't make syscalls, yes? So they're normally
> unfilterable by seccomp.
>
> What was the prior vDSO behavior?

The prior vDSO behavior was identical except that it was
clock_gettime, not clock_gettime64.  It's a little bit more subtle:
the syscall only happens sometimes, mostly depending on hypervisor
details, hardware, and hardware configuration.  In the preferred TSC
clock mode, we will not do the syscall for most clock ids.

The emulated vsyscall behavior is that, if the gettimeofday() vsyscall
is issued, we fake a seccomp event and we make a somewhat credible
effort to honor the result.  See arch/x86/entry/vsyscall_64.c.  In
general, I consider the combination of PR_SET_TSC to PR_TSC_DISABLE +
seccomp blocking timing syscalls to mean that fine-grained timing is
genuinely disabled.  So I don't love bypassing seccomp in this type of
context.  Also, there are a few ways that programs could fake the
return address as coming from the vDSO, the simplest of which is to
simply jump to that syscall instruction.

This is horrible but: what if we added a new parameter passed when a
seccomp filter is registered that indicates that the kernel should
remap syscalls with numbers above the given parameter.  The default
value for legacy users would be clock_gettime64 - 1 :)  The idea being
that an old trace-everything filter will sometimes get clock_gettime64
wrong, but a new one can opt in to more accurate behavior.  Ditto for
a hypothetical restart_syscall_renumbered().  I admit I still don't
love this either.
