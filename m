Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18626C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEFF21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DAkTcLdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfEHIRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:17:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44902 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEHIRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:17:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so21210104edm.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0N5lnGAYpVl8jLu0POCScTDd8sfYN5q61LdKD5JAjDs=;
        b=DAkTcLdGYhnJCVY4IkNJ0G0i4EJT46OzMiH5ZTn93wJXF5Z7EK0zgt6AHjy9PIzOKy
         3vJ+SHx2b75l1gsUddKs3lBS4ZUpZnQSqaQzW6e2X0yEPYCQP9Bpu40CQPzoUVktN4Cw
         4OtivpDrUpwc7KBYTgtxIEG9Vl59FRTONKQwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=0N5lnGAYpVl8jLu0POCScTDd8sfYN5q61LdKD5JAjDs=;
        b=jKGrUK0yrpqTqU+e22hXkUtU5PDLxYlc8cNLsWAMAtumABO4AJFagWnpeajTFHzTru
         PAKeWa5cOiCdqHH0yBdjjxmti7/hprsnAxbylJlpPmqXW2Slhfe2E/d6iggwYbc2VnS1
         MyXUBSdxQgzUa1fyyhKxKqSbg05glON9sT6vX909l13KjZ3RavhEJTAruGc8m82e93Jf
         ufEUd0ovqdY1n+KlA/7X1NHrp1fHLKPPUeSZStxAl5C266bL90fzcwE4GB82sNI8fPyK
         cTXwaPUDrqQLXED/e6gHa1wcyL0mr88TbTj8ZdXID0cFJN6qi4wkPZEuY5uzUp7sfg30
         LAqQ==
X-Gm-Message-State: APjAAAWSnqAhGVw8drgQwbbz0uz2Q7Wg1uspNr3kUArqBsA1Sebmbabu
        a2DoLRJN13FzgyDpIB0xILpzYQ==
X-Google-Smtp-Source: APXvYqz+mpxWshuU26UyHoB8ox7W8kTtZXnf6nLdtTuCZczDanWJ43OpBb+lAoPhFsj1Wz2jvfNgDw==
X-Received: by 2002:a17:906:4bda:: with SMTP id x26mr28323747ejv.176.1557303436362;
        Wed, 08 May 2019 01:17:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id q33sm4932194eda.71.2019.05.08.01.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:17:15 -0700 (PDT)
Date:   Wed, 8 May 2019 10:17:12 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] RFC: console: hack up console_lock more v2
Message-ID: <20190508081712.GQ17751@phenom.ffwll.local>
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
 <20190506093812.GG17751@phenom.ffwll.local>
 <20190506112448.rng2oefmp2c262dq@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506112448.rng2oefmp2c262dq@pathway.suse.cz>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 01:24:48PM +0200, Petr Mladek wrote:
> On Mon 2019-05-06 11:38:13, Daniel Vetter wrote:
> > On Mon, May 06, 2019 at 10:26:28AM +0200, Petr Mladek wrote:
> > > On Mon 2019-05-06 10:16:14, Petr Mladek wrote:
> > > > On Mon 2019-05-06 09:45:53, Daniel Vetter wrote:
> > > > > console_trylock, called from within printk, can be called from pretty
> > > > > much anywhere. Including try_to_wake_up. Note that this isn't common,
> > > > > usually the box is in pretty bad shape at that point already. But it
> > > > > really doesn't help when then lockdep jumps in and spams the logs,
> > > > > potentially obscuring the real backtrace we're really interested in.
> > > > > One case I've seen (slightly simplified backtrace):
> > > > > 
> > > > >  Call Trace:
> > > > >   <IRQ>
> > > > >   console_trylock+0xe/0x60
> > > > >   vprintk_emit+0xf1/0x320
> > > > >   printk+0x4d/0x69
> > > > >   __warn_printk+0x46/0x90
> > > > >   native_smp_send_reschedule+0x2f/0x40
> > > > >   check_preempt_curr+0x81/0xa0
> > > > >   ttwu_do_wakeup+0x14/0x220
> > > > >   try_to_wake_up+0x218/0x5f0
> > > > 
> > > > try_to_wake_up() takes p->pi_lock. It could deadlock because it
> > > > can get called recursively from printk_safe_up().
> > > > 
> > > > And there are more locks taken from try_to_wake_up(), for example,
> > > > __task_rq_lock() taken from ttwu_remote().
> > > > 
> > > > IMHO, the most reliable solution would be do call the entire
> > > > up_console_sem() from printk deferred context. We could assign
> > > > few bytes for this context in the per-CPU printk_deferred
> > > > variable.
> > > 
> > > Ah, I was too fast and did the same mistake. This won't help because
> > > it would still call try_to_wake_up() recursively.
> > 
> > Uh :-/
> > 
> > > We need to call all printk's that can be called under locks
> > > taken in try_to_wake_up() path in printk deferred context.
> > > Unfortunately it is whack a mole approach.
> > 
> > Hm since it's whack-a-mole anyway, what about converting the WARN_ON into
> > a prinkt_deferred, like all the other scheduler related code? Feels a
> > notch more consistent to me than leaking the printk_context into areas it
> > wasn't really meant built for. Scheduler code already fully subscribed to
> > the whack-a-mole approach after all.
> 
> I am not sure how exactly you mean the conversion.
> 
> Anyway, we do not want to use printk_deferred() treewide. It reduces
> the chance that the messages reach consoles. Scheduler is an
> exception because of the possible deadlocks.
> 
> A solution would be to define WARN_ON_DEFERRED() that would
> call normal WARN_ON() in printk deferred context and
> use in scheduler.

Sent it out, and then Sergey pointed out printk_safe_enter/exit (which I
guess is what you meant, and which I missed), but we're doing this already
around the up() call in __up_console_sem.

So I think these further recursions you're pointed out are already handled
correctly, and all we need to do is to break the loop involving
semaphore.lock of the console_lock semaphore only. Which I think this
patch here achieves.

Thoughts? Or are we again missing something here?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
