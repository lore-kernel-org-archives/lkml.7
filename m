Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5A3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FE52184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCTPZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:25:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:43810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbfCTPZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:25:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A8C0AAC4;
        Wed, 20 Mar 2019 15:25:20 +0000 (UTC)
Date:   Wed, 20 Mar 2019 16:25:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Subject: Re: ratelimit API: was: [RFC PATCH] printk: Introduce "store now but
 print later" prefix.
Message-ID: <20190320152516.3gbmaj5xoyxkivyt@pathway.suse.cz>
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
> > I did not mean serializing. I meant to avoid printing the warnings
> > at all until OOM killer finishes its job.
> 
> But your ratelimit_reset() below requires serializing.
> 
> > 
> > 
> >> Also, both nopage_rs in warn_alloc() and oom_rs in oom_kill_process() are not
> >> working well. This is because ___ratelimit() function assumes that operations
> >> to be ratelimited complete fast enough to be able to repeat many times within
> >> a second. If one operation to be ratelimited takes many seconds (or even
> >> minutes), ___ratelimit() becomes always true and can not ratelimit at all.
> > 
> > The current ratelimiting is time driven. We might need an event
> > driven variant. It might even be done with the current
> > implementation if we add something like:
> > 
> > void ratelimit_reset(struct ratelimit_state *rs)
> > {
> > 	unsigned long flags;
> > 
> > 	raw_spin_irqsave(&rs->lock, flags);
> > 
> > 	rs->begin   = jiffies;
> > 	rs->printed = 0;
> > 
> > 	raw_spin_unlock_irqrestore(&rs->lock, flags);
> > }
> > 
> > We could call this when some event "solved" the problem.
> 
> This requires serialization among threads using "rs". I already
> proposed ratelimit_reset() for memcg's OOM problem at
> https://lkml.kernel.org/r/201810180246.w9I2koi3011358@www262.sakura.ne.jp
> but it was not accepted.

IMHO, the main problem was that the patch tried to work around
the ratelimit API weakness by a custom code.

I believe that using an improved/extended ratelimit API with
a sane semantic would be more acceptable.


> > It means that it makes sense to enable the related
> > ratelimited messages again because they would describe
> > another problem.
> 
> ___ratelimit() could also check number of not-yet-flushed
> printk() records (e.g. log_next_seq - console_seq <= $some_threshold).

The number is almost useless without more information, for example,
how fast the consoles are, how many lines will get filtered
by a console_loglevel, if the console_sem owner is sleeping,
how many messages are being added by other CPUs.

I believe that we do not really need it. The ratelimit_reset()
user should know when the messages can get skipped because
they describe the same situation again and again.

Best Regards,
Petr
