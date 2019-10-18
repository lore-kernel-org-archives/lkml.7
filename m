Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05521CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4FD222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633014AbfJRPVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:21:20 -0400
Received: from [217.140.110.172] ([217.140.110.172]:42406 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2389421AbfJRPVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:21:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDC3AC8F;
        Fri, 18 Oct 2019 08:20:59 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4DA3F718;
        Fri, 18 Oct 2019 08:20:57 -0700 (PDT)
Date:   Fri, 18 Oct 2019 16:20:52 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        lorenzo.pieralisi@arm.com, tglx@linutronix.de,
        David.Laight@ACULAB.COM, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com, wuyun.wu@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH v4] arm64: psci: Reduce the waiting time for
 cpu_psci_cpu_kill()
Message-ID: <20191018152052.GA10312@bogus>
References: <04ab51e4-bc08-8250-4e70-4c87c58c8ad0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ab51e4-bc08-8250-4e70-4c87c58c8ad0@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 08:46:37PM +0800, Yunfeng Ye wrote:
> In case like suspend-to-disk and uspend-to-ram, a large number of CPU

s/case/cases/
s/uspend-to-ram/suspend-to-ram/

> cores need to be shut down. At present, the CPU hotplug operation is
> serialised, and the CPU cores can only be shut down one by one. In this
> process, if PSCI affinity_info() does not return LEVEL_OFF quickly,
> cpu_psci_cpu_kill() needs to wait for 10ms. If hundreds of CPU cores
> need to be shut down, it will take a long time.
> 
> Normally, there is no need to wait 10ms in cpu_psci_cpu_kill(). So
> change the wait interval from 10 ms to max 1 ms and use usleep_range()
> instead of msleep() for more accurate timer.
> 
> In addition, reducing the time interval will increase the messages
> output, so remove the "Retry ..." message, instead, put the number of
> waiting times to the sucessful message.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
> v3 -> v4:
>  - using time_before(jiffies, timeout) to check
>  - update the comment as review suggest
> 
> v2 -> v3:
>  - update the comment
>  - remove the busy-wait logic, modify the loop logic and output message
> 
> v1 -> v2:
>  - use usleep_range() instead of udelay() after waiting for a while
>  arch/arm64/kernel/psci.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index c9f72b2665f1..77965c3ba477 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -81,7 +81,8 @@ static void cpu_psci_cpu_die(unsigned int cpu)
> 
>  static int cpu_psci_cpu_kill(unsigned int cpu)
>  {
> -	int err, i;
> +	int err, i = 0;
> +	unsigned long timeout;
> 
>  	if (!psci_ops.affinity_info)
>  		return 0;
> @@ -91,16 +92,17 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
>  	 * while it is dying. So, try again a few times.
>  	 */
> 
> -	for (i = 0; i < 10; i++) {
> +	timeout = jiffies + msecs_to_jiffies(100);
> +	do {
> +		i++;
>  		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
>  		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
> -			pr_info("CPU%d killed.\n", cpu);
> +			pr_info("CPU%d killed (polled %d times)\n", cpu, i);

We can even drop loop counter completely, track time and log that
instead of loop counter that doesn't give any indication without looking
into the code.

	start = jiffies, end = start + msecs_to_jiffies(100);
	do {
			....
			pr_info("CPU%d killed (polled %u ms)\n", cpu,
				jiffies_to_msecs(jiffies - start));
			....
	} while (time_before(jiffies, end));

Just my preference. Looks good otherwise.

--
Regards,
Sudeep

