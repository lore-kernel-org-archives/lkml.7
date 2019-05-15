Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BE7C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25ED20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfEOOrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:47:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:50856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727206AbfEOOrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:47:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 803C7AFCC;
        Wed, 15 May 2019 14:47:02 +0000 (UTC)
Date:   Wed, 15 May 2019 16:47:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2 4/4] printk: make sure we always print console disabled
 message
Message-ID: <20190515144702.uja2mk2vfip6maws@pathway.suse.cz>
References: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
 <20190426053302.4332-5-sergey.senozhatsky@gmail.com>
 <20190426054445.GA564@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426054445.GA564@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-04-26 14:44:45, Sergey Senozhatsky wrote:
> 
> Forgot to mention that the series is still in RFC phase.
> 
> 
> On (04/26/19 14:33), Sergey Senozhatsky wrote:
> [..]
> > +++ b/kernel/printk/printk.c
> > @@ -2613,6 +2613,12 @@ static int __unregister_console(struct console *console)
> >  	pr_info("%sconsole [%s%d] disabled\n",
> >  		(console->flags & CON_BOOT) ? "boot" : "",
> >  		console->name, console->index);
> > +	/*
> > +	 * Print 'console disabled' on all the consoles, including the
> > +	 * one we are about to unregister.
> > +	 */
> > +	console_unlock();
> > +	console_lock();
> >  
> >  	res = _braille_unregister_console(console);
> >  	if (res)
> 
> Need to think more if this is race free...

I am afraid that it is racy against for_each_console() when
removing the boot consoles.

I think that it is _not_ worth a code complication. It worked
this way for ages and people do not seem to complain.

Best Regards,
Petr
