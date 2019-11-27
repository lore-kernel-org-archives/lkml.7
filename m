Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9BAC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBCA20684
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfK0Iyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:54:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:50498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfK0Iyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:54:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 303A5AAF1;
        Wed, 27 Nov 2019 08:54:52 +0000 (UTC)
Date:   Wed, 27 Nov 2019 09:54:51 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 0/1] printf: add support for printing symbolic error
 names
Message-ID: <20191127085451.ldrzaz4oy54rs7ug@pathway.suse.cz>
References: <20190917065959.5560-1-linux@rasmusvillemoes.dk>
 <20191011133617.9963-1-linux@rasmusvillemoes.dk>
 <CAMuHMdXSt_xtgUz+r9n5_YkJU09HUttbfibOvw8b2zBdXZtT4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXSt_xtgUz+r9n5_YkJU09HUttbfibOvw8b2zBdXZtT4g@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-11-26 15:04:06, Geert Uytterhoeven wrote:
> Hi Rasmus,
> 
> Nice idea!
> 
> On Fri, Oct 11, 2019 at 3:38 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> > This is a bit much for under the ---, so a separate cover letter for
> > this single patch.
> >
> > v4: Dropped Uwe's ack since it's changed quite a bit. Change
> > errcode->errname as suggested by Petr. Make it 'default y if PRINTK'
> > so it's available in the common case, while those who have gone to
> > great lengths to shave their kernel to the bare minimum are not
> > affected.
> >
> > Also require the caller to use %pe instead of printing all ERR_PTRs
> > symbolically. I can see some value in having the call site explicitly
> > indicate that they're printing an ERR_PTR (i.e., having the %pe), but
> > I also still believe it would make sense to print ordinary %p,
> > ERR_PTR() symbolically instead of as a random hash value that's not
> > stable across reboots. But in the interest of getting this in, I'll
> > leave that for now. It's easy enough to do later by just changing the
> > "case 'e'" to do a break (with an updated comment), then do an
> > IS_ERR() check after the switch.
> >
> > Something I've glossed over in previous versions, and nobody has
> > commented on, is that I produced "ENOSPC" while the 'fallback' would
> > print "-28" (i.e., there's no minus in the symbolic case). I don't
> > care much either way, but here I've tried to show how I'd do it if we
> > want the minus also in the symbolic case. At first, I tried just using
> > the standard idiom
> >
> >   if (buf < end)
> >     *buf = '-';
> >   buf++;
> >
> > followed by string(sym, ...). However, that doesn't work very well if
> > one wants to honour field width - for that to work, the whole string
> > including - must come from the errname() lookup and be handled by
> > string(). The simplest seemed to be to just unconditionally prefix all
> > strings with "-" when building the tables, and then change errname()
> > back to supporting both positive and negative error numbers.
> 
> Still, it looks a bit wasteful to me to include the dash in each and every
> string value.
> 
> Do you think you can code the +/- logic in string_nocheck() in less than
> the gain achieved by dropping the dashes from the tables?
> (e.g. by using the SIGN spec.flags? ;-)
> Or, do we need it? IS_ERR() doesn't consider positive values errors.
> 
> Oh, what about the leading "E"? That one looks harder to get rid of,
> though ;-)

It would be nice. But too big hack is not worth it. Anybody who cares
about saving 0.2kB would likely disable this feature completely.

Feel to provide a patch so that we could see how good/bad it is.

Best Regards,
Petr
