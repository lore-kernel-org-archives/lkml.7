Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A123CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8042206DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cSzORSS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfCONUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:20:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36411 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbfCONUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:20:06 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44LR5H0SdNzB09Zj;
        Fri, 15 Mar 2019 14:20:03 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=cSzORSS3; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uBRCu8vMd-vG; Fri, 15 Mar 2019 14:20:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44LR5G6JxczB09Zg;
        Fri, 15 Mar 2019 14:20:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1552656002; bh=yqt9unfFV3OXa8uYQsP+5NOpDusQGk9tbLXzGF+g1Ps=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=cSzORSS3T9vhdVxTLUW4MgpgWhIVOzXYC0pFcaw9FXOAElMOyO3eNLVXQ145ta0Qc
         n9wRbKc7pSBz0zbmlZtmOaeANIJufM0XPHgTy0fpMtiijq5GocQhjwM+bem/EHHtTN
         JYCIB/EMgQjBxD7xIdENizKhrBlcVrzTbCba2LZs=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CB478BF53;
        Fri, 15 Mar 2019 14:20:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mdEm6Dq-Ewph; Fri, 15 Mar 2019 14:20:04 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 168178BF48;
        Fri, 15 Mar 2019 14:20:04 +0100 (CET)
Subject: Re: [PATCH] powerpc/6xx: fix setup and use of SPRN_PGDIR for hash32
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
References: <7e45ca3f0283fb24c2642e5b91bd75c55f2ba96f.1552028583.git.christophe.leroy@c-s.fr>
 <20190308160334.GZ3969@gate.crashing.org>
 <7681ad2b-35d4-6e43-f727-21545e3bb223@c-s.fr>
Message-ID: <72bac00c-d2e3-515e-3ab1-99f20c058ea1@c-s.fr>
Date:   Fri, 15 Mar 2019 14:20:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <7681ad2b-35d4-6e43-f727-21545e3bb223@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

Are you able to get this merged before 5.1-rc1 comes out ?

Thanks
Christophe

Le 08/03/2019 à 17:06, Christophe Leroy a écrit :
> 
> 
> Le 08/03/2019 à 17:03, Segher Boessenkool a écrit :
>> On Fri, Mar 08, 2019 at 07:05:22AM +0000, Christophe Leroy wrote:
>>> Not only the 603 but all 6xx need SPRN_PGDIR to be initialised at
>>> startup. This patch move it from __setup_cpu_603() to start_here()
>>> and __secondary_start(), close to the initialisation of SPRN_THREAD.
>>
>> I thought you meant an SPR I did not know about.  But you just misspelled
>> SPRN_SPRG_PGDIR :-)
>>
> 
> Oops.
> 
> Michael, can you fix the commit text (and subject) when applying ?
> 


