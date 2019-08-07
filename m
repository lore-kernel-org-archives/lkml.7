Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B97C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58E021BE6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hPfZMFax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfHGJRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:17:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46986 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfHGJRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:17:39 -0400
Received: from zn.tnic (p200300EC2F0D5000E5DBE4FCCFA1B2C9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5000:e5db:e4fc:cfa1:b2c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8712F1EC0B07;
        Wed,  7 Aug 2019 11:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565169456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DnDOhlWyeBJK0zKV1ZwYlhfVwPmz+ei49G/WGlB2iao=;
        b=hPfZMFaxhhqp2+aJnjwK3pVi8VFag/8HppNPSdmP0fZ6AzvUNyDeb9/5evvOfX5aUdI1HG
        EKz8tZD9PL5rJ9BabtENxgO7cCgYD1urysOFmyGt6aAq/JV9VidP2Mzv8XYG2LfRGR+OLI
        Ts5fRbeaJUwZ0vSLDw/jBjStFHS7uVY=
Date:   Wed, 7 Aug 2019 11:18:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 08/10] x86/resctrl: Support pseudo-lock regions
 spanning resources
Message-ID: <20190807091822.GB18207@zn.tnic>
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <2a53901c44b1286097ba142a7b64cc092d99ad86.1564504902.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a53901c44b1286097ba142a7b64cc092d99ad86.1564504902.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:29:42AM -0700, Reinette Chatre wrote:
> Currently cache pseudo-locked regions only consider one cache level but
> cache pseudo-locked regions may span multiple cache levels.
> 
> In preparation for support of pseudo-locked regions spanning multiple
> cache levels pseudo-lock 'portions' are introduced. A 'portion' of a
> pseudo-locked region is the portion of a pseudo-locked region that
> belongs to a specific resource. Each pseudo-locked portion is identified
> with the resource (for example, L2 or L3 cache), the domain (the
> specific cache instance), and the capacity bitmask that specifies which
> region of the cache is used by the pseudo-locked region.
> 
> In support of pseudo-locked regions spanning multiple cache levels a
> pseudo-locked region could have multiple 'portions' but in this
> introduction only single portions are allowed.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  26 +++-
>  arch/x86/kernel/cpu/resctrl/internal.h    |  32 ++--
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 180 ++++++++++++++++------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  44 ++++--
>  4 files changed, 211 insertions(+), 71 deletions(-)

This patch kinda got pretty big and is hard to review. Can
you split it pls? The addition of pseudo_lock_portion and
pseudo_lock_single_portion_valid() look like a separate patch to me.

> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index a0383ff80afe..a60fb38a4d20 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -207,7 +207,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
>  	 * hierarchy.
>  	 */
>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
> -	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
> +	    rdtgroup_pseudo_locked_in_hierarchy(rdtgrp, d)) {
>  		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
>  		return -EINVAL;
>  	}
> @@ -282,6 +282,7 @@ static int parse_line(char *line, struct rdt_resource *r,
>  			if (r->parse_ctrlval(&data, r, d))
>  				return -EINVAL;
>  			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
> +				struct pseudo_lock_portion *p;
>  				/*
>  				 * In pseudo-locking setup mode and just
>  				 * parsed a valid CBM that should be
> @@ -290,9 +291,15 @@ static int parse_line(char *line, struct rdt_resource *r,
>  				 * the required initialization for single
>  				 * region and return.
>  				 */
> -				rdtgrp->plr->r = r;
> -				rdtgrp->plr->d_id = d->id;
> -				rdtgrp->plr->cbm = d->new_ctrl;
> +				p = kzalloc(sizeof(*p), GFP_KERNEL);
> +				if (!p) {
> +					rdt_last_cmd_puts("Unable to allocate memory for pseudo-lock portion\n");
> +					return -ENOMEM;
> +				}
> +				p->r = r;
> +				p->d_id = d->id;
> +				p->cbm = d->new_ctrl;
> +				list_add(&p->list, &rdtgrp->plr->portions);
>  				return 0;
>  			}

Looking at the indentation level of this, it is basically begging to
become a separate, helper function...

