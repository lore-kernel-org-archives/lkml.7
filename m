Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD74C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABA7206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfCDOXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:23:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:38922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726095AbfCDOXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:23:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16F54ABE1;
        Mon,  4 Mar 2019 14:23:41 +0000 (UTC)
Date:   Mon, 4 Mar 2019 15:23:39 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] printk: Introduce "store now but print later" prefix.
Message-ID: <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
References: <1550896930-12324-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190304032202.GD23578@jagdpanzerIV>
 <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-03-04 20:40:37, Tetsuo Handa wrote:
> On 2019/03/04 12:22, Sergey Senozhatsky wrote:
> > On (02/23/19 13:42), Tetsuo Handa wrote:
> > [..]
> >> This patch tries to address "don't lockup the system" with minimal risk of
> >> failing to "print out printk() messages", by allowing printk() callers to
> >> tell printk() "store $body_text_lines lines into logbuf but start actual
> >> printing after $trailer_text_line line is stored into logbuf". This patch
> >> is different from existing printk_deferred(), for printk_deferred() is
> >> intended for scheduler/timekeeping use only. Moreover, what this patch
> >> wants to do is "do not try to print out printk() messages as soon as
> >> possible", for accumulated stalling period cannot be decreased if
> >> printk_deferred() from e.g. dump_tasks() from out_of_memory() immediately
> >> prints out the messages. The point of this patch is to defer the stalling
> >> duration to after leaving the critical section.
> > 
> > We can export printk deferred, I guess; but I'm not sure if it's going
> > to be easy to switch OOM to printk_deferred - there are lots of direct
> > printk callers: warn-s, dump_stacks, etc; it might even be simpler to
> > start re-directing OOM printouts to printk_safe buffer.

Exactly. OOM calls many functions that are called also in other situations.
The async messages are not pushed to the console unless someone calls
a non-async printk.

How do you want to guarantee that the non-async printk will get called
in all situations? The async printk() API is too error-prone.


> I confirmed that printk_deferred() is not suitable for this purpose, for
> it suddenly stalls for seconds at random locations flushing pending output
> accumulated by printk_deferred(). Stalling inside critical section (e.g.
> RCU read lock held) is what I don't like.

I still do not see why your async printk should be significantly
better than printk_deferred(). There is still a random victim
that would be responsible to flush the messages.

It might increase the chance that it will get printed from
normal context. But it also adds the risk that consoles
will not get handled at all.

BTW: The comment above printk_deferred() is there for a reason.
     It is a hack that should not be used widely.

     If you convert half printk() calls into a deferred/async
     module, you will just get into another problems. For example,
     not seeing the messages at all, more lost messages, random
     victims would spend even more time with flushing to the console.

     And not. Handling all messages only from normal context
     or from a dedicated kthread is not acceptable.


> > This is a bit of a strange issue, to be honest. If OOM prints too
> > many messages then we might want to do some work on the OOM side.

To be honest, I am still not sure what messages we are talking about.
Are the messages printed() from OOM killer code? Or are most of
the messages about allocation failures?

Well, both sources of messages would deserve a revision/regulation
if they cause such a big problem.

For example, I would stop printing allocation failures until
the currently running OOM killer succeeds in freeing some memory.
It might print a message about that all further allocation
failures will not get reported and then another message
about the success...

Best Regards,
Petr
