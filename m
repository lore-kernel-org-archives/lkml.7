Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11D1C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 02:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5045222C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 02:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfKFCtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 21:49:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730426AbfKFCtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 21:49:31 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E49AE89323F883981E04;
        Wed,  6 Nov 2019 10:49:29 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 6 Nov 2019
 10:49:19 +0800
Subject: Re: [PATCH v2] lib: optimize cpumask_local_spread()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
References: <1572863268-28585-1-git-send-email-zhangshaokun@hisilicon.com>
 <20191105070141.GF22672@dhcp22.suse.cz>
 <20191105173359.39052327cf221d9c4b26b783@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, yuqi jin <jinyuqi@huawei.com>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <f1f92a35-f7a4-8710-9a1a-21561e76f5ff@hisilicon.com>
Date:   Wed, 6 Nov 2019 10:49:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20191105173359.39052327cf221d9c4b26b783@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 2019/11/6 9:33, Andrew Morton wrote:
> On Tue, 5 Nov 2019 08:01:41 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
>> On Mon 04-11-19 18:27:48, Shaokun Zhang wrote:
>>> From: yuqi jin <jinyuqi@huawei.com>
>>>
>>> In the multi-processor and NUMA system, I/O device may have many numa
>>> nodes belonging to multiple cpus. When we get a local numa, it is
>>> better to find the node closest to the local numa node, instead
>>> of choosing any online cpu immediately.
>>>
>>> For the current code, it only considers the local NUMA node and it
>>> doesn't compute the distances between different NUMA nodes for the
>>> non-local NUMA nodes. Let's optimize it and find the nearest node
>>> through NUMA distance. The performance will be better if it return
>>> the nearest node than the random node.
>>
>> Numbers please
> 
> The changelog had
> 
> : When Parameter Server workload is tested using NIC device on Huawei
> : Kunpeng 920 SoC:
> : Without the patch, the performance is 22W QPS;
> : Added this patch, the performance become better and it is 26W QPS.
> 
>> [...]
>>> +/**
>>> + * cpumask_local_spread - select the i'th cpu with local numa cpu's first
>>> + * @i: index number
>>> + * @node: local numa_node
>>> + *
>>> + * This function selects an online CPU according to a numa aware policy;
>>> + * local cpus are returned first, followed by the nearest non-local ones,
>>> + * then it wraps around.
>>> + *
>>> + * It's not very efficient, but useful for setup.
>>> + */
>>> +unsigned int cpumask_local_spread(unsigned int i, int node)
>>> +{
>>> +	int node_dist[MAX_NUMNODES] = {0};
>>> +	bool used[MAX_NUMNODES] = {0};
>>
>> Ugh. This might be a lot of stack space. Some distro kernels use large
>> NODE_SHIFT (e.g 10 so this would be 4kB of stack space just for the
>> node_dist).
> 
> Yes, that's big.  From a quick peek I suspect we could get by using an
> array of unsigned shorts here but that might be fragile over time even
> if it works now?
> 

Yes, how about we define another macro and its value is 128(not sure it
is big enough for the actual need)?

--->8
 unsigned int cpumask_local_spread(unsigned int i, int node)
 {
-       int node_dist[MAX_NUMNODES] = {0};
-       bool used[MAX_NUMNODES] = {0};
+       #define NUMA_NODE_NR     128
+       int node_dist[NUMA_NODE_NR] = {0};
+       bool used[NUMA_NODE_NR] = {0};
        int cpu, j, id;

        /* Wrap: we always want a cpu. */
@@ -278,7 +279,7 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
                        if (i-- == 0)
                                return cpu;
        } else {
-               if (nr_node_ids > MAX_NUMNODES)
+               if (nr_node_ids > NUMA_NODE_NR)
                        return __cpumask_local_spread(i, node);

                calc_node_distance(node_dist, node);

> Perhaps we could make it a statically allocated array and protect the
> entire thing with a spin_lock_irqsave()?  It's not a frequently called

It's another way to solve this issue. I'm not sure you and Michal like which one. ;-)

Thanks,
Shaokun

> function.
> 
> 
> .
> 

