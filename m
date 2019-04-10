Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E312BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2902083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkobFuGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfDJKR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:17:56 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43853 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbfDJKRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:17:55 -0400
Received: by mail-yb1-f195.google.com with SMTP id d20so586350ybm.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtieiXoddZbmYVaCrf6tlGPQByx88qja12G5NglVOGY=;
        b=HkobFuGZEKCT2MvXUUFw1NhEC3SV9kEDvICKaJVsevmoWKnXfGh6x7vlNDyelwC3qJ
         U3Y1Jzwm4Tda38ori4gVG5+qwUFdkAE1ndWoUQ9N9MKSWUq7z+ikBG1E+YbcTnE/KzbG
         sQtW2MlRJ1NC4OAHagnpSOXOGKlLHmZJNrYCuVjlF5RgHuWwrY/WCrWAAMerpG8KsTgi
         EHVVf3yAa9y9+9ruBio26DidjlkGia4bfdVmpDSnCsPdRPTuQdtOGXxpik5aooqWXK1l
         U2jk5jd4ErO2g0qFRVBRFN1qfW6SrMHihNuOE4gKbM2dLoYPwiYhxnIL30B/1QZP0eg2
         3c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtieiXoddZbmYVaCrf6tlGPQByx88qja12G5NglVOGY=;
        b=V9GaG8g+UWyf0q2M5XFuknX6FEvqsFQUy9SQ2PimPRP+RIxS9b2nxIvS1/Q+CfMFV/
         dbJUGlsg+m1nsyGuJFQ3aXMZvQ80dovpMrxD1bW4o0UZ1Deo1Om8Xi5ii3ohiFSW1tAk
         DZFgyZFh9ChAza4bAVxorJMjJazUFyXbt+skYdneHtlpoVjBmBr+zUtq6EdImBJzl/Vd
         Kilva2jc647yDMbLYSvPZS1Tze6di8ZsRlZ67gX/2urbzP3lfR9sU2DLMm4fJBxMsFjU
         QLPN4X1972CLkQqoPMODHKtyAleEscFLKW/wkCpjf3RSbWQ4s+lAVw3lYsfa4oQ8RTKK
         ZnVg==
X-Gm-Message-State: APjAAAVZw95QrXnMj5PrqPV67PhRdNnbsXLKy+APGplPVCnkeBueRPsV
        jluKpjDIrdRfkMG5ag48ZTTnxmATOD37SABQg0E=
X-Google-Smtp-Source: APXvYqxembit50mS9ObUU2d+d2iqN9Z4fuYnZ8yLUEyxwSyGjOUYayAjGfKyr7FHxIDdJKR2pxYjo0wVAFMlK8Lgm90=
X-Received: by 2002:a25:c9c7:: with SMTP id z190mr34729588ybf.234.1554891473995;
 Wed, 10 Apr 2019 03:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <1554883239-12051-1-git-send-email-erwan.leray@st.com>
In-Reply-To: <1554883239-12051-1-git-send-email-erwan.leray@st.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 10 Apr 2019 12:19:38 +0200
Message-ID: <CAJiuCcd9884Kn2MAtLMzZpdSa-=xpCDKRLQSVC6NmRNC+YFtaA@mail.gmail.com>
Subject: Re: [PATCH] ARM: debug: stm32: add UART early console configuration
To:     Erwan Le Ray <erwan.leray@st.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Clement Peron <clement.peron@devialet.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Stefan Agner <stefan@agner.ch>,
        Biju Das <biju.das@bp.renesas.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Clement Peron <peron.clem@gmail.com>,
        Bich Hemon <bich.hemon@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 10 Apr 2019 at 10:03, Erwan Le Ray <erwan.leray@st.com> wrote:
>
> - This patch allows to configure UART instance for early console by setting
> physical and virtual base addresses.
> - This patch adds UART early console support for stm32h7 and stm32mp157c.

*Newbie kernel speaking*

I think this patch introduce at least 2, I will go for 3 modifications:
-Adding H7 Debug
-Adding MP1 debug
-(Fixing dependencies F4/F7)

With my little knowledge, I will separate this patch in 3.
Also try to have a commit log like this :
1) Explain What's wrong or is not present
2) Explain what you do in the patch

here you don't explain a lot what the issues are.

My 2cts on your patch, again newbie user here and I have post only few
patches but this is my sharing.

Thanks,
Clement

