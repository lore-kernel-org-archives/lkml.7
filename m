Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF60C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F2A213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="j+7NkOIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfCLU4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:56:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36821 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfCLU4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:56:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44JnMT37Mpz9tyk3;
        Tue, 12 Mar 2019 21:56:37 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=j+7NkOIc; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZcMN-w2vrowR; Tue, 12 Mar 2019 21:56:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44JnMT228Hz9tyk2;
        Tue, 12 Mar 2019 21:56:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1552424197; bh=ma12Y6RsnhRzCTumhsFUFzmI7UYA2S9LBdNggvbgfh4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j+7NkOIcSOtL2Zr7m1ZKmqzCnx7pzpi7kQTqWvw7JcMF6x9Wfd3t1eGYLaRC4v9KI
         buY/zpWcVu2j2yef2WYcEuMXArRIjDS7tllj0Txwv4tx352klG5RLA/YY4pLK2gPzF
         ovkURbG7rdfgoABjJEMpMoeX0bAu7aBv/Wsw5W14=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 65D7B8B8B1;
        Tue, 12 Mar 2019 21:56:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YEhftJxJO-Tp; Tue, 12 Mar 2019 21:56:37 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EF75B8B8A7;
        Tue, 12 Mar 2019 21:56:36 +0100 (CET)
Subject: Re: [PATCH] powerpc: sstep: Mark variable `rc` as unused in function
 'analyse_instr'
To:     Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20190312202008.29681-1-malat@debian.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <57a0d93c-8784-d6af-a5fb-75e31455ae57@c-s.fr>
Date:   Tue, 12 Mar 2019 21:56:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190312202008.29681-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/03/2019 à 21:20, Mathieu Malaterre a écrit :
> Add gcc attribute unused for `rc` variable.
> 
> Fix warnings treated as errors with W=1:
> 
>    arch/powerpc/lib/sstep.c:1172:31: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/lib/sstep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 3d33fb509ef4..32d092f62ae0 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1169,7 +1169,7 @@ static nokprobe_inline int trap_compare(long v1, long v2)
>   int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>   		  unsigned int instr)
>   {
> -	unsigned int opcode, ra, rb, rc, rd, spr, u;
> +	unsigned int opcode, ra, rb, rc __maybe_unused, rd, spr, u;

I think it would be better to enclose 'rc' inside a #ifdef CONFIG_PPC64

Christophe

>   	unsigned long int imm;
>   	unsigned long int val, val2;
>   	unsigned int mb, me, sh;
> 