>  			goto next;
> @@ -410,8 +417,11 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  			goto out;
>  		}
>  		ret = rdtgroup_parse_resource(resname, tok, rdtgrp);
> -		if (ret)
> +		if (ret) {
> +			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP)
> +				pseudo_lock_region_clear(rdtgrp->plr);
>  			goto out;
> +		}
>  	}
>  
>  	for_each_alloc_enabled_rdt_resource(r) {
> @@ -459,6 +469,7 @@ static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
>  int rdtgroup_schemata_show(struct kernfs_open_file *of,
>  			   struct seq_file *s, void *v)
>  {
> +	struct pseudo_lock_portion *p;
>  	struct rdtgroup *rdtgrp;
>  	struct rdt_resource *r;
>  	int ret = 0;
> @@ -470,8 +481,9 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
>  			for_each_alloc_enabled_rdt_resource(r)
>  				seq_printf(s, "%s:uninitialized\n", r->name);
>  		} else if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
> -			seq_printf(s, "%s:%d=%x\n", rdtgrp->plr->r->name,
> -				   rdtgrp->plr->d_id, rdtgrp->plr->cbm);
> +			list_for_each_entry(p, &rdtgrp->plr->portions, list)
> +				seq_printf(s, "%s:%d=%x\n", p->r->name, p->d_id,
> +					   p->cbm);

Shouldn't this say that those are portions now?

>  		} else {
>  			closid = rdtgrp->closid;
>  			for_each_alloc_enabled_rdt_resource(r) {
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 892f38899dda..b041029d4de1 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -145,13 +145,27 @@ struct mongroup {
>  	u32			rmid;
>  };
>  
> +/**
> + * struct pseudo_lock_portion - portion of a pseudo-lock region on one resource
> + * @r:		RDT resource to which this pseudo-locked portion
> + *		belongs
> + * @d_id:	ID of cache instance to which this pseudo-locked portion
> + *		belongs
> + * @cbm:	bitmask of the pseudo-locked portion
> + * @list:	Entry in the list of pseudo-locked portion
> + *		belonging to the pseudo-locked region
> + */
> +struct pseudo_lock_portion {
> +	struct rdt_resource	*r;
> +	int			d_id;
> +	u32			cbm;
> +	struct list_head	list;
> +};
> +
>  /**
>   * struct pseudo_lock_region - pseudo-lock region information
> - * @r:			RDT resource to which this pseudo-locked region
> - *			belongs
> - * @d_id:		ID of cache instance to which this pseudo-locked region
> - *			belongs
> - * @cbm:		bitmask of the pseudo-locked region
> + * @portions:		list of portions across different resources that
> + *			are associated with this pseudo-locked region
>   * @lock_thread_wq:	waitqueue used to wait on the pseudo-locking thread
>   *			completion
>   * @thread_done:	variable used by waitqueue to test if pseudo-locking
> @@ -168,9 +182,7 @@ struct mongroup {
>   * @pm_reqs:		Power management QoS requests related to this region
>   */
>  struct pseudo_lock_region {
> -	struct rdt_resource	*r;
> -	int			d_id;
> -	u32			cbm;
> +	struct list_head	portions;
>  	wait_queue_head_t	lock_thread_wq;
>  	int			thread_done;
>  	int			cpu;
> @@ -569,11 +581,13 @@ bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_resource *r,
>  					 struct rdt_domain *d,
>  					 unsigned long cbm);
>  u32 rdtgroup_pseudo_locked_bits(struct rdt_resource *r, struct rdt_domain *d);
> -bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d);
> +bool rdtgroup_pseudo_locked_in_hierarchy(struct rdtgroup *selfgrp,
> +					 struct rdt_domain *d);
>  int rdt_pseudo_lock_init(void);
>  void rdt_pseudo_lock_release(void);
>  int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
>  void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
> +void pseudo_lock_region_clear(struct pseudo_lock_region *plr);
>  struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
>  int update_domains(struct rdt_resource *r, int closid);
>  int closids_supported(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 733cb7f34948..717ea26e325b 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -270,28 +270,85 @@ static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr,
>   *
>   * Return: void
>   */
> -static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
> +void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
>  {
> +	struct pseudo_lock_portion *p, *tmp;
> +
>  	plr->size = 0;
>  	plr->line_size = 0;
>  	kfree(plr->kmem);
>  	plr->kmem = NULL;
> -	plr->r = NULL;
> -	plr->d_id = -1;
> -	plr->cbm = 0;
>  	pseudo_lock_cstates_relax(plr);
> +	if (!list_empty(&plr->portions)) {
> +		list_for_each_entry_safe(p, tmp, &plr->portions, list) {
> +			list_del(&p->list);
> +			kfree(p);
> +		}
> +	}
>  	plr->debugfs_dir = NULL;
>  }
>  
> +/**
> + * pseudo_lock_single_portion_valid - Verify properties of pseudo-lock region
> + * @plr: the main pseudo-lock region
> + * @p: the single portion that makes up the pseudo-locked region
> + *
> + * Verify and initialize properties of the pseudo-locked region.
> + *
> + * Return: -1 if portion of cache unable to be used for pseudo-locking
> + *         0 if portion of cache can be used for pseudo-locking, in
> + *         addition the CPU on which pseudo-locking will be performed will
> + *         be initialized as well as the size and cache line size of the region
> + */
> +static int pseudo_lock_single_portion_valid(struct pseudo_lock_region *plr,
> +					    struct pseudo_lock_portion *p)
> +{
> +	struct rdt_domain *d;
> +
> +	d = rdt_find_domain(p->r, p->d_id, NULL);
> +	if (IS_ERR_OR_NULL(d)) {
> +		rdt_last_cmd_puts("Cannot find cache domain\n");
> +		return -1;
> +	}
> +
> +	plr->cpu = cpumask_first(&d->cpu_mask);
> +	if (!cpu_online(plr->cpu)) {
> +		rdt_last_cmd_printf("CPU %u not online\n", plr->cpu);
> +		goto err_cpu;
> +	}
> +
> +	plr->line_size = get_cache_line_size(plr->cpu, p->r->cache_level);
> +	if (plr->line_size == 0) {
> +		rdt_last_cmd_puts("Unable to compute cache line length\n");
> +		goto err_cpu;
> +	}
> +
> +	if (pseudo_lock_cstates_constrain(plr, &d->cpu_mask)) {
> +		rdt_last_cmd_puts("Cannot limit C-states\n");
> +		goto err_line;
> +	}
> +
> +	plr->size = rdtgroup_cbm_to_size(p->r, d, p->cbm);
> +
> +	return 0;
> +
> +err_line:
> +	plr->line_size = 0;
> +err_cpu:
> +	plr->cpu = 0;
> +	return -1;
> +}
> +
>  /**
>   * pseudo_lock_region_init - Initialize pseudo-lock region information
>   * @plr: pseudo-lock region
>   *
>   * Called after user provided a schemata to be pseudo-locked. From the
>   * schemata the &struct pseudo_lock_region is on entry already initialized
> - * with the resource, domain, and capacity bitmask. Here the information
> - * required for pseudo-locking is deduced from this data and &struct
> - * pseudo_lock_region initialized further. This information includes:
> + * with the resource, domain, and capacity bitmask. Here the
> + * provided data is validated and information required for pseudo-locking
> + * deduced, and &struct pseudo_lock_region initialized further. This
> + * information includes:
>   * - size in bytes of the region to be pseudo-locked
>   * - cache line size to know the stride with which data needs to be accessed
>   *   to be pseudo-locked
> @@ -303,44 +360,50 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
>   */
>  static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  {
> -	struct rdt_domain *d;
> +	struct rdt_resource *l3_resource = &rdt_resources_all[RDT_RESOURCE_L3];
> +	struct pseudo_lock_portion *p;
>  	int ret;
>  
> -	/* Pick the first cpu we find that is associated with the cache. */
> -	d = rdt_find_domain(plr->r, plr->d_id, NULL);
> -	if (IS_ERR_OR_NULL(d)) {
> -		rdt_last_cmd_puts("Cache domain offline\n");
> -		ret = -ENODEV;
> +	if (list_empty(&plr->portions)) {
> +		rdt_last_cmd_puts("No pseudo-lock portions provided\n");
>  		goto out_region;

Not return?

Do you need to clear anything in an not even initialized plr?

>  	}
>  
> -	plr->cpu = cpumask_first(&d->cpu_mask);
> -
> -	if (!cpu_online(plr->cpu)) {
> -		rdt_last_cmd_printf("CPU %u associated with cache not online\n",
> -				    plr->cpu);
> -		ret = -ENODEV;
> -		goto out_region;
> +	/* Cache Pseudo-Locking only supported on L2 and L3 resources */
> +	list_for_each_entry(p, &plr->portions, list) {
> +		if (p->r->rid != RDT_RESOURCE_L2 &&
> +		    p->r->rid != RDT_RESOURCE_L3) {
> +			rdt_last_cmd_puts("Unsupported resource\n");
> +			goto out_region;
> +		}
>  	}
>  
> -	plr->line_size = get_cache_line_size(plr->cpu, plr->r->cache_level);
> -	if (plr->line_size == 0) {
> -		rdt_last_cmd_puts("Unable to determine cache line size\n");
> -		ret = -1;
> -		goto out_region;
> +	/*
> +	 * If only one resource requested to be pseudo-locked then:
> +	 * - Just a L3 cache portion is valid
> +	 * - Just a L2 cache portion on system without L3 cache is valid
> +	 */
> +	if (list_is_singular(&plr->portions)) {
> +		p = list_first_entry(&plr->portions, struct pseudo_lock_portion,
> +				     list);

Let that line stick out.

> +		if (p->r->rid == RDT_RESOURCE_L3 ||
> +		    (p->r->rid == RDT_RESOURCE_L2 &&
> +		     !l3_resource->alloc_capable)) {
> +			ret = pseudo_lock_single_portion_valid(plr, p);
> +			if (ret < 0)
> +				goto out_region;
> +			return 0;
> +		} else {
> +			rdt_last_cmd_puts("Invalid resource or just L2 provided when L3 is required\n");
> +			goto out_region;
> +		}
> +	} else {
> +		rdt_last_cmd_puts("Multiple pseudo-lock portions unsupported\n");
>  	}
>  
> -	plr->size = rdtgroup_cbm_to_size(plr->r, d, plr->cbm);
> -
> -	ret = pseudo_lock_cstates_constrain(plr, &d->cpu_mask);
> -	if (ret < 0)
> -		goto out_region;
> -
> -	return 0;
> -
>  out_region:
>  	pseudo_lock_region_clear(plr);
> -	return ret;
> +	return -1;
>  }
>

Yap, this patch is doing too many things at once and splitting it would help.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
