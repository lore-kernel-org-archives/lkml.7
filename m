Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F806C2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2266920731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgAFKZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:25:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:50390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgAFKZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:25:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F2EFFAF8A;
        Mon,  6 Jan 2020 10:25:37 +0000 (UTC)
Date:   Mon, 6 Jan 2020 11:25:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] printk: Fix preferred console selection with multiple
 matches
Message-ID: <20200106102537.nirnfcauqdh4olgv@pathway.suse.cz>
References: <2712d7e2fb68bca06a33e2e062fc8e65a2652410.camel@kernel.crashing.org>
 <20191219135053.xr67lybhycepcxkp@pathway.suse.cz>
 <32fde8cd451ea0eaff38108d9f2f2d4a97a43097.camel@kernel.crashing.org>
 <20191220091131.4uifcbudwppjspf4@pathway.suse.cz>
 <20200106051508.GA17351@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106051508.GA17351@google.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-01-06 14:15:08, Sergey Senozhatsky wrote:
> On (19/12/20 10:11), Petr Mladek wrote:
> [..]
> > > > > +enum con_match {
> > > > > +	con_matched,
> > > > > +	con_matched_preferred,
> > > > > +	con_braille,
> > > > > +	con_failed,
> > > > > +	con_no_match,
> > > > > +};
> > > > 
> > > > Please, replace this with int, where:
> > > > 
> > > >    + con_matched -> 0
> > > >    + con_matched_preferred -> 0 and make "has_preferred" global variable
> > > >    + con_braile -> 0		later check for CON_BRL flag
> > > >    + con_failed -> -EFAULT
> > > >    + con_no_match -> -ENOENT
> > > 
> > > Not fan of using -EFAULT here, it's a detail since it's rather kernel
> > > internal, but I'd rather use -ENXIO for no match and -EIO for failed
> > > (or pass the original error code up if any). That said it's really bike
> > > shed painting at this point :-)
> > 
> > Sigh, either variant is somehow confusing.
> > 
> > I think that -ENOENT is a bit better than -EIO. It is abbreviation of
> > "No entry or No entity" which quite fits here. Also the device might
> > exist but it is not used when not requested.
> 
> Can we please keep the enum? Enum is super self-descriptive, can't
> get any better. Any other alternative - be it -EFAULT or -EIO or
> -ENOENT - would force one to always look at what is actually going
> on in try_match_new_console() and what particular errno means. None
> of those errnos fit, they make things cryptic. IMHO.

I agree that the enums are more self-descriptive. My problem with it is
that there are 5 values. I wanted to check how they were handled
and neither 'con_matched' nor 'con_failed' were later used.

I though how to improve it. And I ended with feeling that the enum
did more harm then good. -E??? codes are a bit less descriptive
but there are only two. The meaning can be explained easily by
a comment above the function.

If you want to keep the enum then please handle the return values
by switch(). Or make it clear that all possible return values
are handled properly.

Best Regards,
Petr
