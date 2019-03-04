Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3E3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120A7205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="swgzuo9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfCDO1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:27:41 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:42314 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfCDO1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:27:40 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Cj6F6R09z9v4wW;
        Mon,  4 Mar 2019 15:27:33 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=swgzuo9G; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IOOkahzk2WU8; Mon,  4 Mar 2019 15:27:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Cj6F56kSz9v1QP;
        Mon,  4 Mar 2019 15:27:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1551709653; bh=74npQgHLavCFiHbVDB4xQO10uiwkD3vrFd5Z1BDGDTw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=swgzuo9Gt81C1bPoiK3qAfhtSTv6UFhTVEw5RrCJH2tSsLCP9NOSQAe3Gg3xWTQjY
         JhOkykm6w+I0v9I+Zq5Kigjy0su/vJzt9T92iPDpsToRTQucB9N7Jo3GAUhbWzKcy2
         lhfyaP2ioJXlbcgVgKydoI1/MNwo3WJAdbQYeC9w=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F2DB48B84E;
        Mon,  4 Mar 2019 15:27:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AqeOoWAo4L8F; Mon,  4 Mar 2019 15:27:33 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A612C8B876;
        Mon,  4 Mar 2019 15:27:04 +0100 (CET)
Subject: Re: [PATCH 2/3] powerpc: convert to generic builtin command line
To:     Daniel Walker <danielwa@cisco.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     xe-linux-external@cisco.com, linux-kernel@vger.kernel.org,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        Daniel Walker <dwalker@fifo99.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
References: <1551469472-53043-3-git-send-email-danielwa@cisco.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e6dc6500-0e33-da0c-c975-0d9125e38c0e@c-s.fr>
Date:   Mon, 4 Mar 2019 15:26:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551469472-53043-3-git-send-email-danielwa@cisco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/03/2019 à 20:44, Daniel Walker a écrit :
> This updates the powerpc code to use the CONFIG_GENERIC_CMDLINE
> option.

Please explain more in details how each powerpc option is replaced by 
one of the generic options.

> 
> [maksym.kokhan@globallogic.com: add strlcat to prom_init_check.sh
> whitelist]
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Daniel Walker <danielwa@cisco.com>
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
> ---
>   arch/powerpc/Kconfig                   | 23 +----------------------
>   arch/powerpc/kernel/prom.c             |  4 ++++
>   arch/powerpc/kernel/prom_init.c        |  8 ++++----
>   arch/powerpc/kernel/prom_init_check.sh |  2 +-
>   4 files changed, 10 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8be31261aec8..6321b2a0b87b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -172,6 +172,7 @@ config PPC
>   	select GENERIC_STRNCPY_FROM_USER
>   	select GENERIC_STRNLEN_USER
>   	select GENERIC_TIME_VSYSCALL
> +	select GENERIC_CMDLINE
>   	select HAVE_ARCH_AUDITSYSCALL
>   	select HAVE_ARCH_JUMP_LABEL
>   	select HAVE_ARCH_KGDB
> @@ -777,28 +778,6 @@ config PPC_DENORMALISATION
>   	  Add support for handling denormalisation of single precision
>   	  values.  Useful for bare metal only.  If unsure say Y here.
>   
> -config CMDLINE_BOOL
> -	bool "Default bootloader kernel arguments"
> -
> -config CMDLINE
> -	string "Initial kernel command string"
> -	depends on CMDLINE_BOOL
> -	default "console=ttyS0,9600 console=tty0 root=/dev/sda2"
> -	help
> -	  On some platforms, there is currently no way for the boot loader to
> -	  pass arguments to the kernel. For these platforms, you can supply
> -	  some command-line options at build time by entering them here.  In
> -	  most cases you will need to specify the root device here.
> -
> -config CMDLINE_FORCE
> -	bool "Always use the default kernel command string"
> -	depends on CMDLINE_BOOL
> -	help
> -	  Always use the default kernel command string, even if the boot
> -	  loader passes other arguments to the kernel.
> -	  This is useful if you cannot or don't want to change the
> -	  command-line options your boot loader passes to the kernel.
> -
>   config EXTRA_TARGETS
>   	string "Additional default image types"
>   	help
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index fe758cedb93f..d78b1d6fe1c8 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -34,6 +34,7 @@
>   #include <linux/of_fdt.h>
>   #include <linux/libfdt.h>
>   #include <linux/cpu.h>
> +#include <linux/cmdline.h>
>   
>   #include <asm/prom.h>
>   #include <asm/rtas.h>
> @@ -716,6 +717,9 @@ void __init early_init_devtree(void *params)
>   	 */
>   	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
>   
> +	/* append and prepend any arguments built into the kernel. */
> +	cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);
> +

