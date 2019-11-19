Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F74C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503C622362
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfKSRXM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:23:12 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:62135 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbfKSRXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:23:11 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47HXht0h7hz9tyLh;
        Tue, 19 Nov 2019 18:23:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9_yGQs22jHWr; Tue, 19 Nov 2019 18:23:10 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47HXhs50M2z9tyLQ;
        Tue, 19 Nov 2019 18:23:09 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id A9FDCCCF; Tue, 19 Nov 2019 18:23:10 +0100 (CET)
Received: from 37-173-93-145.coucou-networks.fr
 (37-173-93-145.coucou-networks.fr [37.173.93.145]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Tue, 19 Nov 2019 18:23:10 +0100
Date:   Tue, 19 Nov 2019 18:23:10 +0100
Message-ID: <20191119182310.Horde.k9AYj80RSVXLkAUdXVQqrQ1@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, dja@axtens.net, npiggin@gmail.com,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 15/15] powerpc/32s: Activate CONFIG_VMAP_STACK
References: <cover.1568106758.git.christophe.leroy@c-s.fr>
 <a99bdfb64e287b16b8cd3f7ec1abfdfb50c7cc64.1568106758.git.christophe.leroy@c-s.fr>
 <87v9rhcuc5.fsf@mpe.ellerman.id.au>
In-Reply-To: <87v9rhcuc5.fsf@mpe.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> a écrit :

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> A few changes to retrieve DAR and DSISR from struct regs
>> instead of retrieving them directly, as they may have
>> changed due to a TLB miss.
>>
>> Also modifies hash_page() and friends to work with virtual
>> data addresses instead of physical ones.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/kernel/entry_32.S         |  4 +++
>>  arch/powerpc/kernel/head_32.S          | 19 +++++++++++---
>>  arch/powerpc/kernel/head_32.h          |  4 ++-
>>  arch/powerpc/mm/book3s32/hash_low.S    | 46  
>> +++++++++++++++++++++-------------
>>  arch/powerpc/mm/book3s32/mmu.c         |  9 +++++--
>>  arch/powerpc/platforms/Kconfig.cputype |  2 ++
>>  6 files changed, 61 insertions(+), 23 deletions(-)
>
> If I build pmac32_defconfig with KVM enabled this causes a build break:
>
>   arch/powerpc/kernel/head_32.S: Assembler messages:
>   arch/powerpc/kernel/head_32.S:324: Error: attempt to move .org backwards
>   scripts/Makefile.build:357: recipe for target  
> 'arch/powerpc/kernel/head_32.o' failed
>   make[2]: *** [arch/powerpc/kernel/head_32.o] Error 1
>
> In the interests of getting the series merged I'm inclined to just make
> VMAP_STACK and KVM incompatible for now with:
>
> diff --git a/arch/powerpc/platforms/Kconfig.cputype  
> b/arch/powerpc/platforms/Kconfig.cputype
> index 15c9097dc4f7..5074fe77af40 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -31,7 +31,7 @@ config PPC_BOOK3S_6xx
>         select PPC_HAVE_PMU_SUPPORT
>         select PPC_HAVE_KUEP
>         select PPC_HAVE_KUAP
> -       select HAVE_ARCH_VMAP_STACK
> +       select HAVE_ARCH_VMAP_STACK if !KVM_BOOK3S_32
>
>  config PPC_BOOK3S_601
>         bool "PowerPC 601"
>
>
> Thoughts?

Ok, lets do it the way you propose.

I'll look at this problem with KVM when I'm back next week.

Thanks
Christophe



