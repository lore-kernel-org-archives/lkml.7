Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A9EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EE421902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfCUSc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:32:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34465 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbfCUSc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:32:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 623813092650;
        Thu, 21 Mar 2019 18:32:27 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-117-2.phx2.redhat.com [10.3.117.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA0A35D6A9;
        Thu, 21 Mar 2019 18:32:26 +0000 (UTC)
Date:   Thu, 21 Mar 2019 14:32:24 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH v2] sched/fair: Limit sched_cfs_period_timer loop to
 avoid hard lockup
Message-ID: <20190321183224.GA15047@lorien.usersys.redhat.com>
References: <20190319130005.25492-1-pauld@redhat.com>
 <20190321180137.GQ6058@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321180137.GQ6058@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 21 Mar 2019 18:32:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 07:01:37PM +0100 Peter Zijlstra wrote:
> On Tue, Mar 19, 2019 at 09:00:05AM -0400, Phil Auld wrote:
> > sched/fair: Limit sched_cfs_period_timer loop to avoid hard lockup
> > 
> > With extremely short cfs_period_us setting on a parent task group with a large
> > number of children the for loop in sched_cfs_period_timer can run until the
> > watchdog fires. There is no guarantee that the call to hrtimer_forward_now()
> > will ever return 0.  The large number of children can make
> > do_sched_cfs_period_timer() take longer than the period.
> 
> > 
> > To prevent this we add protection to the loop that detects when the loop has run
> > too many times and scales the period and quota up, proportionally, so that the timer
> > can complete before then next period expires.  This preserves the relative runtime
> > quota while preventing the hard lockup.
> > 
> > A warning is issued reporting this state and the new values.
> > 
> > v2: Math reworked/simplified by Peter Zijlstra.
> > 
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Anton Blanchard <anton@ozlabs.org>
> 
> Thanks!

Thank you for your time and help.

What do you think about Cc: stable?


Cheers,
Phil

-- 
