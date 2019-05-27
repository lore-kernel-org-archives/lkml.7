Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7DDC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F192F20815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfE0MpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:45:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:52054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfE0MpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:45:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD5F9AE15;
        Mon, 27 May 2019 12:45:01 +0000 (UTC)
Date:   Mon, 27 May 2019 14:45:01 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2 4/4] printk: make sure we always print console disabled
 message
Message-ID: <20190527124501.vabg7whwmufld3dt@pathway.suse.cz>
References: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
 <20190426053302.4332-5-sergey.senozhatsky@gmail.com>
 <20190426054445.GA564@jagdpanzerIV>
 <20190515144702.uja2mk2vfip6maws@pathway.suse.cz>
 <20190523065947.GB18333@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523065947.GB18333@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-05-23 15:59:47, Sergey Senozhatsky wrote:
> On (05/15/19 16:47), Petr Mladek wrote:
> > On Fri 2019-04-26 14:44:45, Sergey Senozhatsky wrote:
> > > 
> > > Forgot to mention that the series is still in RFC phase.
> > > 
> > > 
> > > On (04/26/19 14:33), Sergey Senozhatsky wrote:
> > > [..]
> > > > +++ b/kernel/printk/printk.c
> > > > @@ -2613,6 +2613,12 @@ static int __unregister_console(struct console *console)
> > > >  	pr_info("%sconsole [%s%d] disabled\n",
> > > >  		(console->flags & CON_BOOT) ? "boot" : "",
> > > >  		console->name, console->index);
> > > > +	/*
> > > > +	 * Print 'console disabled' on all the consoles, including the
> > > > +	 * one we are about to unregister.
> > > > +	 */
> > > > +	console_unlock();
> > > > +	console_lock();
> > > >  
> > > >  	res = _braille_unregister_console(console);
> > > >  	if (res)
> > > 
> > > Need to think more if this is race free...
> > 
> > I am afraid that it is racy against for_each_console() when
> > removing the boot consoles.
> 
> Can you explain? Do you mean that we can execute two paths unregistering
> the same bcon?
> 
> 	CPU0					CPU1
> 
> 	console_lock();
> 	__unregister_console(bconA)		console_lock();
> 	console_unlock();
> 
> 						__unregister_console(bconA);
> 						for (a = console_drivers->next ...)
> 							if (a == console)
> 								unregister();
> 							// console bconA is
> 							// not in the list
> 							// anymore
> 						console_unlock();
> 	for (a = console_drivers->next ...)
> 		if (a == console)
> 	console_unlock();
> 
> 
> This CPU0 will never see bconA in the console drivers list.
> But... it will try to do
> 
> 	console->flags &= ~CON_ENABLED;
> 
> Which we need to fix.

I have to admit that I expected more races. But the most intuitive ones
are avoided by the 2nd for-cycle in __unregister_console(). As a
result, most operations are ignored when the console was
already unregistered in parallel.

Anyway, it is really tricky. My head is still spinning around it.
The console_lock handling is really hard to follow. And it is
error prone.

To make it clear. The code has already been tricky. Your patchset has
a potential. It fixes some races but it still keeps the code tricky
anoter way.

OK, all these nasty hacks are needed only because we need to flush
the messages to the console.

Much cleaner solution would be to refactor console_unlock()
and allow to handle existing messages using a separate function.
It is perfectly safe to flush all existing messages to all registered
consoles without releasing console_lock.

How does that sound, please?

Best Regards,
Petr
