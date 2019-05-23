Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960F6C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CD52168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dDhplhtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfEWH07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:26:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47349 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729781AbfEWH05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:26:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 458gzy1zmFz9v23W;
        Thu, 23 May 2019 09:26:54 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dDhplhtn; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id r_mYKpjo8VNy; Thu, 23 May 2019 09:26:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 458gzy033Rz9v23V;
        Thu, 23 May 2019 09:26:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1558596414; bh=y0ndvATBuFeBuD1aCpeFBhYVI+2u7k6MGm7Va98zHq8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dDhplhtnXkzFY/ATEefKFa2nsAnGJkFilJI74ov27kmHlMUaYVqU2Yxn1PJggw1Vj
         FkFqdInH5+TEbZ+tQDPPc0vCpF9mximrMFysWuEUbDnaXQ7f06B4xd7JakVWPonEGa
         wdcYmuMjpWQyeXrTcfQbk+m6N0tQz5rFZ/nS/qV4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 032218B77D;
        Thu, 23 May 2019 09:26:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mYH4J9Ejz9ZD; Thu, 23 May 2019 09:26:54 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E6578B75A;
        Thu, 23 May 2019 09:26:54 +0200 (CEST)
Subject: Re: [PATCH] powerpc/powernv: fix variable "c" set but not used
To:     Qian Cai <cai@lca.pw>, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au
Cc:     aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20190523023141.2973-1-cai@lca.pw>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d0512822-ca22-75ec-3dd9-1024001632f5@c-s.fr>
Date:   Thu, 23 May 2019 09:26:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523023141.2973-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 23/05/2019 à 04:31, Qian Cai a écrit :
> The commit 58629c0dc349 ("powerpc/powernv/npu: Fault user page into the
> hypervisor's pagetable") introduced a variable "c" to be used in
> __get_user() and __get_user_nocheck() which need to stay as macros for
> performance reasons, and "c" is not actually used in
> pnv_npu2_handle_fault(),
> 
> arch/powerpc/platforms/powernv/npu-dma.c: In function 'pnv_npu2_handle_fault':
> arch/powerpc/platforms/powernv/npu-dma.c:1122:7: warning: variable 'c'
> set but not used [-Wunused-but-set-variable]
> 
> Fixed it by appending the __maybe_unused attribute, so compilers would
> ignore it.

You are not fixing the problem, you are just hiding it.

If the result of __get_user() is unneeded, it means __get_user() is not 
the good function to use.

Should use fault_in_pages_readable() instead.

A similar warning was fixed in commit 9f9eae5ce717 ("powerpc/kvm: Prefer 
fault_in_pages_readable function")

See 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/powerpc?id=9f9eae5ce

> 
> Signed-off-by: Qian Cai <cai@lca.pw>

You should add a Fixes: tag

58629c0dc349 ("powerpc/powernv/npu: Fault user page into the 
hypervisor's pagetable")

Christophe

> ---
>   arch/powerpc/platforms/powernv/npu-dma.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index 495550432f3d..5bbe59573ee6 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -1119,7 +1119,8 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
>   	int i, is_write;
>   	struct page *page[1];
>   	const char __user *u;
> -	char c;
> +	/* To silence a -Wunused-but-set-variable warning. */
> +	char c __maybe_unused;
>   
>   	/* mmap_sem should be held so the struct_mm must be present */
>   	struct mm_struct *mm = context->mm;
> 
