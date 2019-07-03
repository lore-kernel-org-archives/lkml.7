Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7715EC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DA3218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Cc7c7iey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfGCNT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:19:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1735 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfGCNT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:19:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45f1sn4cdnz9v01x;
        Wed,  3 Jul 2019 15:19:25 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Cc7c7iey; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zOalVqxx5uRw; Wed,  3 Jul 2019 15:19:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45f1sn3b62z9v01w;
        Wed,  3 Jul 2019 15:19:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1562159965; bh=lh03SiMTXDB9kYjUCArwWbtvnoP0VQ3+8H0ObHrYEmA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cc7c7ieyDxvj43rPPEUjaRF+pbzbGG8S5qzI3a/7zaV43cnz3lPFtnnnH44KKNLpl
         4nk1r9qVOgaIOPQHXOVNsNe19+rKZCeoujEscx0NqZTukGD6NlZRvk+Tb1S1uhDA+5
         ohHyJfToeSWAaGEQjYorjyiAr2BM0m1f2FPZ9wrY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EC77C8B815;
        Wed,  3 Jul 2019 15:19:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ssm5YARw6vJA; Wed,  3 Jul 2019 15:19:26 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9DAF98B811;
        Wed,  3 Jul 2019 15:19:26 +0200 (CEST)
Subject: Re: [PATCH 02/30] powerpc: Use kmemdup rather than duplicating its
 implementation
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20190703131327.24762-1-huangfq.daxian@gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <80d073af-f7b5-6c9d-de51-110f14d15380@c-s.fr>
Date:   Wed, 3 Jul 2019 15:19:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703131327.24762-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/07/2019 à 15:13, Fuqian Huang a écrit :
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memset, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

s/memset/memcpy/

> 
> Add an allocation failure check.

Shouldn't this be in another patch ?

Christophe

> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>   arch/powerpc/platforms/pseries/dlpar.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 437a74173db2..20fe7b79e09e 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -383,9 +383,10 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog)
>   	struct pseries_hp_work *work;
>   	struct pseries_hp_errorlog *hp_errlog_copy;
>   
> -	hp_errlog_copy = kmalloc(sizeof(struct pseries_hp_errorlog),
> +	hp_errlog_copy = kmemdup(hp_errlog, sizeof(struct pseries_hp_errorlog),
>   				 GFP_KERNEL);
> -	memcpy(hp_errlog_copy, hp_errlog, sizeof(struct pseries_hp_errorlog));
> +	if (!hp_errlog_copy)
> +		return;
>   
>   	work = kmalloc(sizeof(struct pseries_hp_work), GFP_KERNEL);
>   	if (work) {
> 
