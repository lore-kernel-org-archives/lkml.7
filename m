Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F567CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518DF2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfJUHWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:22:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36538 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfJUHWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:22:20 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 38ACE34F3F7D61CA77E1;
        Mon, 21 Oct 2019 15:22:17 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 15:22:08 +0800
Subject: Re: [RFC] lib: optimize cpumask_local_spread()
To:     Michal Hocko <mhocko@kernel.org>
References: <1571307788-43169-1-git-send-email-zhangshaokun@hisilicon.com>
 <20191017123734.GJ24485@dhcp22.suse.cz>
CC:     <linux-kernel@vger.kernel.org>, yuqi jin <jinyuqi@huawei.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Paul Burton" <paul.burton@mips.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <f45ce213-f2a3-80ee-713a-700e4636ec12@hisilicon.com>
Date:   Mon, 21 Oct 2019 15:22:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20191017123734.GJ24485@dhcp22.suse.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 2019/10/17 20:37, Michal Hocko wrote:
> On Thu 17-10-19 18:23:08, Shaokun Zhang wrote:
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
> 
> Could you be more specific on the effect of this patch please? Do you
> have any performance numbers?

The NIC driver calls this function to determine the core which irq will be binded to,
and the initialization of XPS depends on the binding of irqs. The NIC driver will get
the local NUMA node where it is located.

On Huawei Kunpeng 920 SoC, there are 4-NUMA nodes and there is 24-cores per node.
If the function paratmer @i = 0-23 and @node = 2, then the core which is located on
node 2 and irq will be binded to node2.
If the parameter @i = 24-47 and @node = 2, without this patch, it will return the
core which is on NUMA node0; Applied the patch, it will return NUMA node3 cpu cores
which are in the same sokcet.

without the patch, the performance is 22W QPS and added this patch, the performance
become better and it is 26W QPS.

I'm not sure whether anyone also hits this problem and send it as a RFC.

> Also is it safe and reasonable to perform GFP_KERNEL (aka sleepable)
> allocations from this function?
> 

Good catch, I missed it and it should be GFP_ATOMIC.

Thanks,
Shaokun.

>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>> Cc: Paul Burton <paul.burton@mips.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: yuqi jin <jinyuqi@huawei.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>  lib/cpumask.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 67 insertions(+), 11 deletions(-)
>>
>> diff --git a/lib/cpumask.c b/lib/cpumask.c
>> index 0cb672eb107c..8f89c7cebfb0 100644
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
>>  {
>> -	int cpu;
>> +	int cpu, j, id, *node_dist;
>> +	bool *used_flag;
>>  
>>  	/* Wrap: we always want a cpu. */
>>  	i %= num_online_cpus();
>> @@ -215,19 +243,47 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
>>  			if (i-- == 0)
>>  				return cpu;
>>  	} else {
>> -		/* NUMA first. */
>> -		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
>> -			if (i-- == 0)
>> -				return cpu;
>> +		node_dist = kmalloc_array(nr_node_ids,
>> +			sizeof(int), GFP_KERNEL);
>> +		if (!node_dist)
>> +			for_each_cpu(cpu, cpu_online_mask)
>> +				if (i-- == 0)
>> +					return cpu;
>>  
>> -		for_each_cpu(cpu, cpu_online_mask) {
>> -			/* Skip NUMA nodes, done above. */
>> -			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
>> -				continue;
>> +		used_flag = kmalloc_array(nr_node_ids,
>> +			sizeof(bool), GFP_KERNEL);
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
>> -- 
>> 2.7.4
> 

