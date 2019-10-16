Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF44CFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD2720854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404984AbfJPPcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:32:31 -0400
Received: from foss.arm.com ([217.140.110.172]:43458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfJPPcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:32:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47089142F;
        Wed, 16 Oct 2019 08:32:30 -0700 (PDT)
Received: from bogus (unknown [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86B693F68E;
        Wed, 16 Oct 2019 08:32:28 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:32:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wuyun.wu@huawei.com" <wuyun.wu@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V2] arm64: psci: Reduce waiting time of
 cpu_psci_cpu_kill()
Message-ID: <20191016153221.GA8978@bogus>
References: <18068756-0f39-6388-3290-cf03746e767d@huawei.com>
 <9df267db-e647-a81d-16bb-b8bfb06c2624@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df267db-e647-a81d-16bb-b8bfb06c2624@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 12:45:16PM +0800, Yunfeng Ye wrote:
> If psci_ops.affinity_info() fails, it will sleep 10ms, which will not
> take so long in the right case. Use usleep_range() instead of msleep(),
> reduce the waiting time, and give a chance to busy wait before sleep.
>
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
> V1->V2:
> - use usleep_range() instead of udelay() after waiting for a while
>
>  arch/arm64/kernel/psci.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index c9f72b2..99b3122 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -82,6 +82,7 @@ static void cpu_psci_cpu_die(unsigned int cpu)
>  static int cpu_psci_cpu_kill(unsigned int cpu)
>  {
>  	int err, i;
> +	unsigned long timeout;
>
>  	if (!psci_ops.affinity_info)
>  		return 0;
> @@ -91,16 +92,24 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
>  	 * while it is dying. So, try again a few times.
>  	 */
>
> -	for (i = 0; i < 10; i++) {
> +	i = 0;
> +	timeout = jiffies + msecs_to_jiffies(100);
> +	do {
>  		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
>  		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
>  			pr_info("CPU%d killed.\n", cpu);
>  			return 0;
>  		}
>
> -		msleep(10);
> -		pr_info("Retrying again to check for CPU kill\n");

You dropped this message, any particular reason ?

> -	}
> +		/* busy-wait max 1ms */
> +		if (i++ < 100) {
> +			cond_resched();
> +			udelay(10);
> +			continue;

Why can't it be simple like loop of 100 * msleep(1) instead of loop of
10 * msleep(10). The above initial busy wait for 1 ms looks too much
optimised for your setup where it takes 50-500us, what if it take just
over 1 ms ?

We need more generic solution.

--
Regards,
Sudeep
