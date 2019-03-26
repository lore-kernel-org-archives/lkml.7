Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8901DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B5720811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ImTSDzAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfCZGF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:05:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28315 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZGF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:05:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44T0wj6F6Mz9v24W;
        Tue, 26 Mar 2019 07:05:25 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ImTSDzAc; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id m8613gtAmuAq; Tue, 26 Mar 2019 07:05:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44T0wj4ttWz9v1Lc;
        Tue, 26 Mar 2019 07:05:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553580325; bh=s7rz+ZTrZk0iy9n7oZR5e17q+ZAS0q6r97WmT/cWfbQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ImTSDzAcpy/+8yz1nndpOtczJgIrTBU2Hdt4PK8pCDwIHdt57VRmT2Wgk3Rly/kpE
         0n+tw7SfI0TBpH/Sv6KnqUARCp5DGysHglIUtbtRcKCbzONUALCKjroP153L2TF5GG
         Yt0o+gem3KDU86WVpPGS+LSMJlh/XCudEoM+jpho=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 77F688B77C;
        Tue, 26 Mar 2019 07:05:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id a_0wNBFWpLlS; Tue, 26 Mar 2019 07:05:26 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EBAB58B74C;
        Tue, 26 Mar 2019 07:05:25 +0100 (CET)
Subject: Re: [PATCH v3] powerpc/8xx: fix possible object reference leak
To:     Peng Hao <peng.hao2@zte.com.cn>, vitb@kernel.crashing.org,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     Wen Yang <wen.yang99@zte.com.cn>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1553596191-78889-1-git-send-email-peng.hao2@zte.com.cn>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <747f819a-9b1a-55c9-c0cf-860c75e5855c@c-s.fr>
Date:   Tue, 26 Mar 2019 07:05:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553596191-78889-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/03/2019 à 11:29, Peng Hao a écrit :

Could you fix your clock or clock setup ?

This emails appears to have been sent today at 11:29 (Paris Time ie 
GMT+1) allthough it is only 7am at the time being.

Christophe

> From: Wen Yang <wen.yang99@zte.com.cn>
> 
> The call to of_find_compatible_node returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> irq_domain_add_linear also calls of_node_get to increase refcount,
> so irq_domain will not be affected when it is released.
> 
> Detected by coccinelle with the following warnings:
> ./arch/powerpc/platforms/8xx/pic.c:158:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 136, but without a corresponding object release within this function.
> 
> Fixes: a8db8cf0d894 ("irq_domain: Replace irq_alloc_host() with
> revmap-specific initializers")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Vitaly Bordug <vitb@kernel.crashing.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v3->v2: set ret to zero explicitly.
> v2->v1: add a Fixes tag.
> 
>   arch/powerpc/platforms/8xx/pic.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
> index 8d5a25d..9993998 100644
> --- a/arch/powerpc/platforms/8xx/pic.c
> +++ b/arch/powerpc/platforms/8xx/pic.c
> @@ -153,9 +153,9 @@ int mpc8xx_pic_init(void)
>   	if (mpc8xx_pic_host == NULL) {
>   		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
>   		ret = -ENOMEM;
> -		goto out;
>   	}
> -	return 0;
> +
> +	ret = 0;
>   
>   out:
>   	of_node_put(np);
> 
