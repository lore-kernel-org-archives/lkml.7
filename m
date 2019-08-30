Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6BBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0171622CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfH3GgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:36:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58354 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbfH3Gf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:35:59 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 02AEE32FDCC591199C7F;
        Fri, 30 Aug 2019 14:35:56 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 30 Aug 2019
 14:35:46 +0800
Subject: Re: [PATCH] arm64: numa: check the node id before accessing
 node_to_cpumask_map
To:     Michal Hocko <mhocko@kernel.org>
CC:     <will@kernel.org>, <akpm@linux-foundation.org>,
        <rppt@linux.ibm.com>, <anshuman.khandual@arm.com>,
        <adobriyan@gmail.com>, <cai@lca.pw>, <robin.murphy@arm.com>,
        <tglx@linutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <1567131991-189761-1-git-send-email-linyunsheng@huawei.com>
 <20190830055528.GO28313@dhcp22.suse.cz>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <49b86da7-f114-27c2-463a-9bf5082ac197@huawei.com>
Date:   Fri, 30 Aug 2019 14:35:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190830055528.GO28313@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/30 13:55, Michal Hocko wrote:
> On Fri 30-08-19 10:26:31, Yunsheng Lin wrote:
>> Some buggy bios may not set the device' numa id, and dev_to_node
>> will return -1, which may cause global-out-of-bounds error
>> detected by KASAN.
> 
> Why should we workaround a buggy bios like that? Is it so widespread and
> no BIOS update available? Also, why is this arm64 specific?

For our case, there is BIOS update available. I just thought it might
be better to protect from this case when BIOS has not implemented the
device' numa id setting feature or the feature from BIOS has some bug.

It is not arm64 specific, right now I only have arm64 board. If it is
ok to protect this from the buggy BIOS, maybe all other arch can be
changed too.

> 
>> This patch changes cpumask_of_node to return cpu_none_mask if the
>> node is not valid, and sync the cpumask_of_node between the
>> cpumask_of_node function in numa.h and numa.c.
> 
> Why?

When CONFIG_DEBUG_PER_CPU_MAPS is defined, the cpumask_of_node() in
numa.c is used, if not, the cpumask_of_node() in numa.h is used.

I am not sure why there is difference between them, and it is there
when since the below commit:
1a2db300348b ("arm64, numa: Add NUMA support for arm64 platforms.")

I synced them to keep them consistent whether CONFIG_DEBUG_PER_CPU_MAPS
is defined.

> 
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  arch/arm64/include/asm/numa.h | 6 ++++++
>>  arch/arm64/mm/numa.c          | 2 +-
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
>> index 626ad01..da891ed 100644
>> --- a/arch/arm64/include/asm/numa.h
>> +++ b/arch/arm64/include/asm/numa.h
>> @@ -25,6 +25,12 @@ const struct cpumask *cpumask_of_node(int node);
>>  /* Returns a pointer to the cpumask of CPUs on Node 'node'. */
>>  static inline const struct cpumask *cpumask_of_node(int node)
>>  {
>> +	if (node >= nr_node_ids || node < 0)
>> +		return cpu_none_mask;
>> +
>> +	if (!node_to_cpumask_map[node])
>> +		return cpu_online_mask;
>> +
>>  	return node_to_cpumask_map[node];
>>  }
>>  #endif
>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>> index 4f241cc..3846313 100644
>> --- a/arch/arm64/mm/numa.c
>> +++ b/arch/arm64/mm/numa.c
>> @@ -46,7 +46,7 @@ EXPORT_SYMBOL(node_to_cpumask_map);
>>   */
>>  const struct cpumask *cpumask_of_node(int node)
>>  {
>> -	if (WARN_ON(node >= nr_node_ids))
>> +	if (WARN_ON(node >= nr_node_ids || node < 0))
>>  		return cpu_none_mask;
>>  
>>  	if (WARN_ON(node_to_cpumask_map[node] == NULL))
>> -- 
>> 2.8.1
> 

