Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382C0C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092D020740
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfLZVVb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:21:31 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:43362 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfLZVVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:21:30 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47kNDm5XNmz9vK4M;
        Thu, 26 Dec 2019 22:21:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jeNv5bw7Fs1z; Thu, 26 Dec 2019 22:21:28 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47kNDm4H21z9vK4L;
        Thu, 26 Dec 2019 22:21:28 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 1F68B605; Thu, 26 Dec 2019 22:22:02 +0100 (CET)
Received: from 37-165-97-118.coucou-networks.fr
 (37-165-97-118.coucou-networks.fr [37.165.97.118]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Thu, 26 Dec 2019 22:22:02 +0100
Date:   Thu, 26 Dec 2019 22:22:02 +0100
Message-ID: <20191226222202.Horde.0xaecj7x1FoNwm4fHxlH0Q2@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [PATCH -next] powerpc/pmac/smp: Fix old-style declaration
In-Reply-To: <20191225114943.17216-1-yuehaibing@huawei.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> a écrit :

> There expect the 'static' keyword to come first in a declaration
>
> arch/powerpc/platforms/powermac/smp.c:664:1: warning: static is not  
> at beginning of declaration [-Wold-style-declaration]
> arch/powerpc/platforms/powermac/smp.c:665:1: warning: static is not  
> at beginning of declaration [-Wold-style-declaration]
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/powerpc/platforms/powermac/smp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powermac/smp.c  
> b/arch/powerpc/platforms/powermac/smp.c
> index f95fbde..7233b85 100644
> --- a/arch/powerpc/platforms/powermac/smp.c
> +++ b/arch/powerpc/platforms/powermac/smp.c
> @@ -661,8 +661,8 @@ static void smp_core99_gpio_tb_freeze(int freeze)
>  #endif /* !CONFIG_PPC64 */
>
>  /* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
> -volatile static long int core99_l2_cache;
> -volatile static long int core99_l3_cache;
> +static volatile long int core99_l2_cache;
> +static volatile long int core99_l3_cache;

Is it correct to declare it as volatile ?

See  
https://www.kernel.org/doc/html/latest/process/volatile-considered-harmful.html

Christophe

