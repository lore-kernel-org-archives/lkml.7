Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AE1C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09D22063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="rFQ6wPYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfFQVri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:47:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:65095 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfFQVri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:47:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45SPvX6TlFz9v2j5;
        Mon, 17 Jun 2019 23:47:36 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=rFQ6wPYm; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kfOc68UfSeIR; Mon, 17 Jun 2019 23:47:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45SPvX5J6hz9v2j4;
        Mon, 17 Jun 2019 23:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560808056; bh=ZZO4LfmpEKhCUXBijrOkaQcSAOYgGw2UTduyEJKqtUM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rFQ6wPYmQaExzXDJpuiuwF99J40FOd3hnE2uSehyW28k5885nTWUowJdEwZb/P5d4
         pbBu5Tjp/FYB046ADolt7U/U7qWYQYalbvkkoGof6+o3NdbtRi3HPYmJrOZ8UtiWPx
         95HrQPIJjHuHmOlx0hiK/+SInH+u1YZMgtadrHos=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EF6648B84D;
        Mon, 17 Jun 2019 23:47:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OwA-rgv9DTHK; Mon, 17 Jun 2019 23:47:36 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 50FEF8B7FF;
        Mon, 17 Jun 2019 23:47:36 +0200 (CEST)
Subject: Re: [PATCH] powerpc/mm/32s: fix condition that is always true
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
 <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
 <87muif52lv.fsf_-_@igel.home>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <58297c81-430b-d615-fa11-55136ae924f5@c-s.fr>
Date:   Mon, 17 Jun 2019 23:47:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <87muif52lv.fsf_-_@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/06/2019 à 23:22, Andreas Schwab a écrit :
> Move a misplaced paren that makes the condition always true.
> 
> Fixes: 63b2bc619565 ("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX")
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/mm/pgtable_32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index d53188dee18f..35cb96cfc258 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -360,7 +360,7 @@ void mark_initmem_nx(void)
>   	unsigned long numpages = PFN_UP((unsigned long)_einittext) -
>   				 PFN_DOWN((unsigned long)_sinittext);
>   
> -	if (v_block_mapped((unsigned long)_stext) + 1)
> +	if (v_block_mapped((unsigned long)_stext + 1))
>   		mmu_mark_initmem_nx();
>   	else
>   		change_page_attr(page, numpages, PAGE_KERNEL);
> 
