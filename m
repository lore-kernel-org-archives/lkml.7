Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B61C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50FF205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF0Gv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 02:51:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52473 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfF0Gv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 02:51:57 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgOG8-0003BK-Tv; Thu, 27 Jun 2019 08:51:53 +0200
Date:   Thu, 27 Jun 2019 08:51:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net
Subject: Re: [PATCH v3 6/7] x86/smpboot: introduce per-cpu variable for HT
 siblings
In-Reply-To: <20190627012919.4341-7-subhra.mazumdar@oracle.com>
Message-ID: <alpine.DEB.2.21.1906270844500.32342@nanos.tec.linutronix.de>
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com> <20190627012919.4341-7-subhra.mazumdar@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019, subhra mazumdar wrote:

> Introduce a per-cpu variable to keep the number of HT siblings of a cpu.
> This will be used for quick lookup in select_idle_cpu to determine the
> limits of search.

Why? The number of siblings is constant at least today unless you play
silly cpu hotplug games. A bit more justification for adding yet another
random storage would be appreciated.

> This patch does it only for x86.

# grep 'This patch' Documentation/process/submitting-patches.rst

IOW, we all know already that this is a patch and from the subject prefix
and the diffstat it's pretty obvious that this is x86 only.

So instead of documenting the obvious, please add proper context to justify
the change.
 
> +/* representing number of HT siblings of each CPU */
> +DEFINE_PER_CPU_READ_MOSTLY(unsigned int, cpumask_weight_sibling);
> +EXPORT_PER_CPU_SYMBOL(cpumask_weight_sibling);

Why does this need an export? No module has any reason to access this.

>  /* representing HT and core siblings of each logical CPU */
>  DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
>  EXPORT_PER_CPU_SYMBOL(cpu_core_map);
> @@ -520,6 +524,8 @@ void set_cpu_sibling_map(int cpu)
>  
>  	if (!has_mp) {
>  		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
> +		per_cpu(cpumask_weight_sibling, cpu) =
> +		    cpumask_weight(topology_sibling_cpumask(cpu));
>  		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
>  		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
>  		c->booted_cores = 1;
> @@ -529,8 +535,12 @@ void set_cpu_sibling_map(int cpu)
>  	for_each_cpu(i, cpu_sibling_setup_mask) {
>  		o = &cpu_data(i);
>  
> -		if ((i == cpu) || (has_smt && match_smt(c, o)))
> +		if ((i == cpu) || (has_smt && match_smt(c, o))) {
>  			link_mask(topology_sibling_cpumask, cpu, i);
> +			threads = cpumask_weight(topology_sibling_cpumask(cpu));
> +			per_cpu(cpumask_weight_sibling, cpu) = threads;
> +			per_cpu(cpumask_weight_sibling, i) = threads;

This only works for SMT=2, but fails to update the rest for SMT=4.

> @@ -1482,6 +1494,8 @@ static void remove_siblinginfo(int cpu)
>  
>  	for_each_cpu(sibling, topology_core_cpumask(cpu)) {
>  		cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
> +		per_cpu(cpumask_weight_sibling, sibling) =
> +		    cpumask_weight(topology_sibling_cpumask(sibling));

While remove does the right thing.

Thanks,

	tglx
