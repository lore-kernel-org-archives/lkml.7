Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5622C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C096217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JFrH+ub8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfE0KAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:00:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfE0KAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pxkp8tq0sMiTLO95g3xOPswyqXvnhhBUINaDYGjGqIk=; b=JFrH+ub8189YFBJQ++CwXXpXD
        bjLXxf4yQ8tNefpx70/8kC2rlsGT4or1N0FoJfttEIPuxQT11/007WKSJQVV6DpbbqOksGrXHxxJD
        UtM6zzj7EhTYvgX3MaxvXdar1Db7jttKUyjk4QM9o5ttDJEbXe5hhXzRrPlMR+NW73qLZ8LFlXOOu
        8MeVXH0XkX0ZpUwisM5yrg3Pza1y12xbRZMs6AC+lfn7dYGOMTodSMP7Ime5fuKKHHL2TfJLbEGm1
        jrTXbhWeJFp739IS3+JgXyE9BiQgCZ290lvPgRvRO6WdqAAOecqwMhj+AAD0R/P/Nv9wFZ2EGFO1p
        oXVOGtgvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVCQC-0003kQ-RS; Mon, 27 May 2019 10:00:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E4AF202BF403; Mon, 27 May 2019 11:59:59 +0200 (CEST)
Date:   Mon, 27 May 2019 11:59:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        jgross@suse.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Subject: Re: [RFC PATCH 0/6] x86/mm: Flush remote and local TLBs concurrently
Message-ID: <20190527095959.GV2623@hirez.programming.kicks-ass.net>
References: <20190525082203.6531-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525082203.6531-1-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 01:21:57AM -0700, Nadav Amit wrote:
> Currently, local and remote TLB flushes are not performed concurrently,
> which introduces unnecessary overhead - each INVLPG can take 100s of
> cycles. This patch-set allows TLB flushes to be run concurrently: first
> request the remote CPUs to initiate the flush, then run it locally, and
> finally wait for the remote CPUs to finish their work.
> 
> The proposed changes should also improve the performance of other
> invocations of on_each_cpu(). Hopefully, no one has relied on the
> behavior of on_each_cpu() that functions were first executed remotely
> and only then locally.
> 
> On my Haswell machine (bare-metal), running a TLB flush microbenchmark
> (MADV_DONTNEED/touch for a single page on one thread), takes the
> following time (ns):
> 
> 	n_threads	before		after
> 	---------	------		-----
> 	1		661		663
> 	2		1436		1225 (-14%)
> 	4		1571		1421 (-10%)
> 
> Note that since the benchmark also causes page-faults, the actual
> speedup of TLB shootdowns is actually greater. Also note the higher
> improvement in performance with 2 thread (a single remote TLB flush
> target). This seems to be a side-effect of holding synchronization
> data-structures (csd) off the stack, unlike the way it is currently done
> (in smp_call_function_single()).
> 
> Patches 1-2 do small cleanup. Patches 3-5 actually implement the
> concurrent execution of TLB flushes. Patch 6 restores local TLB flushes
> performance, which was hurt by the optimization, to be as good as it was
> before these changes by introducing a fast-pass for this specific case.

I like; ideally we'll get Hyper-V and Xen sorted before the final
version and avoid having to introduce more PV crud and static keys for
that.

The Hyper-V implementation in particular is horrifically ugly, the Xen
one also doesn't win any prices, esp. that on-stack CPU mask needs to
go.

Looking at them, I'm not sure they can actually win anything from using
the new interface, but at least we can avoid making our PV crud uglier
than it has to be.
