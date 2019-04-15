Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1267C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF5120854
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfDOWXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:23:39 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36521 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726093AbfDOWXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:23:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TPPkBEu_1555367013;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPPkBEu_1555367013)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Apr 2019 06:23:36 +0800
Subject: Re: [v2 PATCH 7/9] mm: vmscan: check if the demote target node is
 contended or not
To:     Dave Hansen <dave.hansen@intel.com>, mhocko@suse.com,
        mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <1554955019-29472-8-git-send-email-yang.shi@linux.alibaba.com>
 <6d40d60e-dde4-7d70-c7a8-1a444c70c3ff@intel.com>
 <5082655c-6a24-a3d7-1b7d-bb256597890c@linux.alibaba.com>
 <9bcf765c-c051-9086-b3fe-679adbe239cb@intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <1b317d9a-406f-78c4-c2dd-d4c41eef8cc6@linux.alibaba.com>
Date:   Mon, 15 Apr 2019 15:23:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9bcf765c-c051-9086-b3fe-679adbe239cb@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/19 3:13 PM, Dave Hansen wrote:
> On 4/15/19 3:06 PM, Yang Shi wrote:
>>> This seems like an actively bad idea to me.
>>>
>>> Why do we need an *active* note to say the node is contended?  Why isn't
>>> just getting a failure back from migrate_pages() enough?  Have you
>>> observed this in practice?
>> The flag will be used to check if the target node is contended or not
>> before moving the page into the demotion list. If the target node is
>> contended (i.e. GFP_NOWAIT would likely fail), the page reclaim code
>> even won't scan anonymous page list on swapless system.
> That seems like the actual problem that needs to get fixed.
>
> On systems where we have demotions available, perhaps we need to start
> scanning anonymous pages again, at least for zones where we *can* demote
> from them.

But the problem is if we know the demotion would likely fail, why bother 
scanning anonymous pages again? The flag will be cleared by the target 
node's kswapd once it gets balanced again. Then the anonymous pages 
would get scanned next time.


