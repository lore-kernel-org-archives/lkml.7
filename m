Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF72C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366E5205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jATk1C77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfEFIkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:40:45 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35039 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfEFIko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:40:44 -0400
Received: by mail-it1-f193.google.com with SMTP id l140so18700388itb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8NoodJz3Tyk7K1SdtPgr1wSQtdEp94KgYEW4R597E8=;
        b=jATk1C77darD17jedT+v35FcfAnUSaDwzjZZMyFA6RNBWBR9GLFh6MrKGAek6gaqjP
         WJ6ii/Acr4HRe2NQUDuP85bYPhp8GwKEYg56vXNOdJkQDmY3CEKYycFKA6tw8u0AT2ux
         zeimwvmgvSKlmrHPQd37Opoq5rmItsMxTM48w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8NoodJz3Tyk7K1SdtPgr1wSQtdEp94KgYEW4R597E8=;
        b=FREEtntib40Rm4X/s2wJ2ZAgiWJ38xcTW7B5p08zx6c0y9gQltG4UNv0IP65DG45pg
         uxqi3nmICOL41Snt3Y8m3rcai0hTBJYxU0uNryBYkMpeX/7h250cCWwt/LcXUskF7bFR
         LIZnvRyWr/dvQ5vNTFS4LDh11tbG/+9xhGJhpeLciVBobCL+bmhF9H6qKp3yrnU0PySo
         pz1QmQyNR16WYQ2gN1mu2uMidMm5UZWClUZszxDYE1d/dMHV79nXBBXQFao/ezPls9Uw
         HHk/oc6XXFqjNhL8JGG2VWZoOVB2bGE17Mdm5wJHUOLBqjgP0nPlk3Wae47jC+U4cxfC
         jfqw==
X-Gm-Message-State: APjAAAXy8OPJ5aNkT2zWEOkEDVDr2g1f0CSYfCoz7kVJXI9dBGTOBwS3
        h96yG9n0yA7R1BtlsU3xRKU4nAs1wh3S9+rj3CI8iQ==
X-Google-Smtp-Source: APXvYqxIk196lXAtmsgY4J+3B7uPUVFG8JolEjHfu8ThOXPRJHWrZ3uHcwsYaAP6AVP9mbMCxNsOBGv9eICcrcGv6ts=
X-Received: by 2002:a05:660c:4d0:: with SMTP id v16mr4955544itk.62.1557132043602;
 Mon, 06 May 2019 01:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190502141643.21080-1-daniel.vetter@ffwll.ch>
 <20190503151437.dc2ty2mnddabrz4r@pathway.suse.cz> <CAKMK7uF8AD6033_tJw1Y7VsAXb6OD_syZtG3a-JM2g9eEb-P9g@mail.gmail.com>
 <20190506074809.huawsdaynyci5kwz@pathway.suse.cz>
In-Reply-To: <20190506074809.huawsdaynyci5kwz@pathway.suse.cz>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 6 May 2019 10:40:32 +0200
Message-ID: <CAKMK7uE=vAewKNfN3Svw1L47cKv10umws1HdYTehnLBnTMp0mQ@mail.gmail.com>
Subject: Re: [PATCH] RFC: console: hack up console_trylock more
To:     Petr Mladek <pmladek@suse.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 9:48 AM Petr Mladek <pmladek@suse.com> wrote:
> On Mon 2019-05-06 09:11:37, Daniel Vetter wrote:
> > On Fri, May 3, 2019 at 5:14 PM Petr Mladek <pmladek@suse.com> wrote:
> > > On Thu 2019-05-02 16:16:43, Daniel Vetter wrote:
> > > > console_trylock, called from within printk, can be called from pretty
> > > > much anywhere. Including try_to_wake_up. Note that this isn't common,
> > > > usually the box is in pretty bad shape at that point already. But it
> > > > really doesn't help when then lockdep jumps in and spams the logs,
> > > > potentially obscuring the real backtrace we're really interested in.
> > > > One case I've seen (slightly simplified backtrace):
> > > >
> > > >  Call Trace:
> > > >   <IRQ>
> > > >   console_trylock+0xe/0x60
> > > >   vprintk_emit+0xf1/0x320
> > > >   printk+0x4d/0x69
> > > >   __warn_printk+0x46/0x90
> > > >   native_smp_send_reschedule+0x2f/0x40
> > > >   check_preempt_curr+0x81/0xa0
> > > >   ttwu_do_wakeup+0x14/0x220
> > > >   try_to_wake_up+0x218/0x5f0
> > > >   pollwake+0x6f/0x90
> > > >   credit_entropy_bits+0x204/0x310
> > > >   add_interrupt_randomness+0x18f/0x210
> > > >   handle_irq+0x67/0x160
> > > >   do_IRQ+0x5e/0x130
> > > >   common_interrupt+0xf/0xf
> > > >   </IRQ>
> > > >
> > > > This alone isn't a problem, but the spinlock in the semaphore is also
> > > > still held while waking up waiters (up() -> __up() -> try_to_wake_up()
> > > > callchain), which then closes the runqueue vs. semaphore.lock loop,
> > > > and upsets lockdep, which issues a circular locking splat to dmesg.
> > > > Worse it upsets developers, since we don't want to spam dmesg with
> > > > clutter when the machine is dying already.
> > > >
> > > > Fix this by creating a __down_trylock which only trylocks the
> > > > semaphore.lock. This isn't correct in full generality, but good enough
> > > > for console_lock:
> > > >
> > > > - there's only ever one console_lock holder, we won't fail spuriously
> > > >   because someone is doing a down() or up() while there's still room
> > > >   (unlike other semaphores with count > 1).
> > > >
> > > > - console_unlock() has one massive retry loop, which will catch anyone
> > > >   who races the trylock against the up(). This makes sure that no
> > > >   printk lines will get lost. Making the trylock more racy therefore
> > > >   has no further impact.
> > >
> > > To be honest, I do not see how this could solve the problem.
> > >
> > > The circular dependency is still there. If the new __down_trylock()
> > > succeeds then console_unlock() will get called in the same context
> > > and it will still need to call up() -> try_to_wake_up().
> > >
> > > Note that there are many other console_lock() callers that might
> > > happen in parallel and might appear in the wait queue.
> >
> > Hm right. It's very rare we hit this in our CI and I don't know how to
> > repro otherwise, so just threw this out at the wall to see if it
> > sticks. I'll try and come up with a new trick then.
>
> Single messages are printed from scheduler via printk_deferred().
> WARN() might be solved by introducing printk deferred context,
> see the per-cpu variable printk_context.

I convinced myself that I can take the wake_up_process out from under
the spinlock, for the limited case of the console lock. I think that's
a cleaner and more robust fix than leaking printk_context trickery
into the console_unlock code.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
