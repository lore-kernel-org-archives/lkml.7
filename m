Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBD2C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA4B20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbfHFN7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:59:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfHFN7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:59:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DEDE31475D8;
        Tue,  6 Aug 2019 13:59:02 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-117-119.phx2.redhat.com [10.3.117.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2BCF600CC;
        Tue,  6 Aug 2019 13:59:01 +0000 (UTC)
Date:   Tue, 6 Aug 2019 09:58:59 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: use rq_lock/unlock in online_fair_sched_group
Message-ID: <20190806135858.GA15188@lorien.usersys.redhat.com>
References: <20190801133749.11033-1-pauld@redhat.com>
 <20190806130334.GO2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806130334.GO2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 06 Aug 2019 13:59:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 03:03:34PM +0200 Peter Zijlstra wrote:
> On Thu, Aug 01, 2019 at 09:37:49AM -0400, Phil Auld wrote:
> > Enabling WARN_DOUBLE_CLOCK in /sys/kernel/debug/sched_features causes
> 
> ISTR there were more issues; but it sure is good to start picking them
> off.

I haven't hit any others but if/when I'll try to dig into them. 

> 
> > warning to fire in update_rq_clock. This seems to be caused by onlining
> > a new fair sched group not using the rq lock wrappers.
> > 
> > [472978.683085] rq->clock_update_flags & RQCF_UPDATED
> > [472978.683100] WARNING: CPU: 5 PID: 54385 at kernel/sched/core.c:210 update_rq_clock+0xec/0x150
> 
> > Using the wrappers in online_fair_sched_group instead of the raw locking 
> > removes this warning. 
> 
> Yeah, that seems sane. Thanks!

Thanks,
Phil

-- 
