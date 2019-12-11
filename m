Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818EAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACBE214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfLKJRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:17:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:56376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbfLKJRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:17:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57636AB89;
        Wed, 11 Dec 2019 09:17:41 +0000 (UTC)
Date:   Wed, 11 Dec 2019 10:17:40 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        AlekseyMakarov <aleksey.makarov@linaro.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20191211091740.p6bgjy7sy75maenw@pathway.suse.cz>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
 <20191210091502.qoq55fdjad6aixab@pathway.suse.cz>
 <50d2c44a15960760c6a9d24442a93fa4b31b7594.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d2c44a15960760c6a9d24442a93fa4b31b7594.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-12-11 09:39:06, Benjamin Herrenschmidt wrote:
> On Tue, 2019-12-10 at 10:15 +0100, Petr Mladek wrote:
> > On Tue 2019-12-10 11:57:26, Benjamin Herrenschmidt wrote:
> > > In the following circumstances, the rule of selecting the console
> > > corresponding to the last "console=" entry on the command line as
> > > the preferred console (CON_CONSDEV, ie, /dev/console) fails. This
> > > is a specific example, but it could happen with different consoles
> > > that have a similar name aliasing mechanism.
> > > 
> > > This tentative fix changes the loop in register_console to continue
> > > matching with the array until the match is actually the preferred
> > > console.
> > 
> > One problem with this is that con->match() callbacks might have
> > side effects. If the console matches, the callback sometimes
> > do some changes in the console driver because it expects
> > that the console is going to be registered and used.
> 
> It will still be enabled. I am not changing that. The main issue would
> be if the match callback chokes on being called multiple times.

And this would exactly happen as pointed out by Sergey. match() does
also some setup operations. I would be scared to call them twice.

> This looks indeed a lot more invasive. Is there any reason why what I
> propose wouldn't work as a first patch that can easily be backported ?

Your solution is not acceptable because it might cause calling
match() more times.

The reverse search of list of console does not work for ttySX
consoles because the number is omitted when matching. And the messages
will appear only on the first matched serial console. There is
a paragraph about this in the commit message of my patch.


> We can continue cleaning up from there of course, but I'd be keen on
> having a minimal fix that can go back to stable first.

I would be fine to take my patch as is and do the clean up later.
It seems that more users are affected by the problem. The clean up
might be complicated and prone to regressions.

The question is how far back you would like to go. The changes
in register_console() are rare. Everybody is scared to touch
this mess ;-) And it is prone to regressions.

> I'll give it a spin. However I don't fully grasp why it's necessarily
> so complicated. Correct me if I'm wrong here but you are trying to
> address two issues in that patch:
> 
>  - The one I'm trying to address which is that we might "miss" the
> preferred console in the case of multiple matches.
> 
>  - The fact that when the preferred console isn't found, the one we
> default to (which ends up first in the list) is missing CONSDEV.

My patch is primary fixing this 2nd problem. It fixes showconsole
tool to work correctly. But it covers also the 1st one. It might
be possible to split it when needed. But I think that you could
not easily fix the 1st problem without solving the 2nd one.

The best solution would be to split the match() and setup
functionality. It would be really appreciated. But it is a lot
of work. And it might be hard to backport.

Best Regards,
Petr
