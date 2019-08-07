Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A58C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412162086D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfHGTXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:23:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:39549 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbfHGTXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 15:23:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 12:23:31 -0700
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
   d="scan'208";a="258467021"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.173]) ([10.24.14.173])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 07 Aug 2019 12:23:31 -0700
Subject: Re: [PATCH V2 09/10] x86/resctrl: Pseudo-lock portions of multiple
 resources
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <c0095fd15488d87be06deddf43abb4a2834dc7e6.1564504902.git.reinette.chatre@intel.com>
 <20190807152511.GB24328@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <e9145623-bf5a-b96c-d802-7b61caa406e0@intel.com>
Date:   Wed, 7 Aug 2019 12:23:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807152511.GB24328@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 8/7/2019 8:25 AM, Borislav Petkov wrote:
> On Tue, Jul 30, 2019 at 10:29:43AM -0700, Reinette Chatre wrote:
>> A cache pseudo-locked region may span more than one level of cache. A
>> part of the pseudo-locked region that falls on one cache level is
>> referred to as a pseudo-lock portion that was introduced previously.
>>
>> Now a pseudo-locked region is allowed to have two portions instead of
>> the previous limit of one. When a pseudo-locked region consists out of
>> two portions it can only span a L2 and L3 resctrl resource.
>> When a pseudo-locked region consists out of a L2 and L3 portion then
>> there are some requirements:
>> - the L2 and L3 cache has to be in same cache hierarchy
>> - the L3 portion must be same size or larger than L2 portion
>>
>> As documented in previous changes the list of portions are
>> maintained so that the L2 portion would always appear first in the list
>> to simplify any information retrieval.
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 142 +++++++++++++++++++++-
>>  1 file changed, 139 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> index 717ea26e325b..7ab4e85a33a7 100644
>> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> @@ -339,13 +339,104 @@ static int pseudo_lock_single_portion_valid(struct pseudo_lock_region *plr,
>>  	return -1;
>>  }
>>  
>> +/**
>> + * pseudo_lock_l2_l3_portions_valid - Verify region across L2 and L3
>> + * @plr: Pseudo-Locked region
>> + * @l2_portion: L2 Cache portion of pseudo-locked region
>> + * @l3_portion: L3 Cache portion of pseudo-locked region
>> + *
>> + * User requested a pseudo-locked region consisting of a L2 as well as L3
>> + * cache portion. The portions are tested as follows:
>> + *   - L2 and L3 cache instances have to be in the same cache hierarchy.
>> + *     This is tested by ensuring that the L2 portion's cpumask is a
>> + *     subset of the L3 portion's cpumask.
>> + *   - L3 portion must be same size or larger than L2 portion.
>> + *
>> + * Return: -1 if the portions are unable to be used for a pseudo-locked
>> + *         region, 0 if the portions could be used for a pseudo-locked
>> + *         region. When returning 0:
>> + *         - the pseudo-locked region's size, line_size (cache line length)
>> + *           and CPU on which locking thread will be run are set.
>> + *         - CPUs associated with L2 cache portion are constrained from
>> + *           entering C-state that will affect the pseudo-locked region.
>> + */
>> +static int pseudo_lock_l2_l3_portions_valid(struct pseudo_lock_region *plr,
>> +					    struct pseudo_lock_portion *l2_p,
>> +					    struct pseudo_lock_portion *l3_p)
>> +{
>> +	struct rdt_domain *l2_d, *l3_d;
>> +	unsigned int l2_size, l3_size;
>> +
>> +	l2_d = rdt_find_domain(l2_p->r, l2_p->d_id, NULL);
>> +	if (IS_ERR_OR_NULL(l2_d)) {
>> +		rdt_last_cmd_puts("Cannot locate L2 cache domain\n");
>> +		return -1;
>> +	}
>> +
>> +	l3_d = rdt_find_domain(l3_p->r, l3_p->d_id, NULL);
>> +	if (IS_ERR_OR_NULL(l3_d)) {
>> +		rdt_last_cmd_puts("Cannot locate L3 cache domain\n");
>> +		return -1;
>> +	}
>> +
>> +	if (!cpumask_subset(&l2_d->cpu_mask, &l3_d->cpu_mask)) {
>> +		rdt_last_cmd_puts("L2 and L3 caches need to be in same hierarchy\n");
>> +		return -1;
>> +	}
>> +
> 
> Put that sentence above about L2 CPUs being constrained here - it is
> easier when following the code.

Will do.

> 
>> +	if (pseudo_lock_cstates_constrain(plr, &l2_d->cpu_mask)) {
>> +		rdt_last_cmd_puts("Cannot limit C-states\n");
>> +		return -1;
>> +	}
> 
> Also, can that function call be last in this function so that you can
> save yourself all the goto labels?

I do not fully understand this proposal. All those goto labels take care
of the the different failures that can be encountered during the
initialization of the pseudo-lock region. Each initialization failure is
associated with a goto where it jumps to the cleanup path. The
initialization starts with the constraining of the c-states
(initializing plr->pm_reqs), but if I move that I think it will not
reduce the goto labels, just change the order because of the other
initialization done (plr->size, plr->line_size, plr->cpu).

> 
>> +
>> +	l2_size = rdtgroup_cbm_to_size(l2_p->r, l2_d, l2_p->cbm);
>> +	l3_size = rdtgroup_cbm_to_size(l3_p->r, l3_d, l3_p->cbm);
>> +
>> +	if (l2_size > l3_size) {
>> +		rdt_last_cmd_puts("L3 cache portion has to be same size or larger than L2 cache portion\n");
>> +		goto err_size;
>> +	}
>> +
>> +	plr->size = l2_size;
>> +
>> +	l2_size = get_cache_line_size(cpumask_first(&l2_d->cpu_mask),
>> +				      l2_p->r->cache_level);
>> +	l3_size = get_cache_line_size(cpumask_first(&l3_d->cpu_mask),
>> +				      l3_p->r->cache_level);
>> +	if (l2_size != l3_size) {
>> +		rdt_last_cmd_puts("L2 and L3 caches have different coherency cache line sizes\n");
>> +		goto err_line;
>> +	}
>> +
>> +	plr->line_size = l2_size;
>> +
>> +	plr->cpu = cpumask_first(&l2_d->cpu_mask);
>> +
>> +	if (!cpu_online(plr->cpu)) {
>> +		rdt_last_cmd_printf("CPU %u associated with cache not online\n",
>> +				    plr->cpu);
>> +		goto err_cpu;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_cpu:
>> +	plr->line_size = 0;
>> +	plr->cpu = 0;
>> +err_line:
>> +	plr->size = 0;
>> +err_size:
>> +	pseudo_lock_cstates_relax(plr);
>> +	return -1;
>> +}
>> +
>>  /**
>>   * pseudo_lock_region_init - Initialize pseudo-lock region information
>>   * @plr: pseudo-lock region
>>   *
>>   * Called after user provided a schemata to be pseudo-locked. From the
>>   * schemata the &struct pseudo_lock_region is on entry already initialized
>> - * with the resource, domain, and capacity bitmask. Here the
>> + * with the resource(s), domain(s), and capacity bitmask(s). Here the
>>   * provided data is validated and information required for pseudo-locking
>>   * deduced, and &struct pseudo_lock_region initialized further. This
>>   * information includes:
>> @@ -355,13 +446,24 @@ static int pseudo_lock_single_portion_valid(struct pseudo_lock_region *plr,
>>   * - a cpu associated with the cache instance on which the pseudo-locking
>>   *   flow can be executed
>>   *
>> + * A user provides a schemata for a pseudo-locked region. This schemata may
>> + * contain portions that span different resources, for example, a cache
>> + * pseudo-locked region that spans L2 and L3 cache. After the schemata is
>> + * parsed into portions it needs to be verified that the provided portions
>> + * are valid with the following tests:
>> + *
>> + * - L2 only portion on system that has only L2 resource - OK
>> + * - L3 only portion on any system that supports it - OK
>> + * - L2 portion on system that has L3 resource - require L3 portion
>> + **
>> + *
>>   * Return: 0 on success, <0 on failure. Descriptive error will be written
>>   * to last_cmd_status buffer.
>>   */
>>  static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>>  {
>>  	struct rdt_resource *l3_resource = &rdt_resources_all[RDT_RESOURCE_L3];
>> -	struct pseudo_lock_portion *p;
>> +	struct pseudo_lock_portion *p, *n_p, *tmp;
>>  	int ret;
>>  
>>  	if (list_empty(&plr->portions)) {
>> @@ -397,8 +499,42 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>>  			rdt_last_cmd_puts("Invalid resource or just L2 provided when L3 is required\n");
>>  			goto out_region;
>>  		}
>> +	}
>> +
>> +	/*
>> +	 * List is neither empty nor singular, process first and second portions
>> +	 */
>> +	p = list_first_entry(&plr->portions, struct pseudo_lock_portion, list);
>> +	n_p = list_next_entry(p, list);
>> +
>> +	/*
>> +	 * If the second portion is not also the last portion user provided
>> +	 * more portions than can be supported.
>> +	 */
>> +	tmp = list_last_entry(&plr->portions, struct pseudo_lock_portion, list);
>> +	if (n_p != tmp) {
>> +		rdt_last_cmd_puts("Only two pseudo-lock portions supported\n");
>> +		goto out_region;
>> +	}
>> +
>> +	if (p->r->rid == RDT_RESOURCE_L2 && n_p->r->rid == RDT_RESOURCE_L3) {
>> +		ret = pseudo_lock_l2_l3_portions_valid(plr, p, n_p);
>> +		if (ret < 0)
>> +			goto out_region;
>> +		return 0;
>> +	} else if (p->r->rid == RDT_RESOURCE_L3 &&
>> +		   n_p->r->rid == RDT_RESOURCE_L2) {
>> +		if (pseudo_lock_l2_l3_portions_valid(plr, n_p, p) == 0) {
> 
> 		if (!pseudo_...
> 

Will do. Seems that I need to check all my code for this pattern.

>> +			/*
>> +			 * Let L2 and L3 portions appear in order in the
>> +			 * portions list in support of consistent output to
>> +			 * user space.
>> +			 */
>> +			list_rotate_left(&plr->portions);
>> +			return 0;
>> +		}
>>  	} else {
>> -		rdt_last_cmd_puts("Multiple pseudo-lock portions unsupported\n");
>> +		rdt_last_cmd_puts("Invalid combination of resources\n");
>>  	}
>>  
>>  out_region:
>> -- 
>> 2.17.2
>>
> 

Thank you very much

Reinette
