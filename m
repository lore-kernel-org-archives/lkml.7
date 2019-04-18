Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FF2C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FF4217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbfDRHDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:03:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:58683 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfDRHDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:03:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 00:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,365,1549958400"; 
   d="scan'208";a="143702540"
Received: from xshen14-mobl.ccr.corp.intel.com (HELO [10.238.129.23]) ([10.238.129.23])
  by orsmga003.jf.intel.com with ESMTP; 18 Apr 2019 00:03:36 -0700
Subject: Re: [tip:x86/cache] x86/resctrl: Initialize a new resource group with
 default MBA values
To:     tony.luck@intel.com, x86@kernel.org, mingo@redhat.com, bp@suse.de,
        reinette.chatre@intel.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, linux-tip-commits@vger.kernel.org
References: <1555499329-1170-3-git-send-email-xiaochen.shen@intel.com>
 <tip-47820e73f5b3a1fdb8ebd1219191edc96e0c85c1@git.kernel.org>
Cc:     Xiaochen Shen <xiaochen.shen@intel.com>
From:   Xiaochen Shen <xiaochen.shen@intel.com>
Message-ID: <0ab6a79f-d1ae-1c99-1447-722f18405309@intel.com>
Date:   Thu, 18 Apr 2019 15:03:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <tip-47820e73f5b3a1fdb8ebd1219191edc96e0c85c1@git.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

I found a nitpick - an unnecessary newline at the end of the patch.
Please help double check. Thank you.

On 4/18/2019 6:14, tip-bot for Xiaochen Shen wrote:
> Commit-ID:  47820e73f5b3a1fdb8ebd1219191edc96e0c85c1
> Gitweb:     https://git.kernel.org/tip/47820e73f5b3a1fdb8ebd1219191edc96e0c85c1
> Author:     Xiaochen Shen <xiaochen.shen@intel.com>
> AuthorDate: Wed, 17 Apr 2019 19:08:49 +0800
> Committer:  Borislav Petkov <bp@suse.de>
> CommitDate: Thu, 18 Apr 2019 00:06:31 +0200
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
> Initialize the MBA resource and cache resources in separate functions.
> 
>   [ bp: Add newlines between code blocks for better readability. ]
> 
> Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: pei.p.jia@intel.com
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: x86-ml <x86@kernel.org>
> Link: https://lkml.kernel.org/r/1555499329-1170-3-git-send-email-xiaochen.shen@intel.com
> ---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +--
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 52 ++++++++++++++++++++-----------
>   2 files changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 2dbd990a2eb7..89320c0396b1 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -342,10 +342,10 @@ int update_domains(struct rdt_resource *r, int closid)
>   	if (cpumask_empty(cpu_mask) || mba_sc)
>   		goto done;
>   	cpu = get_cpu();
> -	/* Update CBM on this cpu if it's in cpu_mask. */
> +	/* Update resource control msr on this CPU if it's in cpu_mask. */
>   	if (cpumask_test_cpu(cpu, cpu_mask))
>   		rdt_ctrl_update(&msr_param);
> -	/* Update CBM on other cpus. */
> +	/* Update resource control msr on other CPUs. */
>   	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
>   	put_cpu();
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 36ace51ee705..333c177a2471 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2581,8 +2581,8 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
>   	return 0;
>   }
>   
> -/**
> - * rdtgroup_init_alloc - Initialize the new RDT group's allocations
> +/*
> + * Initialize cache resources with default values.
>    *
>    * A new RDT group is being created on an allocation capable (CAT)
>    * supporting system. Set this group up to start off with all usable
> @@ -2591,38 +2591,52 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
>    * If there are no more shareable bits available on any domain then
>    * the entire allocation will fail.
>    */
> +static int rdtgroup_init_cat(struct rdt_resource *r, u32 closid)
> +{
> +	struct rdt_domain *d;
> +	int ret;
> +
> +	list_for_each_entry(d, &r->domains, list) {
> +		ret = __init_one_rdt_domain(d, r, closid);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Initialize MBA resource with default values. */
> +static void rdtgroup_init_mba(struct rdt_resource *r)
> +{
> +	struct rdt_domain *d;
> +
> +	list_for_each_entry(d, &r->domains, list) {
> +		d->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
> +		d->have_new_ctrl = true;
> +	}
> +}
> +
> +/* Initialize the RDT group's allocations. */
>   static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>   {
>   	struct rdt_resource *r;
> -	struct rdt_domain *d;
>   	int ret;
>   
>   	for_each_alloc_enabled_rdt_resource(r) {
> -		/*
> -		 * Only initialize default allocations for CBM cache
> -		 * resources
> -		 */
> -		if (r->rid == RDT_RESOURCE_MBA)
> -			continue;
> -		list_for_each_entry(d, &r->domains, list) {
> -			ret = __init_one_rdt_domain(d, r, rdtgrp->closid);
> +		if (r->rid == RDT_RESOURCE_MBA) {
> +			rdtgroup_init_mba(r);
> +		} else {
> +			ret = rdtgroup_init_cat(r, rdtgrp->closid);
>   			if (ret < 0)
>   				return ret;
>   		}
> -	}
>   
> -	for_each_alloc_enabled_rdt_resource(r) {
> -		/*
> -		 * Only initialize default allocations for CBM cache
> -		 * resources
> -		 */
> -		if (r->rid == RDT_RESOURCE_MBA)
> -			continue;
>   		ret = update_domains(r, rdtgrp->closid);
>   		if (ret < 0) {
>   			rdt_last_cmd_puts("Failed to initialize allocations\n");
>   			return ret;
>   		}
> +

In my opinion, this newline is unnecessary. Thank you.

>   	}
>   
>   	rdtgrp->mode = RDT_MODE_SHAREABLE;
> 

-- 
Best regards,
Xiaochen
