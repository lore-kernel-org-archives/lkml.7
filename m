Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E973C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D24620868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfDPUvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:51:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:52816 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbfDPUvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:51:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 13:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,359,1549958400"; 
   d="scan'208";a="151438904"
Received: from xshen14-mobl.ccr.corp.intel.com (HELO [10.254.213.238]) ([10.254.213.238])
  by orsmga002.jf.intel.com with ESMTP; 16 Apr 2019 13:51:19 -0700
Subject: Re: [PATCH 2/2] x86/resctrl: Initialize new resource group with
 default MBA values
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
References: <1554839728-5544-1-git-send-email-xiaochen.shen@intel.com>
 <20190415113405.GC29317@zn.tnic>
From:   Xiaochen Shen <xiaochen.shen@intel.com>
Message-ID: <9e99ed5f-d60a-717c-9322-c6f0b8090d6b@intel.com>
Date:   Wed, 17 Apr 2019 04:51:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190415113405.GC29317@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Thank you very much for code review.
I will fix these issues in v2 patch.

Please find more comments inline.
Thank you.

On 4/15/2019 19:34, Borislav Petkov wrote:
> On Wed, Apr 10, 2019 at 03:55:28AM +0800, Xiaochen Shen wrote:
>> Currently when a new resource group is created, the allocation values
>> of MBA resource are not initialized and remain meaningless data.
>>
>> For example:
>> mkdir /sys/fs/resctrl/p1
>> cat /sys/fs/resctrl/p1/schemata
>> MB:0=100;1=100
>>
>> echo "MB:0=10;1=20" > /sys/fs/resctrl/p1/schemata
>> cat /sys/fs/resctrl/p1/schemata
>> MB:0= 10;1= 20
>>
>> rmdir /sys/fs/resctrl/p1
>> mkdir /sys/fs/resctrl/p2
>> cat /sys/fs/resctrl/p2/schemata
>> MB:0= 10;1= 20
>>
>> When the new group is created, it is reasonable to initialize MBA
>> resource with default values.
>>
>> Initialize MBA resource and cache resources in separate functions.
> 
> Please format your commit message by indenting the examples:

OK. Thank you.

> 
> x86/resctrl: Initialize a new resource group with default MBA values
> 
> Currently, when a new resource group is created, the allocation values
> of the MBA resource are not initialized and remain meaningless data.
> 
> For example:
> 
>    mkdir /sys/fs/resctrl/p1
>    cat /sys/fs/resctrl/p1/schemata
>    MB:0=100;1=100
> 
>    echo "MB:0=10;1=20" > /sys/fs/resctrl/p1/schemata
>    cat /sys/fs/resctrl/p1/schemata
>    MB:0= 10;1= 20
> 
>    rmdir /sys/fs/resctrl/p1
>    mkdir /sys/fs/resctrl/p2
>    cat /sys/fs/resctrl/p2/schemata
>    MB:0= 10;1= 20
> 
> Therefore, when the new group is created, it is reasonable to initialize
> MBA resource with default values.
> 
> Initialize the MBA resource and cache resources in separate functions."
> 
> Thx.
> 
>>
>> Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
>> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   4 +-
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 139 ++++++++++++++++--------------
>>   2 files changed, 75 insertions(+), 68 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 2dbd990..576bb6a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -342,10 +342,10 @@ int update_domains(struct rdt_resource *r, int closid)
>>   	if (cpumask_empty(cpu_mask) || mba_sc)
>>   		goto done;
>>   	cpu = get_cpu();
>> -	/* Update CBM on this cpu if it's in cpu_mask. */
>> +	/* Update resource control msr on this cpu if it's in cpu_mask. */
> 
> s/cpu/CPU/g
> 

OK.

>>   	if (cpumask_test_cpu(cpu, cpu_mask))
>>   		rdt_ctrl_update(&msr_param);
>> -	/* Update CBM on other cpus. */
>> +	/* Update resource control msr on other cpus. */
> 
> Ditto.

OK.

