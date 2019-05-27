Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B61C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B733720673
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfE0Lmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:42:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:38470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbfE0Lma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:42:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8DDBAD03;
        Mon, 27 May 2019 11:42:28 +0000 (UTC)
Date:   Mon, 27 May 2019 13:42:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2 3/4] printk: factor out register_console() code
Message-ID: <20190527114228.uxg4awhtdovoi2cc@pathway.suse.cz>
References: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
 <20190426053302.4332-4-sergey.senozhatsky@gmail.com>
 <20190515143631.vuhbda6btucrkskx@pathway.suse.cz>
 <20190523065144.GA18333@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523065144.GA18333@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-05-23 15:51:44, Sergey Senozhatsky wrote:
> Hello,
> 
> On (05/15/19 16:36), Petr Mladek wrote:
> [..]
> > >  
> > >  	console_unlock();
> > >  	console_sysfs_notify();
> > > +	console_lock();
> > 
> > I have got an idea how to get rid of this weirdness:
> >
> > 1. The check for bcon seems to be just an optimization. There is not need
> >    to remove boot consoles when there are none.
> > 
> > 2. The condition (newcon->flags & (CON_CONSDEV|CON_BOOT)) == CON_CONSDEV)
> >    is valid only when the preferred console was really added.
> > 
> > Therefore we could move the code to a separate function, e.g.
> > 
> > void unregister_boot_consoles(void)
> > {
> > 	struct console *bcon;
> > 
> > 	console_lock();
> > 	for_each_console(bcon)
> > 		if (bcon->flags & CON_BOOT)
> > 			__unregister_console(bcon);
> > 	}
> > 	console_unlock();
> > 	console_sysfs_notify();
> > }
> > 
> > Then we could do something like:
> > 
> > void register_console(struct console *newcon)
> > {
> > 	bool newcon_is_preferred = false;
> > 
> > 	console_lock();
> > 	__register_console(newcon);
> > 	if ((newcon->flags & (CON_CONSDEV|CON_BOOT)) == CON_CONSDEV)
> > 		newcon_is_preferred = true;
> > 	console_unlock();
> > 	console_sysfs_notify();
> > 
> > 	/*
> > 	 * By unregistering the bootconsoles after we enable the real console
> > 	 * we get the "console xxx enabled" message on all the consoles -
> > 	 * boot consoles, real consoles, etc - this is to ensure that end
> > 	 * users know there might be something in the kernel's log buffer that
> > 	 * went to the bootconsole (that they do not see on the real console)
> > 	 */
> > 	if (newcon_is_preferred && !keep_bootcon)
> > 		unregister_boot_consoles();
> > }
> > 
> > How does that sound?
> 
> Hmm, may be I'm missing something. I think that the 'weirdness'
> is still needed.

I probably used wrong words. For me the most weird thing was
that the original code temporary released a lock that
was originally taken in another function.

My proposal is just a refactoring. It allows to do all
the locking/unlocking operations in a single function.
It makes is easier to track.

> 
> 	console_lock();
> 	__unregister_console(bcon);  // pr_info("%sconsole disabled\n")
> 	console_unlock();
> 
> is going to change the visible behaviour - we need to show
> pr_info("%sconsole [%s%d] disabled\n") on all consoles, especially
> on the console which we are disabling.

It was the 1st patch that changed the behavior. It moved
the pr_info() under console_lock. Therefore it never
appears on the console.

The 4th patch tries to fix this but it looks racy. I am going
to comment the race in the thread about the 4th patch.


> Who knows, maybe that's the last remaining properly working
> console. Doing __unregister_console() under console_sem will
> end up in a lost/missing message on bcon (or
> on any other console we are unregistering).

I agree that we should make sure that the message is printed on
the console that is being disabled.

Sigh, I am afraid that a proper solution would result in a messy
code. It would be pity. The original problem is rather theoretical.
The fix is not worth making the code even more hairy.

Best Regards,
Petr
