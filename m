Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD25FC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 06:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972B620651
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 06:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfEAGpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 02:45:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:44968 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfEAGpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 02:45:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 23:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,416,1549958400"; 
   d="scan'208";a="147194485"
Received: from lixinshe-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.94])
  by orsmga003.jf.intel.com with ESMTP; 30 Apr 2019 23:45:01 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1hLixs-0001t9-M9; Wed, 01 May 2019 14:43:36 +0800
Date:   Wed, 1 May 2019 14:43:36 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, mgorman@techsingularity.net,
        riel@surriel.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190501064336.jktcqkvz27ihpqh3@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190417091748.GF655@dhcp22.suse.cz>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:17:48AM +0200, Michal Hocko wrote:
>On Tue 16-04-19 12:19:21, Yang Shi wrote:
>>
>>
>> On 4/16/19 12:47 AM, Michal Hocko wrote:
>[...]
>> > Why cannot we simply demote in the proximity order? Why do you make
>> > cpuless nodes so special? If other close nodes are vacant then just use
>> > them.
>>
>> We could. But, this raises another question, would we prefer to just demote
>> to the next fallback node (just try once), if it is contended, then just
>> swap (i.e. DRAM0 -> PMEM0 -> Swap); or would we prefer to try all the nodes
>> in the fallback order to find the first less contended one (i.e. DRAM0 ->
>> PMEM0 -> DRAM1 -> PMEM1 -> Swap)?
>
>I would go with the later. Why, because it is more natural. Because that
>is the natural allocation path so I do not see why this shouldn't be the
>natural demotion path.

"Demotion" should be more performance wise by "demoting to the
next-level (cheaper/slower) memory". Otherwise something like this
may happen.

DRAM0 pressured => demote cold pages to DRAM1 
DRAM1 pressured => demote cold pages to DRAM0

Kind of DRAM0/DRAM1 exchanged a fraction of the demoted cold pages,
which looks not helpful for overall system performance.

Over time, it's even possible some cold pages get "demoted" in path
DRAM0=>DRAM1=>DRAM0=>DRAM1=>...

Thanks,
Fengguang
