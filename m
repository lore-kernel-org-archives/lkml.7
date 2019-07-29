Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4798C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE762077C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfG2DFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 23:05:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:19572 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfG2DFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 23:05:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jul 2019 20:05:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,321,1559545200"; 
   d="scan'208";a="173741429"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2019 20:04:59 -0700
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
Date:   Mon, 29 Jul 2019 11:04:58 +0800
In-Reply-To: <20190726092021.GA5273@linux.vnet.ibm.com> (Srikar Dronamraju's
        message of "Fri, 26 Jul 2019 14:50:21 +0530")
Message-ID: <87ef295yn9.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:

> * Huang, Ying <ying.huang@intel.com> [2019-07-26 15:45:39]:
>
>> Hi, Srikar,
>> 
>> >
>> > More Remote + Private page Accesses:
>> > Most likely the Private accesses are going to be local accesses.
>> >
>> > In the unlikely event of the private accesses not being local, we should
>> > scan faster so that the memory and task consolidates.
>> >
>> > More Remote + Shared page Accesses: This means the workload has not
>> > consolidated and needs to scan faster. So we need to scan faster.
>> 
>> This sounds reasonable.  But
>> 
>> lr_ratio < NUMA_PERIOD_THRESHOLD
>> 
>> doesn't indicate More Remote.  If Local = Remote, it is also true.  If
>
> less lr_ratio means more remote.
>
>> there are also more Shared, we should slow down the scanning.  So, the
>
> Why should we slowing down if there are more remote shared accesses?
>
>> logic could be
>> 
>> if (lr_ratio >= NUMA_PERIOD_THRESHOLD)
>>     slow down scanning
>> else if (sp_ratio >= NUMA_PERIOD_THRESHOLD) {
>>     if (NUMA_PERIOD_SLOTS - lr_ratio >= NUMA_PERIOD_THRESHOLD)
>>         speed up scanning

Thought about this again.  For example, a multi-threads workload runs on
a 4-sockets machine, and most memory accesses are shared.  The optimal
situation will be pseudo-interleaving, that is, spreading memory
accesses evenly among 4 NUMA nodes.  Where "share" >> "private", and
"remote" > "local".  And we should slow down scanning to reduce the
overhead.

What do you think about this?

Best Regards,
Huang, Ying

>>     else
>>         slow down scanning
>> } else
>>    speed up scanning
>> 
>> This follows your idea better?
>> 
>> Best Regards,
>> Huang, Ying
