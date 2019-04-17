Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CEEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064932173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbfDQRAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:00:12 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:57569 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732737AbfDQRAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:00:12 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id C80244406EA;
        Wed, 17 Apr 2019 20:00:10 +0300 (IDT)
References: <20190417151348.100050-1-arnd@arndb.de>
User-agent: mu4e 1.0; emacs 26.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: debug-ll: add default address for digicolor
In-reply-to: <20190417151348.100050-1-arnd@arndb.de>
Date:   Wed, 17 Apr 2019 20:00:10 +0300
Message-ID: <87y348h8it.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Apr 17 2019, Arnd Bergmann wrote:
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

Reviewed-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  arch/arm/Kconfig.debug | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index a8a1e14f20ab..3e33753bd60c 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1676,6 +1676,7 @@ config DEBUG_UART_PHYS
>  	default 0xe6e68000 if DEBUG_RCAR_GEN2_SCIF1
>  	default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
>  	default 0xe8008000 if DEBUG_R7S72100_SCIF2
> +	default 0xf0000000 if DEBUG_DIGICOLOR_UA0
>  	default 0xf0000be0 if ARCH_EBSA110
>  	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
>  	default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
> @@ -1728,6 +1729,7 @@ config DEBUG_UART_VIRT
>  	default 0xe0010fe0 if ARCH_RPC
>  	default 0xf0000be0 if ARCH_EBSA110
>  	default 0xf0010000 if DEBUG_ASM9260_UART
> +	default 0xf0100000 if DEBUG_DIGICOLOR_UA0
>  	default 0xf01fb000 if DEBUG_NOMADIK_UART
>  	default 0xf0201000 if DEBUG_BCM2835 || DEBUG_BCM2836
>  	default 0xf1000300 if DEBUG_BCM_5301X

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
