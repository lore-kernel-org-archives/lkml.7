Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C17CC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA2520872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfDQEMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 00:12:55 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:57528 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfDQEMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 00:12:55 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 0B4F84403CA;
        Wed, 17 Apr 2019 07:12:52 +0300 (IDT)
Date:   Wed, 17 Apr 2019 07:12:50 +0300
From:   Baruch Siach <baruch@tkos.co.il>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: debug-ll: add default address for digicolor
Message-ID: <20190417041250.nbqy2ltjw77wlnts@tarshish>
References: <20190416131746.1303495-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416131746.1303495-1-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Apr 16, 2019 at 03:17:30PM +0200, Arnd Bergmann wrote:
> The digicolor platform has three UARTs, but the Kconfig.debug
> file explicitly lists port zero as the one to be used for the
> console, while not providing any default values.
> 
> This can get an automated randconfig build stuck in a loop
> waiting for the user to input the number. As we already know
> the physical address, this patch provides that number as
> default, along with a reasonable default value for the virtual
> address.
> 
> Cc: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig.debug | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index a8a1e14f20ab..e5f0b36d797f 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1676,6 +1676,7 @@ config DEBUG_UART_PHYS
>  	default 0xe6e68000 if DEBUG_RCAR_GEN2_SCIF1
>  	default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
>  	default 0xe8008000 if DEBUG_R7S72100_SCIF2
> +	default 0xf0000740 if DEBUG_DIGICOLOR_UA0

The addruart macro in arch/arm/include/debug/digicolor.S adds the 0x740 offset. 
So CONFIG_DEBUG_UART_PHYS should be 0xf0000000.

>  	default 0xf0000be0 if ARCH_EBSA110
>  	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
>  	default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
> @@ -1785,6 +1786,7 @@ config DEBUG_UART_VIRT
>  	default 0xfd012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_MV78XX0
>  	default 0xfd883000 if DEBUG_ALPINE_UART0
>  	default 0xfde12000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_DOVE
> +	default 0xfe000740 if DEBUG_DIGICOLOR_UA0

The value I used when testing used to be 0xf0100000.

>  	default 0xfe012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_ORION5X
>  	default 0xfe017000 if DEBUG_MMP_UART2
>  	default 0xfe018000 if DEBUG_MMP_UART3

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
