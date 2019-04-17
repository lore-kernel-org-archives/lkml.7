Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4C0C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D714D21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfDQUn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:43:57 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:40096 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbfDQUn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:43:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TPaV10X_1555533824;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPaV10X_1555533824)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Apr 2019 04:43:49 +0800
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
Message-ID: <c0fe0c54-b61a-4f5d-8af5-59818641e747@linux.alibaba.com>
Date:   Wed, 17 Apr 2019 13:43:44 -0700
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


>>
>>>> I would also not touch the numa balancing logic at this stage and 
>>>> rather
>>>> see how the current implementation behaves.
>>> I agree we would prefer start from something simpler and see how it 
>>> works.
>>>
>>> The "twice access" optimization is aimed to reduce the PMEM 
>>> bandwidth burden
>>> since the bandwidth of PMEM is scarce resource. I did compare "twice 
>>> access"
>>> to "no twice access", it does save a lot bandwidth for some once-off 
>>> access
>>> pattern. For example, when running stress test with mmtest's
>>> usemem-stress-numa-compact. The kernel would promote ~600,000 pages 
>>> with
>>> "twice access" in 4 hours, but it would promote ~80,000,000 pages 
>>> without
>>> "twice access".
>> I pressume this is a result of a synthetic workload, right? Or do you
>> have any numbers for a real life usecase?
>
> The test just uses usemem.

I tried to run some more real life like usecases, the below shows the 
result by running mmtest's db-sysbench-mariadb-oltp-rw-medium test, 
which is a typical database workload, with and w/o "twice access" 
optimization.

                              w/                  w/o
promotion          32771           312250

We can see the kernel did 10x promotion w/o "twice access" optimization.

I also tried kernel-devel and redis tests in mmtest, but they can't 
generate enough memory pressure, so I had to run usemem test to generate 
memory pressure. However, this brought in huge noise, particularly for 
the w/o "twice access" case. But, the mysql test should be able to 
demonstrate the improvement achieved by this optimization.

And, I'm wondering whether this optimization is also suitable to general 
NUMA balancing or not.