I don't think it is worth an implementation as complex as in the 
previous patch just for the above line.
Could easily define the temporary buffer in this file directely, then 
just locally do:

strlcpy(temp_buff, CONFIG_CMDLINE_PREPEND, COMMAND_LINE_SIZE);
strlcat(temp_buff, boot_command_line, COMMAND_LINE_SIZE);
strlcat(temp_buff, CONFIG_CMDLINE_APPEND, COMMAND_LINE_SIZE);
strlcpy(boot_command_line, temp_buff, COMMAND_LINE_SIZE);



>   	/* Scan memory nodes and rebuild MEMBLOCKs */
>   	of_scan_flat_dt(early_init_dt_scan_root, NULL);
>   	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index f33ff4163a51..e8e9fca22470 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -30,6 +30,7 @@
>   #include <linux/delay.h>
>   #include <linux/initrd.h>
>   #include <linux/bitops.h>
> +#include <linux/cmdline.h>
>   #include <asm/prom.h>
>   #include <asm/rtas.h>
>   #include <asm/page.h>
> @@ -637,11 +638,10 @@ static void __init early_cmdline_parse(void)
>   	p = prom_cmd_line;
>   	if ((long)prom.chosen > 0)
>   		l = prom_getprop(prom.chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
> -#ifdef CONFIG_CMDLINE
> +
>   	if (l <= 0 || p[0] == '\0') /* dbl check */
> -		strlcpy(prom_cmd_line,
> -			CONFIG_CMDLINE, sizeof(prom_cmd_line));
> -#endif /* CONFIG_CMDLINE */
> +		cmdline_add_builtin_section(prom_cmd_line, NULL, sizeof(prom_cmd_line), __prombss);
> +

You don't need something as complex as what your generic code does for 
that. It could be done with the following simple line:

strlcpy(prom_cmd_line, CONFIG_CMDLINE_PREPEND " " CONFIG_CMDLINE_APPEND, 
sizeof(prom_cmd_line));

>   	prom_printf("command line: %s\n", prom_cmd_line);
>   
>   #ifdef CONFIG_PPC64
> diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
> index 667df97d2595..ab2acc8d8b5a 100644
> --- a/arch/powerpc/kernel/prom_init_check.sh
> +++ b/arch/powerpc/kernel/prom_init_check.sh
> @@ -18,7 +18,7 @@
>   
>   WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
>   _end enter_prom memcpy memset reloc_offset __secondary_hold
> -__secondary_hold_acknowledge __secondary_hold_spinloop __start
> +__secondary_hold_acknowledge __secondary_hold_spinloop __start strlcat

The above is a big issue. In the scope of KASAN implementation, we are 
getting rid of generic string functions from prom_init because they are 
KASAN instrumented and that's far too early for prom_init. See series 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=94949 and 
especially patch [v9,03/11] powerpc/prom_init: don't use string 
functions from lib/

>   strcmp strcpy strlcpy strlen strncmp strstr kstrtobool logo_linux_clut224
>   reloc_got2 kernstart_addr memstart_addr linux_banner _stext
>   __prom_init_toc_start __prom_init_toc_end btext_setup_display TOC."
> 

Thanks
Christophe
