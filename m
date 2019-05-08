Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F20C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B3321019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jXCprDUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEHIZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:25:33 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34040 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfEHIZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:25:33 -0400
Received: by mail-it1-f193.google.com with SMTP id p18so1716778itm.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPBNJEnOOgZOHP3DTkbWlOxf/mJIrBhutW0vGsGc1B8=;
        b=jXCprDUUshKVwss7HDPEZJcorfnfLTcvXjQhe/GtsyRYKLD8OZKqvjNIuK7EIqW/gI
         NrADf/w6vCYRcdhKz3ZQEnK2JcXgfyjwSzxnAKNaF3NSxv92cfarsSf0qjlUX3+Zm1Gz
         e7IL41sZF/D+wuNMtyXtU82pKahZWsHfVz3wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPBNJEnOOgZOHP3DTkbWlOxf/mJIrBhutW0vGsGc1B8=;
        b=pv1sWrvzk2lmw3tX9NxPE92eYdbrWB/6nS6QreGbx7UO9h/DMgF8bXutTLS5FrkPFb
         /53tPTIr+U3ieCYJ/RRDNuoU3zam5VTAzrc/vziBEUj74DB4RZM/xkzcqEsqAYUXJEox
         KF+ecJpZdaJ5T3f7eoPdcePLktBEFEJlt3zGCVz/zW2fWpWE2LPKVPOjgjBCcLX+MRFu
         0b4rnK/UWoOvtEBLmylT1qahg/yedA99lBzV5PQGbzpWfFek7qjLLLRub13y5X4d5+qL
         /pOZAAVVE6FWlH0VvvvNSDn0a2luYmuyiwKtBbNnV92t72RhyXZfFRk2Iz3iAccoxSN3
         Htzg==
X-Gm-Message-State: APjAAAV4L8E8x8O5ZqU61VX3WCAda6UYK7ZhgzqRbxclbXwz74PwtZWJ
        mHKbd/BU4YsfWN4w/Byavsa9GjDHjnRH/jxqEfqKFw==
X-Google-Smtp-Source: APXvYqzTloJlW0inTtoYD5qbYbep//Q1zTPB6vaGFFnpXuJ1SJ7igL7fT98s5D2BWX8MxxcLaI/57hDNfl4TzG8G7fY=
X-Received: by 2002:a24:39c6:: with SMTP id l189mr2576224ita.51.1557303932766;
 Wed, 08 May 2019 01:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190507173329.17031-1-daniel.vetter@ffwll.ch> <20190508074420.GB15704@jagdpanzerIV>
In-Reply-To: <20190508074420.GB15704@jagdpanzerIV>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 8 May 2019 10:25:19 +0200
Message-ID: <CAKMK7uHF_2QyYP5TB40gPQ6eG_=qk4ucij4RHnM_E=vutqWH5g@mail.gmail.com>
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

On Wed, May 8, 2019 at 9:44 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (05/07/19 19:33), Daniel Vetter wrote:
> [..]
> > - make the console_trylock trylock also the spinlock. This works in
> >   the limited case of the console_lock use-case, but doesn't fix the
> >   same semaphore.lock acquisition in the up() path in console_unlock,
> >   which we can't avoid with a trylock.
> >
> > - move the wake_up_process in up() out from under the semaphore.lock
> >   spinlock critical section. Again this works for the limited case of
> >   the console_lock, and does fully break the cycle for this lock.
> >   Unfortunately there's still plenty of scheduler related locks that
> >   wake_up_process needs, so the loop is still there, just with a few
> >   less locks involved.
> >
> > Hence now third attempt, trying to fix this by using printk_deferred()
> > instead of the normal printk that WARN() uses.
> > native_smp_send_reschedule is only called from scheduler related code,
> > which has to use printk_deferred due to this locking recursion, so
> > this seems consistent.
> >
> > It has the unfortunate downside that we're losing the backtrace though
> > (I didn't find a printk_deferred version of WARN, and I'm not sure
> > it's a bright idea to dump that much using printk_deferred.)
>
> I'm catching up with the emails now (was offline for almost 2 weeks),
> so I haven't seen [yet] all of the previous patches/discussions.
>
> [..]
> >  static void native_smp_send_reschedule(int cpu)
> >  {
> >       if (unlikely(cpu_is_offline(cpu))) {
> > -             WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
> > +             printk_deferred(KERN_WARNING
> > +                             "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
> >               return;
> >       }
> >       apic->send_IPI(cpu, RESCHEDULE_VECTOR);
>
> Hmm,
> One thing to notice here is that the CPU in question is offline-ed,
> and printk_deferred() is a per-CPU type of deferred printk(). So the
> following thing
>
>         __this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
>         irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
>
> might not print anything at all. In this particular case we always
> need another CPU to do console_unlock(), since this_cpu() is not
> really expected to do wake_up_klogd_work_func()->console_unlock().

Hm right, I was happy enough when Petr pointed out the printk_deferred
infrastructure that I didn't look too deeply into how it works. From a
quick loo




--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
