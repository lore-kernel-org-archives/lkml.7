Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CBDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13354222DC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfKSWVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:21:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54803 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfKSWV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:21:29 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iXBsA-0004OH-Pm; Tue, 19 Nov 2019 23:21:22 +0100
Date:   Tue, 19 Nov 2019 23:21:21 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@arm.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] ia64: Replace cpu_down with
 freeze_secondary_cpus
In-Reply-To: <20191030153837.18107-5-qais.yousef@arm.com>
Message-ID: <alpine.DEB.2.21.1911192318400.6731@nanos.tec.linutronix.de>
References: <20191030153837.18107-1-qais.yousef@arm.com> <20191030153837.18107-5-qais.yousef@arm.com>
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

On Wed, 30 Oct 2019, Qais Yousef wrote:

> Use freeze_secondary_cpus() instead of open coding using cpu_down()
> directly.
> 
> This also prepares to make cpu_up/down a private interface for anything
> but the cpu subsystem.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Tony Luck <tony.luck@intel.com>
> CC: Fenghua Yu <fenghua.yu@intel.com>
> CC: linux-ia64@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/ia64/kernel/process.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
> index 968b5f33e725..70b433eafa5c 100644
> --- a/arch/ia64/kernel/process.c
> +++ b/arch/ia64/kernel/process.c
> @@ -647,12 +647,8 @@ cpu_halt (void)
>  void machine_shutdown(void)
>  {
>  #ifdef CONFIG_HOTPLUG_CPU
> -	int cpu;
> -
> -	for_each_online_cpu(cpu) {
> -		if (cpu != smp_processor_id())
> -			cpu_down(cpu);
> -	}
> +	/* TODO: Can we use disable_nonboot_cpus()? */
> +	freeze_secondary_cpus(smp_processor_id());

freeze_secondary_cpus() is only available for CONFIG_PM_SLEEP_SMP=y and
disable_nonboot_cpus() is a NOOP for CONFIG_PM_SLEEP_SMP=n :)

Thanks,

	tglx

