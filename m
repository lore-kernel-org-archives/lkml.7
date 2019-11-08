Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714DAFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F004206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfKHIrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:47:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:37096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfKHIrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:47:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7F52B209;
        Fri,  8 Nov 2019 08:47:08 +0000 (UTC)
Date:   Fri, 8 Nov 2019 09:47:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ioannis Ilkos <ilkos@google.com>,
        minchan@google.com, primiano@google.com, fmayer@google.com,
        hjd@google.com, joaodias@google.com, lalitm@google.com,
        rslawik@google.com, sspatil@google.com, timmurray@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rss_stat: Add support to detect RSS updates of external
 mm
Message-ID: <20191108084707.fwy6junacy4b4fld@pathway.suse.cz>
References: <20191106024452.81923-1-joel@joelfernandes.org>
 <20191106085959.ae2dgvmny3njnk7n@pathway.suse.cz>
 <20191107180751.GA3846@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107180751.GA3846@google.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-11-07 13:07:51, Joel Fernandes wrote:
> On Wed, Nov 06, 2019 at 09:59:59AM +0100, Petr Mladek wrote:
> > On Tue 2019-11-05 21:44:51, Joel Fernandes (Google) wrote:
> > > Also vsprintf.c is refactored a bit to allow reuse of hashing code.
> > 
> > I agree with Sergey that it would make sense to move this outside
> > vsprintf.c.
> 
> I am of the opinion that its Ok to have it this way and I am not sure if
> another translation unit is worth it just for this. If we have more users,
> then yes we can consider splitting into its own translation unit at that
> time.

Fair enough. I still think that it would make sense to move the code
but I do not want to block this patch because of this.

My view is that vsprintf.c is huge and the hashing-related code
is lost there. It consists of more pieces, early_param, static key,
workqueue work.

> If Andrew Morton objects, then I'll do it since the intention was for this
> patch to go through his tree and I believe he is Ok with it this way.
> 
> > > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > > index dee8fc467fcf..401baaac1813 100644
> > > --- a/lib/vsprintf.c
> > > +++ b/lib/vsprintf.c
> > > @@ -761,11 +761,34 @@ static int __init initialize_ptr_random(void)
> > >  early_initcall(initialize_ptr_random);
> > >  
> > >  /* Maps a pointer to a 32 bit unique identifier. */
> > > +int ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
> > > +{
> > > +	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
> > 
> > str is unused.
> 
> I believe Andrew has already fixed this in his tree.
> 
> linux-next has local variable removed now:
> 7422993b4f8e ("rss_stat-add-support-to-detect-rss-updates-of-external-mm-fix")

I see. With this fix, feel free to add:

Acked-by: Petr Mladek <pmladek@suse.com> # lib/vsprintf.c

The clean up could be done by a followup patches.

Best Regards,
Petr
