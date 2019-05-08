Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8308C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8930321530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PbkJUDcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfEHIPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:15:09 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34303 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfEHIPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:15:08 -0400
Received: by mail-it1-f196.google.com with SMTP id p18so1696666itm.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2BaVnSXPGFPoW5xhJE0cknU55cfU2+DP9Ftt16VCH4=;
        b=PbkJUDcswrFyqSBqbPqkp81afTguNnIoOWND0MkBGLoEmIRKjSU1i7mGtQJIKcS6TU
         df8FNExJ7Ueu1d0V7DpZgF6GTwhCLdCg8Idsqr5F2W4i0VTpiIY5G3/nPTChcujgTgKB
         U0ZGjvGnkywQQXm/ZOCOgMAWrI/44yNo8lYPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2BaVnSXPGFPoW5xhJE0cknU55cfU2+DP9Ftt16VCH4=;
        b=FhdwMBADLPpAY6lPG5sJg6tG/KUkjL13KlCg7A58tfu1KSLztQZJcgYjN4gmos+Z/O
         m9iqf61Lfs/Maj9X9SAY3uP5ECqHUHZXz5nEzmmHITzcvWAV9oB/XXUvT1KTc11G+EEY
         C0iPappvoRbI65LG3lhAmOyCDFa0g07TNE/0A7hbFAqvRXwdmUw9YvnMC2OVwCyOIDCD
         DNZbrVZA1Z5SE/wjZV+VrzHsWZ0j+xkN58Cv31DuhJ9tsxkb7kJZWislqFXVO3U3gI+X
         VjTC1tBVz3JsqKKwq9ymm4yz9h5REc/u0SxuXWiB2+BhBpJtsiGpX+KrouXTymYFrN6C
         WLag==
X-Gm-Message-State: APjAAAVNhtGDsfKx8K1b3ds0C3Dk2Uwse5Kk+g1RlWHDGGdKYp7jQv1E
        n+xC06iAQNNP9ptXr1ToZYFxWEXz4j2uyEisa1bNTA==
X-Google-Smtp-Source: APXvYqxKY6qBR/GcaojVTpSV0ibbrs2IcUUWrTgbOa2moyXMfBUqbYmJBKdx4KSC2RlKedp9umj3QRI8uDstN9OmXXs=
X-Received: by 2002:a05:660c:4d0:: with SMTP id v16mr2663613itk.62.1557303307917;
 Wed, 08 May 2019 01:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190507173329.17031-1-daniel.vetter@ffwll.ch>
 <20190508074420.GB15704@jagdpanzerIV> <20190508075302.GC15704@jagdpanzerIV>
In-Reply-To: <20190508075302.GC15704@jagdpanzerIV>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 8 May 2019 10:14:55 +0200
Message-ID: <CAKMK7uGOitk0hgOAnoWEVWTJWzbE5WzzuRAUVfrRiNYfVk-uvA@mail.gmail.com>
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
>
> Any printk-related patch in this area will make PeterZ really-really
> angry :)
>
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

[coffee slowly kicking in it seems]

Locking at __up_console_sem in printk.c, we already do this. I get a
bit a feeling that the 2nd attempt in this saga (pulling the
wake_up_process out from under semaphore.lock spinlock of the
console_lock) is all we really need, since the more direct recursion
that Petr pointed out is already handled with printk_safe_enter/exit
around the up().

https://patchwork.kernel.org/patch/10930673/ for reference that
approach, in case it's lost in your inbox.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
