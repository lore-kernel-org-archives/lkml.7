Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA380C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A35C22500
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ib9TrnUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfI3Uxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:53:51 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55610 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbfI3Uxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eeuwhcBg0/unot9yWRfZ0iTRvvETLH1N0h7aGRGzozM=; b=Ib9TrnUBuSEP/SHSV5oxODafF
        zAF9LlKsABuY/ZLU9bFCCprcSYkNYQAO/x11zo9yhH8mNZUkjYmE5+duixfEiFscs5YTVenyV4a7t
        J9OFOTFiPlSfzB/8QL58Ozm8fcyObEjAiV4MTcF6p9sgjdKdjTkyfDRiDrfHXUlCnc9RRUt1HRkEL
        eQOTvgtKNErEKXDaSIZ6aiThkDGM6cm99b45BgH2IAT7ATDCjdq9NJ2ySnnmpwxvDhoo2/ReJm0ws
        +EU2l4+M9nPkAOeJoZqVtg632ouEf2lUBXJKAEDXy+X3gBedYt0vg0Ehjx5eQwkfAruxxMPzyPCVo
        DnyoJ5YKg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:45960)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iEzoM-0005uI-Ud; Mon, 30 Sep 2019 18:50:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iEzoH-0007R6-5U; Mon, 30 Sep 2019 18:50:09 +0100
Date:   Mon, 30 Sep 2019 18:50:09 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>, linux-kernel@vger.kernel.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] ARM: fix __get_user_check() in case uaccess_* calls are
 not inlined
Message-ID: <20190930175009.GH25745@shell.armlinux.org.uk>
References: <20190930055925.25842-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930055925.25842-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 02:59:25PM +0900, Masahiro Yamada wrote:
> KernelCI reports that bcm2835_defconfig is no longer booting since
> commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> forcibly"):
> 
>   https://lkml.org/lkml/2019/9/26/825
> 
> I also received a regression report from Nicolas Saenz Julienne:
> 
>   https://lkml.org/lkml/2019/9/27/263
> 
> This problem has cropped up on arch/arm/config/bcm2835_defconfig
> because it enables CONFIG_CC_OPTIMIZE_FOR_SIZE. The compiler tends
> to prefer not inlining functions with -Os. I was able to reproduce
> it with other boards and defconfig files by manually enabling
> CONFIG_CC_OPTIMIZE_FOR_SIZE.
> 
> The __get_user_check() specifically uses r0, r1, r2 registers.
> So, uaccess_save_and_enable() and uaccess_restore() must be inlined
> in order to avoid those registers being overwritten in the callees.
> 
> Prior to commit 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING"), the 'inline' marker was always enough for
> inlining functions, except on x86.
> 
> Since that commit, all architectures can enable CONFIG_OPTIMIZE_INLINING.
> So, __always_inline is now the only guaranteed way of forcible inlining.
> 
> I want to keep as much compiler's freedom as possible about the inlining
> decision. So, I changed the function call order instead of adding
> __always_inline around.
> 
> Call uaccess_save_and_enable() before assigning the __p ("r0"), and
> uaccess_restore() after evacuating the __e ("r0").
> 
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/include/asm/uaccess.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index 303248e5b990..559f252d7e3c 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -191,11 +191,12 @@ extern int __get_user_64t_4(void *);
>  #define __get_user_check(x, p)						\
>  	({								\
>  		unsigned long __limit = current_thread_info()->addr_limit - 1; \
> +		unsigned int __ua_flags = uaccess_save_and_enable();	\

If the compiler is moving uaccess_save_and_enable(), that's something
we really don't want - the idea is to _minimise_ the number of kernel
memory accesses between enabling userspace access and performing the
actual access.

Fixing it in this way widens the window for the kernel to be doing
something it shoulding in userspace.

So, the right solution is to ensure that the compiler always inlines
the uaccess_*() helpers - which should be nothing more than four
instructions for uaccess_save_and_enable() and two for the
restore.

I.O.W. it should look something like this:

     144:       ee134f10        mrc     15, 0, r4, cr3, cr0, {0}
     148:       e3c4200c        bic     r2, r4, #12
     14c:       e24e1001        sub     r1, lr, #1
     150:       e3822004        orr     r2, r2, #4
     154:       ee032f10        mcr     15, 0, r2, cr3, cr0, {0}
     158:       f57ff06f        isb     sy
     15c:       ebfffffe        bl      0 <__get_user_4>
     160:       ee034f10        mcr     15, 0, r4, cr3, cr0, {0}
     164:       f57ff06f        isb     sy

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
