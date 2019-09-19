Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E3CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8DB21A49
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389914AbfISLdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 07:33:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2737 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388015AbfISLdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 07:33:53 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CB98343A971F55E9DBF1;
        Thu, 19 Sep 2019 19:33:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Sep 2019
 19:33:50 +0800
Subject: Re: [PATCH] mm: Support memblock alloc on the exact node for
 sparse_buffer_init()
To:     Wei Yang <richardw.yang@linux.intel.com>
CC:     <rppt@linux.ibm.com>, <akpm@linux-foundation.org>,
        <osalvador@suse.de>, <mhocko@suse.co>, <dan.j.williams@intel.com>,
        <david@redhat.com>, <cai@lca.pw>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <af88d8ab-4088-e857-575f-9be57542e130@huawei.com>
 <20190918065140.GA5446@richard>
 <a0cbf140-7045-81bf-4686-6e742f97ceb8@huawei.com>
 <20190919003047.GA20697@richard>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <b06c114c-450c-8d75-0f45-0bd314e1bf5a@huawei.com>
Date:   Thu, 19 Sep 2019 19:33:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190919003047.GA20697@richard>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/19 8:30, Wei Yang wrote:
> On Wed, Sep 18, 2019 at 03:08:41PM +0800, Yunfeng Ye wrote:
>>
>>
>> On 2019/9/18 14:51, Wei Yang wrote:
>>> On Wed, Sep 18, 2019 at 12:22:29PM +0800, Yunfeng Ye wrote:
>>>> Currently, when memblock_find_in_range_node() fail on the exact node, it
>>>> will use %NUMA_NO_NODE to find memblock from other nodes. At present,
>>>> the work is good, but when the large memory is insufficient and the
>>>> small memory is enough, we want to allocate the small memory of this
>>>> node first, and do not need to allocate large memory from other nodes.
>>>>
>>>> In sparse_buffer_init(), it will prepare large chunks of memory for page
>>>> structure. The page management structure requires a lot of memory, but
>>>> if the node does not have enough memory, it can be converted to a small
>>>> memory allocation without having to allocate it from other nodes.
>>>>
>>>> Add %MEMBLOCK_ALLOC_EXACT_NODE flag for this situation. Normally, the
>>>> behavior is the same with %MEMBLOCK_ALLOC_ACCESSIBLE, only that it will
>>>> not allocate from other nodes when a single node fails to allocate.
>>>>
>>>> If large contiguous block memory allocated fail in sparse_buffer_init(),
>>>> it will allocates small block memmory section by section later.
>>>>
>>>
>>> Looks this changes current behavior even it fall back to section based
>>> allocation.
>>>
>> When fall back to section allocation, it still use %MEMBLOCK_ALLOC_ACCESSIBLE
>> ,I think the behavior is not change, Can you tell me the detail about the
>> changes. thanks.
>>
> 
> You pass MEMBLOCK_ALLOC_EXACT_NODE for the first round allocation, which
> forbid it allocates from other node. This is different from current behavior.
> Am I right?
> 
Most cases, it will not go to the %MEMBLOCK_ALLOC_EXACT_NODE allocate routine.
so the behavior will not change.
If current node have no large contiguous block memory, it will fall back to
allocate memory based section. this is the different from current behavior.

thanks.
> .
> 

