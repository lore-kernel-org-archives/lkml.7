Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0EFC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4E620645
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="bIqFgS6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfEBMLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:11:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5378 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfEBMLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:11:19 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44vvHm3PrRz9txbD;
        Thu,  2 May 2019 14:11:16 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=bIqFgS6W; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 85-dP5nXS5-Y; Thu,  2 May 2019 14:11:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44vvHm1bbTz9txbC;
        Thu,  2 May 2019 14:11:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556799076; bh=K+3HbF0k8U9kzLuov5Fm/KEAbxDnzuIT8BsXj82K3n8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bIqFgS6WgXUsxNL6vv3SX/LN3c0X1vwPk2YfK20MalsA70YYDx4SE9JvUdgivEa1p
         GpuxI+tAFWbvNmf1Hhvmx3XcaHATRVF38iJw8Gd6oR2UwBZnSI5CDdThr6XVbMUDzi
         6bp48ajjxDcJ0SuNhQs1yjLcp7BUlpti0tEWEv+k=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E77A8B8F7;
        Thu,  2 May 2019 14:11:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WNNQZJ3gXNeX; Thu,  2 May 2019 14:11:17 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E90D8B899;
        Thu,  2 May 2019 14:11:17 +0200 (CEST)
Subject: Re: [PATCH v2 01/17] powerpc/mm: Don't BUG() in hugepd_page()
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1556258134.git.christophe.leroy@c-s.fr>
 <ff4366d14b3ef4de6af835a880a772477577139f.1556258135.git.christophe.leroy@c-s.fr>
 <87o94lxdxe.fsf@concordia.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d8e3c5e3-553b-da0a-46d9-b3f555c767d0@c-s.fr>
Date:   Thu, 2 May 2019 14:11:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87o94lxdxe.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/05/2019 à 14:02, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Use VM_BUG_ON() instead of BUG_ON(), as those BUG_ON()
>> are not there to catch runtime errors but to catch errors
>> during development cycle only.
> 
> I've dropped this one and the next, because I don't like VM_BUG_ON().
> 
> Why not? Because it's contradictory. It's a condition that's so
> important that we should BUG, but only if the kernel has been built
> specially for debugging.
> 
> I don't really buy the development cycle distinction, it's not like we
> have a rigorous test suite that we run and then we declare everything's
> gold and ship a product. We often don't find bugs until they're hit in
> the wild.
> 
> For example the recent corruption Joel discovered with STRICT_KERNEL_RWX
> could have been caught by a BUG_ON() to check we weren't patching kernel
> text in radix__change_memory_range(), but he wouldn't have been using
> CONFIG_DEBUG_VM. (See 8adddf349fda)
> 
> I know Aneesh disagrees with me on this, so maybe you two can convince
> me otherwise.
> 

I have no strong oppinion about this. In v1, I replaced them with a 
WARN_ON(), and Aneesh suggested to go with VM_BUG_ON() instead.

My main purpose was to reduce the amount of BUG/BUG_ON and I thought 
those were good candidates, but if you prefer keeping the BUG(), that's 
ok for me. Or maybe you prefered v1 alternatives (series at 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=98170) ?

Christophe
