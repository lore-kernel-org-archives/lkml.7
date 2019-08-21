Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B6CC3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01DD2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfHUBOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 21:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfHUBOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:14:36 -0400
Received: from oasis.local.home (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C5222DA7;
        Wed, 21 Aug 2019 01:14:35 +0000 (UTC)
Date:   Tue, 20 Aug 2019 21:14:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew Davenport <ddavenport@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Message-ID: <20190820211429.7030b6f6@oasis.local.home>
In-Reply-To: <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
References: <20190819234111.9019-1-keescook@chromium.org>
        <20190819234111.9019-8-keescook@chromium.org>
        <20190820100638.GK2332@hirez.programming.kicks-ass.net>
        <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 12:58:49 +0200
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> >> index 1077366f496b..6c22e8a6f9de 100644
> >> --- a/lib/bug.c
> >> +++ b/lib/bug.c
> >> @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
> >>   		}
> >>   	}
> >>   
> >> +	/*
> >> +	 * BUG() and WARN_ON() families don't print a custom debug message
> >> +	 * before triggering the exception handler, so we must add the
> >> +	 * "cut here" line now. WARN() issues its own "cut here" before the
> >> +	 * extra debugging message it writes before triggering the handler.
> >> +	 */
> >> +	if ((bug->flags & BUGFLAG_PRINTK) == 0)
> >> +		printk(KERN_DEFAULT CUT_HERE);  
> > 
> > I'm not loving that BUGFLAG_PRINTK name, BUGFLAG_CUT_HERE makes more
> > sense to me.
> >   
> 
> Actually it would be BUGFLAG_NO_CUT_HERE then, otherwise all arches not 
> using the generic macros will have to add the flag to get the "cut here" 
> line.
>

Perhaps they all should be audited to see if they don't have the same
problem?

-- Steve
