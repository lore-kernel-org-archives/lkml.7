Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE39C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234AF20830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Jjd/dda7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDIOVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:21:24 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48178 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfDIOVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nO/dERlqScMjvLbUn94nxl6ati7SX2Q3nt7tRpK6SXM=; b=Jjd/dda75B5dbpQnOxkpYoFNo
        RVLxkNmV29YsdnRVjYw+CgOifjb/lo4h92OqxkuUtk/t+yQLukqIcsKpAg0AYahhtBJGXAO8bCA7F
        P8NW1XAxrzhByD6VdFlp2AgvdhfgoJ36dHfuZITawNjuIlGMNhqI4BiYUawy60v7ByFOdvIX/opwN
        TxkN37mhmI4lxc9MsZ9hdY4yTxqCD6z9PiwIK2XkcjXTGstnRwwThrFe0z9SnN2+IE4g/65JtwoOS
        dTCSOFsup+YE/7jBSdzJ8QSSacgZyVFiZbSlWtw+dE/BIudE9tB3LhfG2HyMk1krhH02FcoFD7gu7
        VqbLlC/1g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52036)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hDrcg-0007My-S9; Tue, 09 Apr 2019 15:21:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hDrce-0002H4-9x; Tue, 09 Apr 2019 15:21:12 +0100
Date:   Tue, 9 Apr 2019 15:21:12 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jinyoung Park <gt.jypark@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Ketan Patil <ketanp@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] arch: arm64: process: Unlock console after SMP
 stopped
Message-ID: <20190409142112.mcvzdxigjfxnzrb4@shell.armlinux.org.uk>
References: <CAMfhKb-PNYrEqc6S=AJKRvfwUU61x4La6dM-1EsxoCa69et6eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMfhKb-PNYrEqc6S=AJKRvfwUU61x4La6dM-1EsxoCa69et6eQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:17:14PM +0900, Jinyoung Park wrote:
> If the console lock is held by other CPU running while the system is
> restarting or shutting down, the Kernel messages in the printk log buffer
> can not be printed out to the console drivers. The Kernel messages can be
> lost or messed up.
> This change calls console_unlock after SMP stopped to flush the kernel
> messages in the printk log buffer to the console drivers.

I think you need to explain how we can get to each of these points
while the current CPU is holding the console lock - and why this is
only an ARM64 problem (or why you are only fixing this on ARM64 and
not any of the other architectures.)

> 
> Signed-off-by: Jinyoung Park <jinyoungp@nvidia.com>
> ---
>  arch/arm64/kernel/process.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 3767fb21a5b8..d629a75c7602 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -49,6 +49,7 @@
>  #include <trace/events/power.h>
>  #include <linux/percpu.h>
>  #include <linux/thread_info.h>
> +#include <linux/console.h>
> 
>  #include <asm/alternative.h>
>  #include <asm/arch_gicv3.h>
> @@ -164,6 +165,7 @@ void machine_halt(void)
>  {
>   local_irq_disable();
>   smp_send_stop();
> + console_unlock();
>   while (1);
>  }
> 
> @@ -177,6 +179,7 @@ void machine_power_off(void)
>  {
>   local_irq_disable();
>   smp_send_stop();
> + console_unlock();
>   if (pm_power_off)
>   pm_power_off();
>  }
> @@ -195,6 +198,7 @@ void machine_restart(char *cmd)
>   /* Disable interrupts first */
>   local_irq_disable();
>   smp_send_stop();
> + console_unlock();
> 
>   /*
>   * UpdateCapsule() depends on the system being reset via
> -- 
> 2.19.0
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
