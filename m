Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493A6C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7462087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="d4yoYmO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfEFHLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:11:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45949 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfEFHLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:11:50 -0400
Received: by mail-io1-f65.google.com with SMTP id b3so4558504iob.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8UT3Tn0T2EP3iQmDK1wowFJS5RBn2hVawFqvc++3dU=;
        b=d4yoYmO7+QLVUx1XeEVtgfXn+9mEq5nbnq3Ff/ns4s/RG+VKMH3QVIz4fT5MRFxFgO
         eA8TI7hh8gf6QqXZ2QGankFqvWBqIYQx7UeMsJGNz3/5GwcJOwwALATBwnnTxe5diKSK
         gZg4oo04esqti8ArfExvZS+7e9ob6e2abCc+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8UT3Tn0T2EP3iQmDK1wowFJS5RBn2hVawFqvc++3dU=;
        b=JDy9I8gOd0rR//azX9me0knEwQeWeDe1gBrx/McYceV+Fo3SYvPxGmZr8fLtNpMV/j
         I3aBv1uE0OswnaGpgH8DqRCKRcpT8QkAyeksfePY8jbACiUpETMnxpCbxX5zCMr1PwsJ
         a5sFV+gUj0n+EQ6kjA3apxcXZaQtYETQsUJAxoAVapuElTBthCdRbcONr/1p5uvhEP3t
         G6oQl9+1s7zAiZk7e2078Kaqo/wjmZlTgjCCKC0uy6Y9om51W678o/cKZhUwcB/9c/D7
         Y0dzDvlQD0ViX44zOSBQXIV6tpdxiiEKRFTNvBERygy2nueNBaO1lhRrJ2xHaPj3rxjC
         gAcg==
X-Gm-Message-State: APjAAAXCn9rgJJfZAy2KCEVdIFtvOYFGvsSGT5xZwJCDKiYVbURGWRf8
        2CBd47cW31I9t6sZGvIjp5Jn4I/w+Eb8JhtlVC0B5g==
X-Google-Smtp-Source: APXvYqxtJtItUL3SFcvknMu2SDjVfpED2iuBsb8Ja6ehJj2ySNhVJwztFSL/SpK7NM1x2+2/ZRJgiI4aPK/8vZPaoq8=
X-Received: by 2002:a6b:b654:: with SMTP id g81mr11945265iof.34.1557126709525;
 Mon, 06 May 2019 00:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190502141643.21080-1-daniel.vetter@ffwll.ch> <20190503151437.dc2ty2mnddabrz4r@pathway.suse.cz>
In-Reply-To: <20190503151437.dc2ty2mnddabrz4r@pathway.suse.cz>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 6 May 2019 09:11:37 +0200
Message-ID: <CAKMK7uF8AD6033_tJw1Y7VsAXb6OD_syZtG3a-JM2g9eEb-P9g@mail.gmail.com>
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

On Fri, May 3, 2019 at 5:14 PM Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2019-05-02 16:16:43, Daniel Vetter wrote:
> > console_trylock, called from within printk, can be called from pretty
> > much anywhere. Including try_to_wake_up. Note that this isn't common,
> > usually the box is in pretty bad shape at that point already. But it
> > really doesn't help when then lockdep jumps in and spams the logs,
> > potentially obscuring the real backtrace we're really interested in.
> > One case I've seen (slightly simplified backtrace):
> >
> >  Call Trace:
> >   <IRQ>
> >   console_trylock+0xe/0x60
> >   vprintk_emit+0xf1/0x320
> >   printk+0x4d/0x69
> >   __warn_printk+0x46/0x90
> >   native_smp_send_reschedule+0x2f/0x40
> >   check_preempt_curr+0x81/0xa0
> >   ttwu_do_wakeup+0x14/0x220
> >   try_to_wake_up+0x218/0x5f0
> >   pollwake+0x6f/0x90
> >   credit_entropy_bits+0x204/0x310
> >   add_interrupt_randomness+0x18f/0x210
> >   handle_irq+0x67/0x160
> >   do_IRQ+0x5e/0x130
> >   common_interrupt+0xf/0xf
> >   </IRQ>
> >
> > This alone isn't a problem, but the spinlock in the semaphore is also
> > still held while waking up waiters (up() -> __up() -> try_to_wake_up()
> > callchain), which then closes the runqueue vs. semaphore.lock loop,
> > and upsets lockdep, which issues a circular locking splat to dmesg.
> > Worse it upsets developers, since we don't want to spam dmesg with
> > clutter when the machine is dying already.
> >
> > Fix this by creating a __down_trylock which only trylocks the
> > semaphore.lock. This isn't correct in full generality, but good enough
> > for console_lock:
> >
> > - there's only ever one console_lock holder, we won't fail spuriously
> >   because someone is doing a down() or up() while there's still room
> >   (unlike other semaphores with count > 1).
> >
> > - console_unlock() has one massive retry loop, which will catch anyone
> >   who races the trylock against the up(). This makes sure that no
> >   printk lines will get lost. Making the trylock more racy therefore
> >   has no further impact.
>
> To be honest, I do not see how this could solve the problem.
>
> The circular dependency is still there. If the new __down_trylock()
> succeeds then console_unlock() will get called in the same context
> and it will still need to call up() -> try_to_wake_up().
>
> Note that there are many other console_lock() callers that might
> happen in parallel and might appear in the wait queue.

Hm right. It's very rare we hit this in our CI and I don't know how to
repro otherwise, so just threw this out at the wall to see if it
sticks. I'll try and come up with a new trick then.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
