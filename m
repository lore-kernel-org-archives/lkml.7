Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BA6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D1F20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="RenvFtDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfCYIum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:50:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5430 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729985AbfCYIul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:50:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44SSdl1kFQz9v0Yj;
        Mon, 25 Mar 2019 09:50:35 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=RenvFtDM; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UP11EXQHm3pD; Mon, 25 Mar 2019 09:50:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44SSdl0ZqTz9v0Yh;
        Mon, 25 Mar 2019 09:50:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553503835; bh=eUXXTPKBtmZnBbOIuM1qXfH1lS7OM5bWpi2af9aCZ+o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RenvFtDMIPG6pchf+IpUNAZNIBqsGB5ACfu0dhHlVPQaRA8v4zIiMORkVKAexzJaA
         IgysjsZQL48GS63uYjy7uRkIw+3Dql4S2gnOZemdlfduFeITHOOovN/khGSK+DRroh
         Rb44kSG6TOiQ9vZG25+Pk+iLjJLm7qduBoCQKhYQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 93DBA8B89C;
        Mon, 25 Mar 2019 09:50:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iHDVtVmwxPMH; Mon, 25 Mar 2019 09:50:39 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B90F8B74F;
        Mon, 25 Mar 2019 09:50:39 +0100 (CET)
Subject: Re: [PATCH v2] powerpc/8xx: fix possible object reference leak
To:     Peng Hao <peng.hao2@zte.com.cn>, vitb@kernel.crashing.org,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     Wen Yang <wen.yang99@zte.com.cn>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1553533919-75527-1-git-send-email-peng.hao2@zte.com.cn>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1846dc49-e691-cd24-2439-26d92f634036@c-s.fr>
Date:   Mon, 25 Mar 2019 09:50:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553533919-75527-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/03/2019 à 18:11, Peng Hao a écrit :
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
> Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> Cc: Vitaly Bordug <vitb@kernel.crashing.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/powerpc/platforms/8xx/pic.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
> index 8d5a25d..4453df6 100644
> --- a/arch/powerpc/platforms/8xx/pic.c
> +++ b/arch/powerpc/platforms/8xx/pic.c
> @@ -153,9 +153,7 @@ int mpc8xx_pic_init(void)
>   	if (mpc8xx_pic_host == NULL) {
>   		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
>   		ret = -ENOMEM;
> -		goto out;
>   	}
> -	return 0;
>   
>   out:
>   	of_node_put(np);
> 
