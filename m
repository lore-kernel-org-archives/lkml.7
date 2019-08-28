Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16190C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF91D2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfH1Paj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:30:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfH1Pai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:30:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6AAE308A9E0;
        Wed, 28 Aug 2019 15:30:37 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2565100197A;
        Wed, 28 Aug 2019 15:30:35 +0000 (UTC)
Date:   Wed, 28 Aug 2019 11:30:34 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
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
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190828153033.GA15512@pauld.bos.csb>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <20190827211417.snpwgnhsu5t6u52y@srcf.ucam.org>
 <20190827215035.GH2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827215035.GH2332@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 28 Aug 2019 15:30:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 11:50:35PM +0200 Peter Zijlstra wrote:
> On Tue, Aug 27, 2019 at 10:14:17PM +0100, Matthew Garrett wrote:
> > Apple have provided a sysctl that allows applications to indicate that 
> > specific threads should make use of core isolation while allowing 
> > the rest of the system to make use of SMT, and browsers (Safari, Firefox 
> > and Chrome, at least) are now making use of this. Trying to do something 
> > similar using cgroups seems a bit awkward. Would something like this be 
> > reasonable? 
> 
> Sure; like I wrote earlier; I only did the cgroup thing because I was
> lazy and it was the easiest interface to hack on in a hurry.
> 
> The rest of the ABI nonsense can 'trivially' be done later; if when we
> decide to actually do this.

I think something that allows the tag to be set may be needed. One of 
the use cases for this is virtualization stacks, where you really want
to be able to keep the higher CPU count and to set up the isolation 
from management processes on the host. 

The current cgroup interface doesn't work for that because it doesn't 
apply the tag to children. We've been unable to fully test it in a virt
setup because our VMs are made of a child cgroup per vcpu. 

> 
> And given MDS, I'm still not entirely convinced it all makes sense. If
> it were just L1TF, then yes, but now...

I was thinking MDS is really the reason for this. L1TF has mitigations but
the only current mitigation for MDS for smt is ... nosmt. 

The current core scheduler implementation, I believe, still has (theoretical?) 
holes involving interrupts, once/if those are closed it may be even less 
attractive.

> 
> > Having spoken to the Chrome team, I believe that the 
> > semantics we want are:
> > 
> > 1) A thread to be able to indicate that it should not run on the same 
> > core as anything not in posession of the same cookie
> > 2) Descendents of that thread to (by default) have the same cookie
> > 3) No other thread be able to obtain the same cookie
> > 4) Threads not be able to rejoin the global group (ie, threads can 
> > segregate themselves from their parent and peers, but can never rejoin 
> > that group once segregated)
> > 
> > but don't know if that's what everyone else would want.
> > 
> > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > index 094bb03b9cc2..5d411246d4d5 100644
> > --- a/include/uapi/linux/prctl.h
> > +++ b/include/uapi/linux/prctl.h
> > @@ -229,4 +229,5 @@ struct prctl_mm_map {
> >  # define PR_PAC_APDBKEY			(1UL << 3)
> >  # define PR_PAC_APGAKEY			(1UL << 4)
> >  
> > +#define PR_CORE_ISOLATE			55
> >  #endif /* _LINUX_PRCTL_H */
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index 12df0e5434b8..a054cfcca511 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -2486,6 +2486,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> >  			return -EINVAL;
> >  		error = PAC_RESET_KEYS(me, arg2);
> >  		break;
> > +	case PR_CORE_ISOLATE:
> > +#ifdef CONFIG_SCHED_CORE
> > +		current->core_cookie = (unsigned long)current;
> 
> This needs to then also force a reschedule of current. And there's the
> little issue of what happens if 'current' dies while its children live
> on, and current gets re-used for a new process and does this again.

sched_core_get() too?


Cheers,
Phil

> 
> > +#else
> > +		result = -EINVAL;
> > +#endif
> > +		break;
> >  	default:
> >  		error = -EINVAL;
> >  		break;
> > 
> > 
> > -- 
> > Matthew Garrett | mjg59@srcf.ucam.org

-- 
