Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84BBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC26A21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403996AbfJYDkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 23:40:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:44679 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfJYDkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:40:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 20:40:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="398639982"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2019 20:40:13 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Jonathan Adams <jwadams@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Williams\, Dan J" <dan.j.williams@intel.com>,
        "Verma\, Vishal L" <vishal.l.verma@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [RFC] Memory Tiering
References: <c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com>
        <CA+VK+GMAqMVXKQqjGzSj9P+-TKr_Jn6qQ1cHSyxhDsoChorm_w@mail.gmail.com>
Date:   Fri, 25 Oct 2019 11:40:12 +0800
In-Reply-To: <CA+VK+GMAqMVXKQqjGzSj9P+-TKr_Jn6qQ1cHSyxhDsoChorm_w@mail.gmail.com>
        (Jonathan Adams's message of "Wed, 23 Oct 2019 16:11:39 -0700")
Message-ID: <87k18th4rn.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Adams <jwadams@google.com> writes:

>  1
> On Wed, Oct 16, 2019 at 1:05 PM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> The memory hierarchy is getting more complicated and the kernel is
>> playing an increasing role in managing the different tiers.  A few
>> different groups of folks described "migration" optimizations they were
>> doing in this area at LSF/MM earlier this year.  One of the questions
>> folks asked was why autonuma wasn't being used.
>>
>> At Intel, the primary new tier that we're looking at is persistent
>> memory (PMEM).  We'd like to be able to use "persistent memory"
>> *without* using its persistence properties, treating it as slightly
>> slower DRAM.  Keith Busch has some patches to use NUMA migration to
>> automatically migrate DRAM->PMEM instead of discarding it near the end
>> of the reclaim process.  Huang Ying has some patches which use a
>> modified autonuma to migrate frequently-used data *back* from PMEM->DRAM.
>>
>> We've tried to do this all generically so that it is not tied to
>> persistent memory and can be applied to any memory types in lots of
>> topologies.
>>
>> We've been running this code in various forms for the past few months,
>> comparing it to pure DRAM and hardware-based caching.  The initial
>> results are encouraging and we thought others might want to take a look
>> at the code or run their own experiments.  We're expecting to post the
>> individual patches soon.  But, until then, the code is available here:
>>
>>         https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git
>>
>> and is tagged with "tiering-0.2", aka. d8e31e81b1dca9.
>
> Hi Dave,
>
> Thanks for sharing this git link and information on your approach.
> This interesting, and lines up somewhat with the approach Google has
> been investigating.  As we discussed at LSF/MM[1] and Linux
> Plumbers[2], we're working on an approach which integrates with our
> proactive reclaim work, with a similar attitude to PMEM (use it as
> "slightly slower" DRAM, ignoring its persistence).  The prototype we
> have has a similar basic structure to what you're doing here and Yang
> Shi's patchset from March[3] (separate NUMA nodes for PMEM), but
> relies on a fair amount of kernel changes to control allocations from
> the NUMA nodes, and uses a similar "is_far" NUMA flag to Yang Shi's
> approach.
>
> We're working on redesigning to reduce the scope of kernel changes and
> to remove the "is_far" special handling;  we still haven't refined
> down to a final approach, but one basic part we want to keep from the
> prototype is proactively pushing PMEM data back to DRAM when we've
> noticed it's in use. If we look at a two-socket system:
>
> A: DRAM & CPU node for socket 0
> B: PMEM node for socket 0
> C: DRAM & CPU node for socket 1
> D: PMEM node for socket 1
>
> instead of the unidirectional approach your patches go for:
>
>   A is marked as "in reclaim, push pages to" B
>   C is marked as "in reclaim, push pages to" D
>   B & D have no markings
>
> we would have a bidirectional attachment:
>
> A is marked "move cold pages to" B
> B is marked "move hot pages to" A
> C is marked "move cold pages to" D
> D is marked "move hot pages to" C
>
> By using autonuma for moving PMEM pages back to DRAM, you avoid
> needing the B->A  & D->C links, at the cost of migrating the pages
> back synchronously at pagefault time (assuming my understanding of how

Yes.  It's "synchronously".  But it will avoid most time-consuming
direct-reclaiming or page lock acquiring, so the latency will not be
uncontrollable.

> autonuma works is accurate).
>
> Our approach still lets you have multiple levels of hierarchy for a
> given socket (you could imaging an "E" node with the same relation to
> "B" as "B" has to "A"), but doesn't make it easy to represent (say) an
> "E" which was equally close to all sockets (which I could imagine for
> something like remote memory on GenZ or what-have-you), since there
> wouldn't be a single back link; there would need to be something like
> your autonuma support to achieve that.

If hot pages in PMEM is identified via check "A" bit in PTE, there's no
information about which CPU is accessing the pages.  One way to mitigate
is to use the original AutoNUMA.  For example, the hot pages may be
migrated

B -> A: via PMEM hot page promotion
A -> C: via original AutoNUMA

> Does that make sense?

Yes.  Definitely.

Best Regards,
Huang, Ying

> Thanks,
> - Jonathan
>
> [1] Shakeel's talk, I can't find a link at the moment.  The basic
> kstaled/kreclaimd approach we built upon is talked about in
> https://blog.acolyer.org/2019/05/22/sw-far-memory/ and the linked
> ASPLOS paper
> [2] https://linuxplumbersconf.org/event/4/contributions/561/; slides
> at
> https://linuxplumbersconf.org/event/4/contributions/561/attachments/363/596/Persistent_Memory_as_Memory.pdf
> [3] https://lkml.org/lkml/2019/3/23/10
