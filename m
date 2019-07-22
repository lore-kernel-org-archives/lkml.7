Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB74C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B6B219BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563839272;
	bh=ZJaWlqPi2cdZE2l3aFe+zt2XP8rCoSUqW+jNvs+HvNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rf6tSK4wR8BI7R0s7MK2QQGUkegY22EoPGMdDGg2BDwWz9Z0sXlVVudh3BEpElDce
	 Uhat9jPy4saUVmSruIW0sJ2+Uqzo3Kg5o2DY/IyzgoHodSp/nm9s7YtzR5lfq1/mAh
	 FdtepP5ZcMbfWO+PyMzxcPvgPjRsIXvQIgkPPbYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbfGVXru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbfGVXru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:47:50 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 946F421E70
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 23:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563839269;
        bh=ZJaWlqPi2cdZE2l3aFe+zt2XP8rCoSUqW+jNvs+HvNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EkqROvek39weM/EmV7A0thZwlX/NAlBfawlc0NcqiZY01njUcGWhiGpUMo9HvH9sR
         m1Ne/VIJ8ORlqcwW+/RnvQ36aDp9zUbe5ZqOUOok9fgOWLBjA8krGJ5kGrN1+eHoKX
         qZHPRnp/qin31xajsOh4DCjVxwZkDB0kqGfZTyaw=
Received: by mail-wr1-f51.google.com with SMTP id 31so41175413wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 16:47:49 -0700 (PDT)
X-Gm-Message-State: APjAAAXWu/ovbXMjoMGYbQ9atnPjrVdhSAVZxOgPckhQSgFj46bZ8EUB
        OMTLdGYbgmtp0X46QqeX2sbzDyzX52JmjO8bEsybPQ==
X-Google-Smtp-Source: APXvYqwAIA+zz6u6QBDVlYPUQTRuAj5apJ1OiftcFR+jI3UsI3EoxsU+6lP/gtGZ+idzIBt7brzF/57apW17CzjlCL0=
X-Received: by 2002:a5d:4309:: with SMTP id h9mr74387750wrq.221.1563839268042;
 Mon, 22 Jul 2019 16:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190719170343.GA13680@linux.intel.com> <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net>
 <201907221012.41504DCD@keescook> <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
 <201907221135.2C2D262D8@keescook> <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
 <201907221620.F31B9A082@keescook>
In-Reply-To: <201907221620.F31B9A082@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 22 Jul 2019 16:47:36 -0700
X-Gmail-Original-Message-ID: <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
Message-ID: <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
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

On Mon, Jul 22, 2019 at 4:28 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jul 22, 2019 at 12:17:16PM -0700, Andy Lutomirski wrote:
> > On Mon, Jul 22, 2019 at 11:39 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, Jul 22, 2019 at 08:31:32PM +0200, Thomas Gleixner wrote:
> > > > On Mon, 22 Jul 2019, Kees Cook wrote:
> > > > > Just so I'm understanding: the vDSO change introduced code to make an
> > > > > actual syscall on i386, which for most seccomp filters would be rejected?
> > > >
> > > > No. The old x86 specific VDSO implementation had a fallback syscall as
> > > > well, i.e. clock_gettime(). On 32bit clock_gettime() uses the y2038
> > > > endangered timespec.
> > > >
> > > > So when the VDSO was made generic we changed the internal data structures
> > > > to be 2038 safe right away. As a consequence the fallback syscall is not
> > > > clock_gettime(), it's clock_gettime64(). which seems to surprise seccomp.
> > >
> > > Okay, it's didn't add a syscall, it just changed it. Results are the
> > > same: conservative filters suddenly start breaking due to the different
> > > call. (And now I see why Andy's alias suggestion would help...)
> > >
> > > I'm not sure which direction to do with this. It seems like an alias
> > > list is a large hammer for this case, and a "seccomp-bypass when calling
> > > from vDSO" solution seems too fragile?
> > >
> >
> > I don't like the seccomp bypass at all.  If someone uses seccomp to
> > disallow all clock_gettime() variants, there shouldn't be a back door
> > to learn the time.
> >
> > Here's the restart_syscall() logic that makes me want aliases: we have
> > different syscall numbers for restart_syscall() on 32-bit and 64-bit.
> > The logic to decide which one to use is dubious at best.  I'd like to
> > introduce a restart_syscall2() that is identical to restart_syscall()
> > except that it has the same number on both variants.
>
> I've built a straw-man for this idea... but I have to say I don't
> like it. This can lead to really unexpected behaviors if someone
> were to have differing filters for the two syscalls. For example,
> let's say someone was doing a paranoid audit of 2038-unsafe clock usage
> and marked clock_gettime() with RET_KILL and marked clock_gettime64()
> with RET_LOG. This aliasing would make clock_gettime64() trigger with
> RET_KILL...

This particular issue is solvable:

> +       /* Handle syscall aliases when result is not SECCOMP_RET_ALLOW. */
> +       if (unlikely(action != SECCOMP_RET_ALLOW)) {
> +               int alias;
> +
> +               alias = seccomp_syscall_alias(sd->arch, sd->nr);
> +               if (unlikely(alias != -1)) {
> +                       /* Use sd_local for an aliased syscall. */
> +                       if (sd != &sd_local) {
> +                               sd_local = *sd;
> +                               sd = &sd_local;
> +                       }
> +                       sd_local.nr = alias;
> +
> +                       /* Run again, with the alias, accepting the results. */
> +                       filter_ret = seccomp_run_filters(sd, &match);
> +                       data = filter_ret & SECCOMP_RET_DATA;
> +                       action = filter_ret & SECCOMP_RET_ACTION_FULL;

How about:

new_data = ...;
new_action = ...;
if (new_action == SECCOMP_RET_ALLOW) {
  data = new_data;
  action = new_action;
}

It might also be nice to allow a filter to say "hey, I want to set
this result and I do *not* want compatibility aliases applied", but
I'm not quite sure how to express that.

I don't love this whole concept, but I also don't have a better idea.


--Andy
