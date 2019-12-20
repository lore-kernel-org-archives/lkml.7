Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A372C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9332465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfLTJLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:11:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:41152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbfLTJLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:11:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 70A3DAE88;
        Fri, 20 Dec 2019 09:11:33 +0000 (UTC)
Date:   Fri, 20 Dec 2019 10:11:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] printk: Fix preferred console selection with multiple
 matches
Message-ID: <20191220091131.4uifcbudwppjspf4@pathway.suse.cz>
References: <2712d7e2fb68bca06a33e2e062fc8e65a2652410.camel@kernel.crashing.org>
 <20191219135053.xr67lybhycepcxkp@pathway.suse.cz>
 <32fde8cd451ea0eaff38108d9f2f2d4a97a43097.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32fde8cd451ea0eaff38108d9f2f2d4a97a43097.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-12-20 08:48:24, Benjamin Herrenschmidt wrote:
> On Thu, 2019-12-19 at 14:50 +0100, Petr Mladek wrote:
> > The code really need simplification. I would prefer to take the risk
> > and reduce the amount of added conditions as much as possible.
> > I have an idea, see below.
> 
> I wanted you to say that :-) I'll rework along those lines. Just a nit
> or two:
> > 
> > 
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -2542,6 +2545,53 @@ static int __init keep_bootcon_setup(char *str)
> > >  
> > >  early_param("keep_bootcon", keep_bootcon_setup);
> > >  
> > > +enum con_match {
> > > +	con_matched,
> > > +	con_matched_preferred,
> > > +	con_braille,
> > > +	con_failed,
> > > +	con_no_match,
> > > +};
> > 
> > Please, replace this with int, where:
> > 
> >    + con_matched -> 0
> >    + con_matched_preferred -> 0 and make "has_preferred" global variable
> >    + con_braile -> 0		later check for CON_BRL flag
> >    + con_failed -> -EFAULT
> >    + con_no_match -> -ENOENT
> 
> Not fan of using -EFAULT here, it's a detail since it's rather kernel
> internal, but I'd rather use -ENXIO for no match and -EIO for failed
> (or pass the original error code up if any). That said it's really bike
> shed painting at this point :-)

Sigh, either variant is somehow confusing.

I think that -ENOENT is a bit better than -EIO. It is abbreviation of
"No entry or No entity" which quite fits here. Also the device might
exist but it is not used when not requested.

I do not mind about -EFAULT vs -EIO. Well, -EIO might actually
better describe the reality.

That said, I do not want to spend much time on bikesheding. Feel free
to use whatever looks better to you.


> > > @@ -2615,41 +2664,19 @@ void register_console(struct console *newcon)
> > 	/* Prefer command line over platform specific defaults. */
> > 	err = try_match_new_console(newcon, true);
> > 	if (err = -ENOENT)
> > 		err = try_match_new_console(newcon, false);
> > 
> > 	/* printk() messages are not printed to Braille consoles. */
> > 	if (err || console->flags | CON_BRL)
> > 		return;
> 
> So this changes the existing behaviour in one way that may or may not
> matter, I don't know:
> 
> If setup() fails, the existing code will not exit. That means that if
> the console has CON_ENABLED already set (some do set it statically or
> set it from outside this function, I haven't looked into details the
> various circumstances this can happen), the existing code will still
> insert it. Your patch will make us not insert it.

Great catch! There is still a lot to learn about this code.

It seems that, for example, pstore and netconsole are not added
into console_cmdline and do not match. They relly on the explicitely
set CON_ENABLED.

I would prefer to hide this into the new "shorter" function. I would
rename it to try_enable_new_console() and add the following at the end:

	/*
	 * For example, pstore, netconsole, are enabled even
	 * without matching.
	 */
	if (console->flags & CON_ENABLED)
		return 0;

Best Regards,
Petr
