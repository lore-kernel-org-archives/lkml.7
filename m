Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCEEC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A17208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfFQL6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:58:30 -0400
Received: from foss.arm.com ([217.140.110.172]:47056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfFQL6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:58:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ADBE344;
        Mon, 17 Jun 2019 04:58:29 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C95093F246;
        Mon, 17 Jun 2019 05:00:13 -0700 (PDT)
Date:   Mon, 17 Jun 2019 12:58:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux@arm.linux.org.uk, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH arm] Use common outgoing-CPU-notification code
Message-ID: <20190617115809.GA3767@lakrids.cambridge.arm.com>
References: <20190611192410.GA27930@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611192410.GA27930@linux.ibm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 12:24:10PM -0700, Paul E. McKenney wrote:
> This commit removes the open-coded CPU-offline notification with new
> common code.  In particular, this change avoids calling scheduler code
> using RCU from an offline CPU that RCU is ignoring.  This is a minimal
> change.  A more intrusive change might invoke the cpu_check_up_prepare()
> and cpu_set_state_online() functions at CPU-online time, which would
> allow onlining throw an error if the CPU did not go offline properly.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

On the assumption that Russell is ok with this, I think this should be
dropped into the ARM patch system [1].

Paul, are you familiar with that, or would you prefer that someone else
submits the patch there? I can do so if you'd like.

Thanks,
Mark.

[1] https://www.armlinux.org.uk/developer/patches/info.php

> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index ebc53804d57b..8687d619260f 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -267,15 +267,13 @@ int __cpu_disable(void)
>  	return 0;
>  }
>  
> -static DECLARE_COMPLETION(cpu_died);
> -
>  /*
>   * called on the thread which is asking for a CPU to be shutdown -
>   * waits until shutdown has completed, or it is timed out.
>   */
>  void __cpu_die(unsigned int cpu)
>  {
> -	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
> +	if (!cpu_wait_death(cpu, 5)) {
>  		pr_err("CPU%u: cpu didn't die\n", cpu);
>  		return;
>  	}
> @@ -322,7 +320,7 @@ void arch_cpu_idle_dead(void)
>  	 * this returns, power and/or clocks can be removed at any point
>  	 * from this CPU and its cache by platform_cpu_kill().
>  	 */
> -	complete(&cpu_died);
> +	(void)cpu_report_death();
>  
>  	/*
>  	 * Ensure that the cache lines associated with that completion are
> 
