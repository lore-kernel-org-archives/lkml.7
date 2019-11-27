Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61806C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE992073F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="hz2scKtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfK0OnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:43:25 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:52496 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfK0OnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:43:25 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NNmn5ntbz9v0w7;
        Wed, 27 Nov 2019 15:43:21 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=hz2scKtZ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UFtiQgiiPNp0; Wed, 27 Nov 2019 15:43:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NNmn3FNHz9v0w6;
        Wed, 27 Nov 2019 15:43:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574865801; bh=NA4XDMENdTgyTE7/eRNhB4x9XdgIeH45lbqXvTK24JM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hz2scKtZ199Hz7BZQrerYYi0WdQ/8f0XIlsvz5pLPEhSLi5vCmAEaF2dWPlVtY1G4
         bC+bb6WbtspaBpIV6uvAH2pLN0m+5NZh5yFzGM0Y2s5E5wmIdNpnFKbPPyBHgKCr8T
         ulJeT1AtJVxXwPADg1cL4DIjoQ+4qkPhLjoum3Ss=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D72E28B862;
        Wed, 27 Nov 2019 15:43:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ck_hcbGfimtV; Wed, 27 Nov 2019 15:43:22 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 477E38B85A;
        Wed, 27 Nov 2019 15:43:22 +0100 (CET)
Subject: Re: [PATCH v1 1/4] powerpc/fixmap: don't clear fixmap area in
 paging_init()
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        hch@infradead.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <47MQrc6TCxz9sPV@ozlabs.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <bedbd52f-9eea-7253-e28b-68e01a848405@c-s.fr>
Date:   Wed, 27 Nov 2019 15:43:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <47MQrc6TCxz9sPV@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/11/2019 à 02:13, Michael Ellerman a écrit :
> On Thu, 2019-09-12 at 13:49:41 UTC, Christophe Leroy wrote:
>> fixmap is intended to map things permanently like the IMMR region on
>> FSL SOC (8xx, 83xx, ...), so don't clear it when initialising paging()
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/f2bb86937d86ebcb0e52f95b6d19aba1d850e601
> 

Hi,

What happened ?

It looks like it is gone in today's powerpc next.

Christophe
