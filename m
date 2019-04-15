Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F36FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA38220833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="R630wj9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfDOLgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:36:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38918 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfDOLgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:36:19 -0400
Received: from zn.tnic (p4FED3D80.dip0.t-ipconnect.de [79.237.61.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EC3551EC04B9;
        Mon, 15 Apr 2019 13:36:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555328178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2xpUU5C8DKfqBB3m3oeH9RMdPkaA483999IXjeC0//U=;
        b=R630wj9aKHLDforXY1jeXXwT7MnjEaoehx8WZcngbPXvRlt8MjXz5Yma2AyRNOd9OahPWo
        N3A2IMQ9sGD+YJxLPmb6+egPqMpVz7I31m94iEws5lz33dX4dPf2U6HNku8/MAL6KCUY87
        2gp7KStQhH/JLJ1Wp7iQGI8vxv1OwdA=
Date:   Mon, 15 Apr 2019 13:34:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com
Subject: Re: [PATCH 2/2] x86/resctrl: Initialize new resource group with
 default MBA values
Message-ID: <20190415113405.GC29317@zn.tnic>
References: <1554839728-5544-1-git-send-email-xiaochen.shen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554839728-5544-1-git-send-email-xiaochen.shen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 03:55:28AM +0800, Xiaochen Shen wrote:
> Currently when a new resource group is created, the allocation values
> of MBA resource are not initialized and remain meaningless data.
> 
> For example:
> mkdir /sys/fs/resctrl/p1
> cat /sys/fs/resctrl/p1/schemata
> MB:0=100;1=100
> 
> echo "MB:0=10;1=20" > /sys/fs/resctrl/p1/schemata
> cat /sys/fs/resctrl/p1/schemata
> MB:0= 10;1= 20
> 
> rmdir /sys/fs/resctrl/p1
> mkdir /sys/fs/resctrl/p2
> cat /sys/fs/resctrl/p2/schemata
> MB:0= 10;1= 20
> 
> When the new group is created, it is reasonable to initialize MBA
> resource with default values.
> 
> Initialize MBA resource and cache resources in separate functions.

Please format your commit message by indenting the examples:

x86/resctrl: Initialize a new resource group with default MBA values

Currently, when a new resource group is created, the allocation values
of the MBA resource are not initialized and remain meaningless data.

For example:

  mkdir /sys/fs/resctrl/p1
  cat /sys/fs/resctrl/p1/schemata
  MB:0=100;1=100

  echo "MB:0=10;1=20" > /sys/fs/resctrl/p1/schemata
  cat /sys/fs/resctrl/p1/schemata
  MB:0= 10;1= 20

  rmdir /sys/fs/resctrl/p1
  mkdir /sys/fs/resctrl/p2
  cat /sys/fs/resctrl/p2/schemata
  MB:0= 10;1= 20

Therefore, when the new group is created, it is reasonable to initialize
MBA resource with default values.

Initialize the MBA resource and cache resources in separate functions."

Thx.

> 
> Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   4 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 139 ++++++++++++++++--------------
>  2 files changed, 75 insertions(+), 68 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 2dbd990..576bb6a 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -342,10 +342,10 @@ int update_domains(struct rdt_resource *r, int closid)
>  	if (cpumask_empty(cpu_mask) || mba_sc)
>  		goto done;
>  	cpu = get_cpu();
> -	/* Update CBM on this cpu if it's in cpu_mask. */
> +	/* Update resource control msr on this cpu if it's in cpu_mask. */

s/cpu/CPU/g

>  	if (cpumask_test_cpu(cpu, cpu_mask))
>  		rdt_ctrl_update(&msr_param);
> -	/* Update CBM on other cpus. */
> +	/* Update resource control msr on other cpus. */

Ditto.

>  	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
>  	put_cpu();
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 08e0333..9f12a02 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2516,8 +2516,8 @@ static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
>  	bitmap_clear(val, zero_bit, cbm_len - zero_bit);
>  }
>  
> -/**
> - * rdtgroup_init_alloc - Initialize the new RDT group's allocations
> +/*
> + * Initialize cache resources with default values.
>   *
>   * A new RDT group is being created on an allocation capable (CAT)
>   * supporting system. Set this group up to start off with all usable
> @@ -2526,85 +2526,92 @@ static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
>   * All-zero CBM is invalid. If there are no more shareable bits available
>   * on any domain then the entire allocation will fail.
>   */
> -static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
> +static int rdtgroup_init_cat(struct rdt_resource *r, u32 closid)
>  {
>  	struct rdt_resource *r_cdp = NULL;
>  	struct rdt_domain *d_cdp = NULL;
>  	u32 used_b = 0, unused_b = 0;
> -	u32 closid = rdtgrp->closid;
> -	struct rdt_resource *r;
>  	unsigned long tmp_cbm;
>  	enum rdtgrp_mode mode;
>  	struct rdt_domain *d;
>  	u32 peer_ctl, *ctrl;
> -	int i, ret;
> +	int i;
>  
> -	for_each_alloc_enabled_rdt_resource(r) {
> +	list_for_each_entry(d, &r->domains, list) {
> +		rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
> +		d->have_new_ctrl = false;
> +		d->new_ctrl = r->cache.shareable_bits;
> +		used_b = r->cache.shareable_bits;
> +		ctrl = d->ctrl_val;
> +		for (i = 0; i < closids_supported(); i++, ctrl++) {
> +			if (closid_allocated(i) && i != closid) {
> +				mode = rdtgroup_mode_by_closid(i);
> +				if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
> +					break;
> +				/*
> +				 * If CDP is active include peer
> +				 * domain's usage to ensure there
> +				 * is no overlap with an exclusive
> +				 * group.
> +				 */
> +				if (d_cdp)
> +					peer_ctl = d_cdp->ctrl_val[i];
> +				else
> +					peer_ctl = 0;
> +				used_b |= *ctrl | peer_ctl;
> +				if (mode == RDT_MODE_SHAREABLE)
> +					d->new_ctrl |= *ctrl | peer_ctl;
> +			}
> +		}
> +		if (d->plr && d->plr->cbm > 0)
> +			used_b |= d->plr->cbm;
> +		unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
> +		unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
> +		d->new_ctrl |= unused_b;
> +		cbm_ensure_valid(&d->new_ctrl, r);
>  		/*
> -		 * Only initialize default allocations for CBM cache
> -		 * resources
> +		 * Assign the u32 CBM to an unsigned long to ensure
> +		 * that bitmap_weight() does not access out-of-bound
> +		 * memory.
>  		 */

So all this code working on a rdt_domain *d pointer could be carved out
into a separate function called something like:

	__init_one_rdt_domain(d, ...)

and this will make the code more readable and save us at least 2
indentation levels.

Please do that in a preparatory patch.

> -		if (r->rid == RDT_RESOURCE_MBA)
> -			continue;

Then, after having done that, it would be very obvious when you do this
above because you won't be calling that __init_one_rdt_domain() function
for an MBA anyway.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
