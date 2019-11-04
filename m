Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAF9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8E120578
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfKDKNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:13:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:65334 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfKDKNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:13:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 02:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,266,1569308400"; 
   d="scan'208";a="401562144"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga005.fm.intel.com with ESMTP; 04 Nov 2019 02:13:22 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC 08/10] autonuma, memory tiering: Select hotter pages to promote to fast memory node
References: <20191101075727.26683-1-ying.huang@intel.com>
        <20191101075727.26683-9-ying.huang@intel.com>
        <20191101092404.GS4131@hirez.programming.kicks-ass.net>
        <87k18gcqih.fsf@yhuang-dev.intel.com>
        <20191104084404.GA4131@hirez.programming.kicks-ass.net>
Date:   Mon, 04 Nov 2019 18:13:21 +0800
In-Reply-To: <20191104084404.GA4131@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 4 Nov 2019 09:44:04 +0100")
Message-ID: <87bltsar0e.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Nov 04, 2019 at 10:41:10AM +0800, Huang, Ying wrote:
>
>> >> +#define NUMA_SCAN_NR_HIST	16
>> >> +		int numa_scan_idx;
>> >> +		unsigned long numa_scan_jiffies[NUMA_SCAN_NR_HIST];
>> >> +		unsigned long numa_scan_starts[NUMA_SCAN_NR_HIST];
>> >
>> > Why 16? This is 4 cachelines.
>> 
>> We want to keep the NUMA scanning history reasonably long.  From
>> task_scan_min(), the minimal interval between task_numa_work() running
>> is about 100 ms by default.  So we can keep 1600 ms history by default
>> if NUMA_SCAN_NR_HIST is 16.  If user choose to use smaller
>> sysctl_numa_balancing_scan_size, then we can only keep shorter history.
>> In general, we want to keep no less than 1000 ms history.  So 16 appears
>> like a reasonable choice for us.  Any other suggestion?
>
> This is very good information for Changelogs and comments :-)

Thanks!  Will do this in the next version.

Best Regards,
Huang, Ying
