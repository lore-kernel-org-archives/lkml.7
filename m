Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291C1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CA1208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JS/uUe1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfH1QBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:01:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49170 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfH1QBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T2C3qa57ei+z6I+sxwzCsEwSVzg2AfcS5B55dEodyQo=; b=JS/uUe1j1IMBl6pGYGQbHu1C8
        uM4r8T3B31GnORseMzzh3aF0NMw4Ht/1Ra1X8+q731fIz4ZHK2jVTiYAkpajojw0QMupeI5lNxGsm
        QavgstrX8J6evWaU3g0J0OTpjvT5WTEhrahoRi3V3mHfPWmp4oGJiVABQleURz/BAMJEugZUk/N+C
        54J/dp4N28g0n0Tfeo0m/BXIrDSi65Qs3O4BoSMn9+jy8frRsfjmmEHfNQh6cv/qpZt1MxYbCoqMc
        FLswq1I7Cmye3Ws/3K8OfsKAEXp1remcNwNehHZRiBgGVTaPvVjvSl6E7VhaGSHlCR/v74YcYwiS8
        HdCg6Vf+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i30No-0005YE-GB; Wed, 28 Aug 2019 16:01:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9BECB98040A; Wed, 28 Aug 2019 18:01:14 +0200 (CEST)
Date:   Wed, 28 Aug 2019 18:01:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
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
Message-ID: <20190828160114.GE17205@worktop.programming.kicks-ass.net>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <20190827211417.snpwgnhsu5t6u52y@srcf.ucam.org>
 <20190827215035.GH2332@hirez.programming.kicks-ass.net>
 <20190828153033.GA15512@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828153033.GA15512@pauld.bos.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:30:34AM -0400, Phil Auld wrote:
> On Tue, Aug 27, 2019 at 11:50:35PM +0200 Peter Zijlstra wrote:

> > And given MDS, I'm still not entirely convinced it all makes sense. If
> > it were just L1TF, then yes, but now...
> 
> I was thinking MDS is really the reason for this. L1TF has mitigations but
> the only current mitigation for MDS for smt is ... nosmt. 

L1TF has no known mitigation that is SMT safe. The moment you have
something in your L1, the other sibling can read it using L1TF.

The nice thing about L1TF is that only (malicious) guests can exploit
it, and therefore the synchronizatin context is VMM. And it so happens
that VMEXITs are 'rare' (and already expensive and thus lots of effort
has already gone into avoiding them).

If you don't use VMs, you're good and SMT is not a problem.

If you do use VMs (and do/can not trust them), _then_ you need
core-scheduling; and in that case, the implementation under discussion
misses things like synchronization on VMEXITs due to interrupts and
things like that.

But under the assumption that VMs don't generate high scheduling rates,
it can work.

> The current core scheduler implementation, I believe, still has (theoretical?) 
> holes involving interrupts, once/if those are closed it may be even less 
> attractive.

No; so MDS leaks anything the other sibling (currently) does, this makes
_any_ privilidge boundary a synchronization context.

Worse still, the exploit doesn't require a VM at all, any other task can
get to it.

That means you get to sync the siblings on lovely things like system
call entry and exit, along with VMM and anything else that one would
consider a privilidge boundary. Now, system calls are not rare, they
are really quite common in fact. Trying to sync up siblings at the rate
of system calls is utter madness.

So under MDS, SMT is completely hosed. If you use VMs exclusively, then
it _might_ work because a 'pure' host doesn't schedule that often
(maybe, same assumption as for L1TF).

Now, there have been proposals of moving the privilidge boundary further
into the kernel. Just like PTI exposes the entry stack and code to
Meltdown, the thinking is, lets expose more. By moving the priv boundary
the hope is that we can do lots of common system calls without having to
sync up -- lots of details are 'pending'.
