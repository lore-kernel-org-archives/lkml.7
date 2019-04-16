Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38713C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D11220868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfDPXSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:18:45 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:34734 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728237AbfDPXSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:18:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TPV9h2n_1555456718;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPV9h2n_1555456718)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Apr 2019 07:18:41 +0800
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
Message-ID: <fe21be04-88a4-b2f6-0fa6-24776ac4d7dd@linux.alibaba.com>
Date:   Tue, 16 Apr 2019 16:18:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> Why cannot we start simple and build from there? In other words I 
>>>> do not
>>>> think we really need anything like N_CPU_MEM at all.
>>> In this patchset N_CPU_MEM is used to tell us what nodes are cpuless 
>>> nodes.
>>> They would be the preferred demotion target.  Of course, we could 
>>> rely on
>>> firmware to just demote to the next best node, but it may be a 
>>> "preferred"
>>> node, if so I don't see too much benefit achieved by demotion. Am I 
>>> missing
>>> anything?
>> Why cannot we simply demote in the proximity order? Why do you make
>> cpuless nodes so special? If other close nodes are vacant then just use
>> them.

And, I'm supposed we agree to *not* migrate from PMEM node (cpuless 
node) to any other node on reclaim path, right? If so we need know if 
the current node is DRAM node or PMEM node. If DRAM node, do demotion; 
if PMEM node, do swap. So, using N_CPU_MEM to tell us if the current 
node is DRAM node or not.

> We could. But, this raises another question, would we prefer to just 
> demote to the next fallback node (just try once), if it is contended, 
> then just swap (i.e. DRAM0 -> PMEM0 -> Swap); or would we prefer to 
> try all the nodes in the fallback order to find the first less 
> contended one (i.e. DRAM0 -> PMEM0 -> DRAM1 -> PMEM1 -> Swap)?
>
>
> |------|     |------| |------|        |------|
> |PMEM0|---|DRAM0| --- CPU0 --- CPU1 --- |DRAM1| --- |PMEM1|
> |------|     |------| |------|       |------|
>
> The first one sounds simpler, and the current implementation does so 
> and this needs find out the closest PMEM node by recognizing cpuless 
> node.
>
> If we prefer go with the second option, it is definitely unnecessary 
> to specialize any node.
>

