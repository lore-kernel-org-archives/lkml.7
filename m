Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50091C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B43208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pAu/wPwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfFUH5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 03:57:42 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37362 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFUH5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 03:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1c5gL1nvNHdHQ5BkpLdgJdzuOwoAU/kbh+UdoysTyXM=; b=pAu/wPwQ/la+CpsmO0Um0wwWL
        MEJh1NFiNDmqiSzyVJWg9d305xmNqaHFsPj4UswwuyIGxOBO89gneWJeATAM6I3vDLzJPJi6i9pfM
        ZDuSssM/NtoWzXqBEcFkSzqYACyj4rl6nRXfQrvBEI/YP7fcVgyp9cNIiwlo2jHpwKddkFlplNe+N
        /jSnVzNV75x3KIrljhpMGmfAx9P29U3UlH1pElOvJkLEw1PK2Is3/IzXk0AZq4WeHaBNFLEu8Ehxq
        v4myVYpdpQZ3uENoFIlpUUzDr9CjnWvWu+nPa/VQ9wDC8oU2VQesEnJjTCTk+iX9K26D1bMoAcDeB
        g8AXpfLaw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:58940)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1heEQQ-0003oX-Eh; Fri, 21 Jun 2019 08:57:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1heEQN-00035c-5P; Fri, 21 Jun 2019 08:57:31 +0100
Date:   Fri, 21 Jun 2019 08:57:31 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [PATCH v2 2/2] ARM: smp: Moved cpu_logical_map[] to smp.h
Message-ID: <20190621075730.nubg7657nwlkmmmk@shell.armlinux.org.uk>
References: <20190603231830.24129-1-f.fainelli@gmail.com>
 <20190603231830.24129-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603231830.24129-3-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:18:30PM -0700, Florian Fainelli wrote:
> asm/smp.h is included by linux/smp.h and some drivers, in particular
> irqchip drivers can access cpu_logical_map[] in order to perform SMP
> affinity tasks. Make arm64 consistent with other architectures here.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

I merged this last night, and it causes ojn's builder to fail 98
defconfigs with errors like:

arch/arm/include/asm/smp_plat.h:79:7: error: implicit declaration of function 'cpu_logical_map' [-Werror=implicit-function-declaration]
arch/arm/kernel/setup.c:594:21: error: lvalue required as left operand of assignment
arch/arm/kernel/setup.c:596:22: error: lvalue required as left operand of assignment

Dropping this patch.

Also, you may wish to make the patch description refer to the correct
architecture.

> ---
>  arch/arm/include/asm/smp.h      | 6 ++++++
>  arch/arm/include/asm/smp_plat.h | 5 -----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
> index 451ae684aaf4..112d78e82f35 100644
> --- a/arch/arm/include/asm/smp.h
> +++ b/arch/arm/include/asm/smp.h
> @@ -20,6 +20,12 @@
>  
>  #define raw_smp_processor_id() (current_thread_info()->cpu)
>  
> +/*
> + * Logical CPU mapping.
> + */
> +extern u32 __cpu_logical_map[];
> +#define cpu_logical_map(cpu)	__cpu_logical_map[cpu]
> +
>  struct seq_file;
>  
>  /*
> diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
> index f2c36acf9886..ca6b91d400cf 100644
> --- a/arch/arm/include/asm/smp_plat.h
> +++ b/arch/arm/include/asm/smp_plat.h
> @@ -66,11 +66,6 @@ static inline int cache_ops_need_broadcast(void)
>  }
>  #endif
>  
> -/*
> - * Logical CPU mapping.
> - */
> -extern u32 __cpu_logical_map[];
> -#define cpu_logical_map(cpu)	__cpu_logical_map[cpu]
>  /*
>   * Retrieve logical cpu index corresponding to a given MPIDR[23:0]
>   *  - mpidr: MPIDR[23:0] to be used for the look-up
> -- 
> 2.17.1
> 
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
