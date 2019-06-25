Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822FFC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB4A20883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfFYWaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:30:20 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47007 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726077AbfFYWaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:30:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TVCU4oo_1561501813;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TVCU4oo_1561501813)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Jun 2019 06:30:16 +0800
Subject: Re: [v3 PATCH 3/4] mm: shrinker: make shrinker not depend on memcg
 kmem
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1560376609-113689-1-git-send-email-yang.shi@linux.alibaba.com>
 <1560376609-113689-4-git-send-email-yang.shi@linux.alibaba.com>
 <20190625151425.6fafced70f42e6db49496ac6@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3d099616-2fc6-fa4e-377c-2f406e3302f9@linux.alibaba.com>
Date:   Tue, 25 Jun 2019 15:30:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190625151425.6fafced70f42e6db49496ac6@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/19 3:14 PM, Andrew Morton wrote:
> On Thu, 13 Jun 2019 05:56:48 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> Currently shrinker is just allocated and can work when memcg kmem is
>> enabled.  But, THP deferred split shrinker is not slab shrinker, it
>> doesn't make too much sense to have such shrinker depend on memcg kmem.
>> It should be able to reclaim THP even though memcg kmem is disabled.
>>
>> Introduce a new shrinker flag, SHRINKER_NONSLAB, for non-slab shrinker.
>> When memcg kmem is disabled, just such shrinkers can be called in
>> shrinking memcg slab.
> This causes a couple of compile errors with an allnoconfig build.
> Please fix that and test any other Kconfig combinations which might
> trip things up.

I just tested !CONFIG_TRANSPARENT_HUGEPAGE, but I didn't test 
!CONFIG_MEMCG. It looks we need keep the code for !CONFIG_MEMCG, will 
post the corrected patches soon.


