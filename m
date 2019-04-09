Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D4EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364C920830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDIOSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:18:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38968 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfDIOSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:18:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC69EA78;
        Tue,  9 Apr 2019 07:18:45 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B94653F68F;
        Tue,  9 Apr 2019 07:18:44 -0700 (PDT)
Date:   Tue, 9 Apr 2019 15:18:42 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jinyoung Park <gt.jypark@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Ketan Patil <ketanp@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arch: arm64: process: Unlock console after SMP
 stopped
Message-ID: <20190409141842.GF2990@fuggles.cambridge.arm.com>
References: <CAMfhKb-PNYrEqc6S=AJKRvfwUU61x4La6dM-1EsxoCa69et6eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMfhKb-PNYrEqc6S=AJKRvfwUU61x4La6dM-1EsxoCa69et6eQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
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

Hmm, why don't other architectures seem to do this?

Will
