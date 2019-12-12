Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA58C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F32C205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="EfCot0cP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfLLPzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:55:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:48925 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729509AbfLLPzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:55:14 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47Ydfl2H6MzB09ZV;
        Thu, 12 Dec 2019 16:55:11 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=EfCot0cP; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id D9rWWWTshkIZ; Thu, 12 Dec 2019 16:55:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47Ydfl1CmQzB09ZT;
        Thu, 12 Dec 2019 16:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576166111; bh=PJztFoqZeZST1HMzqILi2xyKFqgX3RxPFx1/4+TG/tk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=EfCot0cPMLRcALyzGy3x1WzkPa0APIh0auRG5pNwxZo4b8aMF1/1AuW51bYPESZ9Y
         ziBgDeI5oE/4VJLWfQJzArHXiDhT/RM2jU9+Mlon2y9KpuYpFaPvE9JRTUFmP0hPUw
         SWOnTZe7prONi+zR7dyM5qmsxnh/nNhDVTJJhZm4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B10348B872;
        Thu, 12 Dec 2019 16:55:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9AsI8caOxSn5; Thu, 12 Dec 2019 16:55:12 +0100 (CET)
Received: from [172.25.230.112] (po15451.idsi0.si.c-s.fr [172.25.230.112])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 935D68B860;
        Thu, 12 Dec 2019 16:55:12 +0100 (CET)
Subject: Re: [PATCH v3 1/3] kasan: define and use MAX_PTRS_PER_* for early
 shadow tables
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
References: <20191212151656.26151-1-dja@axtens.net>
 <20191212151656.26151-2-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <65a52c58-4409-de89-6f5d-8797d0ebca74@c-s.fr>
Date:   Thu, 12 Dec 2019 16:55:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191212151656.26151-2-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/12/2019 à 16:16, Daniel Axtens a écrit :
> powerpc has a variable number of PTRS_PER_*, set at runtime based
> on the MMU that the kernel is booted under.
> 
> This means the PTRS_PER_* are no longer constants, and therefore
> breaks the build.
> 
> Define default MAX_PTRS_PER_*s in the same style as MAX_PTRS_PER_P4D.
> As KASAN is the only user at the moment, just define them in the kasan
> header, and have them default to PTRS_PER_* unless overridden in arch
> code.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Suggested-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   include/linux/kasan.h | 18 +++++++++++++++---
>   mm/kasan/init.c       |  6 +++---
>   2 files changed, 18 insertions(+), 6 deletions(-)
> 

Christophe
