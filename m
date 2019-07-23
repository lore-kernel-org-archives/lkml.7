Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B4CC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17639216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxV92/sY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfGWDNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:13:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34384 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfGWDNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:13:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so18360282pfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 20:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DEPyqOFBjYOs8r/K2MnwvAKT/cOE+11qZMvmIBt/O40=;
        b=JxV92/sYCzZyDebfI8BDV+r6UdBlKENd9J3R2uShbj8Fh7BUdpGhjtgGcXhIa4fW95
         BRCzKGQidiuafKZrKaE2gSRxcRvy9g8At42mnM1aBciayx1DIO7e8LQMKOgo83PZaRoy
         g0jNuy9qnWpqCKV9wWIdrIxTxAbiicFPUsQo6Vb19nNMzSv4SbVrBhdfUU1lHHWSNEio
         GxMmR78OLQOz1tT+kEVPMdXQaE/NNwFLXMck4Oxv++54Wa8nAmyQC6CG54PiNLnutC6b
         iRSxLD/epCzXzYXcA/ENZE0EyxXm83a36lIILeDtcm60NYe8nx4OufqfLxSgaaNpeLEH
         awvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DEPyqOFBjYOs8r/K2MnwvAKT/cOE+11qZMvmIBt/O40=;
        b=f+/qDd+5YPmlkNne2tbCBV8dts0qRfpV4W26gjO15vyqjo97qk8Rg6OIfx3WEuDPcX
         Wqo2IqOXnLZQfobp74Gqtb9rfChInA1PY+A1Sy6FYIdQx6A5Oqgq/vRL7zv24e6JTVD+
         WvIegyWMWaG9vMT5f0yrfigoKO13JbQEe8jn65Bgdv7gY9k83kCp1gM2yObl87aaTFaW
         sG/vqZ9Veh2K4rC+EchO6SYcDrAJns6sX2Q4jkWTFmuEDjd6urFKU1VmkLL5ClpIwwda
         z2h7+0+WUHzIXlRp3w0y2a3f3DMgubtfE5Gm0C0vyySpSpQg+dcIny6sD0wuGS7677/b
         qVog==
X-Gm-Message-State: APjAAAUxbVcvdWXFarSoS/oNRIBuW7xZjBFCdi5KotL4luFo7z3aH3L5
        Ly6dc82S9EMjfywj9LPIptAlUVpm
X-Google-Smtp-Source: APXvYqxxk7yVAf59cZn5dAs97QoWkozCGI9o2Jy/lk91i/POwY+BJErjiRaEKlBOEVuJ+2oy/0U/pw==
X-Received: by 2002:a17:90a:c68c:: with SMTP id n12mr80445270pjt.33.1563851624700;
        Mon, 22 Jul 2019 20:13:44 -0700 (PDT)
Received: from localhost ([175.223.34.148])
        by smtp.gmail.com with ESMTPSA id a12sm76925027pje.3.2019.07.22.20.13.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 20:13:43 -0700 (PDT)
Date:   Tue, 23 Jul 2019 12:13:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk/panic: Access the main printk log in panic()
 only when safe
Message-ID: <20190723031340.GA19463@jagdpanzerIV>
References: <20190716072805.22445-1-pmladek@suse.com>
 <20190716072805.22445-2-pmladek@suse.com>
 <20190717095615.GD3664@jagdpanzerIV>
 <20190718083629.nso3vwbvmankqgks@pathway.suse.cz>
 <20190718094934.GA10041@jagdpanzerIV>
 <20190719125753.miniwfq4nhicy76n@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719125753.miniwfq4nhicy76n@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/19/19 14:57), Petr Mladek wrote:
[..]
> > Where do nested printk()-s come from? Which one of the following
> > scenarios you cover in commit message:
> > 
> > scenario 1
> > 
> > - we have CPUB which holds logbuf_lock
> > - we have CPUA which panic()-s the system, but can't bring CPUB down,
> >   so logbuf_lock stays locked on remote CPU
> 
> No, this scenario is not affected by this patch. It would always lead to
> a deadlock.

Agreed, in many cases we won't be able to panic() the system properly,
deadlocking somewhere in smp_send_stop().

> > scenario 2
> > 
> > - we have CPUA which holds logbuf_lock
> > - we have panic() on CPUA, but it cannot bring down some other CPUB
> >   so logbuf_lock stays locked on local CPU, and it cannot re-init
> >   logbuf.
[..]
>   + Before:
>       + printk_safe_flush_on_panic() will keep logbuf_lock locked
> 	and do nothing.
> 
>       + kmsg_dump(), console_unblank(), or console_flush_on_panic()
> 	will deadlock when they try to get logbuf_lock(). They will
> 	not be able to process any single line.
> 
>   + After:
>       + printk_bust_lock_safe() will keep logbuf_lock locked
> 
>       + All functions using logbuf_lock will not get called.
> 	We will not see the messages (as previously) but the
> 	system will not deadlock.
> 
> 
> But there is one more scenario 3:

Yes!

>   - we have CPUB which loops or is deadlocked in IRQ context
> 
>   - we have CPUA which panic()-s the system, but can't bring CPUB down,
>     so logbuf_lock might be takes and release from time to time
>     by CPUB

Great!

This is the only case when we actually need to pay attention to
num_online_cpus(), because there is an active logbuf_lock owner;
in any other case we can unconditionally re-init printk() locks.

But there is more to it.

Note, that the problem in scenario 3 is bigger than just logbuf_lock.
Regardless of logbuf implementation we will not be able to panic()
the system.

If we have a never ending source of printk() messages, coming from
misbehaving CPU which stuck in printing loop in IRQ context, then
flush_on_panic() will never end or kmsg dump will never stop, etc.
We need to cut off misbehaving CPUs. Panic CPU waits (for up to 1
second?) in smp_send_stop() for secondary CPUs to die, if some
secondary CPUs are still chatty after that then most likely those
CPUs don't have anything good to say, just a pointless flood of same
messages over and over again; which, however, will not let panic
CPU to proceed.

And this is where the idea of "disconnecting" those CPUs from main
logbuf come from.

So what we can do:
- smp_send_stop()
- disconnect all-but-self from logbuf (via printk-safe)
- wait for 1 or 2 more extra seconds for secondary CPUs to leave
  console_unlock() and to redirect printks to per-CPU buffers
- after that we are sort of good-to-go: re-init printk locks
  and do kmsg_dump, flush_on_panic().

Note, misbehaving CPUs will write to per-CPU buffers, they are not
expected to be able to flush per-CPU buffers to the main logbuf. That
will require enabled IRQs, which should deliver stop IPI. But we can
do even more - just disable print_safe irq work on disconnect CPUs.

So, shall we try one more time with the "disconnect" misbehaving CPUs
approach? I can send an RFC patch.

	-ss
