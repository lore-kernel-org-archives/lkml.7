Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C84C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6179206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="eW4f61P8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfG3HCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:02:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40655 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729303AbfG3HCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:02:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45ySDh686Mz9v4h1;
        Tue, 30 Jul 2019 09:02:44 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eW4f61P8; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QcEtw8KqWF5p; Tue, 30 Jul 2019 09:02:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45ySDh4cr1z9v4h0;
        Tue, 30 Jul 2019 09:02:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1564470164; bh=bWFtKsw+3UAAT5I5cI+YLfmPdp4W+J6fqe8KYjCREkI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eW4f61P8Noa8AZB3iSyf7Hb0Bt3dw3pzEADfkhidVc6H8KGeuP+TZhVbMVg06uPDP
         ejZE21GlJgmWv0nG3WGrhV2Cepz+HnJI1ib3XUhUsN4lLM65NybPMbBG54Cu49tcnC
         bTWz3kyR0MSOc2sLN4Pn1VoZZFyKJpl7pQauqBHI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D3768B7F3;
        Tue, 30 Jul 2019 09:02:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OXFoUiHJ8vv9; Tue, 30 Jul 2019 09:02:45 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 448228B74F;
        Tue, 30 Jul 2019 09:02:45 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Support CMDLINE_EXTEND
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190724053303.24317-1-chris.packham@alliedtelesis.co.nz>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <59674457-eda5-fe3b-65e0-29c20102fe4d@c-s.fr>
Date:   Tue, 30 Jul 2019 09:02:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724053303.24317-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/07/2019 à 07:33, Chris Packham a écrit :
> Device tree aware platforms can make use of CMDLINE_EXTEND to extend the
> kernel command line provided by the bootloader. This is particularly
> useful to set parameters for built-in modules that would otherwise be
> done at module insertion. Add support for this in the powerpc
> architecture.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>   arch/powerpc/Kconfig | 12 ++++++++++++

I think you also have to implement some stuff in early_cmdline_parse() 
in arch/powerpc/kernel/prom_init.c

Maybe look at https://patchwork.ozlabs.org/patch/1074126/

Christophe

>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d8dcd8820369..cd9b3974aa36 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -851,6 +851,11 @@ config CMDLINE
>   	  some command-line options at build time by entering them here.  In
>   	  most cases you will need to specify the root device here.
>   
> +choice
> +	prompt "Kernel command line type" if CMDLINE != ""
> +	default CMDLINE_FORCE
> +	depends on CMDLINE_BOOL
> +
>   config CMDLINE_FORCE
>   	bool "Always use the default kernel command string"
>   	depends on CMDLINE_BOOL
> @@ -860,6 +865,13 @@ config CMDLINE_FORCE
>   	  This is useful if you cannot or don't want to change the
>   	  command-line options your boot loader passes to the kernel.
>   
> +config CMDLINE_EXTEND
> +	bool "Extend bootloader kernel arguments"
> +	help
> +	  The command-line arguments provided by the boot loader will be
> +	  appended to the default kernel command string.
> +endchoice
> +
>   config EXTRA_TARGETS
>   	string "Additional default image types"
>   	help
> 
