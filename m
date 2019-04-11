Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84819C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F0220818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDKDFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:05:52 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:26187 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbfDKDFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:05:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TP0HtHW_1554951941;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TP0HtHW_1554951941)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Apr 2019 11:05:48 +0800
Date:   Thu, 11 Apr 2019 11:05:41 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190411030541.GA99895@aaronlu>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.667598558@infradead.org>
 <20190402064612.GA46500@aaronlu>
 <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
 <20190405145530.GA453@aaronlu>
 <460ce6fb-6a40-4a72-47e8-cf9c7c409bef@linux.intel.com>
 <20190410043633.GA67532@aaronlu>
 <20190410144418.GH2490@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410144418.GH2490@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:44:18PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 10, 2019 at 12:36:33PM +0800, Aaron Lu wrote:
> > On Tue, Apr 09, 2019 at 11:09:45AM -0700, Tim Chen wrote:
> > > Now that we have accumulated quite a number of different fixes to your orginal
> > > posted patches.  Would you like to post a v2 of the core scheduler with the fixes?
> > 
> > One more question I'm not sure: should a task with cookie=0, i.e. tasks
> > that are untagged, be allowed to scheduled on the the same core with
> > another tagged task?
> 
> That was not meant to be possible.

Good to know this.

> > The current patch seems to disagree on this, e.g. in pick_task(),
> > if max is already chosen but max->core_cookie == 0, then we didn't care
> > about cookie and simply use class_pick for the other cpu. This means we
> > could schedule two tasks with different cookies(one is zero and the
> > other can be tagged).
> 
> When core_cookie==0 we shouldn't schedule the other siblings at all.

Not even with another untagged task?

I was thinking to leave host side tasks untagged, like kernel threads,
init and other system daemons or utilities etc., and tenant tasks tagged.
Then at least two untagged tasks can be scheduled on the same core.

Kindly let me know if you see a problem with this.

> > But then sched_core_find() only allow idle task to match with any tagged
> > tasks(we didn't place untagged tasks to the core tree of course :-).
> > 
> > Thoughts? Do I understand this correctly? If so, I think we probably
> > want to make this clear before v2. I personally feel, we shouldn't allow
> > untagged tasks(like kernel threads) to match with tagged tasks.
> 
> Agreed, cookie should always match or idle.

Thanks a lot for the clarification.
