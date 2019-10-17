Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C022ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3F3218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391894AbfJQBib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:38:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727399AbfJQBib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:38:31 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C435A5000E3F6047F88E;
        Thu, 17 Oct 2019 09:38:29 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 09:38:27 +0800
Message-ID: <5DA7C612.1090300@huawei.com>
Date:   Thu, 17 Oct 2019 09:38:26 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     John Hubbard <jhubbard@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>, <mhocko@kernel.org>,
        <anshuman.khandual@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Unsigned 'nr_pages' always larger than zero
References: <1567592763-25282-1-git-send-email-zhongjiang@huawei.com> <5505fa16-117e-8890-0f48-38555a61a036@suse.cz> <20190904114820.42d9c4daf445ded3d0da52ab@linux-foundation.org> <73c49a1b-4f42-c21d-ccd8-2b063cdf1293@nvidia.com> <5DA6DDE0.6000804@huawei.com> <20191016174955.300d5fd4968537151d3ad43f@linux-foundation.org>
In-Reply-To: <20191016174955.300d5fd4968537151d3ad43f@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/17 8:49, Andrew Morton wrote:
> On Wed, 16 Oct 2019 17:07:44 +0800 zhong jiang <zhongjiang@huawei.com> wrote:
>
>>>> --- a/mm/gup.c~a
>>>> +++ a/mm/gup.c
>>>> @@ -1450,6 +1450,7 @@ static long check_and_migrate_cma_pages(
>>>>       bool drain_allow = true;
>>>>       bool migrate_allow = true;
>>>>       LIST_HEAD(cma_page_list);
>>>> +    long ret;
>>>>     check_again:
>>>>       for (i = 0; i < nr_pages;) {
>>>> @@ -1511,17 +1512,18 @@ check_again:
>>>>            * again migrating any new CMA pages which we failed to isolate
>>>>            * earlier.
>>>>            */
>>>> -        nr_pages = __get_user_pages_locked(tsk, mm, start, nr_pages,
>>>> +        ret = __get_user_pages_locked(tsk, mm, start, nr_pages,
>>>>                              pages, vmas, NULL,
>>>>                              gup_flags);
>>>>   -        if ((nr_pages > 0) && migrate_allow) {
>>>> +        nr_pages = ret;
>>>> +        if (ret > 0 && migrate_allow) {
>>>>               drain_allow = true;
>>>>               goto check_again;
>>>>           }
>>>>       }
>>>>   -    return nr_pages;
>>>> +    return ret;
>>>>   }
>>>>   #else
>>>>   static long check_and_migrate_cma_pages(struct task_struct *tsk,
>>>>
>>> +1 for this approach, please.
>>>
>>>
>>> thanks,
>> Hi,  Andrew
>>
>> I didn't see the fix for the issue in the upstream. Your proposal should be
>> appiled to upstream. Could you appiled the patch or  repost by me ?
> Forgotten about it ;)  Please send a patch sometime?
>
> .
>
I will  repost the patch as your suggestion.  Thanks,

Sincerely,
zhong jiang

