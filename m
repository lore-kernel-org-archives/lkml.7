Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775C9C48BD8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5BB2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfFZKqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:46:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:33994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbfFZKqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:46:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE25DAD78;
        Wed, 26 Jun 2019 10:46:35 +0000 (UTC)
Date:   Wed, 26 Jun 2019 12:46:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 07/10] vsprintf: Consolidate handling of unknown
 pointer specifiers
Message-ID: <20190626104633.arpobvevpxnkrt5k@pathway.suse.cz>
References: <20190417115350.20479-1-pmladek@suse.com>
 <20190417115350.20479-8-pmladek@suse.com>
 <CAMuHMdVX+2tRjCabqVNR9HcnWE+EU0bR55KAW9bbD=GBEoE-=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVX+2tRjCabqVNR9HcnWE+EU0bR55KAW9bbD=GBEoE-=w@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-06-25 12:59:57, Geert Uytterhoeven wrote:
> Hi Petr,
> 
> On Wed, Apr 17, 2019 at 1:56 PM Petr Mladek <pmladek@suse.com> wrote:
> > There are few printk formats that make sense only with two or more
> > specifiers. Also some specifiers make sense only when a kernel feature
> > is enabled.
> >
> > The handling of unknown specifiers is inconsistent and not helpful.
> > Using WARN() looks like an overkill for this type of error. pr_warn()
> > is not good either. It would by handled via printk_safe buffer and
> > it might be hard to match it with the problematic string.
> >
> > A reasonable compromise seems to be writing the unknown format specifier
> > into the original string with a question mark, for example (%pC?).
> > It should be self-explaining enough. Note that it is in brackets
> > to follow the (null) style.
> >
> > Note that it introduces a warning about that test_hashed() function
> > is unused. It is going to be used again by a later patch.
> >
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1706,7 +1712,7 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
> >  #ifdef CONFIG_COMMON_CLK
> >                 return string(buf, end, __clk_get_name(clk), spec);
> >  #else
> > -               return ptr_to_id(buf, end, clk, spec);
> > +               return string_nocheck(buf, end, "(%pC?)", spec);
> 
> What's the reason behind this change? This is not an error case,
> but for printing the clock pointer as a distinguishable ID when using
> the legacy clock framework, which does not store names with clocks.

You are right. We should put back ptr_to_id() there.

Would you like to send a patch?

Best Regards,
Petr
