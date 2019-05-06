Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF7FC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FD1208C2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GrqoWz8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfEFJiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:38:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40903 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfEFJiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:38:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id e56so14589056ede.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MUCBKoTdL7VxsTLho10xCSR8XMf/U+cya+mYQZsv5YA=;
        b=GrqoWz8ic+tDcnjbjpjFtcOjd6NbN54Wyvv5rMJIdupSUBjBwo0/ROqMu7caGtGH06
         lZiC9iXum79qeSwTMg5qAqzmJdIyIYMAQHMaeBPWRVkfeWFAQ3qQkV21tSPWc4JOWaoi
         g8cWXqYAaDYT9ZB5vyO8Cm30d3U03sJVI9Z5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=MUCBKoTdL7VxsTLho10xCSR8XMf/U+cya+mYQZsv5YA=;
        b=qfhN6/DvcgZjDne+btDGtbFIGwzeldQQLD+t0kYKNOIdxNRuuStd5GDALPg1xLVf/p
         Y3sW4gUJ/Hrncr8yMedncMKHOmLcS0WJU2/UJuH4YOQ9DQoGb+1Or9NhUwRLfq47SPQk
         ek5tYuIbdEIJTF/f0TcerZkOV5HWBd7Xu3uJMihwmZYBtwf+J8hOK0SfqFd4/4saoeiC
         okO32u2XISzdbGwxYJ2ADRscrmx84iG0XnIozdQDFCPSfN6q6zL+5S0YHTmNJC3hv67d
         Uzo+WoHIiUhdvwFT9aMFF154F7yBfHudi7aNpB1KSRgydOVK40KHavyA0p121ToEQBSz
         cwxA==
X-Gm-Message-State: APjAAAW4Hn42G0T4Bgl8wz90u5IKoi8M9/8ipMa0VbJmwtT1wEnCv8Ly
        mz+I0ibWqloO9msSHVxZk2wvpA==
X-Google-Smtp-Source: APXvYqw3h5nl5mbp+FVa0nCaCTx5coCf2LzYGxq4yAq8+03Hn5kxlCza/d+7Jjzk2FFRKDNEt/P9yw==
X-Received: by 2002:a17:906:3403:: with SMTP id c3mr18303929ejb.177.1557135496310;
        Mon, 06 May 2019 02:38:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g11sm157101eda.42.2019.05.06.02.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:38:15 -0700 (PDT)
Date:   Mon, 6 May 2019 11:38:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: console: hack up console_lock more v2
Message-ID: <20190506093812.GG17751@phenom.ffwll.local>
Mail-Followup-To: Petr Mladek <pmladek@suse.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20190502141643.21080-1-daniel.vetter@ffwll.ch>
 <20190506074553.21464-1-daniel.vetter@ffwll.ch>
 <20190506081614.b7b22k4prodskbiy@pathway.suse.cz>
 <20190506082628.wehkislebljxmk5d@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506082628.wehkislebljxmk5d@pathway.suse.cz>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 10:26:28AM +0200, Petr Mladek wrote:
> On Mon 2019-05-06 10:16:14, Petr Mladek wrote:
> > On Mon 2019-05-06 09:45:53, Daniel Vetter wrote:
> > > console_trylock, called from within printk, can be called from pretty
> > > much anywhere. Including try_to_wake_up. Note that this isn't common,
> > > usually the box is in pretty bad shape at that point already. But it
> > > really doesn't help when then lockdep jumps in and spams the logs,
> > > potentially obscuring the real backtrace we're really interested in.
> > > One case I've seen (slightly simplified backtrace):
> > > 
> > >  Call Trace:
> > >   <IRQ>
> > >   console_trylock+0xe/0x60
> > >   vprintk_emit+0xf1/0x320
> > >   printk+0x4d/0x69
> > >   __warn_printk+0x46/0x90
> > >   native_smp_send_reschedule+0x2f/0x40
> > >   check_preempt_curr+0x81/0xa0
> > >   ttwu_do_wakeup+0x14/0x220
> > >   try_to_wake_up+0x218/0x5f0
> > 
> > try_to_wake_up() takes p->pi_lock. It could deadlock because it
> > can get called recursively from printk_safe_up().
> > 
> > And there are more locks taken from try_to_wake_up(), for example,
> > __task_rq_lock() taken from ttwu_remote().
> > 
> > IMHO, the most reliable solution would be do call the entire
> > up_console_sem() from printk deferred context. We could assign
> > few bytes for this context in the per-CPU printk_deferred
> > variable.
> 
> Ah, I was too fast and did the same mistake. This won't help because
> it would still call try_to_wake_up() recursively.

Uh :-/

> We need to call all printk's that can be called under locks
> taken in try_to_wake_up() path in printk deferred context.
> Unfortunately it is whack a mole approach.

Hm since it's whack-a-mole anyway, what about converting the WARN_ON into
a prinkt_deferred, like all the other scheduler related code? Feels a
notch more consistent to me than leaking the printk_context into areas it
wasn't really meant built for. Scheduler code already fully subscribed to
the whack-a-mole approach after all.

This would mean we drop the backtrace from the native_smp_send_reschedule,
or maybe we need a printk_deferred_backtrace()?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
