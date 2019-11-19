Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD77CC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8027A22309
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="oEzgknc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKSG5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:57:11 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:43989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfKSG5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:57:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47HGpW0SZfz9sRY;
        Tue, 19 Nov 2019 17:57:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1574146627;
        bh=abFbgG1igsThhgb3dlNVPaVj97B/UnH0/Rzd5PqAH+0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=oEzgknc7lx7h5mOjZB0zQ3OpkhQjE2o7K2yyBwiUDKIpC76o8tVULItublIoVzqSR
         IdXlpROlMM68c7Ufy69ZgmokqgE4PAe0yrWx53/OeYK+qKsHRJHp/UkbV1I2lYoMvI
         rb+qPgWWCxtRMW2fBV8yrPh+jL9kbZjyCD9Vvu76Ai9NolmcXQahEze5dtjpCfpj3b
         4p3UjTem+R663qkGKc21teebtxS+C74oXnNYQ4stRAaIdu/bgqzIZ2AJbrJt3+eA1i
         FXSlzh2Chck58Mgg45i3Fe9GR9wP7WCPyGNi2K72I1H9ILsMSqLsVgpsgyvx8k1ksv
         yh0y5KM8NT1Qw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 15/15] powerpc/32s: Activate CONFIG_VMAP_STACK
In-Reply-To: <87v9rhcuc5.fsf@mpe.ellerman.id.au>
References: <cover.1568106758.git.christophe.leroy@c-s.fr> <a99bdfb64e287b16b8cd3f7ec1abfdfb50c7cc64.1568106758.git.christophe.leroy@c-s.fr> <87v9rhcuc5.fsf@mpe.ellerman.id.au>
Date:   Tue, 19 Nov 2019 17:57:03 +1100
Message-ID: <878soccq0w.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:

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
>>  arch/powerpc/mm/book3s32/hash_low.S    | 46 +++++++++++++++++++++-------------
>>  arch/powerpc/mm/book3s32/mmu.c         |  9 +++++--
>>  arch/powerpc/platforms/Kconfig.cputype |  2 ++
>>  6 files changed, 61 insertions(+), 23 deletions(-)
>
> If I build pmac32_defconfig with KVM enabled this causes a build break:
>
>   arch/powerpc/kernel/head_32.S: Assembler messages:
>   arch/powerpc/kernel/head_32.S:324: Error: attempt to move .org backwards
>   scripts/Makefile.build:357: recipe for target 'arch/powerpc/kernel/head_32.o' failed
>   make[2]: *** [arch/powerpc/kernel/head_32.o] Error 1
>
> In the interests of getting the series merged I'm inclined to just make
> VMAP_STACK and KVM incompatible for now with:
>
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 15c9097dc4f7..5074fe77af40 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -31,7 +31,7 @@ config PPC_BOOK3S_6xx
>         select PPC_HAVE_PMU_SUPPORT
>         select PPC_HAVE_KUEP
>         select PPC_HAVE_KUAP
> -       select HAVE_ARCH_VMAP_STACK
> +       select HAVE_ARCH_VMAP_STACK if !KVM_BOOK3S_32

For some reason this needs to be !KVM.

>  config PPC_BOOK3S_601
>         bool "PowerPC 601"
>
>
> Thoughts?

cheers
