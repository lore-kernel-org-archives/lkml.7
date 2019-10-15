Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39882ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A84420873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571156647;
	bh=+3bA41N9zG3Na8eiZmgyqf6wPpM7u7VDlcQ7i85yw3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yCX4YJOTsaiMyMoJ33uqNgjT9VWBnTNlZTnxOqwybdHnPclxwxWZyrdmp73vL8Kzs
	 wD+Xed/jplVvz+0NB/XHYV3OPvnLOFu3bHNYFRKzrOK7HlpM5HdKJKpVd6hbyTautu
	 QALG3ZJiQpueoJQIU1Rqim4m0iBHY0EaWbGXvJEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbfJOQYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfJOQYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:24:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81B3F2086A;
        Tue, 15 Oct 2019 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571156644;
        bh=+3bA41N9zG3Na8eiZmgyqf6wPpM7u7VDlcQ7i85yw3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=StYJMA5/BLxta6Bq7ntiXfwvCAGN+ItksqqushdPMj8/N5YyCsnDGO0W16VHdpGB0
         IxG4cxi6wDfDKCaXcI8oBfLjDBrt6KHc8VekcXdhf8yBRzt7ba+Z1BuhDx6bOHJUOo
         GMMMTfPhgpPP4m43Rut46SbGtc+mKa19vvgUyeJ0=
Date:   Tue, 15 Oct 2019 17:23:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>, sudeep.holla@arm.com
Cc:     David Laight <David.Laight@ACULAB.COM>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wuyun.wu@huawei.com" <wuyun.wu@huawei.com>
Subject: Re: [PATCH V2] arm64: psci: Reduce waiting time of
 cpu_psci_cpu_kill()
Message-ID: <20191015162358.bt5rffidkv2j4xqb@willie-the-truck>
References: <18068756-0f39-6388-3290-cf03746e767d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18068756-0f39-6388-3290-cf03746e767d@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Sep 21, 2019 at 07:21:17PM +0800, Yunfeng Ye wrote:
> If psci_ops.affinity_info() fails, it will sleep 10ms, which will not
> take so long in the right case. Use usleep_range() instead of msleep(),
> reduce the waiting time, and give a chance to busy wait before sleep.

Can you elaborate on "the right case" please? It's not clear to me
exactly what problem you're solving here.

I've also added Sudeep to the thread, since I'd like his ack on the change.

Will

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
> -	}
> +		/* busy-wait max 1ms */
> +		if (i++ < 100) {
> +			cond_resched();
> +			udelay(10);
> +			continue;
> +		}
> +
> +		usleep_range(100, 1000);
> +	} while (time_before(jiffies, timeout));
> 
>  	pr_warn("CPU%d may not have shut down cleanly (AFFINITY_INFO reports %d)\n",
>  			cpu, err);
> -- 
> 2.7.4.huawei.3
> 
