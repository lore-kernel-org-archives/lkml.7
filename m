Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D433C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC13520717
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfE0N6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:58:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbfE0N6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:58:24 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A18F1DA764C56511616F;
        Mon, 27 May 2019 21:58:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 27 May 2019
 21:58:18 +0800
Message-ID: <5CEBECF9.2060500@huawei.com>
Date:   Mon, 27 May 2019 21:58:17 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>, <osalvador@suse.de>,
        <khandual@linux.vnet.ibm.com>, <mhocko@suse.com>,
        <mgorman@techsingularity.net>, <aarcange@redhat.com>,
        <rcampbell@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/mempolicy: Fix an incorrect rebind node in mpol_rebind_nodemask
References: <1558768043-23184-1-git-send-email-zhongjiang@huawei.com> <20190525112851.ee196bcbbc33bf9e0d869236@linux-foundation.org> <2ff829ea-1d74-9d4b-8501-e9c2ebdc36ef@suse.cz>
In-Reply-To: <2ff829ea-1d74-9d4b-8501-e9c2ebdc36ef@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/27 20:23, Vlastimil Babka wrote:
> On 5/25/19 8:28 PM, Andrew Morton wrote:
>> (Cc Vlastimil)
> Oh dear, 2 years and I forgot all the details about how this works.
>
>> On Sat, 25 May 2019 15:07:23 +0800 zhong jiang <zhongjiang@huawei.com> wrote:
>>
>>> We bind an different node to different vma, Unluckily,
>>> it will bind different vma to same node by checking the /proc/pid/numa_maps.   
>>> Commit 213980c0f23b ("mm, mempolicy: simplify rebinding mempolicies when updating cpusets")
>>> has introduced the issue.  when we change memory policy by seting cpuset.mems,
>>> A process will rebind the specified policy more than one times. 
>>> if the cpuset_mems_allowed is not equal to user specified nodes. hence the issue will trigger.
>>> Maybe result in the out of memory which allocating memory from same node.
> I have a hard time understanding what the problem is. Could you please
> write it as a (pseudo) reproducer? I.e. an example of the process/admin
> mempolicy/cpuset actions that have some wrong observed results vs the
> correct expected result.
Sorry, I havn't an testcase to reproduce the issue. At first, It was disappeared by
my colleague to configure the xml to start an vm.  To his suprise, The bind mempolicy
doesn't work.

Thanks,
zhong jiang
>>> --- a/mm/mempolicy.c
>>> +++ b/mm/mempolicy.c
>>> @@ -345,7 +345,7 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
>>>  	else {
>>>  		nodes_remap(tmp, pol->v.nodes,pol->w.cpuset_mems_allowed,
>>>  								*nodes);
>>> -		pol->w.cpuset_mems_allowed = tmp;
>>> +		pol->w.cpuset_mems_allowed = *nodes;
> Looks like a mechanical error on my side when removing the code for
> step1+step2 rebinding. Before my commit there was
>
> pol->w.cpuset_mems_allowed = step ? tmp : *nodes;
>
> Since 'step' was removed and thus 0, I should have used *nodes indeed.
> Thanks for catching that.
>
>>>  	}
>>>  
>>>  	if (nodes_empty(tmp))
>> hm, I'm not surprised the code broke.  What the heck is going on in
>> there?  It used to have a perfunctory comment, but Vlastimil deleted
>> it.
> Yeah the comment was specific for the case that was being removed.
>
>> Could someone please propose a comment for the above code block
>> explaining why we're doing what we do?
> I'll have to relearn this first...
>
>


