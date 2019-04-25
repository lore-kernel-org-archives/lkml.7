Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BA2C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C15B217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfDYIxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:53:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:50654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbfDYIxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:53:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 721A5AE3C;
        Thu, 25 Apr 2019 08:53:35 +0000 (UTC)
Date:   Thu, 25 Apr 2019 10:53:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 2/2] printk: take console_sem when accessing console
 drivers list
Message-ID: <20190425085334.v5v3ardpsx4ddvty@pathway.suse.cz>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
 <20190423062511.1118-3-sergey.senozhatsky@gmail.com>
 <20190424151306.jcmygibltizcorgk@pathway.suse.cz>
 <20190425051944.GB8532@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425051944.GB8532@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-04-25 14:19:44, Sergey Senozhatsky wrote:
> On (04/24/19 17:13), Petr Mladek wrote:
> > >  	/*
> > >  	 * before we register a new CON_BOOT console, make sure we don't
> > > @@ -2691,6 +2696,7 @@ void register_console(struct console *newcon)
> > >  			if (!(bcon->flags & CON_BOOT)) {
> > >  				pr_info("Too late to register bootconsole %s%d\n",
> > >  					newcon->name, newcon->index);
> > > +				console_unlock();
> > >  				return;
> > >  			}
> > >  		}
> > > @@ -2701,6 +2707,7 @@ void register_console(struct console *newcon)
> > >  
> > >  	if (!has_preferred || bcon || !console_drivers)
> > >  		has_preferred = preferred_console >= 0;
> > > +	console_unlock();
> 
> Thanks for taking a look!
> 
> > We should keep it until the console is added into the list. Otherwise
> > there are races with accessing the static has_preferred and
> > the global preferred_console variables.
> 
> We don't modify `preferred_console' in register_console(), only
> read-access it. Write-access, at the same time, is not completely
> race free. That global `preferred_console' is modified from
> 
>  add_preferred_console() -> __add_preferred_console() -> WRITE preferred_console
>  console_setup() -> __add_preferred_console() -> WRITE preferred_console
> 
> So `preferred_console' is not WRITE protected by console_sem, that's
> why I didn't make sure to READ protected it in register_console().

Sigh, it is complicated.

OK, preferred_console is used to iterate over console_cmdline array.
The good thing is that entries are never removed from there.
It is static and thus zeroed at boot. Therefore there is not
risk of buffer overflow by strcmp() or so.

Also the newly added entry should never match() console that
it being registered because the entry is added earlier when
parsing cmdline or it is added later by a probe call before
the probed console is registered[*].

IMHO, the only danger is that we wrongly detect preferred
console and unregister boot consoles too early. But I doubt
that it might even happen.

[*] Calling add_preferred_console() from a probe() call
    is not common. But I see, for example:

    + hv_probe()
      + sunserial_console_match()
	+ add_preferred_console()

Result: I think that we do not need to synchronize access to
	preferred_console.


> As of static `has_preferred'... I kind of couldn't figure out if
> we really need to protect it, but can do.

For example, I think that we might end up with two consoles
that have CON_CONSDEV set and are handled as preferred.

It would happen when two parallel register_console() calls enter
the following code:

	if (!has_preferred) {
		if (newcon->index < 0)
			newcon->index = 0;
		if (newcon->setup == NULL ||
		    newcon->setup(newcon, NULL) == 0) {
			newcon->flags |= CON_ENABLED;
			if (newcon->device) {
				newcon->flags |= CON_CONSDEV;
				has_preferred = true;
			}
		}
	}


> > Also the value of bcon should stay synchronized until we decide
> > about replaying the log.
> 
> Good catch. So we, basically, can do the same thing as we did to
> __unregister_console(): factor out the registration code and call
> that new __register_console() under console_lock, and do
> console_unlock()/console_lock() after we add console to the list,
> but before we unregister boot consoles.

Yup.

> Except for one small detail:
> 
> > IMHO, the only danger might be when con->match() or con->setup()
> > would want to take console_lock() as well. I checked few drivers
> > and they looked safe. But I did not check all of them.
> >
> > What do you think, please?
> 
> That's a hard question. I would assume that ->match() has
> no business in console_sem; but I'm not completely sure about
> ->setup().

Same here. It would be nice to check all possible paths but
I do not know how to do so.

IMHO, it could happen only when a console uses console_lock
for its own synchronization. I hope that it is only tty code
and it can be tested easily.


> E.g. 8250 does take console_sem during port configuration:
> 	config_port()
> 	 serial8250_config_port()
> 	  autoconfig_irq()
> 	   console_lock()
> 
> But it doesn't look like we hit this path from ->setup(); seems
> to be early serial setup stage.
> 
> So may be we can move the whole thing under console_sem.

I believe that it should be safe.

Best Regards,
Petr
