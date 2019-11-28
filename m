Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEF9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3EF206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dyDBE4cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfK1IGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:06:53 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:6328 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfK1IGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:06:53 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47Nqwq3STlz9ty0Y;
        Thu, 28 Nov 2019 09:06:51 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dyDBE4cz; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mgpN2mQI7JlB; Thu, 28 Nov 2019 09:06:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47Nqwq2FZrz9ty0T;
        Thu, 28 Nov 2019 09:06:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574928411; bh=r0UjyHYvteSzLuUih/qEKzzmGw4ED7wqOOic8C4w5SA=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=dyDBE4czf+EVa7HddAfrip5wNrdAXpxfQppTvkKZyv4sMXgEaMYcWNXHWKi0ttugQ
         0Dpwk6SvIFZ+81slLnonUt1xeydEFkqqtVamutMVtyiFLsrpP7zWzfliuQTw5OurYG
         USk2sUpqVviGeSmwEBSlYaNiEcG53eDCKpSWMb0M=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 40CA28B787;
        Thu, 28 Nov 2019 09:06:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TDIdejapCBoz; Thu, 28 Nov 2019 09:06:52 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1CD438B767;
        Thu, 28 Nov 2019 09:06:52 +0100 (CET)
Subject: Re: [PATCH v1 1/4] powerpc/fixmap: don't clear fixmap area in
 paging_init()
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        hch@infradead.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <47MQrc6TCxz9sPV@ozlabs.org>
 <bedbd52f-9eea-7253-e28b-68e01a848405@c-s.fr>
Message-ID: <51c97c23-251d-90d9-0c52-41ef55c9f4c9@c-s.fr>
Date:   Thu, 28 Nov 2019 09:06:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <bedbd52f-9eea-7253-e28b-68e01a848405@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 27/11/2019 à 15:43, Christophe Leroy a écrit :
> 
> 
> Le 26/11/2019 à 02:13, Michael Ellerman a écrit :
>> On Thu, 2019-09-12 at 13:49:41 UTC, Christophe Leroy wrote:
>>> fixmap is intended to map things permanently like the IMMR region on
>>> FSL SOC (8xx, 83xx, ...), so don't clear it when initialising paging()
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> Applied to powerpc next, thanks.
>>
>> https://git.kernel.org/powerpc/c/f2bb86937d86ebcb0e52f95b6d19aba1d850e601
>>
> 
> Hi,
> 
> What happened ?
> 
> It looks like it is gone in today's powerpc next.
> 

I see it back today in powerpc/merge, thanks.

The issue is it is crashing with HIGHMEM, indeed exactly the same as you 
saw with "[PATCH] powerpc/8xx: Fix permanently mapped IMMR region.", 
since that was exactly the same code.

I sent a fix for it, and I also rebased "[PATCH] powerpc/8xx: Fix 
permanently mapped IMMR region." into v2 to exclude from it the already 
merged part.

It would be wise if you could merge both.

Thanks
Christophe
