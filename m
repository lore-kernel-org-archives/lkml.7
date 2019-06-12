Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C49C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A562086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbfFLFIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 01:08:01 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44002 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbfFLFIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 01:08:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TTyCGal_1560316075;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TTyCGal_1560316075)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Jun 2019 13:07:58 +0800
Subject: Re: [PATCH 4/4] mm: shrinker: make shrinker not depend on memcg kmem
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1559887659-23121-1-git-send-email-yang.shi@linux.alibaba.com>
 <1559887659-23121-5-git-send-email-yang.shi@linux.alibaba.com>
 <20190612025257.7fv55qmx6p45hz7o@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a8f6f119-fd72-9a93-de99-fc7bea6404c0@linux.alibaba.com>
Date:   Tue, 11 Jun 2019 22:07:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190612025257.7fv55qmx6p45hz7o@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/19 7:52 PM, Kirill A. Shutemov wrote:
> On Fri, Jun 07, 2019 at 02:07:39PM +0800, Yang Shi wrote:
>> Currently shrinker is just allocated and can work when memcg kmem is
>> enabled.  But, THP deferred split shrinker is not slab shrinker, it
>> doesn't make too much sense to have such shrinker depend on memcg kmem.
>> It should be able to reclaim THP even though memcg kmem is disabled.
>>
>> Introduce a new shrinker flag, SHRINKER_NONSLAB, for non-slab shrinker,
>> i.e. THP deferred split shrinker.  When memcg kmem is disabled, just
>> such shrinkers can be called in shrinking memcg slab.
> Looks like it breaks bisectability. It has to be done before makeing
> shrinker memcg-aware, hasn't it?

No, it doesn't break bisectability. But, THP shrinker just can be called 
with kmem charge enabled without this patch.

>

