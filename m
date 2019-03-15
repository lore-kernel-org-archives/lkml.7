Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD9921871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfCOQRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:17:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfCOQRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:17:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5666F68575;
        Fri, 15 Mar 2019 16:17:10 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 830D25C219;
        Fri, 15 Mar 2019 16:17:09 +0000 (UTC)
Date:   Fri, 15 Mar 2019 12:17:07 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/fair: Limit sched_cfs_period_timer loop to avoid
 hard lockup
Message-ID: <20190315161707.GG27131@pauld.bos.csb>
References: <20190313150826.16862-1-pauld@redhat.com>
 <20190315101150.GV5996@hirez.programming.kicks-ass.net>
 <20190315153042.GF27131@pauld.bos.csb>
 <20190315160347.GZ5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315160347.GZ5996@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 15 Mar 2019 16:17:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 05:03:47PM +0100 Peter Zijlstra wrote:
> On Fri, Mar 15, 2019 at 11:30:42AM -0400, Phil Auld wrote:
> 
> > In my defense here, all the fair.c imbalance pct code also uses 100 :)
> 
> Yes, I know, I hate on that too ;-) Just never got around to fixing
> that.
> 
> 
> > with the below:
> > 
> > [  117.235804] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 2492, cfs_quota_us = 143554)
> > [  117.346807] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 2862, cfs_quota_us = 164863)
> > [  117.470569] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 3286, cfs_quota_us = 189335)
> > [  117.574883] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 3774, cfs_quota_us = 217439)
> > [  117.652907] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 4335, cfs_quota_us = 249716)
> > [  118.090535] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 4978, cfs_quota_us = 286783)
> > [  122.098009] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 5717, cfs_quota_us = 329352)
> > [  126.255209] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 6566, cfs_quota_us = 378240)
> > [  126.358060] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 7540, cfs_quota_us = 434385)
> > [  126.538358] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 8660, cfs_quota_us = 498865)
> > [  126.614304] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 9945, cfs_quota_us = 572915)
> > [  126.817085] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 11422, cfs_quota_us = 657957)
> > [  127.352038] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 13117, cfs_quota_us = 755623)
> > [  127.598043] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 15064, cfs_quota_us = 867785)
> > 
> > 
> > Plus on repeats I see an occasional 
> > 
> > [  152.803384] sched_cfs_period_timer: 9 callbacks suppressed
> 
> That should be fine, right? It's a fallback for an edge case and
> shouldn't trigger too often anyway.

It doesn't hit the NMI, just takes a bit longer to get out. It is a little messier 
output, but as you say, it's a fallback. If you're okay with it do you want to 
just use your patch? 

Otherwise, I'm happy to do a fixup v2.

> 
> >> I'll rework the maths in the averaged version and post v2 if that makes sense.
> > 
> > It may have the extra timer fetch, although maybe I could rework it so that it used the 
> > nsstart time the first time and did not need to do it twice in a row. I had originally
> > reverted the hrtimer_forward_now() to hrtimer_forward() but put that back. 
> 
> Sure; but remember, simpler is often better, esp. for code that
> typically 'never' runs.
> 
> > Also, fwiw, this was reported earlier by Anton Blanchard in https://lkml.org/lkml/2018/12/3/1047
> 
> Bah, yes, I sometimes loose track of things :/


No worries. I just meant that to show I was not the only one with these low settings, 
and to give credit, or whatever :)


Cheers,
Phil

-- 