>
> Signed-off-by: Erwan Le Ray <erwan.leray@st.com>
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 6d6e033..4ea3e17 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1201,23 +1201,49 @@ choice
>
>         config STM32F4_DEBUG_UART
>                 bool "Use STM32F4 UART for low-level debug"
> -               depends on ARCH_STM32
> +               depends on MACH_STM32F429 || MACH_STM32F469
>                 select DEBUG_STM32_UART
>                 help
>                   Say Y here if you want kernel low-level debugging support
>                   on STM32F4 based platforms, which default UART is wired on
> -                 USART1.
> +                 USART1, but another UART instance can be selected by modifying
> +                 CONFIG_DEBUG_UART_PHYS.
>
>                   If unsure, say N.
>
>         config STM32F7_DEBUG_UART
>                 bool "Use STM32F7 UART for low-level debug"
> -               depends on ARCH_STM32
> +               depends on MACH_STM32F746 || MACH_STM32F769
>                 select DEBUG_STM32_UART
>                 help
>                   Say Y here if you want kernel low-level debugging support
>                   on STM32F7 based platforms, which default UART is wired on
> -                 USART1.
> +                 USART1, but another UART instance can be selected by modifying
> +                 CONFIG_DEBUG_UART_PHYS.
> +
> +                 If unsure, say N.
> +
> +       config STM32H7_DEBUG_UART
> +               bool "Use STM32H7 UART for low-level debug"
> +               depends on MACH_STM32H743
> +               select DEBUG_STM32_UART
> +               help
> +                 Say Y here if you want kernel low-level debugging support
> +                 on STM32H7 based platforms, which default UART is wired on
> +                 USART1, but another UART instance can be selected by modifying
> +                 CONFIG_DEBUG_UART_PHYS.
> +
> +                 If unsure, say N.
> +
> +       config STM32MP1_DEBUG_UART
> +               bool "Use STM32MP1 UART for low-level debug"
> +               depends on MACH_STM32MP157
> +               select DEBUG_STM32_UART
> +               help
> +                 Say Y here if you want kernel low-level debugging support
> +                 on STM32MP1 based platforms, wich default UART is wired on
> +                 UART4, but another UART instance can be selected by modifying
> +                 CONFIG_DEBUG_UART_PHYS and CONFIG_DEBUG_UART_VIRT.
>
>                   If unsure, say N.
>
> @@ -1622,6 +1648,9 @@ config DEBUG_UART_PHYS
>         default 0x3e000000 if DEBUG_BCM_KONA_UART
>         default 0x3f201000 if DEBUG_BCM2836
>         default 0x4000e400 if DEBUG_LL_UART_EFM32
> +       default 0x40010000 if STM32MP1_DEBUG_UART
> +       default 0x40011000 if STM32F4_DEBUG_UART || STM32F7_DEBUG_UART || \
> +                               STM32H7_DEBUG_UART
>         default 0x40028000 if DEBUG_AT91_SAMV7_USART1
>         default 0x40081000 if DEBUG_LPC18XX_UART0
>         default 0x40090000 if DEBUG_LPC32XX
> @@ -1716,7 +1745,7 @@ config DEBUG_UART_PHYS
>                 DEBUG_S3C64XX_UART || \
>                 DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
>                 DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
> -               DEBUG_AT91_UART
> +               DEBUG_AT91_UART || DEBUG_STM32_UART
>
>  config DEBUG_UART_VIRT
>         hex "Virtual base address of debug UART"
> @@ -1784,6 +1813,7 @@ config DEBUG_UART_VIRT
>         default 0xfd012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_MV78XX0
>         default 0xfd883000 if DEBUG_ALPINE_UART0
>         default 0xfde12000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_DOVE
> +       default 0xfe010000 if STM32MP1_DEBUG_UART
>         default 0xfe012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_ORION5X
>         default 0xfe017000 if DEBUG_MMP_UART2
>         default 0xfe018000 if DEBUG_MMP_UART3
> @@ -1832,7 +1862,7 @@ config DEBUG_UART_VIRT
>                 DEBUG_S3C64XX_UART || \
>                 DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
>                 DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
> -               DEBUG_AT91_UART
> +               DEBUG_AT91_UART || DEBUG_STM32_UART
>
>  config DEBUG_UART_8250_SHIFT
>         int "Register offset shift for the 8250 debug UART"
> diff --git a/arch/arm/include/debug/stm32.S b/arch/arm/include/debug/stm32.S
> index 1abb32f..6446e46 100644
> --- a/arch/arm/include/debug/stm32.S
> +++ b/arch/arm/include/debug/stm32.S
> @@ -4,14 +4,13 @@
>   * Author:   Gerald Baeza <gerald.baeza@st.com> for STMicroelectronics.
>   */
>
> -#define STM32_UART_BASE                        0x40011000      /* USART1 */
> -
>  #ifdef CONFIG_STM32F4_DEBUG_UART
>  #define STM32_USART_SR_OFF             0x00
>  #define STM32_USART_TDR_OFF            0x04
>  #endif
>
> -#ifdef CONFIG_STM32F7_DEBUG_UART
> +#if defined(CONFIG_STM32F7_DEBUG_UART) || (CONFIG_STM32H7_DEBUG_UART) || \
> +       defined(CONFIG_STM32MP1_DEBUG_UART)
>  #define STM32_USART_SR_OFF             0x1C
>  #define STM32_USART_TDR_OFF            0x28
>  #endif
> @@ -20,8 +19,8 @@
>  #define STM32_USART_TXE                        (1 << 7)        /* Tx data reg empty */
>
>  .macro addruart, rp, rv, tmp
> -       ldr     \rp,      =STM32_UART_BASE      @ physical base
> -       ldr     \rv,      =STM32_UART_BASE      @ virt base /* NoMMU */
> +       ldr     \rp, =CONFIG_DEBUG_UART_PHYS @ physical base
> +       ldr     \rv, =CONFIG_DEBUG_UART_VIRT @ virt base
>  .endm
>
>  .macro  senduart,rd,rx
> --
> 1.9.1
>
