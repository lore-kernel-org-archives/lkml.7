Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4EDC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3A520828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfF1RiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:38:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:59548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbfF1RiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:38:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A22D9ADEA;
        Fri, 28 Jun 2019 17:38:14 +0000 (UTC)
Subject: Re: [PATCH] mm: fix regression with deferred struct page init
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20190620160821.4210-1-jgross@suse.com>
 <20190628151749.GA2880@dhcp22.suse.cz>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <52a8e6d9-003e-c802-b8ff-327a8c7913a5@suse.com>
Date:   Fri, 28 Jun 2019 19:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628151749.GA2880@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.19 17:17, Michal Hocko wrote:
> On Thu 20-06-19 18:08:21, Juergen Gross wrote:
>> Commit 0e56acae4b4dd4a9 ("mm: initialize MAX_ORDER_NR_PAGES at a time
>> instead of doing larger sections") is causing a regression on some
>> systems when the kernel is booted as Xen dom0.
>>
>> The system will just hang in early boot.
>>
>> Reason is an endless loop in get_page_from_freelist() in case the first
>> zone looked at has no free memory. deferred_grow_zone() is always
> 
> Could you explain how we ended up with the zone having no memory? Is
> xen "stealing" memblock memory without adding it to memory.reserved?
> In other words, how do we end up with an empty zone that has non zero
> end_pfn?

Why do you think Xen is stealing the memory in an odd way?

Doesn't deferred_init_mem_pfn_range_in_zone() return false when no free
memory is found? So exactly if the memory was added to memory.reserved
that will happen.

I guess the difference to a bare metal boot is that a Xen dom0 will need
probably more memory in early boot phase, so that issue is more likely
to occur.

In my case the system had two zones, where the 2nd zone had some free
memory. The search never made it to the 2nd zone as the search ended in
an endless loop for the 1st zone.

> 
>> returning true due to the following code snipplet:
>>
>>    /* If the zone is empty somebody else may have cleared out the zone */
>>    if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
>>                                             first_deferred_pfn)) {
>>            pgdat->first_deferred_pfn = ULONG_MAX;
>>            pgdat_resize_unlock(pgdat, &flags);
>>            return true;
>>    }
>>
>> This in turn results in the loop as get_page_from_freelist() is
>> assuming forward progress can be made by doing some more struct page
>> initialization.
> 
> The patch looks correct. The code is subtle but the comment helps.
> 
>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Fixes: 0e56acae4b4dd4a9 ("mm: initialize MAX_ORDER_NR_PAGES at a time instead of doing larger sections")
>> Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks,

Juergen
