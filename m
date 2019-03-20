Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE2BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DC12184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfCTPET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:04:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:39720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727382AbfCTPET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:04:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3295DAD07;
        Wed, 20 Mar 2019 15:04:18 +0000 (UTC)
Date:   Wed, 20 Mar 2019 16:04:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC PATCH] printk: Introduce "store now but print later" prefix.
Message-ID: <20190320150416.4otf2343wmjfbw2c@pathway.suse.cz>
References: <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
 <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
 <201903050123.x251N312025685@www262.sakura.ne.jp>
 <20190306100404.jzfk7oqsh3turqth@pathway.suse.cz>
 <0fc95fee-8b6e-5ff0-9a91-9e0ea66028f3@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fc95fee-8b6e-5ff0-9a91-9e0ea66028f3@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-03-07 03:24:25, Tetsuo Handa wrote:
> On 2019/03/06 19:04, Petr Mladek wrote:
> >> I'm suggesting to use a non-async printk() for $trailer_text_line line. I think
> >> that changing all printk() called from out_of_memory() to async is doable, if
> >> the caller of out_of_memory() wakes up a dedicated kthread described below.
> > 
> > This is error prone. The trailing printk is not guaranteed:
> > 
> >     + It might get lost by code refactoring.
> 
> Caller uses this async printk() with their own risk. This concern is same with
> "buffering into on-stack 'char buf[80]' using snprintf() and forgetting to flush
> it using printk()".

AFAIK, all pr_cont() users are self-contained. Most of them print all
pieces in the same function. Some of them print the part of the lines
using some helper scripts but these are defined in the same source
file, usually right above the caller.

> > 
> >     + People would miss that it is needed when async printk is used
> >       in a shared function, e.g. dump_stack().
> 
> I'm planning to allow async printk() for shared functions like dump_stack()
> because there will be some $trailer_text_line line after such shared functions.
> (By the way, for that reason, I expect that we won't do a tree-wide KERN_DEFAULT
> removal so that callers can pass KERN_DEFAULT_ASYNC as an function argument to
> such shared functions.)

Now, you are going to spread related lines all over the kernel sources.


> > But I would really like to avoid even more printk variants.
> > They have many problems:
> > 
> >     + Only a handful of people would know how to use them right.
> 
> The caller of async printk() knows when/how to use async printk().
> 
> > 
> >     + They are hard to maintain. Any incompatible printk() in the call
> >       chain might break the intention.
> 
> There is no incompatible printk(). Only when to wake up a thread which
> writes to consoles differs.

By incompatible I mean the following:

   + Adding any synchronous printk() into a chain of async printk's
     will break the chain. I mean that the consoles will get handled
     by the new normal printk() before the original author wanted.

   + Also the wanted normal printk() might get removed from some
     reason (by mistake). Then all the previous async lines will
     not get reliably flushed.

Both situations are bugs that might get fixed. But the API
is just too error prone from my POV.

We are repeating the same arguments by different words all over
again. I explained why the API is not acceptable for me and
suggested other approaches. This is my last mail about the API.

Best Regards,
Petr
