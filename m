Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F800C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DADF20578
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfH1I6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:58:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:33498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbfH1I6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:58:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4EC19ADDA;
        Wed, 28 Aug 2019 08:58:46 +0000 (UTC)
Date:   Wed, 28 Aug 2019 10:58:45 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: numlist API Re: [RFC PATCH v4 1/9] printk-rb: add a new printk
 ringbuffer implementation
Message-ID: <20190828085845.5k7ewfshbfed7txh@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
 <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
 <87sgpnmqdo.fsf@linutronix.de>
 <20190827130349.6mrnhdlqyqokgsfk@pathway.suse.cz>
 <20190827130349.6mrnhdlqyqokgsfk@pathway.suse.cz>
 <87o909lq3g.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o909lq3g.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-08-28 09:13:39, John Ogness wrote:
> On 2019-08-27, Petr Mladek <pmladek@suse.com> wrote:
> > The API is complicated because of the callbacks. It depends on a logic
> > that is implemented externally. It makes it abstract to some extent.
> >
> > My view is that the API would be much cleaner and easier to review
> > when the ID handling is "hardcoded" (helper functions). It could be
> > made abstract anytime later when there is another user.
> >
> > There should always be a reason why to make a code more complicated
> > than necessary. It seems that the only reason is some theoretical
> > future user and its theoretical requirements.
> 
> FWIW, I did _not_ create the numlist and dataring structures in order to
> support some theoretical future user. PeterZ helped[0] me realize that
> RFCv2 was actually using multiple internal data structures. Each of
> these internal data structures has their own set of memory barriers and
> semantics. By explicitly refactoring them behind strong APIs, the memory
> barriers could be clearly visible and the semantics clearly defined.
> 
> For me this was a great help in _simplifying_ the design. For me it also
> greatly simplified debugging, testing, and verifying because I could
> write tests for numlist and datalist that explicitly targeted those data
> structures. Once I believed they were bullet-proof, I could move on to
> higher-level tests of the printk_ringbuffer. And once I believed the
> printk_ringbuffer was bullet-proof, I could move on to the higher-level
> printk tests. When a problem was found, I could effectively isolate
> which component failed their job.
> 
> I understand that we disagree about the abstractions being a
> simplification.

This is a misunderstanding. I probably was not clear enough. It makes
perfect sense to have separate APIs for numlist and dataring. I agree
that they allow to split the problem into smaller pieces.

I only think that, especially, numlist API is too generic in v4.
It is not selfcontained. The consistency depends on external barriers.

I believe that it might become fully self-contained and consistent
if we reduce possibilities of the generic usage. In particular,
the numlist should allow only linking of reusable structures
stored in an array.

I explained in the previous mail that other use cases are
questionable. If anyone really finds another usecase,
the API might be made more generic. But we should start
with something simple.


> And I'm not sure how to proceed in this regard. (Maybe
> once we get everything bullet-proof, we can put everything back together
> into a monolith like RFCv2.)

I would actually go the other way. It would be nice to add numlist
and dataring API in separate patches.

> Either way, please understand that the
> abstractions were done for the benefit of printk_ringbuffer, not for any
> theoretical future user.

I understand. I hope that it is more clear now.

Best Regards,
Petr
