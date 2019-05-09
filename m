Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F6AC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1684216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfEIJkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 05:40:52 -0400
Received: from foss.arm.com ([217.140.101.70]:36184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfEIJkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:40:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2805374;
        Thu,  9 May 2019 02:40:51 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2150C3F575;
        Thu,  9 May 2019 02:40:49 -0700 (PDT)
Date:   Thu, 9 May 2019 10:40:44 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     julien.thierry@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] kernel/panic: Use SYSTEM_RESET2 command for warm reset
Message-ID: <20190509094021.GA8239@e107155-lin>
References: <ce0b66f5d00e760f87ddeeacbc40b956@codeaurora.org>
 <1557366432-352469-1-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557366432-352469-1-git-send-email-psodagud@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 06:47:12PM -0700, Prasad Sodagudi wrote:
> Some platforms may need warm reboot support when kernel crashed
> for post mortem analysis instead of cold reboot. So use config
> CONFIG_WARM_REBOOT_ON_PANIC and SYSTEM_RESET2 psci command
> support for warm reset.
>

Please drop all the references to PSCI and SYSTEM_RESET2 including
in subject. This is more generic and PSCIv1.1 with SYSTEM_RESET2 can
make use of it.

> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> ---
>  kernel/panic.c    |  4 ++++
>  lib/Kconfig.debug | 10 ++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index c1fcaad..6ab6675 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -198,6 +198,10 @@ void panic(const char *fmt, ...)
>  
>  	console_verbose();
>  	bust_spinlocks(1);
> +#ifdef CONFIG_WARM_REBOOT_ON_PANIC
> +	/* Configure for warm reboot instead of cold reboot. */
> +	reboot_mode = REBOOT_WARM;
> +#endif
>  	va_start(args, fmt);
>  	len = vscnprintf(buf, sizeof(buf), fmt, args);
>  	va_end(args);
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d695ec1..2a727d8 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1000,6 +1000,16 @@ config PANIC_TIMEOUT
>  	  value n > 0 will wait n seconds before rebooting, while a timeout
>  	  value n < 0 will reboot immediately.
>  
> +config WARM_REBOOT_ON_PANIC
> +	bool "Warm reboot instead of cold reboot for panic"
> +	default n
> +	help
> +	  Some vendor platform may need warm reboot instead of cold reboot
> +	  for debugging. Before vendor specific power off driver is
> +	  probed, platform always gets cold reset. By setting Y here and
> +	  support for PSCI V1.1 is present from firmware, platform would
> +	  get warm reset instead of cold reset.
> +

Ditto here, drop PSCI reference. Since it's being pushed as generic
solution, expecting anyone reading this to understand what is this PSCI
makes no sense and may be even confusing.

--
Regards,
Sudeep

