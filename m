Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0619C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639E220868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfDPXRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:17:51 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44352 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728237AbfDPXRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:17:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TPVBBj6_1555456664;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPVBBj6_1555456664)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Apr 2019 07:17:48 +0800
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
To:     Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
 <99320338-d9d3-74ca-5b07-6c3ca718800f@linux.alibaba.com>
 <1556283f-de69-ce65-abf8-22f6f8d7d358@intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <8bc32012-b747-3827-1814-91942357d170@linux.alibaba.com>
Date:   Tue, 16 Apr 2019 16:17:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1556283f-de69-ce65-abf8-22f6f8d7d358@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/19 4:04 PM, Dave Hansen wrote:
> On 4/16/19 2:59 PM, Yang Shi wrote:
>> On 4/16/19 2:22 PM, Dave Hansen wrote:
>>> Keith Busch had a set of patches to let you specify the demotion order
>>> via sysfs for fun.  The rules we came up with were:
>>> 1. Pages keep no history of where they have been
>>> 2. Each node can only demote to one other node
>> Does this mean any remote node? Or just DRAM to PMEM, but remote PMEM
>> might be ok?
> In Keith's code, I don't think we differentiated.  We let any node
> demote to any other node you want, as long as it follows the cycle rule.

I recall Keith's code let the userspace define the target node. Anyway, 
we may need add one rule: not migrate-on-reclaim from PMEM node. 
Demoting from PMEM to DRAM sounds pointless.


