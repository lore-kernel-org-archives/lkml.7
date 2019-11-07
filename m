Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEDDFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648132178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbfKGBsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 20:48:46 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbfKGBsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:48:46 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A3709C05CAE2898FE0E5;
        Thu,  7 Nov 2019 09:48:40 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 7 Nov 2019
 09:48:30 +0800
Subject: Re: [PATCH v2] lib: optimize cpumask_local_spread()
To:     Michal Hocko <mhocko@kernel.org>
References: <1572863268-28585-1-git-send-email-zhangshaokun@hisilicon.com>
 <20191105070141.GF22672@dhcp22.suse.cz>
 <20191105173359.39052327cf221d9c4b26b783@linux-foundation.org>
 <20191106071742.GB8314@dhcp22.suse.cz>
 <f8f1bce1-4503-4da0-71ea-6fd12fcd687a@hisilicon.com>
 <20191106092208.GE8314@dhcp22.suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, yuqi jin <jinyuqi@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Paul Burton" <paul.burton@mips.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <13134714-09f6-cbd3-ad29-aaf56476ad21@hisilicon.com>
Date:   Thu, 7 Nov 2019 09:48:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20191106092208.GE8314@dhcp22.suse.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 2019/11/6 17:22, Michal Hocko wrote:
> On Wed 06-11-19 16:02:29, Shaokun Zhang wrote:
>> Hi Michal,
>>
>> On 2019/11/6 15:17, Michal Hocko wrote:
>>> On Tue 05-11-19 17:33:59, Andrew Morton wrote:
>>>> On Tue, 5 Nov 2019 08:01:41 +0100 Michal Hocko <mhocko@kernel.org> wrote:
>>>>
>>>>> On Mon 04-11-19 18:27:48, Shaokun Zhang wrote:
>>>>>> From: yuqi jin <jinyuqi@huawei.com>
>>>>>>
>>>>>> In the multi-processor and NUMA system, I/O device may have many numa
>>>>>> nodes belonging to multiple cpus. When we get a local numa, it is
>>>>>> better to find the node closest to the local numa node, instead
>>>>>> of choosing any online cpu immediately.
>>>>>>
>>>>>> For the current code, it only considers the local NUMA node and it
>>>>>> doesn't compute the distances between different NUMA nodes for the
>>>>>> non-local NUMA nodes. Let's optimize it and find the nearest node
>>>>>> through NUMA distance. The performance will be better if it return
>>>>>> the nearest node than the random node.
>>>>>
>>>>> Numbers please
>>>>
>>>> The changelog had
>>>>
>>>> : When Parameter Server workload is tested using NIC device on Huawei
>>>> : Kunpeng 920 SoC:
>>>> : Without the patch, the performance is 22W QPS;
>>>> : Added this patch, the performance become better and it is 26W QPS.
>>>
>>> Maybe it is just me but this doesn't really tell me a lot. What is
>>> Parameter Server workload? What do I do to replicate those numbers? Is
>>
>> I will give it better description on it in next version. Since it returns
>> the nearest node from the non-local node than the random one, no harmless
>> to others, Right?
> 
> Well, I am not really familiar with consumers of this API to understand
> the full consequences and that is why I keep asking. From a very

Good job, thanks you and Andrew's nice comment, at the beginning, I'm not sure
how to fix this issue correctly and it become better now.

> highlevel POV prefering CPUs on the same NUMA domain sounds like a
> reasonable thing to do.

Thanks :-)

> 