> 
>>   	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
>>   	put_cpu();
>>   
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 08e0333..9f12a02 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2516,8 +2516,8 @@ static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
>>   	bitmap_clear(val, zero_bit, cbm_len - zero_bit);
>>   }
>>   
>> -/**
>> - * rdtgroup_init_alloc - Initialize the new RDT group's allocations
>> +/*
>> + * Initialize cache resources with default values.
>>    *
>>    * A new RDT group is being created on an allocation capable (CAT)
>>    * supporting system. Set this group up to start off with all usable
>> @@ -2526,85 +2526,92 @@ static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
>>    * All-zero CBM is invalid. If there are no more shareable bits available
>>    * on any domain then the entire allocation will fail.
>>    */
>> -static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>> +static int rdtgroup_init_cat(struct rdt_resource *r, u32 closid)
>>   {
>>   	struct rdt_resource *r_cdp = NULL;
>>   	struct rdt_domain *d_cdp = NULL;
>>   	u32 used_b = 0, unused_b = 0;
>> -	u32 closid = rdtgrp->closid;
>> -	struct rdt_resource *r;
>>   	unsigned long tmp_cbm;
>>   	enum rdtgrp_mode mode;
>>   	struct rdt_domain *d;
>>   	u32 peer_ctl, *ctrl;
>> -	int i, ret;
>> +	int i;
>>   
>> -	for_each_alloc_enabled_rdt_resource(r) {
>> +	list_for_each_entry(d, &r->domains, list) {
>> +		rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
>> +		d->have_new_ctrl = false;
>> +		d->new_ctrl = r->cache.shareable_bits;
>> +		used_b = r->cache.shareable_bits;
>> +		ctrl = d->ctrl_val;
>> +		for (i = 0; i < closids_supported(); i++, ctrl++) {
>> +			if (closid_allocated(i) && i != closid) {
>> +				mode = rdtgroup_mode_by_closid(i);
>> +				if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
>> +					break;
>> +				/*
>> +				 * If CDP is active include peer
>> +				 * domain's usage to ensure there
>> +				 * is no overlap with an exclusive
>> +				 * group.
>> +				 */
>> +				if (d_cdp)
>> +					peer_ctl = d_cdp->ctrl_val[i];
>> +				else
>> +					peer_ctl = 0;
>> +				used_b |= *ctrl | peer_ctl;
>> +				if (mode == RDT_MODE_SHAREABLE)
>> +					d->new_ctrl |= *ctrl | peer_ctl;
>> +			}
>> +		}
>> +		if (d->plr && d->plr->cbm > 0)
>> +			used_b |= d->plr->cbm;
>> +		unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
>> +		unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
>> +		d->new_ctrl |= unused_b;
>> +		cbm_ensure_valid(&d->new_ctrl, r);
>>   		/*
>> -		 * Only initialize default allocations for CBM cache
>> -		 * resources
>> +		 * Assign the u32 CBM to an unsigned long to ensure
>> +		 * that bitmap_weight() does not access out-of-bound
>> +		 * memory.
>>   		 */
> 
> So all this code working on a rdt_domain *d pointer could be carved out
> into a separate function called something like:
> 
> 	__init_one_rdt_domain(d, ...)
> 
> and this will make the code more readable and save us at least 2
> indentation levels.
> 
> Please do that in a preparatory patch.

Good suggestion. I will do it in v2 patch.

> 
>> -		if (r->rid == RDT_RESOURCE_MBA)
>> -			continue;
> 
> Then, after having done that, it would be very obvious when you do this
> above because you won't be calling that __init_one_rdt_domain() function
> for an MBA anyway. >
> Thx.
> 

In this patch we initialize MBA resource and cache resources in separate 
functions rdtgroup_init_cat() and rdtgroup_init_mba(). If 
__init_one_rdt_domain() is only called by rdtgroup_init_cat(), how about 
using function name "__init_one_rdt_domain_cat()"?

Thank you.

Best regards,
Xiaochen

