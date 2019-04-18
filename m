Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A61C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEA4214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbfDRJcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:32:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58340 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfDRJcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:32:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC66015AB;
        Thu, 18 Apr 2019 02:32:06 -0700 (PDT)
Received: from [10.37.12.217] (unknown [10.37.12.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 003AB3F68F;
        Thu, 18 Apr 2019 02:32:04 -0700 (PDT)
Subject: Re: [PATCH] ARM: mach-shmobile: Don't configure ARCH timer if PSCI is
 enabled
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     horms@verge.net.au, magnus.damm@gmail.com, linux@armlinux.org.uk,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <1555521040-16706-1-git-send-email-olekstysh@gmail.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <1b33dca4-e3ae-4588-05f2-37b23ac8df78@arm.com>
Date:   Thu, 18 Apr 2019 10:32:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555521040-16706-1-git-send-email-olekstysh@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/17/19 6:10 PM, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> If CONFIG_PSCI is enabled then most likely we are running on
> PSCI-enabled U-Boot which, we assume, has already taken care of
> configuring ARCH timer stuff before switching to non-secure mode.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> ---
> A bit of context here...
> 
> We are highly interested in Renesas "Stout" board support (r8a7790)
> in Xen hypervisor. The reason is to have fully supported HW for
> performing "OSSTEST" (Xen automatic test system) on ARM32.
> 
> To reach that target we need a "generic way" for the secondary CPU cores
> bring up and switching them to non-secure hyp mode.
> So, the PSCI as a generic well-known way to bring up CPUs, was chosen
> for that purpose.
> 
> You can find corresponding patches for U-Boot here:
> http://u-boot.10912.n7.nabble.com/PATCH-0-3-PSCI-support-for-r8a7790-SoC-Lager-Stout-boards-td357352.html
> 
> You can find corresponding patches for Xen hypervisor here:
> https://www.mail-archive.com/xen-devel@lists.xenproject.org/msg43332.html
> 
> To sumarize:
> Together with enabling CONFIG_PSCI in shmobile_defconfig, current patch
> is a minimal required change needed to run mainline Linux on top of
> PSCI-enabled U-Boot.
> There is no need to modify device tree. U-Boot will take care of inserting
> proper "enable-method" strings in CPU nodes.
> 
> ---
>   arch/arm/mach-shmobile/setup-rcar-gen2.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> index eea60b2..bac4490 100644
> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> @@ -32,7 +32,7 @@ static const struct of_device_id cpg_matches[] __initconst = {
>   	{ /* sentinel */ }
>   };
>   
> -static unsigned int __init get_extal_freq(void)
> +static unsigned int __init __maybe_unused get_extal_freq(void)
>   {
>   	const struct of_device_id *match;
>   	struct device_node *cpg, *extal;
> @@ -60,6 +60,12 @@ static unsigned int __init get_extal_freq(void)
>   
>   void __init rcar_gen2_timer_init(void)
>   {
> +/*
> + * If CONFIG_PSCI is enabled then most likely we are running on PSCI-enabled
> + * U-Boot which, we assume, has already taken care of configuring ARCH timer
> + * stuff before switching to non-secure mode.
> + */

I disagree with that statement. CONFIG_ARM_PSCI may be selected in your 
.config for multiple reasons:
      - CONFIG_XEN will selected it
      - you build a .config targeting multiple platforms

Yet you may still want to boot the kernel on older U-boot. Such change 
would make it impossible.

If there are code that should not be called when PSCI is used, then you 
need to make sure the function is not called at runtime.

Cheers,

-- 
Julien Grall
