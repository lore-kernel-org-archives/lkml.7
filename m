Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C06C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3A1217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="b5czmhY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfEWGyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 02:54:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11636 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfEWGyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:54:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 458gGG31zHz9v2C7;
        Thu, 23 May 2019 08:54:14 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=b5czmhY9; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sXWhCKzIm3Ok; Thu, 23 May 2019 08:54:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 458gGG1rzGz9v2By;
        Thu, 23 May 2019 08:54:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1558594454; bh=s/0qOfM4Cscsf5U/dbKG8fcNN0atFD4/cWnRCbh6PDw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b5czmhY9iGhGsbJ03OHxeREVJn/XcniinN+G4e+jMw6pPxslXAhnaROXUbdNmE9G4
         6H0+/agMaD4yYwgse634XOE7NqC97NzZTRaQkWynmzxxehol/m3YiMmJ8DctmBdOb0
         WjlUUcptLeJ3FJxVCx28ObZj2ArEhcR7/CEOj3LE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 37B2C8B77D;
        Thu, 23 May 2019 08:54:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qsNF3mH3L8eW; Thu, 23 May 2019 08:54:15 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DF4478B75A;
        Thu, 23 May 2019 08:54:14 +0200 (CEST)
Subject: Re: [PATCH] powerpc/32s: Include <linux/moduleloader.h> header file
 to fix a warning
To:     Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20190523064956.29008-1-malat@debian.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <14b3a3c9-acbd-67b4-9187-912bb1be887f@c-s.fr>
Date:   Thu, 23 May 2019 08:54:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523064956.29008-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 23/05/2019 à 08:49, Mathieu Malaterre a écrit :
> In commit 2edb16efc899 ("powerpc/32: Add KASAN support") support for
> KASAN has been added. However building it as module leads to (warning
> treated as error with W=1):
> 
>    arch/powerpc/mm/kasan/kasan_init_32.c:135:7: error: no previous prototype for 'module_alloc' [-Werror=missing-prototypes]
> 
> Make sure to include <linux/moduleloader.h> to provide the following
> prototype: module_alloc.
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/mm/kasan/kasan_init_32.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
> index 0d62be3cba47..0c31e440d094 100644
> --- a/arch/powerpc/mm/kasan/kasan_init_32.c
> +++ b/arch/powerpc/mm/kasan/kasan_init_32.c
> @@ -7,6 +7,7 @@
>   #include <linux/memblock.h>
>   #include <linux/sched/task.h>
>   #include <linux/vmalloc.h>
> +#include <linux/moduleloader.h>
>   #include <asm/pgalloc.h>
>   #include <asm/code-patching.h>
>   #include <mm/mmu_decl.h>
> 
