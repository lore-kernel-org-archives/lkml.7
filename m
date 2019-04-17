Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E051DC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA7D21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfDQOSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:18:11 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:57562 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728335AbfDQOSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:18:11 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 6CE2B4406EA;
        Wed, 17 Apr 2019 17:18:08 +0300 (IDT)
References: <20190417125153.2510262-1-arnd@arndb.de>
User-agent: mu4e 1.0; emacs 26.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: debug-ll: add default address for digicolor
In-reply-to: <20190417125153.2510262-1-arnd@arndb.de>
Date:   Wed, 17 Apr 2019 17:18:08 +0300
Message-ID: <87zhoohg0v.fsf@tarshish>
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
> ---
> v2: fix physical address
>
>  arch/arm/Kconfig.debug | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 6d6e0330930b..12c0d29b75e3 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1677,6 +1677,7 @@ config DEBUG_UART_PHYS
>  	default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
>  	default 0xe8008000 if DEBUG_R7S72100_SCIF2
>  	default 0xf0000be0 if ARCH_EBSA110
> +	default 0xf0100000 if DEBUG_DIGICOLOR_UA0

Should be 0xf0000000 for the physical address.

>  	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
>  	default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
>  	default 0xf7fc9000 if DEBUG_BERLIN_UART
> @@ -1784,6 +1785,7 @@ config DEBUG_UART_VIRT
>  	default 0xfd012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_MV78XX0
>  	default 0xfd883000 if DEBUG_ALPINE_UART0
>  	default 0xfde12000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_DOVE
> +	default 0xfe000000 if DEBUG_DIGICOLOR_UA0

Maybe you intended to change the virtual address to 0xf0100000?

>  	DEFAULT 0xfe012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_ORION5X
>  	default 0xfe017000 if DEBUG_MMP_UART2
>  	default 0xfe018000 if DEBUG_MMP_UART3

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
