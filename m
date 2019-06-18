Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC05C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F00205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TKNZzGvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfFRGuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:50:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10503 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfFRGuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:50:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45SdK14Rfwz9vBJt;
        Tue, 18 Jun 2019 08:21:57 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TKNZzGvX; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KSmGm5VL72on; Tue, 18 Jun 2019 08:21:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45SdK13G6fz9vBJp;
        Tue, 18 Jun 2019 08:21:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560838917; bh=FCB7CdEBbBFcFNkuD3v6ni+zfUzz8NqMtrHA12Q714w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TKNZzGvXPy40kaL9LaUOHSsIwHMuZxENX96THuEAeEJRimn1kuU1dGmvPR3FDaC2W
         7Jt9nzVF8LwISZuxamxBPn4InCA1/e/hEO+sHFsgDydB+M6A285DccUC2R40a5SeyN
         e9Ibc5LkeplbAUMVNVKaZfFvrL0Gl9nkNuo8TnHo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6DA238B86C;
        Tue, 18 Jun 2019 08:21:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qbpbh5PAMYh3; Tue, 18 Jun 2019 08:21:57 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 78A5A8B78B;
        Tue, 18 Jun 2019 08:21:56 +0200 (CEST)
Subject: Re: [PATCH 2/5] Powerpc/hw-breakpoint: Refactor
 hw_breakpoint_arch_parse()
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, naveen.n.rao@linux.vnet.ibm.com
References: <20190618042732.5582-1-ravi.bangoria@linux.ibm.com>
 <20190618042732.5582-3-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <66e70f57-befa-f241-9476-8e06519bac90@c-s.fr>
Date:   Tue, 18 Jun 2019 08:21:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618042732.5582-3-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/06/2019 à 06:27, Ravi Bangoria a écrit :
> Move feature availability check at the start of the function.
> Rearrange comment to it's associated code. Use hw->address and
> hw->len in the 512 bytes boundary check(to write if statement
> in a single line). Add spacing between code blocks.

Are those cosmetic changes in the boundary check worth it since they 
disappear in the final patch ?

Christophe

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/kernel/hw_breakpoint.c | 34 +++++++++++++++--------------
>   1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 1908e4fcc132..36bcf705df65 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -133,10 +133,13 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>   			     const struct perf_event_attr *attr,
>   			     struct arch_hw_breakpoint *hw)
>   {
> -	int ret = -EINVAL, length_max;
> +	int length_max;
> +
> +	if (!ppc_breakpoint_available())
> +		return -ENODEV;
>   
>   	if (!bp)
> -		return ret;
> +		return -EINVAL;
>   
>   	hw->type = HW_BRK_TYPE_TRANSLATE;
>   	if (attr->bp_type & HW_BREAKPOINT_R)
> @@ -145,34 +148,33 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>   		hw->type |= HW_BRK_TYPE_WRITE;
>   	if (hw->type == HW_BRK_TYPE_TRANSLATE)
>   		/* must set alteast read or write */
> -		return ret;
> +		return -EINVAL;
> +
>   	if (!attr->exclude_user)
>   		hw->type |= HW_BRK_TYPE_USER;
>   	if (!attr->exclude_kernel)
>   		hw->type |= HW_BRK_TYPE_KERNEL;
>   	if (!attr->exclude_hv)
>   		hw->type |= HW_BRK_TYPE_HYP;
> +
>   	hw->address = attr->bp_addr;
>   	hw->len = attr->bp_len;
>   
> -	/*
> -	 * Since breakpoint length can be a maximum of HW_BREAKPOINT_LEN(8)
> -	 * and breakpoint addresses are aligned to nearest double-word
> -	 * HW_BREAKPOINT_ALIGN by rounding off to the lower address, the
> -	 * 'symbolsize' should satisfy the check below.
> -	 */
> -	if (!ppc_breakpoint_available())
> -		return -ENODEV;
>   	length_max = 8; /* DABR */
>   	if (dawr_enabled()) {
>   		length_max = 512 ; /* 64 doublewords */
> -		/* DAWR region can't cross 512 boundary */
> -		if ((attr->bp_addr >> 9) !=
> -		    ((attr->bp_addr + attr->bp_len - 1) >> 9))
> +		/* DAWR region can't cross 512 bytes boundary */
> +		if ((hw->address >> 9) != ((hw->address + hw->len - 1) >> 9))
>   			return -EINVAL;
>   	}
> -	if (hw->len >
> -	    (length_max - (hw->address & HW_BREAKPOINT_ALIGN)))
> +
> +	/*
> +	 * Since breakpoint length can be a maximum of length_max and
> +	 * breakpoint addresses are aligned to nearest double-word
> +	 * HW_BREAKPOINT_ALIGN by rounding off to the lower address,
> +	 * the 'symbolsize' should satisfy the check below.
> +	 */
> +	if (hw->len > (length_max - (hw->address & HW_BREAKPOINT_ALIGN)))
>   		return -EINVAL;
>   	return 0;
>   }
> 
