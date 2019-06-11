Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A8FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CE82086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405990AbfFKRRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:17:54 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:39217 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405263AbfFKRRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:17:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TTwfifQ_1560273465;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TTwfifQ_1560273465)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Jun 2019 01:17:49 +0800
Subject: Re: [v7 PATCH 1/2] mm: vmscan: remove double slab pressure by inc'ing
 sc->nr_scanned
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     Oscar Salvador <osalvador@suse.de>, ying.huang@intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, josef@toxicpanda.com,
        hughd@google.com, shakeelb@google.com, hdanton@sina.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1559025859-72759-1-git-send-email-yang.shi@linux.alibaba.com>
 <1560202615.3312.6.camel@suse.de>
 <d99fbe8f-9c80-d407-e848-0be00e3b8886@linux.alibaba.com>
Message-ID: <52ec93c6-a41b-e5aa-54f0-f508a5e30a09@linux.alibaba.com>
Date:   Tue, 11 Jun 2019 10:17:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d99fbe8f-9c80-d407-e848-0be00e3b8886@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/19 10:12 AM, Yang Shi wrote:
>
>
> On 6/10/19 2:36 PM, Oscar Salvador wrote:
>> On Tue, 2019-05-28 at 14:44 +0800, Yang Shi wrote:
>>> The commit 9092c71bb724 ("mm: use sc->priority for slab shrink
>>> targets")
>>> has broken up the relationship between sc->nr_scanned and slab
>>> pressure.
>>> The sc->nr_scanned can't double slab pressure anymore.  So, it sounds
>>> no
>>> sense to still keep sc->nr_scanned inc'ed.  Actually, it would
>>> prevent
>>> from adding pressure on slab shrink since excessive sc->nr_scanned
>>> would
>>> prevent from scan->priority raise.
>> Hi Yang,
>>
>> I might be misunderstanding this, but did you mean "prevent from scan-
>> priority decreasing"?
>> I guess we are talking about balance_pgdat(), and in case
>> kswapd_shrink_node() returns true (it means we have scanned more than
>> we had to reclaim), raise_priority becomes false, and this does not let
>> sc->priority to be decreased, which has the impact that less pages will
>>   be reclaimed the next round.
>
> Yes, exactly.

BTW, for the scan priority, the smaller number the higher priority. So, 
either "raise" or "decrease" sounds correct. "raise" means the real 
priority, "decrease" means the number itself.

>
>>
>> Sorry for bugging here, I just wanted to see if I got this right.
>>
>>
>

