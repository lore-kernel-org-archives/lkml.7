Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2809C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A4E20854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392676AbfIFMmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:42:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:57754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392067AbfIFMmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:42:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43544B02E;
        Fri,  6 Sep 2019 12:42:12 +0000 (UTC)
Date:   Fri, 6 Sep 2019 14:42:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Message-ID: <20190906124211.2dionk2kzcslaotz@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <20190906090627.GX2386@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906090627.GX2386@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-09-06 11:06:27, Peter Zijlstra wrote:
> On Thu, Sep 05, 2019 at 04:31:18PM +0200, Peter Zijlstra wrote:
> > So I have something roughly like the below; I'm suggesting you add the
> > line with + on:
> > 
> >   int early_vprintk(const char *fmt, va_list args)
> >   {
> > 	char buf[256]; // teh suck!
> > 	int old, n = vscnprintf(buf, sizeof(buf), fmt, args);
> > 
> > 	old = cpu_lock();
> > +	printk_buffer_store(buf, n);
> > 	early_console->write(early_console, buf, n);
> > 	cpu_unlock(old);
> > 
> > 	return n;
> >   }
> > 
> > (yes, yes, we can get rid of the on-stack @buf thing with a
> > reserve+commit API, but who cares :-))
> 
> Another approach is something like:
> 
> DEFINE_PER_CPU(int, printk_nest);
> DEFINE_PER_CPU(char, printk_line[4][256]);
> 
> int vprintk(const char *fmt, va_list args)
> {
> 	int c, n, i;
> 	char *buf;
> 
> 	preempt_disable();
> 	i = min(3, this_cpu_inc_return(printk_nest) - 1);
> 	buf = this_cpu_ptr(printk_line[i]);
> 	n = vscnprintf(buf, 256, fmt, args);
> 
> 	c = cpu_lock();
> 	printk_buffer_store(buf, n);
> 	if (early_console)
> 		early_console->write(early_console, buf, n);
> 	cpu_unlock(c);
> 
> 	this_cpu_dec(printk_nest);
> 	preempt_enable();
> 
> 	return n;
> }
> 
> Again, simple and straight forward (and I'm sure it's been mentioned
> before too).
> 
> We really should not be making this stuff harder than it needs to be
> (and anybody whining about lines longer than 256 characters can just go
> away, those are unreadable anyway).

I wish it was that simple. It is possible that I see it too
complicated. But this comes to my mind:

1. The simple printk_buffer_store(buf, n) is not NMI safe. For this,
   we might need the reserve-store approach.


2. The simple approach works only with lockless consoles. We need
   something else for the rest at least for NMI. Simle offloading
   to a kthread has been blocked for years. People wanted the
   trylock-and-flush-immediately approach.


3. console_lock works in tty as a big kernel lock. I do not know
   much details. But people familiar with the code said that
   it was a disaster. I assume that tty is still rather
   important console. I am not sure how it would fit into the
   simple approach.


4. The console handling has got non-synchronous (console_trylock)
   quite early (ver 2.4.10, year 2001). The reason was to do not
   serialize CPUs by the speed of the console.

   Serialized output could remove many troubles. The logic in
   console_unlock() is really crazy. It might be acceptable
   for debugging. But is it acceptable on production systems?


5. John planed to use the cpu_lock in the lockless consoles.
   I wonder if it was only in the console->write() callback
   or if it would spread the lock more widely.


6. One huge nightmare is panic() and code called from there.
   It is a maze of hacks, including arch-specific code, to
   prevent deadlocks and get the messages out.

   Any lock might be blocked on any CPU at the moment. Or it
   it might become blocked when CPUs are stopped by NMI.

   Fully lock-less log buffer might save us some headache.
   I am not sure whether a single lock shared between printk()
   writers and console drivers will make the situation easier
   or more complicated.


7. People would complain when continuous lines become less
   reliable. It might be most visible when mixing backtraces
   from all CPUs. Simple sorting by prefix will not make
   it readable. The historic way was to synchronize CPUs
   by a spin lock. But then the cpu_lock() could cause
   deadlock.


I would be really happy when we could ignore some of the problems
or find an easy solution. I just want to make sure that we take
into account all the known aspects.

I am sure that we could do better than we do now. I do not want
to block any improvements. I am just a bit lost in the many
black corners.

Best Regards,
Petr
