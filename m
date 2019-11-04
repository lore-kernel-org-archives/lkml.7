Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D694CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A49B2190F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfKDGDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 01:03:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbfKDGDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:03:00 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1E3CFAD45C0D4A48A932;
        Mon,  4 Nov 2019 14:02:57 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Nov 2019
 14:02:47 +0800
Subject: Re: [PATCH] lib: optimize cpumask_local_spread()
To:     Andrew Morton <akpm@linux-foundation.org>
References: <1572501813-2125-1-git-send-email-zhangshaokun@hisilicon.com>
 <20191031173721.e2a40b037799a149433a4867@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, yuqi jin <jinyuqi@huawei.com>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        "Michal Hocko" <mhocko@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <cc3640e1-0e29-f196-97e4-ebf0bc8be78b@hisilicon.com>
Date:   Mon, 4 Nov 2019 14:02:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20191031173721.e2a40b037799a149433a4867@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 2019/11/1 8:37, Andrew Morton wrote:
> On Thu, 31 Oct 2019 14:03:33 +0800 Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> 
>> From: yuqi jin <jinyuqi@huawei.com>
>>
>> In the multi-processor and NUMA system, A device may have many numa
>> nodes belonging to multiple cpus. When we get a local numa, it is better
>> to find the node closest to the local numa node to return instead of
>> going to the online cpu immediately.
>>
>> For example, In Huawei Kunpeng 920 system, there are 4 NUMA node(0 -3)
>> in the 2-socket system(0 - 1). If the I/O device is in socket1
>> and the local NUMA node is 2, we shall choose the non-local node3 in
>> the same socket when cpu core in NUMA node2 is less that I/O requirements.
>> If we directly pick one cpu core from all online ones, it may be in
>> the another socket and it is not friendly for performance.
>>
>> ...
>>
>> Changes from RFC:
>>      Address Michal Hocko's comment: Use GFP_ATOMIC instead of GFP_KERNEL
> 
> Are you sure this is necessary?  cpumask_local_spread() is typically
> called when a device driver is initializing irq affinities, and
> sleeping allocations are usually OK at driver initialization time.  If

Got it and my limited realization, thanks for more explanations about it.

> there is some driver which is calling cpumask_local_spread() from
> atomic context, I bet it's pretty easy to fix.
> 
>> --- a/lib/cpumask.c
>> +++ b/lib/cpumask.c
>> @@ -192,6 +192,33 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
>>  }
>>  #endif
>>  
>> +static void calc_node_distance(int *node_dist, int node)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < nr_node_ids; i++)
>> +		node_dist[i] = node_distance(node, i);
>> +}
>> +
>> +static int find_nearest_node(int *node_dist, bool *used_flag)
> 
> The name "used_flag" is rather redundant for a thing of type bool - we
> know it's a flag!  "used" would suffice.
> 

Ok

>> +{
>> +	int i, min_dist = node_dist[0], node_id = -1;
>> +
>> +	for (i = 0; i < nr_node_ids; i++)
>> +		if (used_flag[i] == 0) {
>> +			min_dist = node_dist[i];
>> +			node_id = i;
>> +			break;
>> +		}
>> +	for (i = 0; i < nr_node_ids; i++)
>> +		if (node_dist[i] < min_dist && used_flag[i] == 0) {
>> +			min_dist = node_dist[i];
>> +			node_id = i;
>> +		}
>> +
>> +	return node_id;
>> +}
>> +
>>  /**
>>   * cpumask_local_spread - select the i'th cpu with local numa cpu's first
>>   * @i: index number
>> @@ -205,7 +232,8 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
>>   */
>>  unsigned int cpumask_local_spread(unsigned int i, int node)
> 
> Yes, this has become quite an expensive function.  That seems harmless
> given the typical callsites.
> 
>>  {
>> -	int cpu;
>> +	int cpu, j, id, *node_dist;
>> +	bool *used_flag;
>>  
>>  	/* Wrap: we always want a cpu. */
>>  	i %= num_online_cpus();
>> @@ -215,19 +243,45 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
>>  			if (i-- == 0)
>>  				return cpu;
>>  	} else {
>> -		/* NUMA first. */
>> -		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
>> -			if (i-- == 0)
>> -				return cpu;
>> +		node_dist = kmalloc_array(nr_node_ids, sizeof(int), GFP_ATOMIC);
>> +		if (!node_dist)
>> +			for_each_cpu(cpu, cpu_online_mask)
>> +				if (i-- == 0)
>> +					return cpu;
>>  
>> -		for_each_cpu(cpu, cpu_online_mask) {
>> -			/* Skip NUMA nodes, done above. */
>> -			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
>> -				continue;
>> +		used_flag = kmalloc_array(nr_node_ids, sizeof(bool), GFP_ATOMIC);
> 
> This could actually be an array of bits (include/linux/bitmap.h), but
> it hardly seems important.
> 

Ok,

> In fact with CONFIG_NODES_SHIFT <= 10, such a bitmap would have max
> size of 128 bytes and could be a local.  But again, this is unimportant
> as long as the other kmalloc is in there.
> 

Got it and I will follow it in next version.

Thanks,
Shaokun

> 
>> +		if (!used_flag)
>> +			for_each_cpu(cpu, cpu_online_mask)
>> +				if (i-- == 0) {
>> +					kfree(node_dist);
>> +					return cpu;
>> +				}
>> +		memset(used_flag, 0, nr_node_ids * sizeof(bool));
>>  
>> -			if (i-- == 0)
>> -				return cpu;
>> +		calc_node_distance(node_dist, node);
>> +		for (j = 0; j < nr_node_ids; j++) {
>> +			id = find_nearest_node(node_dist, used_flag);
>> +			if (id < 0)
>> +				break;
>> +			for_each_cpu_and(cpu,
>> +				cpumask_of_node(id), cpu_online_mask)
>> +				if (i-- == 0) {
>> +					kfree(node_dist);
>> +					kfree(used_flag);
>> +					return cpu;
>> +				}
>> +			used_flag[id] = 1;
>>  		}
>> +
>> +		for_each_cpu(cpu, cpu_online_mask)
>> +			if (i-- == 0) {
>> +				kfree(node_dist);
>> +				kfree(used_flag);
>> +				return cpu;
>> +			}
>> +
>> +		kfree(node_dist);
>> +		kfree(used_flag);
>>  	}
>>  	BUG();
>>  }
> 
> 
> .
> 

