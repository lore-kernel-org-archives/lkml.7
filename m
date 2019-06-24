Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645A6C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446C020820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfFXK5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:57:40 -0400
Received: from foss.arm.com ([217.140.110.172]:46956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbfFXK5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:57:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CCEB2B;
        Mon, 24 Jun 2019 03:57:39 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F3063F718;
        Mon, 24 Jun 2019 03:57:38 -0700 (PDT)
Date:   Mon, 24 Jun 2019 11:57:36 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] kernel/isolation: Asset that a housekeeping CPU comes up
 at boot time
Message-ID: <20190624105729.3isejrp4455suxaz@e107158-lin.cambridge.arm.com>
References: <20190601113919.2678-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190601113919.2678-1-npiggin@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/19 21:39, Nicholas Piggin wrote:
> With the change to allow the boot CPU0 to be isolated, it is possible
> to specify command line options that result in no housekeeping CPU
> online at boot.
> 
> An 8 CPU system booted with "nohz_full=0-6 maxcpus=4", for example.
> 
> It is not easily possible at housekeeping init time to know all the
> various SMP options that will result in an invalid configuration, so
> this patch adds a sanity check after SMP init, to ensure that a
> housekeeping CPU has been onlined.
> 
> The panic is undesirable, but it's better than the alternative of an
> obscure non deterministic failure. The panic will reliably happen
> when advanced parameters are used incorrectly.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  kernel/sched/isolation.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 123ea07a3f3b..7b9e1e0d4ec3 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -63,6 +63,29 @@ void __init housekeeping_init(void)
>  	WARN_ON_ONCE(cpumask_empty(housekeeping_mask));
>  }
>  
> +static int __init housekeeping_verify_smp(void)
> +{
> +	int cpu;
> +
> +	/*
> +	 * Early housekeeping setup is done before CPUs come up, and there are
> +	 * a range of options scattered around that can restrict which CPUs
> +	 * come up. It is possible to pass in a combination of housekeeping
> +	 * and SMP arguments that result in housekeeping assigned to an
> +	 * offline CPU.
> +	 *
> +	 * Check that condition here after SMP comes up, and give a useful
> +	 * error message rather than an obscure non deterministic crash or
> +	 * hang later.
> +	 */
> +	for_each_online_cpu(cpu) {
> +		if (cpumask_test_cpu(cpu, housekeeping_mask))
> +			return 0;
> +	}
> +	panic("Housekeeping: nohz_full= or isolcpus= resulted in no online CPUs for housekeeping.\n");

I am hitting this panic when I boot my juno board.


I have CONFIG_CPU_ISOLATION=y but I don't pass nohuz_full nor isolcpus in the
commandline. I think what's going on is that housekeeping_setup() doesn't get
called and hence housekeeping_mask isn't initialized in my case, causing this
check to fail and trigger the panic.

The below seems to 'fix' it though not sure if it's the right way forward.
A revert obviously fixes it too but I doubt we want that :-)


diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 7b9e1e0d4ec3..a9ca8628c1a2 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -67,6 +67,9 @@ static int __init housekeeping_verify_smp(void)
 {
 	int cpu;
 
+	if (!housekeeping_flags)
+		return 0;
+
 	/*
 	 * Early housekeeping setup is done before CPUs come up, and there are
 	 * a range of options scattered around that can restrict which CPUs


Cheers

--
Qais Yousef


> +}
> +core_initcall(housekeeping_verify_smp);
> +
>  static int __init housekeeping_setup(char *str, enum hk_flags flags)
>  {
>  	cpumask_var_t non_housekeeping_mask;
> -- 
> 2.20.1
> 
