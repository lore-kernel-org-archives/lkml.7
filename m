Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE69C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8813214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfDWRs7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:48:59 -0400
Received: from gloria.sntech.de ([185.11.138.130]:35440 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbfDWRs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:48:59 -0400
Received: from p57b772a1.dip0.t-ipconnect.de ([87.183.114.161] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hIzXK-0003tk-BP; Tue, 23 Apr 2019 19:48:54 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 07/15] ARM: rockchip: fix a leaked reference by adding missing of_node_put
Date:   Tue, 23 Apr 2019 19:48:53 +0200
Message-ID: <1645207.xa1a3A0MYx@phil>
In-Reply-To: <1551785646-46173-7-git-send-email-wen.yang99@zte.com.cn>
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn> <1551785646-46173-7-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry that this took so long to look at, but I think it needs a bit of
rework, see below:

Am Dienstag, 5. März 2019, 12:33:58 CEST schrieb Wen Yang:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-rockchip/pm.c:269:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 259, but without a corresponding object release within this function.
> ./arch/arm/mach-rockchip/pm.c:275:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 259, but without a corresponding object release within this function
> ./arch/arm/mach-rockchip/platsmp.c:280:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 271, but without a corresponding object release within this function.
> ./arch/arm/mach-rockchip/platsmp.c:284:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 271, but without a corresponding object release within this function.
> ./arch/arm/mach-rockchip/platsmp.c:288:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 271, but without a corresponding object release within this function.
> ./arch/arm/mach-rockchip/platsmp.c:302:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 293, but without a corresponding object release within this function.
> ./arch/arm/mach-rockchip/platsmp.c:250:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.
> ./arch/arm/mach-rockchip/platsmp.c:260:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.
> ./arch/arm/mach-rockchip/platsmp.c:263:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v2->v1: add a missing space between "adding" and "missing"
> 
>  arch/arm/mach-rockchip/platsmp.c | 12 ++++++++----
>  arch/arm/mach-rockchip/pm.c      | 11 ++++++-----
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
> index 51984a4..f93d64e 100644
> --- a/arch/arm/mach-rockchip/platsmp.c
> +++ b/arch/arm/mach-rockchip/platsmp.c
> @@ -277,19 +277,20 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
>  	sram_base_addr = of_iomap(node, 0);

just do the of_node_put here and drop the whole error gotos?
Because node in this case only holds the possible pointer to 

>  	if (!sram_base_addr) {
>  		pr_err("%s: could not map sram registers\n", __func__);
> -		return;
> +		goto out_put_node;
>  	}
>  
>  	if (has_pmu && rockchip_smp_prepare_pmu())
> -		return;
> +		goto out_put_node;
>  
>  	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
>  		if (rockchip_smp_prepare_sram(node))
> -			return;
> +			goto out_put_node;
>  
>  		/* enable the SCU power domain */
>  		pmu_set_power_domain(PMU_PWRDN_SCU, true);
>  
> +		of_node_put(node);
>  		node = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
>  		if (!node) {
>  			pr_err("%s: missing scu\n", __func__);
> @@ -299,7 +300,7 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
>  		scu_base_addr = of_iomap(node, 0);

similarly just put the scu node here?

>  		if (!scu_base_addr) {
>  			pr_err("%s: could not map scu registers\n", __func__);
> -			return;
> +			goto out_put_node;
>  		}
>  
>  		/*
> @@ -321,6 +322,9 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
>  	/* Make sure that all cores except the first are really off */
>  	for (i = 1; i < ncores; i++)
>  		pmu_set_power_domain(0 + i, false);
> +
> +out_put_node:
> +	of_node_put(node);
>  }
>  
>  static void __init rk3036_smp_prepare_cpus(unsigned int max_cpus)
> diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
> index 0592534..43a16c9 100644
> --- a/arch/arm/mach-rockchip/pm.c
> +++ b/arch/arm/mach-rockchip/pm.c
> @@ -266,25 +266,26 @@ static int rk3288_suspend_init(struct device_node *np)
>  	rk3288_bootram_base = of_iomap(sram_np, 0);
>  	if (!rk3288_bootram_base) {
>  		pr_err("%s: could not map bootram base\n", __func__);

just add a regular of_node_put here?

> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto out_put_node;
>  	}
>  
>  	ret = of_address_to_resource(sram_np, 0, &res);
>  	if (ret) {
>  		pr_err("%s: could not get bootram phy addr\n", __func__);

and here as well? Not having to follow gotos might improve readability
especially as after here the node isn't used anymore as indicated by the
already existing of_node_put below which should be kept.


Heiko

> -		return ret;
> +		goto out_put_node;
>  	}
>  	rk3288_bootram_phy = res.start;
>  
> -	of_node_put(sram_np);
> -
>  	rk3288_config_bootdata();
>  
>  	/* copy resume code and data to bootsram */
>  	memcpy(rk3288_bootram_base, rockchip_slp_cpu_resume,
>  	       rk3288_bootram_sz);
>  
> -	return 0;
> +out_put_node:
> +	of_node_put(sram_np);
> +	return ret;
>  }
>  
>  static const struct platform_suspend_ops rk3288_suspend_ops = {
> 




