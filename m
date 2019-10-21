Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7817ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BB620679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfJUNE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:04:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:34558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727256AbfJUNE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:04:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C783B504;
        Mon, 21 Oct 2019 13:04:26 +0000 (UTC)
Date:   Mon, 21 Oct 2019 15:04:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog/softlockup: Preserve original timestamp
 when touching watchdog externally
Message-ID: <20191021130425.ewiegm2425hkydb3@pathway.suse.cz>
References: <20190819104732.20966-1-pmladek@suse.com>
 <20190819104732.20966-2-pmladek@suse.com>
 <20191021124214.GD1817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021124214.GD1817@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-10-21 14:42:14, Peter Zijlstra wrote:
> On Mon, Aug 19, 2019 at 12:47:30PM +0200, Petr Mladek wrote:
> > Some bug report included the same softlockups in flush_tlb_kernel_range()
> > in regular intervals. Unfortunately was not clear if there was a progress
> > or not.
> > 
> > The situation can be simulated with a simply busy loop:
> > 
> > 	while (true)
> > 	      cpu_relax();
> > 
> > The softlockup detector produces:
> > 
> > [  168.277520] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
> > [  196.277604] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
> > [  236.277522] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [cat:4865]
> > 
> > One would expect only one softlockup report or several reports with
> > an increased duration.
> 
> Let's just say our expectations differ.
> 
> > The result is that each softlockup is reported only once unless
> > another process get scheduled:
> > 
> > [  320.248948] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4916]
> 
> Which would greatly confuse me; as the above would have me think the
> situation got resolved (no more lockups reported) even though it is
> still very much stuck there.
> 
> IOW, I don't see how this makes anything better. You're removing
> information.

The 2nd patch brings back the regular report but with correctly
counted time (stuck for XXs).

I split it into two patches because I was not sure what would be
preferred behavior. I prefer the regular reports as well.

Best Regards,
Petr
