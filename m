Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6C0C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B0220644
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfG2IQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:16:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:46761 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfG2IQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:16:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 01:16:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,322,1559545200"; 
   d="scan'208";a="165395411"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2019 01:16:28 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, <jhladky@redhat.com>,
        <lvenanci@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] autonuma: Fix scan period updating
References: <20190725080124.494-1-ying.huang@intel.com>
        <20190725173516.GA16399@linux.vnet.ibm.com>
        <87y30l5jdo.fsf@yhuang-dev.intel.com>
        <20190726092021.GA5273@linux.vnet.ibm.com>
        <87ef295yn9.fsf@yhuang-dev.intel.com>
        <20190729072845.GC7168@linux.vnet.ibm.com>
Date:   Mon, 29 Jul 2019 16:16:28 +0800
In-Reply-To: <20190729072845.GC7168@linux.vnet.ibm.com> (Srikar Dronamraju's
        message of "Mon, 29 Jul 2019 12:58:45 +0530")
Message-ID: <87wog145nn.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:

>> >> 
>> >> if (lr_ratio >= NUMA_PERIOD_THRESHOLD)
>> >>     slow down scanning
>> >> else if (sp_ratio >= NUMA_PERIOD_THRESHOLD) {
>> >>     if (NUMA_PERIOD_SLOTS - lr_ratio >= NUMA_PERIOD_THRESHOLD)
>> >>         speed up scanning
>> 
>> Thought about this again.  For example, a multi-threads workload runs on
>> a 4-sockets machine, and most memory accesses are shared.  The optimal
>> situation will be pseudo-interleaving, that is, spreading memory
>> accesses evenly among 4 NUMA nodes.  Where "share" >> "private", and
>> "remote" > "local".  And we should slow down scanning to reduce the
>> overhead.
>> 
>> What do you think about this?
>
> If all 4 nodes have equal access, then all 4 nodes will be active nodes.
>
> From task_numa_fault()
>
> 	if (!priv && !local && ng && ng->active_nodes > 1 &&
> 				numa_is_active_node(cpu_node, ng) &&
> 				numa_is_active_node(mem_node, ng))
> 		local = 1;
>
> Hence all accesses will be accounted as local. Hence scanning would slow
> down.

Yes.  You are right!  Thanks a lot!

There may be another case.  For example, a workload with 9 threads runs
on a 2-sockets machine, and most memory accesses are shared.  7 threads
runs on the node 0 and 2 threads runs on the node 1 based on CPU load
balancing.  Then the 2 threads on the node 1 will have "share" >>
"private" and "remote" >> "local".  But it doesn't help to speed up
scanning.

Best Regards,
Huang, Ying
