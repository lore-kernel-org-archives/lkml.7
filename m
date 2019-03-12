Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A28C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691D52077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="e9UFzVdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfCLVLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:11:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19822 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfCLVLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:11:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44JnhJ4NbWz9tykP;
        Tue, 12 Mar 2019 22:11:12 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=e9UFzVdI; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IuNmQkGCQPpg; Tue, 12 Mar 2019 22:11:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44JnhJ3KC5z9tykN;
        Tue, 12 Mar 2019 22:11:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1552425072; bh=Cl7xbVD4/x1AlYrMnR/USpHRndATs0lxgitlmSBSfc4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e9UFzVdIVpYzuAGd5F7AOSu9eFsfulDyeTkXy3jwydw2iFpcWfWgid5RtbB4sLVGV
         yQ/shl3AMQecDH9iT9znzVo0Xv2RaN45YhtQ9XTjMNWzeVtCK6YpyN7MXZ9V0MbSkf
         LFCBlLkX6z2KudINGymiE6ZYyFUDujEFI3ab501w=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 928C98B8B1;
        Tue, 12 Mar 2019 22:11:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Dw49mXqlquPM; Tue, 12 Mar 2019 22:11:12 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 01CBC8B8A7;
        Tue, 12 Mar 2019 22:11:11 +0100 (CET)
Subject: Re: [PATCH] powerpc/64s: Include <asm/nmi.h> header file to fix a
 warning
To:     Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20190312201823.29371-1-malat@debian.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <040f7bd3-a0b2-6fed-69d7-43efddd7e56d@c-s.fr>
Date:   Tue, 12 Mar 2019 22:11:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190312201823.29371-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/03/2019 à 21:18, Mathieu Malaterre a écrit :
> Make sure to include <asm/nmi.h> to provide the following prototype:
> hv_nmi_check_nonrecoverable.
> 
> Remove the following warning treated as error (W=1):
> 
>    arch/powerpc/kernel/traps.c:393:6: error: no previous prototype for 'hv_nmi_check_nonrecoverable' [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/kernel/traps.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index a21200c6aaea..1fd45a8650e1 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -71,6 +71,7 @@
>   #include <sysdev/fsl_pci.h>
>   #include <asm/kprobes.h>
>   #include <asm/stacktrace.h>
> +#include <asm/nmi.h>
>   
>   #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
>   int (*__debugger)(struct pt_regs *regs) __read_mostly;
> 
