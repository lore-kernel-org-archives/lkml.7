Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D925BC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C39D2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556927575;
	bh=FRZu2uAXb3RBHRAKvIJgvp7yONkAmGJYfDrcPd66jkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t5YBwDXq7+KjAYSW/hbibXwx2QK+QNoiap8B4ZxczoLj2pqF4DMmFHj4mEcYw97RF
	 6NTD0ULIqcNNwVXpRaL04uJpVixnCwh0BV/0xQrVujyWRGUwc+uCQGROj3bK2rjEGU
	 WmpUPmmunKgOXBFNGb63Sxwt+1ukh0vhKw9icqOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfECXwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfECXwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:52:54 -0400
Received: from localhost (lfbn-1-18355-218.w90-101.abo.wanadoo.fr [90.101.143.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14D69206C3;
        Fri,  3 May 2019 23:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556927572;
        bh=FRZu2uAXb3RBHRAKvIJgvp7yONkAmGJYfDrcPd66jkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrrJX3euKLhnPZ9oIp8ZozN2BIHM5PG/7NVqUCxINMH/y8XI6POZsAm2Kum4UzPjb
         w5WTdcyEP300e2Efe6wE1FHKik+Hfgonxzv6rJObO3DbS6ELM+t48yUs8848SeOSj7
         AgmVlQ3ky5eGb5smXFq3YpRbhayLjeK9R3U9MXVk=
Date:   Sat, 4 May 2019 01:52:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        npiggin@gmail.com, fweisbec@gmail.com, peterz@infradead.org,
        torvalds@linux-foundation.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/isolation: Require a present CPU in
 housekeeping mask
Message-ID: <20190503235248.GA19076@lenoir>
References: <20190411033448.20842-5-npiggin@gmail.com>
 <tip-9219565aa89033a9cfdae788c1940473a1253d6c@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-9219565aa89033a9cfdae788c1940473a1253d6c@git.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 10:47:37AM -0700, tip-bot for Nicholas Piggin wrote:
> Commit-ID:  9219565aa89033a9cfdae788c1940473a1253d6c
> Gitweb:     https://git.kernel.org/tip/9219565aa89033a9cfdae788c1940473a1253d6c
> Author:     Nicholas Piggin <npiggin@gmail.com>
> AuthorDate: Thu, 11 Apr 2019 13:34:47 +1000
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Fri, 3 May 2019 19:42:58 +0200
> 
> sched/isolation: Require a present CPU in housekeeping mask
> 
> During housekeeping mask setup, currently a possible CPU is required.
> That does not guarantee the CPU would be available at boot time, so
> check to ensure that at least one present CPU is in the mask.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Link: https://lkml.kernel.org/r/20190411033448.20842-5-npiggin@gmail.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/sched/isolation.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index b02d148e7672..687302051a27 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -65,6 +65,7 @@ void __init housekeeping_init(void)
>  static int __init housekeeping_setup(char *str, enum hk_flags flags)
>  {
>  	cpumask_var_t non_housekeeping_mask;
> +	cpumask_var_t tmp;
>  	int err;
>  
>  	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
> @@ -75,16 +76,23 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
>  		return 0;
>  	}
>  
> +	alloc_bootmem_cpumask_var(&tmp);
>  	if (!housekeeping_flags) {
>  		alloc_bootmem_cpumask_var(&housekeeping_mask);
>  		cpumask_andnot(housekeeping_mask,
>  			       cpu_possible_mask, non_housekeeping_mask);
> -		if (cpumask_empty(housekeeping_mask))
> +
> +		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
> +		if (cpumask_empty(tmp)) {
> +			pr_warn("Housekeeping: must include one present CPU, "
> +				"using boot CPU:%d\n", smp_processor_id());
>  			__cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
> +			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);

Ah that line (along with its twin below) is actually also a fix for the upstream code.
If the housekeeping mask is empty and we force the current one, we must make sure that
the current CPU is excluded from the nohz_full set. Ideally it should have come as a
separate patch but it's nice that you fixed it anyway.

Thanks!

Acked-by: Frederic Weisbecker <frederic@kernel.org>

> +		}
>  	} else {
> -		cpumask_var_t tmp;
> -
> -		alloc_bootmem_cpumask_var(&tmp);
> +		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
> +		if (cpumask_empty(tmp))
> +			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
>  		cpumask_andnot(tmp, cpu_possible_mask, non_housekeeping_mask);
>  		if (!cpumask_equal(tmp, housekeeping_mask)) {
>  			pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
> @@ -92,8 +100,8 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
>  			free_bootmem_cpumask_var(non_housekeeping_mask);
>  			return 0;
>  		}
> -		free_bootmem_cpumask_var(tmp);
>  	}
> +	free_bootmem_cpumask_var(tmp);
>  
>  	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
>  		if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
