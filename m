Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615B5C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BCA23405
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfH2Oa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfH2Oa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:30:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BE413D966;
        Thu, 29 Aug 2019 14:30:56 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0330660461;
        Thu, 29 Aug 2019 14:30:52 +0000 (UTC)
Date:   Thu, 29 Aug 2019 10:30:51 -0400
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
Message-ID: <20190829143050.GA7262@pauld.bos.csb>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <20190827211417.snpwgnhsu5t6u52y@srcf.ucam.org>
 <20190827215035.GH2332@hirez.programming.kicks-ass.net>
 <20190828153033.GA15512@pauld.bos.csb>
 <20190828160114.GE17205@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828160114.GE17205@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 29 Aug 2019 14:30:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 06:01:14PM +0200 Peter Zijlstra wrote:
> On Wed, Aug 28, 2019 at 11:30:34AM -0400, Phil Auld wrote:
> > On Tue, Aug 27, 2019 at 11:50:35PM +0200 Peter Zijlstra wrote:
> 
> > > And given MDS, I'm still not entirely convinced it all makes sense. If
> > > it were just L1TF, then yes, but now...
> > 
> > I was thinking MDS is really the reason for this. L1TF has mitigations but
> > the only current mitigation for MDS for smt is ... nosmt. 
> 
> L1TF has no known mitigation that is SMT safe. The moment you have
> something in your L1, the other sibling can read it using L1TF.
> 
> The nice thing about L1TF is that only (malicious) guests can exploit
> it, and therefore the synchronizatin context is VMM. And it so happens
> that VMEXITs are 'rare' (and already expensive and thus lots of effort
> has already gone into avoiding them).
> 
> If you don't use VMs, you're good and SMT is not a problem.
> 
> If you do use VMs (and do/can not trust them), _then_ you need
> core-scheduling; and in that case, the implementation under discussion
> misses things like synchronization on VMEXITs due to interrupts and
> things like that.
> 
> But under the assumption that VMs don't generate high scheduling rates,
> it can work.
> 
> > The current core scheduler implementation, I believe, still has (theoretical?) 
> > holes involving interrupts, once/if those are closed it may be even less 
> > attractive.
> 
> No; so MDS leaks anything the other sibling (currently) does, this makes
> _any_ privilidge boundary a synchronization context.
> 
> Worse still, the exploit doesn't require a VM at all, any other task can
> get to it.
> 
> That means you get to sync the siblings on lovely things like system
> call entry and exit, along with VMM and anything else that one would
> consider a privilidge boundary. Now, system calls are not rare, they
> are really quite common in fact. Trying to sync up siblings at the rate
> of system calls is utter madness.
> 
> So under MDS, SMT is completely hosed. If you use VMs exclusively, then
> it _might_ work because a 'pure' host doesn't schedule that often
> (maybe, same assumption as for L1TF).
> 
> Now, there have been proposals of moving the privilidge boundary further
> into the kernel. Just like PTI exposes the entry stack and code to
> Meltdown, the thinking is, lets expose more. By moving the priv boundary
> the hope is that we can do lots of common system calls without having to
> sync up -- lots of details are 'pending'.


Thanks for clarifying. My understanding is (somewhat) less fuzzy now. :)

I think, though, that you were basically agreeing with me that the current 
core scheduler does not close the holes, or am I reading that wrong.


Cheers,
Phil

-- 
