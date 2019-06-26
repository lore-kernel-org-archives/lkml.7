Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBEEC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE8920B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfFZI3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:29:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:60738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfFZI3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:29:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32D6CAC2D;
        Wed, 26 Jun 2019 08:29:36 +0000 (UTC)
Date:   Wed, 26 Jun 2019 10:29:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190626082935.ocbqqaol5jzcuxwl@pathway.suse.cz>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
 <87d0j31iyc.fsf@linutronix.de>
 <20190624140948.l7ekcmz5ser3zfr2@pathway.suse.cz>
 <87blylhjy8.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blylhjy8.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-06-25 15:29:35, John Ogness wrote:
> To address your question: For the linked list implementation, if you are
> looking at it from the linked list perspective, the number of
> descriptors on the list is constantly fluctuating (increasing and
> decreasing) and the ordering of the descriptors is constantly
> changing. They are ordered according to the writer commit order (not the
> writer reserve order) and the only descriptors on the list are the ones
> that are not within a reserve/commit window.

This and few other comments below are really valuable explanation.
I misunderstood how the list worked. I have to revisit it and
rethink my view on the patchset.

> >>> If the above is true then we could achieve similar result
> >>> when using the array as a circular buffer. It would be
> >>> the same like when all members are linked from the beginning.
> >> 
> >> So you are suggesting using a multi-reader multi-writer lockless
> >> ringbuffer to implement a multi-reader multi-writer lockless
> >> ringbuffer. ;-)
> >> 
> >> The descriptor ringbuffer has fixed-size items, which simplifies the
> >> task. But I expect you will run into a chicken-egg scenario.
> >
> > AFAIK, the main obstacle with the fully lockless solution was
> > that the entries did not have a fixed size.
> 
> No. The variable size of the records was the reason I used
> descriptors. That has nothing to do with how I chose to connect those
> descriptors.

I think that we are talking about the same. If I remember correctly,
the main problem is that cmpxchg() is not reliable when the same
address might be used by the metadata and data.

For example, the code never know if it compared previous seq number
of it another CPU/NMI wrote there data (string) in the meantime.

> I think it is not as simple as you think it is and I expect you will end
> up with a solution that is more complex (although I could be
> wrong). IMHO the linked list solution is quite elegant.

It is quite likely.

> There is an obvious push to get the kernel docs unified under RST, even
> if it is not how I usually do things either. However, now that I've done
> the work, looking back it seems to be a good idea in order to automate
> documentation.

I personally like /** */ description of public API functions. Also
html/pdf version looks nice even though I do not use them.

The thing is that both /** */ and .rst formats can be well readable
even in the source code. I guess that most existing developers read
only the source code.

Well, this discussion probably belongs to another thread. My wish
was just to make the commit message more verbose, please.

> I explicitly wanted to get away from any preconceptions. By specifying
> we have data linked from oldest to newest, I find it feels more natural,
> regardless if I am a writer writing new records to the newest or a
> reader reading all records from oldest to newest.

As I said, I do not have strong opinion. I could live with oldest, newest.

Best Regards,
Petr
