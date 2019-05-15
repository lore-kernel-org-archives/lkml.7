Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D784FC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F9C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="U7/Xnsfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfEOGo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:44:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11497 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfEOGo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:44:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 453lR94ksXz9vDbb;
        Wed, 15 May 2019 08:44:53 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=U7/Xnsfn; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id cDrn7JUJAzaL; Wed, 15 May 2019 08:44:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 453lR93ZqGz9vDbZ;
        Wed, 15 May 2019 08:44:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557902693; bh=grBuY5owxUGP4FNaEiDCJS+hfjwHv093FTB3bCsWADA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U7/XnsfnUZL6wj//NWeenDQU2xzlndXW5H9rNSjYYIlXy4xUVi7uDGaoyxZRyZcMn
         +KoFChEUzjIWoGmWw5ggZglbMqsQEF5EAzKcslHXCNyYldZMvQIJJTxl6YFQdT3Cer
         buEuD0lVwX57p8FD0I5gyOIKH3hDAEwSBq9VMUjo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6A42F8B7DF;
        Wed, 15 May 2019 08:44:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qxYpZ6wfXh55; Wed, 15 May 2019 08:44:54 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B4DE8B7DD;
        Wed, 15 May 2019 08:44:54 +0200 (CEST)
Subject: Re: [RFC PATCH] powerpc/mm: Implement STRICT_MODULE_RWX
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <df502ffe07caa38c46b0144fc824fff447f4105b.1557901092.git.christophe.leroy@c-s.fr>
 <20190515064205.GB15778@infradead.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <04044ae8-1cd8-108b-f436-76c606cb3aea@c-s.fr>
Date:   Wed, 15 May 2019 08:44:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515064205.GB15778@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/05/2019 à 08:42, Christoph Hellwig a écrit :
>> +static int change_page_ro(pte_t *ptep, pgtable_t token, unsigned long addr, void *data)
> 
> There are a couple way too long lines like this in the patch.
> 

powerpc arch accepts 90 chars per line, see arch/powerpc/tools/checkpatch.pl

Christophe
