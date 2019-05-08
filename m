Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6819FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF3620989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CvUyCgoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfEHIGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:06:35 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33697 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEHIGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:06:34 -0400
Received: by mail-it1-f194.google.com with SMTP id u16so1689605itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ki8hQ48k4lITqZ/TVIYvLD49Gs7QEyF45lWbuLR1Sl0=;
        b=CvUyCgoivRAhF/4ErqyHzJu2eu3YdNKSU7bPgEtxWicHsKTLP+tGbafiiQw2io/GQb
         PsmMQMPtsa2T8025pi5SsvE5ri1xNbzvZLpapw15edM7IGu2w97/kbA/7yKXYYdu1WMI
         IReG5o25f4R84RgSKj515yoqgHSx3qI4bKkMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ki8hQ48k4lITqZ/TVIYvLD49Gs7QEyF45lWbuLR1Sl0=;
        b=a2h+SrMjrFohkx3z7ydu20QOPrpa3uDZzxCeREda5A/qX0A/Yx+KSEw8+2or8QLM2z
         q2cwWlNYgrfIgZdw4eLfqhyIZ4EczQX1Tk2KCraCb4i+YehBmrJ78799HuFur26ZPi6F
         qZWHZTjRgR+js3Wj19gaYvYTd3lEq5m7Fp2VoznHUQ+F/jUVsaBRya8TUiLm+1kRiyvs
         ugp1/hDHdGV1gYq3/C4fKSCyfeFkmUxvBcUTT3k2vVylzSrQpU/pDW7JoQ1LFbZoSjkv
         o1Pcf3vx5Vt9IXCKqr3c650GY44o06lt9XAPqH70G1gnwmBCkkS1QqHLfHeSKARfS+BH
         xPTg==
X-Gm-Message-State: APjAAAX3ApLS37dcaqNQM3z55aUkyv2YzizwQk5CgRf6C4xQFzaLgnlv
        m9xj9enn5F8JJ2Fv/lhmRL4BLOh+6x6Nb8BME5ZUDA==
X-Google-Smtp-Source: APXvYqz+LcWP0P11hgtedlhpXw1Ues0QKV277c7pjb7z6FDlN0mBHxeeIFN92GfUDXQ/Z8jxOJiL3YzcPDe2HsbWoww=
X-Received: by 2002:a02:ca4a:: with SMTP id i10mr27164568jal.70.1557302793766;
 Wed, 08 May 2019 01:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190507173329.17031-1-daniel.vetter@ffwll.ch>
 <20190508074420.GB15704@jagdpanzerIV> <20190508075302.GC15704@jagdpanzerIV>
In-Reply-To: <20190508075302.GC15704@jagdpanzerIV>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 8 May 2019 10:06:20 +0200
Message-ID: <CAKMK7uFeRmSGkqFj-xmdebwKok9+z1pyDZWUMNXfzTT4H2=-fA@mail.gmail.com>
Subject: Re: [PATCH] RFC: x86/smp: use printk_deferred in native_smp_send_reschedule
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 9:53 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (05/08/19 16:44), Sergey Senozhatsky wrote:
> > [..]
> > >  static void native_smp_send_reschedule(int cpu)
> > >  {
> > >     if (unlikely(cpu_is_offline(cpu))) {
> > > -           WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
> > > +           printk_deferred(KERN_WARNING
> > > +                           "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
> > >             return;
> > >     }
> > >     apic->send_IPI(cpu, RESCHEDULE_VECTOR);
> >
> > Hmm,
> > One thing to notice here is that the CPU in question is offline-ed,
> > and printk_deferred() is a per-CPU type of deferred printk(). So the
> > following thing
> >
> >       __this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
> >       irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
> >
> > might not print anything at all. In this particular case we always
> > need another CPU to do console_unlock(), since this_cpu() is not
> > really expected to do wake_up_klogd_work_func()->console_unlock().
>
> D'oh... It's remote CPU which is offline, not this_cpu().
> Sorry, my bad!

Well I started reading, then freaked out about the WARN_ON in
irq_work_queue_on until I realized that's not the one we're calling
either :-)

> Any printk-related patch in this area will make PeterZ really-really
> angry :)

Hm any more context for someone with no clue about this? Just that the
dependencies are already terribly complex and it's not going to get
better, or something more specific?

> printk_deferred(), just like prinkt_safe(), depends on IRQ work;
> printk_safe(), however, can redirect multiple lines, unlike
> printk_deferred(). So if you want to keep the backtrace, you may
> do something like
>
>         if (unlikely(cpu_is_offline(cpu))) {
>                 printk_safe_enter(...);
>                 WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n",
>                          cpu);
>                 printk_safe_exit(...);
>                 return;
>         }
>
> I think, in this case John's reworked-printk can do better than
> printk_safe/printk_deferred.

Hm I think this is what Petr was suggesting, but somehow I didn't find
the printk_safe_* functions and didn't connect the dots. Needs the
_irqsave variants I guess, I'll respin a v2 of this.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
