Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BF5C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A3F214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="CN1IqAJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbfG2LjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:39:01 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36427 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387467AbfG2LjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:39:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45xyPn5NCZz9v9Ll;
        Mon, 29 Jul 2019 13:38:53 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=CN1IqAJT; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id V-9LroEbPpfY; Mon, 29 Jul 2019 13:38:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45xyPn4HVzz9v9Lb;
        Mon, 29 Jul 2019 13:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1564400333; bh=nziOx+hsAmSgHaUew2nk7oKkm5bBxFcVZVeuZ8olOds=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CN1IqAJT5TRTGPGfzxV/ACgvbI3nuqf2174u4PWQd9Ase9/M+vHqjqmWnrCYoIbw6
         yE3FBsZeQZsCnTcqZazPFn2WiXxexkLpBBbomM3ozi46ukMJ3IxVZgdpmFES3H2pwh
         4ivVSPPMX9Pw+vXzT5OWKhHUUUl7ClwZhgNV8iHg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7776E8B7CE;
        Mon, 29 Jul 2019 13:38:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qcnZa5PhHJ3f; Mon, 29 Jul 2019 13:38:58 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 00C3E8B7B3;
        Mon, 29 Jul 2019 13:38:57 +0200 (CEST)
Subject: Re: [RFC PATCH 09/10] powerpc/fsl_booke/kaslr: support nokaslr
 cmdline parameter
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com
References: <20190717080621.40424-1-yanaijie@huawei.com>
 <20190717080621.40424-10-yanaijie@huawei.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e31851fd-5032-2787-ea36-c48a7a6ebbe9@c-s.fr>
Date:   Mon, 29 Jul 2019 13:38:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717080621.40424-10-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/07/2019 à 10:06, Jason Yan a écrit :
> One may want to disable kaslr when boot, so provide a cmdline parameter
> 'nokaslr' to support this.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>   arch/powerpc/kernel/kaslr_booke.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/kaslr_booke.c b/arch/powerpc/kernel/kaslr_booke.c
> index 00339c05879f..e65a5d9d2ff1 100644
> --- a/arch/powerpc/kernel/kaslr_booke.c
> +++ b/arch/powerpc/kernel/kaslr_booke.c
> @@ -373,6 +373,18 @@ static unsigned long __init kaslr_choose_location(void *dt_ptr, phys_addr_t size
>   	return kaslr_offset;
>   }
>   
> +static inline __init bool kaslr_disabled(void)
> +{
> +	char *str;
> +
> +	str = strstr(early_command_line, "nokaslr");

Why using early_command_line instead of boot_command_line ?


> +	if ((str == early_command_line) ||
> +	    (str > early_command_line && *(str - 1) == ' '))

Is that stuff really needed ?

Why not just:

return strstr(early_command_line, "nokaslr") != NULL;

> +		return true;
> +
> +	return false;
> +}


> +
>   /*
>    * To see if we need to relocate the kernel to a random offset
>    * void *dt_ptr - address of the device tree
> @@ -388,6 +400,8 @@ notrace void __init kaslr_early_init(void *dt_ptr, phys_addr_t size)
>   	kernel_sz = (unsigned long)_end - KERNELBASE;
>   
>   	kaslr_get_cmdline(dt_ptr);
> +	if (kaslr_disabled())
> +		return;
>   
>   	offset = kaslr_choose_location(dt_ptr, size, kernel_sz);
>   
> 

Christophe
