Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DADBC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3DB21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKKOXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:23:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41012 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfKKOXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:23:35 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 15A924AF6F555173F9E9;
        Mon, 11 Nov 2019 22:23:24 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.212) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
 22:23:16 +0800
Subject: Re: [RFC PATCH v2] arm64: cpufeatures: add support for tlbi range
 instructions
To:     Marc Zyngier <maz@kernel.org>
References: <5DC960EB.9050503@huawei.com>
 <20191111132716.GA9394@willie-the-truck> <5DC96660.8040505@huawei.com>
 <d4542758f83b3df3ab391341499fecfb@www.loen.fr>
CC:     Will Deacon <will@kernel.org>, <catalin.marinas@arm.com>,
        <suzuki.poulose@arm.com>, <mark.rutland@arm.com>,
        <tangnianyao@huawei.com>, <xiexiangyou@huawei.com>,
        <linux-kernel@vger.kernel.org>, <arm@kernel.org>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <5DC96ED3.90205@huawei.com>
Date:   Mon, 11 Nov 2019 22:23:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <d4542758f83b3df3ab391341499fecfb@www.loen.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.223.212]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/11 22:04, Marc Zyngier wrote:
> On 2019-11-11 14:56, Zhenyu Ye wrote:
>> On 2019/11/11 21:27, Will Deacon wrote:
>>> On Mon, Nov 11, 2019 at 09:23:55PM +0800, Zhenyu Ye wrote:
>>>> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
>>>> range of input addresses. This patch adds support for this feature.
>>>> This is the second version of the patch.
>>>>
>>>> I traced the __flush_tlb_range() for a minute and get some statistical
>>>> data as below:
>>>>
>>>>     PAGENUM        COUNT
>>>>     1        34944
>>>>     2        5683
>>>>     3        1343
>>>>     4        7857
>>>>     5        838
>>>>     9        339
>>>>     16        933
>>>>     19        427
>>>>     20        5821
>>>>     23        279
>>>>     41        338
>>>>     141        279
>>>>     512        428
>>>>     1668        120
>>>>     2038        100
>>>>
>>>> Those data are based on kernel-5.4.0, where PAGENUM = end - start, COUNT
>>>> shows number of calls to the __flush_tlb_range() in a minute. There only
>>>> shows the data which COUNT >= 100. The kernel is started normally, and
>>>> transparent hugepage is opened. As we can see, though most user TLBI
>>>> ranges were 1 pages long, the num of long-range can not be ignored.
>>>>
>>>> The new feature of TLB range can improve lots of performance compared to
>>>> the current implementation. As an example, flush 512 ranges needs only 1
>>>> instruction as opposed to 512 instructions using current implementation.
>>>>
>>>> And for a new hardware feature, support is better than not.
>>>>
>>>> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
>>>> ---
>>>> ChangeLog v1 -> v2:
>>>> - Change the main implementation of this feature.
>>>> - Add some comments.
>>>
>>> How does this address my concerns here:
>>>
>>>
>>> https://lore.kernel.org/linux-arm-kernel/20191031131649.GB27196@willie-the-truck/
>>>
>>> ?
>>>
>>> Will
>>>
>>> .
>>>
>>
>> I think your concern is more about the hardware level, and we can do
>> nothing about
>> this at all. The interconnect/DVM implementation is not exposed to
>> software layer
>> (and no need), and may should be constrained at hardware level.
> 
> You're missing the point here: the instruction may be implemented
> and perfectly working at the CPU level, and yet not carried over
> the interconnect. In this situation, other CPUs may not observe
> the DVM messages instructing them of such invalidation, and you'll end
> up with memory corruption.
> 
> So, in the absence of an architectural guarantee that range invalidation
> is supported and observed by all the DVM agents in the system, there must
> be a firmware description for it on which the kernel can rely.
> 
>         M.

OK, sounds like an architectural defect. Some hardware-level improvements
may should be done here, which is unfamiliar to me.

However, We can discuss other aspects of the patch. Anyway, this should be
support by the kernel in the future, isn't it?


