Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30454C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33A82073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="tAL2i83x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfLJGk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:40:59 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:12029 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfLJGk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:40:58 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47X9S80z1Rz9vBn0;
        Tue, 10 Dec 2019 07:40:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=tAL2i83x; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 826r04EkLdd7; Tue, 10 Dec 2019 07:40:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47X9S771q6z9vBmy;
        Tue, 10 Dec 2019 07:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575960056; bh=oSR9uIzDt/rEY6/KSJx3AbUqofk/Ep6fxitZcrpxY2s=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=tAL2i83xVGrkHPxQu17b9l9jARYFFM2cq04hcSKAVTH3BSSiU1Z7PrjLzTs8hUBOc
         RpT7+wCCC3N0HK4BNd1aykiia0uBaTv2P7kjZDv/gcLstU3kGqRllimvJxO0Wxcbvu
         xCYOsB9YJ+74sPHbusWNIyVYnas1eKOAco2psw/o=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CEE348B802;
        Tue, 10 Dec 2019 07:40:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id k5RN-hFh1dZD; Tue, 10 Dec 2019 07:40:56 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE1AC8B754;
        Tue, 10 Dec 2019 07:40:55 +0100 (CET)
Subject: Re: [PATCH v2 3/4] kasan: Document support on 32-bit powerpc
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-4-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8b64ce35-01df-3c0f-2695-40633c324331@c-s.fr>
Date:   Tue, 10 Dec 2019 07:40:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191210044714.27265-4-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/12/2019 à 05:47, Daniel Axtens a écrit :
> KASAN is supported on 32-bit powerpc and the docs should reflect this.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   Documentation/dev-tools/kasan.rst |  3 ++-
>   Documentation/powerpc/kasan.txt   | 12 ++++++++++++
>   2 files changed, 14 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/powerpc/kasan.txt
> 

Christophe
