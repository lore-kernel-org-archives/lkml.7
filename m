Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ACDC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8877920881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="c4JFbjzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEOJ0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:26:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47568 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfEOJ0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:26:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 453q1C1rtYz9vDc8;
        Wed, 15 May 2019 11:26:07 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=c4JFbjzR; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1Uv3Awwze50y; Wed, 15 May 2019 11:26:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 453q1C0TlNz9vDc7;
        Wed, 15 May 2019 11:26:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557912367; bh=3qRNFOXkrkponxLfzGmEjoSRxN5kc1zj/UiLZP1QB8Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c4JFbjzRxT7TGL7+nB5rqpyUQRiyXqf/27PlDer9jVEZnqqGKWqvy49aA7/bWJcNy
         58RDcE9gRAImFqhpJvA2pjjE7c11hb3wx8OxM5aLCys2ozH1BIFJFazMgXgeQINwVU
         U8uooYdTdm7qVGbyGgLGLIlxo+e8C6QIlM4aSd+o=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E6BF8B8F9;
        Wed, 15 May 2019 11:26:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RCvOx4aCNG0I; Wed, 15 May 2019 11:26:08 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD35F8B8F7;
        Wed, 15 May 2019 11:26:07 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Remove double free
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190515090750.30647-1-tobin@kernel.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <aa001c3b-f96e-2078-0861-315613ec33a0@c-s.fr>
Date:   Wed, 15 May 2019 11:26:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515090750.30647-1-tobin@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_put() released index_dir->kobj

but who will release 'index' ?

Christophe

Le 15/05/2019 à 11:07, Tobin C. Harding a écrit :
> kfree() after kobject_put().  Who ever wrote this was on crack.
> 
> Fixes: 7e8039795a80 ("powerpc/cacheinfo: Fix kobject memleak")
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
> 
> FTR
> 
> git log --pretty=format:"%h%x09%an%x09%ad%x09%s" | grep 7e8039795a80
> 7e8039795a80	Tobin C. Harding	Tue Apr 30 11:09:23 2019 +1000	powerpc/cacheinfo: Fix kobject memleak
> 
>   arch/powerpc/kernel/cacheinfo.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
> index f2ed3ef4b129..862e2890bd3d 100644
> --- a/arch/powerpc/kernel/cacheinfo.c
> +++ b/arch/powerpc/kernel/cacheinfo.c
> @@ -767,7 +767,6 @@ static void cacheinfo_create_index_dir(struct cache *cache, int index,
>   				  cache_dir->kobj, "index%d", index);
>   	if (rc) {
>   		kobject_put(&index_dir->kobj);
> -		kfree(index_dir);
>   		return;
>   	}
>   
> 
