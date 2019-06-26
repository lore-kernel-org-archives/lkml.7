Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3560FC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0974E208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfFZOJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:09:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48412 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZOJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:09:24 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hg8bx-00031H-O6; Wed, 26 Jun 2019 16:09:21 +0200
Date:   Wed, 26 Jun 2019 16:09:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/6] workqueue: convert to raw_spinlock_t
Message-ID: <20190626140921.w2hanfh3pqquzfoi@linutronix.de>
References: <20190613145027.27753-1-bigeasy@linutronix.de>
 <20190626071719.psyftqdop4ny3zxd@linutronix.de>
 <20190626134957.GT657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626134957.GT657710@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-26 06:49:57 [-0700], Tejun Heo wrote:
> On Wed, Jun 26, 2019 at 09:17:19AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-06-13 16:50:21 [+0200], To linux-kernel@vger.kernel.org wrote:
> > > Hi,
> > > 
> > > the workqueue code has been reworked in -RT to use raw_spinlock_t based
> > > locking. This change allows to schedule worker from preempt_disable()ed
> > > or IRQ disabled section on -RT. This is the last patch. The previous
> > > patches are prerequisites or tiny cleanup (like patch #1 and #2).
> > 
> > a gentle *ping*
> 
> I don't now what to make of the series.  AFAICS, there's no benefit to
> mainline.  What am I missing?

Is there something specific you don't like? #1 and #2 are cleanups so we
don't argue about those right?
#5 makes use of swake_up which is slightly smaller compared to wake_up()
so that should be fine.
That last one makes no change to !RT because the difference between
raw_spin and spinlock is not existing. However I'm working a lockdep
patch which complains about wrong context so without it would complain
if anyone would try to schedule a workqueue from IRQ or preemption
disabled region.

> Thanks.

Sebastian
