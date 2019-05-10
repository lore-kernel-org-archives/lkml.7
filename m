Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F765C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5782175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Y7TbJMNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfEJPFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:05:43 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43659 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfEJPFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:05:42 -0400
Received: by mail-io1-f65.google.com with SMTP id v7so4732552iob.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 08:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NuznlxC7GEgYokZCrm7IN/tj/NbTxvoE1lpbLD+P6FM=;
        b=Y7TbJMNHX/xLGrt6Ey5Ga60Br3W/GGMSwc4WapRpMZPFn+rsnXTCRXWgm2noVfXHwr
         IPfC7a5tOe75zipivGvl92RxMtCNfoX7shKuz5CZ1H+2uQyjxDPXfPr1BTGUm9UrHLEC
         i1rf+aEPM9dqjAqNOK5Y0RgZx7YkxWS6hQo10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuznlxC7GEgYokZCrm7IN/tj/NbTxvoE1lpbLD+P6FM=;
        b=RjV3GfbSjiEXmvvjyflfK0q+y7I3/6uh5oTBVmv2LQsQ6BCWc4STNUX6kD8trnASza
         hFQnUPOxBfOsd2xk5xvryAYIUNoBU+SObXkEbguS7kb8B+L/tPQkM4GsWYWvDMKMqhbw
         QQr7jFKEJhG3R53JESgHzQ2MuT3tN7yIT5Vz5npv8lUotV1iupWdheRT2IFlTU+Bswut
         zUk0QbY/E0CRwRtHAC6+9rcTJOEq/4sr/y9J0HK4pWuzVIzwwA6PmsenoxndFgsQuKDg
         B+QVNk7U7/Tfpj7ZvUlFeXFvfz5O1FDsfHyGNqlGTSPgq/fwYwi/dWFUykFugVGuqKm3
         zlxw==
X-Gm-Message-State: APjAAAU6ESfGtMXJypXrc4aOS4bChTXTAdNSWrGLXylTJbR+x/Is9g7S
        n6a9u/OmS3FtvuXu7C8daHI9rxgebG0u4RTSPkAXCQ==
X-Google-Smtp-Source: APXvYqwxgeizLdvyfN+m8ikpEhXLZD1a3NmQ19FUU+pj3MwBauIM70TcpKnQaZZGOg/jgLFS0r+D94herHx1aPVIh0Q=
X-Received: by 2002:a6b:9306:: with SMTP id v6mr7274576iod.278.1557500741598;
 Fri, 10 May 2019 08:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
 <20190509145620.2pjqko7copbxuzth@pathway.suse.cz> <CAKMK7uFTsr1F8nFExTvC7nWFQMcZ7ejh+k_X6E8EcMUaP3e29A@mail.gmail.com>
 <20190510091537.44e3aeb7gcrcob76@pathway.suse.cz>
In-Reply-To: <20190510091537.44e3aeb7gcrcob76@pathway.suse.cz>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 10 May 2019 17:05:30 +0200
Message-ID: <CAKMK7uEqnDATnEUVLjHdv2YkTcfXOJ8Fsg2K9VWYG4nnJX_SAg@mail.gmail.com>
Subject: Re: [PATCH] RFC: console: hack up console_lock more v3
To:     Petr Mladek <pmladek@suse.com>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 11:15 AM Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2019-05-09 18:43:12, Daniel Vetter wrote:
> > One thing to keep in mind is that the kernel is already dying, and
> > things will come crashing down later on
>
> This is important information. I havn't seen it mentioned earlier.

I thought I explained that, sorry if this wasn't clear.

> > (I've seen this only in dmesg
> > tails capture in pstore in our CI, i.e. the box died for good). I just
> > want to make sure that the useful information isn't overwritten by
> > more dmesg splats that happen as a consequence of us somehow trying to
> > run things on an offline cpu. Once console_unlock has completed in
> > your above backtrace and the important stuff has gone out I'm totally
> > fine with the kernel just dying. Pulling the wake_up_process out from
> > under the semaphore.lock is enough to prevent lockdep from dumping
> > more stuff while we're trying to print the important things,
>
> With the more stuff you mean the lockdep splat? If yes, it might
> make sense to call debug_locks_off() earlier in panic().

I'm not sure this only happens in panics (I'm honestly not sure at all
why we're complaining about offline cpus). But in general I've seen
piles of dying systems that dump WARNINGS and then eventually panic.
Still would be good to not have a pointless lockdep splat in between.

> > and I think the untangling of the locking hiararchy is useful irrespective
> > of this lockdep splat. Plus Peter doesn't sound like he likes to roll
> > out more printk_deferred kind of things.
> >
> > But if you think I should do the printk_deferred thing too I can look
> > into that. Just not quite sure what that's supposed to look like now.
>
> Your patch might remove the particular lockdep splat. It might be
> worth it (Peter mentioned also an optimization effect). Anyway
> it will not prevent the deadlock.
>
> The only way to avoid the deadlock is to use printk_deferred()
> with the current printk() code.
>
>
> Finally, I have recently worked on similar problem with dying system.
> I sent the following patch for testing. I wonder if it might be
> acceptable upstream:
>
>
> From: Petr Mladek <pmladek@suse.com>
> Subject: sched/x86: Do not warn about offline CPUs when all are being stopped
> Patch-mainline: No, just for testing
> References: bsc#1104406
>
> The warning about rescheduling offline CPUs cause dealock when
> the CPUs need to get stopped using NMI. It might happen with
> logbuf_lock, locks used by console drivers, especially tty.
> But it might also be caused by a registered kernel message
> dumper, for example, pstore.
>
> The warning is pretty common when there is a high load and
> CPUs are being stopped by native_stop_other_cpus(). But
> they are not really useful in this context. And they scrolls
> the really important messages off the screen.
>
> We need to fix printk() in the long term. But disabling
> the message looks reasonable at least in the meantime.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  arch/x86/kernel/smp.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -124,7 +124,8 @@ static bool smp_no_nmi_ipi = false;
>   */
>  static void native_smp_send_reschedule(int cpu)
>  {
> -       if (unlikely(cpu_is_offline(cpu))) {
> +       if (unlikely(cpu_is_offline(cpu) &&
> +                    atomic_read(&stopping_cpu) < 0)) {

Hm yeah this sounds like another fix which would stop things from
getting worse when the machine is dying. I can try and stuff this (or
something like this, I honestly have no idea about cpu handling code
so no idea what's reasonable) into our CI and see what happens.

Thanks, Daniel

>                 WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
>                 return;
>         }



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
