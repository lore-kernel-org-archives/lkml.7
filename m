Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C07C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3886205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cFsBO9Zs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfFRGuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:50:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7898 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfFRGuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:50:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45SdNQ5LxPz9v2hq;
        Tue, 18 Jun 2019 08:24:54 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=cFsBO9Zs; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rONjPKrv_eoG; Tue, 18 Jun 2019 08:24:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45SdNQ4J7Tz9v2hp;
        Tue, 18 Jun 2019 08:24:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560839094; bh=t8EkGCrHzuXsMOhfuoBqjBOp4EePACQOfRiTKQzo240=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cFsBO9ZsKYA6Rxu22NwSnfmVa4rWolVMT4MyHRVXUn1cxkA0aVhlqdmv9QVHxiu32
         Caam8qSl7zZ8sBIpLx3p3zs2JpEUNXUqhlWXVikc39OUEbtrjhcZJeijlHHaOUylYk
         ELYEzQ0F3erX2aXD4mYoICx28x5KH+hM2pjhnoCM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 95EFD8B86D;
        Tue, 18 Jun 2019 08:24:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LCs9YYj1ow45; Tue, 18 Jun 2019 08:24:54 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC5E08B78B;
        Tue, 18 Jun 2019 08:24:53 +0200 (CEST)
Subject: Re: [PATCH 3/5] Powerpc/hw-breakpoint: Refactor set_dawr()
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, naveen.n.rao@linux.vnet.ibm.com
References: <20190618042732.5582-1-ravi.bangoria@linux.ibm.com>
 <20190618042732.5582-4-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <36044d6d-d46f-8c7b-c597-0e5d156fd9db@c-s.fr>
Date:   Tue, 18 Jun 2019 08:24:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618042732.5582-4-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/06/2019 à 06:27, Ravi Bangoria a écrit :
> Remove unnecessary comments. Code itself is self explanatory.
> And, ISA already talks about MRD field. I Don't think we need
> to re-describe it.

In an RFC patch you may "don't think".
But in the final patch you need to make a decision and write it as such.

Ie, you should write: "We don't need to re-describe it."


> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/kernel/process.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index f0fbbf6a6a1f..f002d2ffff86 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -799,18 +799,11 @@ int set_dawr(struct arch_hw_breakpoint *brk)
>   
>   	dawr = brk->address;
>   
> -	dawrx  = (brk->type & (HW_BRK_TYPE_READ | HW_BRK_TYPE_WRITE)) \
> -		                   << (63 - 58); //* read/write bits */
> -	dawrx |= ((brk->type & (HW_BRK_TYPE_TRANSLATE)) >> 2) \
> -		                   << (63 - 59); //* translate */
> -	dawrx |= (brk->type & (HW_BRK_TYPE_PRIV_ALL)) \
> -		                   >> 3; //* PRIM bits */
> -	/* dawr length is stored in field MDR bits 48:53.  Matches range in
> -	   doublewords (64 bits) baised by -1 eg. 0b000000=1DW and
> -	   0b111111=64DW.
> -	   brk->len is in bytes.
> -	   This aligns up to double word size, shifts and does the bias.
> -	*/
> +	dawrx  = (brk->type & HW_BRK_TYPE_RDWR) << (63 - 58);
> +	dawrx |= ((brk->type & HW_BRK_TYPE_TRANSLATE) >> 2) << (63 - 59);
> +	dawrx |= (brk->type & HW_BRK_TYPE_PRIV_ALL) >> 3;
> +
> +	/* brk->len is in bytes. */
>   	mrd = ((brk->len + 7) >> 3) - 1;
>   	dawrx |= (mrd & 0x3f) << (63 - 53);
>   
> 
