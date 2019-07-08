Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731CDC606BA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4242D21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfGHN43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:56:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:39308 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727401AbfGHN43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:56:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5386AFDB;
        Mon,  8 Jul 2019 13:56:27 +0000 (UTC)
Date:   Mon, 8 Jul 2019 15:56:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] auxdisplay: charlcd: Deduplicate simple_strtoul()
Message-ID: <20190708135626.bvfy4dacv2mst2ht@pathway.suse.cz>
References: <20190704115532.15679-1-andriy.shevchenko@linux.intel.com>
 <20190704115532.15679-2-andriy.shevchenko@linux.intel.com>
 <20190708131652.s3gdoieixgyekued@pathway.suse.cz>
 <20190708133534.GO9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708133534.GO9224@smile.fi.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-07-08 16:35:34, Andy Shevchenko wrote:
> On Mon, Jul 08, 2019 at 03:16:52PM +0200, Petr Mladek wrote:
> > On Thu 2019-07-04 14:55:32, Andy Shevchenko wrote:
> > > Like in the commit
> > >   8b2303de399f ("serial: core: Fix handling of options after MMIO address")
> > > we may use simple_strtoul() which in comparison to kstrtoul() can do conversion
> > > in-place without additional and unnecessary code to be written.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > > - no change since v2
> > >  drivers/auxdisplay/charlcd.c | 34 +++++++---------------------------
> > >  1 file changed, 7 insertions(+), 27 deletions(-)
> > > 
> > > diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
> > > index 92745efefb54..3858dc7a4154 100644
> > > --- a/drivers/auxdisplay/charlcd.c
> > > +++ b/drivers/auxdisplay/charlcd.c
> > > @@ -287,31 +287,6 @@ static int charlcd_init_display(struct charlcd *lcd)
> > >  	return 0;
> > >  }
> > >  
> > > -/*
> > > - * Parses an unsigned integer from a string, until a non-digit character
> > > - * is found. The empty string is not accepted. No overflow checks are done.
> > > - *
> > > - * Returns whether the parsing was successful. Only in that case
> > > - * the output parameters are written to.
> > > - *
> > > - * TODO: If the kernel adds an inplace version of kstrtoul(), this function
> > > - * could be easily replaced by that.
> > > - */
> > > -static bool parse_n(const char *s, unsigned long *res, const char **next_s)
> > > -{
> > > -	if (!isdigit(*s))
> > > -		return false;
> > > -
> > > -	*res = 0;
> > > -	while (isdigit(*s)) {
> > > -		*res = *res * 10 + (*s - '0');
> > > -		++s;
> > > -	}
> > > -
> > > -	*next_s = s;
> > > -	return true;
> > > -}
> > > -
> > >  /*
> > >   * Parses a movement command of the form "(.*);", where the group can be
> > >   * any number of subcommands of the form "(x|y)[0-9]+".
> > > @@ -336,6 +311,7 @@ static bool parse_xy(const char *s, unsigned long *x, unsigned long *y)
> > >  {
> > >  	unsigned long new_x = *x;
> > >  	unsigned long new_y = *y;
> > > +	char *p;
> > >  
> > >  	for (;;) {
> > >  		if (!*s)
> > > @@ -345,11 +321,15 @@ static bool parse_xy(const char *s, unsigned long *x, unsigned long *y)
> > >  			break;
> > >  
> > >  		if (*s == 'x') {
> > > -			if (!parse_n(s + 1, &new_x, &s))
> > > +			new_x = simple_strtoul(s + 1, &p, 10);
> > 
> > simple_strtoul() tries to detect the base even when it has been
> > explicitely specified. 
> 
> I can't see it from the code. Can you point out to this drastic bug that has to
> be fixed?

Grr, the base is detected only when it was not defined.

I am sorry for the noise. I probably have not woken up fully after
the weekend yet.

The patch looks fine then. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
