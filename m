Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A446C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B2820663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfDOW0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:26:46 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:59975 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbfDOW0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:26:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TPPhBLZ_1555367198;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPPhBLZ_1555367198)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Apr 2019 06:26:42 +0800
Subject: Re: [v2 PATCH 5/9] mm: vmscan: demote anon DRAM pages to PMEM node
To:     Dave Hansen <dave.hansen@intel.com>, mhocko@suse.com,
        mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <1554955019-29472-6-git-send-email-yang.shi@linux.alibaba.com>
 <bc4cd9b2-327d-199b-6de4-61561b45c661@intel.com>
 <0f4d092d-1421-7163-d937-f8aa681db594@linux.alibaba.com>
 <42f2a561-f675-14d7-8d4f-87acfe0a18e9@intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <745e396c-d9e0-b222-acd4-2a586832878b@linux.alibaba.com>
Date:   Mon, 15 Apr 2019 15:26:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <42f2a561-f675-14d7-8d4f-87acfe0a18e9@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/19 3:14 PM, Dave Hansen wrote:
> On 4/15/19 3:10 PM, Yang Shi wrote:
>>> Also, I don't see anything in the code tying this to strictly demote
>>> from DRAM to PMEM.  Is that the end effect, or is it really implemented
>>> that way and I missed it?
>> No, not restrict to PMEM. It just tries to demote from "preferred node"
>> (or called compute node) to a memory-only node. In the hardware with
>> PMEM, PMEM would be the memory-only node.
> If that's the case, your patch subject is pretty criminal. :)

Aha, s/PMEM/cpuless would sound guiltless.


