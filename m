Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F81C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1942063F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfFZHrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:47:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:49764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726796AbfFZHrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:47:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4FE3AC9B;
        Wed, 26 Jun 2019 07:47:20 +0000 (UTC)
Date:   Wed, 26 Jun 2019 09:47:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190626074718.n7fmxugeul3lyyq6@pathway.suse.cz>
References: <20190618045117.GA7419@jagdpanzerIV>
 <87imt2bl0k.fsf@linutronix.de>
 <20190625064543.GA19050@jagdpanzerIV>
 <20190625071500.GB19050@jagdpanzerIV>
 <875zoujbq4.fsf@linutronix.de>
 <20190625090620.wufhvdxxiryumdra@pathway.suse.cz>
 <20190625100322.GD532@jagdpanzerIV>
 <87woh9hnxg.fsf@linutronix.de>
 <20190626020837.GA25178@jagdpanzerIV>
 <87mui43jgk.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mui43jgk.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-06-26 09:16:11, John Ogness wrote:
> On 2019-06-26, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > [..]
> >> > CPU0								CPU1
> >> > printk(...)
> >> >  sz = vscprintf(NULL, "Comm %s\n", current->comm);
> >> > 								ia64_mca_modify_comm()
> >> > 								  snprintf(comm, sizeof(comm), "%s %d", current->comm, previous_current->pid);
> >> > 								  memcpy(current->comm, comm, sizeof(current->comm));
> >> >  if ((buf = prb_reserve(... sz))) {
> >> >    vscnprintf(buf, "Comm %s\n", current->comm);
> >> > 				^^^^^^^^^^^^^^ ->comm has changed.
> >> > 					       Nothing critical, we
> >> > 					       should not corrupt
> >> > 					       anything, but we will
> >> > 					       truncate ->comm if its
> >> > 					       new size is larger than
> >> > 					       what it used to be when
> >> > 					       we did vscprintf(NULL).
> >> >    prb_commit(...);
> >> >  }

Great catch.

> After we get a lockless ringbuffer that we are happy with, my next
> series to integrate the buffer into printk will again use the sprint_rb
> solution to avoid the issue discussed in this thread. Perhaps it would
> be best to continue this discussion after I've posted that series.

We should keep it in head. But I fully agree with postponing
the discussion.

I personally think that this is a corner case. I would start with
a simple vscprintf(NULL, ...) and vscprintf(reserved_buf, ...)
approach. We could always make it more complex when it causes
real life problems.

If the data might change under the hood then we have bigger
problems. For example, there might be a race when the trailing
"\0" has not been written yet.

Best Regards,
Petr
