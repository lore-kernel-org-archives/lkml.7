Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EE9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F106A20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfCSMav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:30:51 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:45555 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbfCSMav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:30:51 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id ED3261C171A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:30:48 +0000 (GMT)
Received: (qmail 23637 invoked from network); 19 Mar 2019 12:30:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[213.151.95.130])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 19 Mar 2019 12:30:48 -0000
Date:   Tue, 19 Mar 2019 12:30:47 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Do not re-read h_load_next during hierarchical
 load calculation
Message-ID: <20190319123047.3qlpejilrms5ckad@techsingularity.net>
References: <20190319091709.lqrtbn76sjx73hnv@techsingularity.net>
 <7de2aa1d-ab22-e7ab-ed9d-06acdbfbde7a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <7de2aa1d-ab22-e7ab-ed9d-06acdbfbde7a@arm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 11:38:25AM +0000, Valentin Schneider wrote:
> Hi,
> 
> On 19/03/2019 09:35, Mel Gorman wrote:
> > A NULL pointer dereference bug was reported on a distribution kernel but
> > the same issue should be present on mainline kernel. It occured on s390
> > but should not be arch-specific.  A partial oops looks like
> > 
> > [775277.408564] Unable to handle kernel pointer dereference in virtual kernel address space
> > ...
> > [775277.408759] Call Trace:
> > [775277.408763] ([<0002c11c56899c61>] 0x2c11c56899c61)
> > [775277.408766]  [<0000000000177bb4>] try_to_wake_up+0xfc/0x450
> > [775277.408773]  [<000003ff81ede872>] vhost_poll_wakeup+0x3a/0x50 [vhost]
> > [775277.408777]  [<0000000000194ae4>] __wake_up_common+0xbc/0x178
> > [775277.408779]  [<0000000000194f86>] __wake_up_common_lock+0x9e/0x160
> > [775277.408780]  [<00000000001950de>] __wake_up_sync_key+0x4e/0x60
> > [775277.408785]  [<00000000005d911e>] sock_def_readable+0x5e/0x98
> > 
> > The bug hits any time between 1 hour to 3 days. The dereference occurs
> > in update_cfs_rq_h_load when accumulating h_load. The problem is that
> > cfq_rq->h_load_next is not protected by any locking and can be updated
> > by parallel calls to task_h_load. Depending on the compiler, code may be
> > generated that re-reads cfq_rq->h_load_next after the check for NULL and
> > then oops when reading se->avg.load_avg. The dissassembly showed that it
> > was possible to reread h_load_next after the check for NULL.
> > 
> > While this does not appear to be an issue for later compilers, it's still
> > an accident if the correct code is generated. Full locking in this path
> > would have high overhead so this patch uses READ_ONCE to read h_load_next
> > only once and check for NULL before dereferencing. It was confirmed that
> > there were no further oops after 10 days of testing.
> > 
> 
> Does that also want a
> 
> Fixes: 685207963be9 ("sched: Move h_load calculation to task_h_load()")
> Cc: stable@vger.kernel.org
> 
> ?
> 
> Other than that, the change looks sane to me.
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 

Thanks. I'll add the Fixes because it does look like the old code would
have been ok. Thanks for the review!
