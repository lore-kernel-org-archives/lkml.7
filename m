Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78829C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F302133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Znx0Louq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfCHQGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:06:23 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:57386 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfCHQGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:06:23 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44GC6M618Zz9tyVk;
        Fri,  8 Mar 2019 17:06:19 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Znx0Louq; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id qDmNESE04eWu; Fri,  8 Mar 2019 17:06:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44GC6M4j9Gz9tyVj;
        Fri,  8 Mar 2019 17:06:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1552061179; bh=wzv4gC0yoEtuBZY4bcEJLsqvL2jftcwAllbv/2lZ4MA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Znx0LouqEZx5ziBZc21WDgO5n0O0uWHsZA4R8d2PqVoJSL/94BUSPr9xEVcQTYuI0
         NdDx/ztoa8y75j//rcrKPF74xDf2LXrupzBU6DfI/o1c2+SboZpatXaAbzpwrXm5rO
         MJqQqEk5RllNnsUwn6bJGpzrcuaZol0vEhjHu+2A=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B4998BFB7;
        Fri,  8 Mar 2019 17:06:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KjeVOjKETdGZ; Fri,  8 Mar 2019 17:06:21 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 045268BF9B;
        Fri,  8 Mar 2019 17:06:21 +0100 (CET)
Subject: Re: [PATCH] powerpc/6xx: fix setup and use of SPRN_PGDIR for hash32
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <7e45ca3f0283fb24c2642e5b91bd75c55f2ba96f.1552028583.git.christophe.leroy@c-s.fr>
 <20190308160334.GZ3969@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <7681ad2b-35d4-6e43-f727-21545e3bb223@c-s.fr>
Date:   Fri, 8 Mar 2019 17:06:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308160334.GZ3969@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/03/2019 à 17:03, Segher Boessenkool a écrit :
> On Fri, Mar 08, 2019 at 07:05:22AM +0000, Christophe Leroy wrote:
>> Not only the 603 but all 6xx need SPRN_PGDIR to be initialised at
>> startup. This patch move it from __setup_cpu_603() to start_here()
>> and __secondary_start(), close to the initialisation of SPRN_THREAD.
> 
> I thought you meant an SPR I did not know about.  But you just misspelled
> SPRN_SPRG_PGDIR :-)
> 

Oops.

Michael, can you fix the commit text (and subject) when applying ?

Thanks
Christophe
