Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1601C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A85B217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfDKCMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:12:05 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:41725 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbfDKCMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:12:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TP.w4FA_1554948713;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TP.w4FA_1554948713)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Apr 2019 10:11:59 +0800
Date:   Thu, 11 Apr 2019 10:11:53 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190411021153.GA80125@aaronlu>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.667598558@infradead.org>
 <20190402064612.GA46500@aaronlu>
 <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
 <20190405145530.GA453@aaronlu>
 <460ce6fb-6a40-4a72-47e8-cf9c7c409bef@linux.intel.com>
 <20190410043633.GA67532@aaronlu>
 <CAERHkrsKMm7f2auaQwY5=rodQr5T0kbOo2N1DCUCQcuUOpsEMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrsKMm7f2auaQwY5=rodQr5T0kbOo2N1DCUCQcuUOpsEMg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 10:18:10PM +0800, Aubrey Li wrote:
> On Wed, Apr 10, 2019 at 12:36 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
> >
> > On Tue, Apr 09, 2019 at 11:09:45AM -0700, Tim Chen wrote:
> > > Now that we have accumulated quite a number of different fixes to your orginal
> > > posted patches.  Would you like to post a v2 of the core scheduler with the fixes?
> >
> > One more question I'm not sure: should a task with cookie=0, i.e. tasks
> > that are untagged, be allowed to scheduled on the the same core with
> > another tagged task?
> >
> > The current patch seems to disagree on this, e.g. in pick_task(),
> > if max is already chosen but max->core_cookie == 0, then we didn't care
> > about cookie and simply use class_pick for the other cpu. This means we
> > could schedule two tasks with different cookies(one is zero and the
> > other can be tagged).
> >
> > But then sched_core_find() only allow idle task to match with any tagged
> > tasks(we didn't place untagged tasks to the core tree of course :-).
> >
> > Thoughts? Do I understand this correctly? If so, I think we probably
> > want to make this clear before v2. I personally feel, we shouldn't allow
> > untagged tasks(like kernel threads) to match with tagged tasks.
> 
> Does it make sense if we take untagged tasks as hypervisor, and different
> cookie tasks as different VMs? Isolation is done between VMs, not between
> VM and hypervisor.
> 
> Did you see anything harmful if an untagged task and a tagged task
> run simultaneously on the same core?

VM can see hypervisor's data then, I think.
We probably do not want that happen.
