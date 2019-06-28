Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675ABC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4F0205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="hCseVWrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfF1I7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:59:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30451 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfF1I7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:59:53 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45ZrLb32q7z9v1dq;
        Fri, 28 Jun 2019 10:59:51 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=hCseVWrz; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wg0kRk6LpBEP; Fri, 28 Jun 2019 10:59:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45ZrLb0JB7z9v1dW;
        Fri, 28 Jun 2019 10:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561712391; bh=3PExFE1N6IiyQSDeWR2v89tJ9QeiWcAN1N4Hjay3PlI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hCseVWrzRRQQXlskmPHp+o3zZeA9GBRK4q98IdoDLwuXYMJZ0gqNOJzJu4lD6Mxqb
         cA/OiFk6yj7OXXXZDbS9ktAYJzXSFIfIfzeuxOXNEijxaOSJN+wsUKbnOH/ZnZ0Lmi
         Pgc6B8sCSvQ3DAwq+DJQJ9XYrlUTJvBjOpWEWRUQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 256308B966;
        Fri, 28 Jun 2019 10:59:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mul6Zychpueb; Fri, 28 Jun 2019 10:59:52 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E11848B961;
        Fri, 28 Jun 2019 10:59:51 +0200 (CEST)
Subject: Re: [PATCH v2 27/27] sound: ppc: remove unneeded memset after
 dma_alloc_coherent
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Richard Fontana <rfontana@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, Allison Randal <allison@lohutok.net>
References: <20190628025055.16242-1-huangfq.daxian@gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Followup-To: Takashi Iwai <tiwai@suse.com>
Message-ID: <83108dee-72f7-e56f-95f6-26162c9a0ccc@c-s.fr>
Date:   Fri, 28 Jun 2019 10:59:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628025055.16242-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 28/06/2019 à 04:50, Fuqian Huang a écrit :
> In commit af7ddd8a627c
> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
> dma_alloc_coherent has already zeroed the memory.
> So memset is not needed.

You are refering to a merge commit, is that correct ?

I can't see anything related in that commit, can you please pinpoint it ?

As far as I can see, on powerpc the memory has always been zeroized 
(since 2005 at least).

Christophe

> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>   sound/ppc/pmac.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
> index 1b11e53f6a62..1ab12f4f8631 100644
> --- a/sound/ppc/pmac.c
> +++ b/sound/ppc/pmac.c
> @@ -56,7 +56,6 @@ static int snd_pmac_dbdma_alloc(struct snd_pmac *chip, struct pmac_dbdma *rec, i
>   	if (rec->space == NULL)
>   		return -ENOMEM;
>   	rec->size = size;
> -	memset(rec->space, 0, rsize);
>   	rec->cmds = (void __iomem *)DBDMA_ALIGN(rec->space);
>   	rec->addr = rec->dma_base + (unsigned long)((char *)rec->cmds - (char *)rec->space);
>   
> 
