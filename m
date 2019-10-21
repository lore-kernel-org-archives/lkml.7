Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64161CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D8E214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfJUNko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:56296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729539AbfJUNkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAE91B233;
        Mon, 21 Oct 2019 13:40:39 +0000 (UTC)
Date:   Mon, 21 Oct 2019 15:40:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog/softlockup: Report the same softlockup
 regularly
Message-ID: <20191021134038.fz2cdpxrd3p3yhb7@pathway.suse.cz>
References: <20190819104732.20966-1-pmladek@suse.com>
 <20190819104732.20966-3-pmladek@suse.com>
 <20191021124339.GE1817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021124339.GE1817@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-10-21 14:43:39, Peter Zijlstra wrote:
> On Mon, Aug 19, 2019 at 12:47:31PM +0200, Petr Mladek wrote:
> > Softlockup report means that there is no progress on the given CPU. It
> > might be a "short" affair where the system gets recovered. But often
> > the system stops being responsive and need to get rebooted.
> > 
> > The softlockup might be root of the problems or just a symptom. It might
> > be a deadlock, livelock, or often repeated state.
> > 
> > Regular reports help to distinguish different situations. Fortunately,
> > the watchdog is finally able to show correct information how long
> > softlockup_fn() was not scheduled.
> > 
> > Report before this patch:
> > 
> > [  320.248948] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4916]
> > 
> > And after this patch:
> > 
> > [  480.372418] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4943]
> > [  508.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 52s! [cat:4943]
> > [  548.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 89s! [cat:4943]
> > [  576.372351] watchdog: BUG: soft lockup - CPU#2 stuck for 115s! [cat:4943]
> > 
> > Note that the horrible code never really worked before the accounting
> > was fixed. The last working timestamp was regularly lost by the many
> > touch*watchdog() calls.
> 
> So what's the point of patch 1? Just confusing people?

I was not sure what was the expected behavior. The code actually
looked like only the first report was wanted. But it probably never
worked that way.

Should I squash the two patches and send it again, please?

Best Regards,
Petr
