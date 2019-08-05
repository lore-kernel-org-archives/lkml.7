Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D826C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEFF21738
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hqXVQVO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfHEP5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:57:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34486 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfHEP5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:57:46 -0400
Received: from zn.tnic (p200300EC2F065B00683A29B48F14DC99.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5b00:683a:29b4:8f14:dc99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5834E1EC0C31;
        Mon,  5 Aug 2019 17:57:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565020664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Gi0g2I1SbpSiAESkUfjkocwrvZWSJhT+FGN1+9gI4Qs=;
        b=hqXVQVO1eBdWSbC2SWJjwNbU1BND9M1CfYpHbUaC4l2NaN/xsnsOZOZ1yXmnmg8R5DPYKU
        TJunkjyPpqDi7qBrHWcJsQ57V1jc9RJRJ7orpOC0GasXyPwSQxpsuP6X3gPekea8OOEYNR
        RogX4pSSQcS4sqg53INzn91hAYHyxVk=
Date:   Mon, 5 Aug 2019 17:57:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 04/10] x86/resctrl: Set cache line size using new
 utility
Message-ID: <20190805155739.GB18785@zn.tnic>
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <affb28c7095e94b6fa55870f8739e6184ff4859a.1564504901.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <affb28c7095e94b6fa55870f8739e6184ff4859a.1564504901.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:29:38AM -0700, Reinette Chatre wrote:
> In preparation for support of pseudo-locked regions spanning two
> cache levels the cache line size computation is moved to a utility.

Please write this in active voice: "Move the cache line size computation
to a utility function in preparation... "

And yes, "a utility" solely sounds like you're adding a tool which does
that. But it is simply a separate function. :-)

> Setting of the cache line size is moved a few lines earlier, before
> the C-states are constrained, to reduce the amount of cleanup needed
> on failure.

And in general, that passive voice is kinda hard to read. To quote from
Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Please check all your commit messages.

> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 42 +++++++++++++++++------
>  1 file changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 110ae4b4f2e4..884976913326 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -101,6 +101,30 @@ static u64 get_prefetch_disable_bits(void)
>  	return 0;
>  }
>  
> +/**
> + * get_cache_line_size - Determine the cache coherency line size
> + * @cpu: CPU with which cache is associated
> + * @level: Cache level
> + *
> + * Context: @cpu has to be online.
> + * Return: The cache coherency line size for cache level @level associated
> + * with CPU @cpu. Zero on failure.
> + */
> +static unsigned int get_cache_line_size(unsigned int cpu, int level)
> +{
> +	struct cpu_cacheinfo *ci;
> +	int i;
> +
> +	ci = get_cpu_cacheinfo(cpu);
> +
> +	for (i = 0; i < ci->num_leaves; i++) {
> +		if (ci->info_list[i].level == level)
> +			return ci->info_list[i].coherency_line_size;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * pseudo_lock_minor_get - Obtain available minor number
>   * @minor: Pointer to where new minor number will be stored
> @@ -281,9 +305,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
>   */
>  static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  {
> -	struct cpu_cacheinfo *ci;
>  	int ret;
> -	int i;
>  
>  	/* Pick the first cpu we find that is associated with the cache. */
>  	plr->cpu = cpumask_first(&plr->d->cpu_mask);
> @@ -295,7 +317,12 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  		goto out_region;
>  	}
>  
> -	ci = get_cpu_cacheinfo(plr->cpu);
> +	plr->line_size = get_cache_line_size(plr->cpu, plr->r->cache_level);
> +	if (plr->line_size == 0) {

	if (!plr->...)

> +		rdt_last_cmd_puts("Unable to determine cache line size\n");
> +		ret = -1;
> +		goto out_region;
> +	}
>  
>  	plr->size = rdtgroup_cbm_to_size(plr->r, plr->d, plr->cbm);
>  
> @@ -303,15 +330,8 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  	if (ret < 0)
>  		goto out_region;
>  
> -	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == plr->r->cache_level) {
> -			plr->line_size = ci->info_list[i].coherency_line_size;
> -			return 0;
> -		}
> -	}
> +	return 0;
>  
> -	ret = -1;
> -	rdt_last_cmd_puts("Unable to determine cache line size\n");
>  out_region:
>  	pseudo_lock_region_clear(plr);
>  	return ret;
> -- 
> 2.17.2
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
