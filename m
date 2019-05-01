Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D2CC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7943620866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfEAFUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 01:20:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:31684 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfEAFUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 01:20:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 22:20:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,416,1549958400"; 
   d="scan'208";a="153757165"
Received: from wul-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.158])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Apr 2019 22:20:34 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1hLhfT-0005Vd-6o; Wed, 01 May 2019 13:20:31 +0800
Date:   Wed, 1 May 2019 13:20:31 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, mgorman@techsingularity.net,
        riel@surriel.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190501052031.dt7zbkw5n5gzf2eg@wfg-t540p.sh.intel.com>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <c0fe0c54-b61a-4f5d-8af5-59818641e747@linux.alibaba.com>
 <20190418090227.GG6567@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190418090227.GG6567@dhcp22.suse.cz>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:02:27AM +0200, Michal Hocko wrote:
>On Wed 17-04-19 13:43:44, Yang Shi wrote:
>[...]
>> And, I'm wondering whether this optimization is also suitable to general
>> NUMA balancing or not.
>
>If there are convincing numbers then this should be a preferable way to
>deal with it. Please note that the number of promotions is not the only
>metric to watch. The overal performance/access latency would be another one.

Good question. Shi and me aligned today. Also talked with Mel (but
sorry I must missed some points due to poor English listening). It
becomes clear that

1) PMEM/DRAM page promotion/demotion is a hard problem to attack.
There will and should be multiple approaches for open discussion
before settling down. The criteria might be balanced complexity,
overheads, performance, etc.

2) We need a lot more data to lay solid foundation for effective
discussions. Testing will be a rather time consuming part for
contributor. We'll need to work together to create a number of
benchmarks that can well exercise the kernel promotion/demotion paths
and gather the necessary numbers. By collaborating on a common set of
tests, we can not only amortize efforts, but also compare different
approaches or compare v1/v2/... of the same approach conveniently.

Ying has already created several LKP test cases for that purpose.
Shi and me plan to join the efforts, too.

Thanks,
Fengguang
