Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEE6C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA7A2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfDZOTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:19:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfDZOTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:19:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B6113DBF8;
        Fri, 26 Apr 2019 14:19:20 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-116-103.phx2.redhat.com [10.3.116.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92C6860856;
        Fri, 26 Apr 2019 14:19:17 +0000 (UTC)
Date:   Fri, 26 Apr 2019 10:19:15 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 12/17] sched: A quick and dirty cgroup tagging
 interface
Message-ID: <20190426141915.GC16477@lorien.usersys.redhat.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <b058b74f303fe40e5822925c90a5b0161c4a0a2d.1556025155.git.vpillai@digitalocean.com>
 <20190425142652.GA979@pauld.bos.csb>
 <20190426141307.GB2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426141307.GB2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 26 Apr 2019 14:19:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 04:13:07PM +0200 Peter Zijlstra wrote:
> On Thu, Apr 25, 2019 at 10:26:53AM -0400, Phil Auld wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index e8e5f26db052..b312ea1e28a4 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7541,6 +7541,9 @@ static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype
> >         if (val > 1)
> >                 return -ERANGE;
> >  
> > +       if (num_online_cpus() <= 1) 
> > +               return -EINVAL;
> 
> We actually know if there SMT on the system or not, which is much better
> indication still:
> 
> 	if (!static_branch_likely(&sched_smt_present))
> 		return -EINVAL;
> 
> >         if (tg->tagged == !!val)
> >                 return 0;
> >  
> > 
> > 
> > 
> > -- 

Yeah, I thought there was probably a better check.

Thanks!

-- 
