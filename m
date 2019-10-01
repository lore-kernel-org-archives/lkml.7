Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4D2ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD8320842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbfJAOp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:45:28 -0400
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:40674 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbfJAOp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:45:28 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 2351C98941
        for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2019 15:45:27 +0100 (IST)
Received: (qmail 10165 invoked from network); 1 Oct 2019 14:45:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Oct 2019 14:45:26 -0000
Date:   Tue, 1 Oct 2019 15:45:24 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     tonyj@suse.com, acme@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Tony Jones <tonyj@suse.de>
Subject: Re: [PATCH v2] perf script python: integrate page reclaim analyze
 script
Message-ID: <20191001144524.GB3321@techsingularity.net>
References: <1569899984-16272-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1569899984-16272-1-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 11:19:44PM -0400, Yafang Shao wrote:
> A new perf script page-reclaim is introduced in this patch. This new script
> is used to report the page reclaim details. The possible usage of this
> script is as bellow,
> - identify latency spike caused by direct reclaim
> - whehter the latency spike is relevant with pageout
> - why is page reclaim requested, i.e. whether it is because of memory
>   fragmentation
> - page reclaim efficiency
> etc
> In the future we may also enhance it to analyze the memcg reclaim.
> 

Hi,

I ended up not reviewing this patch in detail simply because I would
approach the same class of problem in an entirely different way today.
There is value in accumulating the stats in a report like this;

>     $ perf script report page-reclaim
>     Direct reclaims: 4924
>     Direct latency (ms)        total         max         avg         min
>         	          177823.211    6378.977      36.114       0.051
>     Direct file reclaimed 22920
>     Direct file scanned 28306
>     Direct file sync write I/O 0
>     Direct file async write I/O 0
>     Direct anon reclaimed 212567
>     Direct anon scanned 1446854
>     Direct anon sync write I/O 0
>     Direct anon async write I/O 278325
>     Direct order      0     1     3
>         	   4870    23    31
>     Wake kswapd requests 716
>     Wake order      0     1
>         	  715     1
> 
>     Kswapd reclaims: 9

However, the basic option I would prefer is having the raw latency
information for Direct latency that can be externally parsed by R or any
other statistical method. The reason why is because knowing the max latency
is not enough, I'd want to know the spread of latencies and whether they
were clustered at a point of time or spread out over long periods of
time. I would then build the higher-level reports on top if necessary.

Today, I would also have considered getting the latency figures using eBPF
or systemtap instead although having perf do it may be useful too. That's
not universally popular though so at minimum I would have;

perf script record page-reclaim -- capture all page-reclaim tracepoints
perf script report page-reclaim -- For reclaim entry/exit, merge the two
	tracepoints into one that reports latency. Dump the rest out
	verbatim

For latencies, I would externally post-process them until such time as I
found a common class of bug that needed a high-level report and then
build the perf script support for it.

Please note that I did not spot anything wrong with your script, it's
just that I would not use it myself in its current format for debugging
a reclaim-related problem.

-- 
Mel Gorman
SUSE Labs
