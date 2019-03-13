Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D018C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B3C2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfCMKIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:08:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:51414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfCMKIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:08:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5543B009;
        Wed, 13 Mar 2019 10:08:28 +0000 (UTC)
Date:   Wed, 13 Mar 2019 11:08:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Calvin Owens <calvinowens@fb.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 3/4] printk: Add consoles to a virtual "console" bus
Message-ID: <20190313100827.oqwoabkgsxfi4zde@pathway.suse.cz>
References: <cover.1551486732.git.calvinowens@fb.com>
 <087b13f7812b32cc7c3f9efea71c9bcf324dd031.1551486732.git.calvinowens@fb.com>
 <20190311133341.vqcagdo4e4vy6dfu@pathway.suse.cz>
 <20190312215209.GD5982@Haydn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312215209.GD5982@Haydn>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-03-12 21:52:13, Calvin Owens wrote:
> On Monday 03/11 at 14:33 +0100, Petr Mladek wrote:
> > On Fri 2019-03-01 16:48:19, Calvin Owens wrote:
> > > This patch embeds a device struct in the console struct, and registers
> > > them on a "console" bus so we can expose attributes in sysfs.
> > > 
> > > Currently, most drivers declare static console structs, and that is
> > > incompatible with the dev refcount model. So we end up needing to patch
> > > all of the console drivers to:
> > > 
> > > 	1. Dynamically allocate the console struct using a new helper
> > > 	2. Handle the allocation in (1) possibly failing
> > > 	3. Dispose of (1) with put_device()
> > > 
> > > Early console structures must still be static, since they're required
> > > before we're able to allocate memory. The least ugly way I can come up
> > > with to handle this is an "is_static" flag in the structure which makes
> > > the gets and puts NOPs, and is checked in ->release() to catch mistakes.
> > >
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index 2e0eb89f046c..67e1e993ab80 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -2706,6 +2770,8 @@ void register_console(struct console *newcon)
> > >  		console_drivers->next = newcon;
> > >  	}
> > >  
> > > +	get_console(newcon);
> > > +
> > >  	if (newcon->flags & CON_EXTENDED)
> > >  		nr_ext_console_drivers++;
> > >  
> > > @@ -2730,6 +2796,7 @@ void register_console(struct console *newcon)
> > >  		exclusive_console_stop_seq = console_seq;
> > >  		logbuf_unlock_irqrestore(flags);
> > >  	}
> > > +	console_register_device(newcon);
> > 
> > This calls console_init_device() for the statically defined
> > early consoles. I guess that it would invalidate the above
> > get_console().
> 
> The get_console() macro checks for ->is_static and is a NOP if it's
> set, which is definitely confusing. 
>  
> > Also it is not symmetric with unregister_console(). We add it
> > to the console_subsys here and did not remove it when
> > the console is unregistered.
> 
> We do a put() in the unregister path, somebody could hold a reference
> through sysfs so we can't just remove it. Or am I misunderstanding?

To be honest, I am not sure what the effect of get_device() and
put_device() is. But they are called also in device_add().
This suggests that the sysfs interface and struct device
stay even when we call device_put() in unregister_console().

This is an asymmetry. The sysfs interface is created only
for successfully registered console but it stays even
after unregistration (if it works as I expect).

Another problem is that register_console()/unregister_console()
might get called repeatedly for the same console. But device_add()
should get called only once.

I think that we could do better, see below.


> > IMHO, this might be done already in allocate_console().
> > And eventually in printk_late_init() for consoles that
> > are allocated earlier.
> > 
> > I am not familiar with the device-related sysfs API.
> > But I see that device_initialize() and device_add()
> > can be done by device_register(). The separate
> > calls are needed only when a special reference
> > handling is needed. Are we special?
> 
> We're special: the console initcalls run before the device core is
> initialized, initialize() lets us use the refcount.

But console_init_device() is called later from printk_late_init()
for the statically defined structures (early consoles). This
would reset the refcount for these consoles.

I think that we should delay calling console_init_device() for
all consoles until printk_late_done is set. Then it should
be safe to call device_register() there.

Best Regards,
Petr

