Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB5BC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB7620679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Dalae2Qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfHNMvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:51:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52932 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfHNMvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:51:31 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467qG837FDz9tyn7;
        Wed, 14 Aug 2019 14:51:28 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Dalae2Qt; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id eImdWDUz0azO; Wed, 14 Aug 2019 14:51:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467qG82236z9tyn6;
        Wed, 14 Aug 2019 14:51:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565787088; bh=mOCEMB2qdCSI10DBAqLVTT6XlR6gmRR0nFTEIlsddIY=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Dalae2Qt0Ch584GmST3PYos10MrE314GXj1HW1Ji6Ex9IvGzIm/lFnCg3WAmyy+CM
         veH5s5VTN7r8usrxVNU/3VzDzMhDGjHSwTzBfTQWbZZbjQ5Udh9q1hHa48TLwI1IdR
         Q3jvSYIQIwAbKBTA+oXde9fw4QpbU4wND00MMdLs=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CD54D8B7F7;
        Wed, 14 Aug 2019 14:51:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3NFi6Z7pSKLw; Wed, 14 Aug 2019 14:51:29 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ADECA8B761;
        Wed, 14 Aug 2019 14:51:29 +0200 (CEST)
Subject: Re: [PATCH 1/5] powerpc/ptdump: fix addresses display on PPC32
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <eb4d626514e22f85814830012642329018ef6af9.1565786091.git.christophe.leroy@c-s.fr>
Message-ID: <db36b9fe-e9f8-0007-ff87-03ac6ae87a8b@c-s.fr>
Date:   Wed, 14 Aug 2019 14:51:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eb4d626514e22f85814830012642329018ef6af9.1565786091.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

Le 14/08/2019 à 14:36, Christophe Leroy a écrit :
> Commit 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")
> wrongly changed KERN_VIRT_START from 0 to PAGE_OFFSET, leading to a
> shift in the displayed addresses.
> 
> Lets revert that change to resync walk_pagetables()'s addr val and
> pgd_t pointer for PPC32.
> 
> Fixes: 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")

Either this patch or patch 2 of the series has to go into fixes.

If you prefer next patch for fixes, then this one can be squashed into 
patch 3 which drops the PPC32 hacked definition of KERN_VIRT_START

Christophe

> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/mm/ptdump/ptdump.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
> index 6a88a9f585d4..3ad64fc11419 100644
> --- a/arch/powerpc/mm/ptdump/ptdump.c
> +++ b/arch/powerpc/mm/ptdump/ptdump.c
> @@ -27,7 +27,7 @@
>   #include "ptdump.h"
>   
>   #ifdef CONFIG_PPC32
> -#define KERN_VIRT_START	PAGE_OFFSET
> +#define KERN_VIRT_START	0
>   #endif
>   
>   /*
> 
