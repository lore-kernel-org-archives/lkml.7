Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF2EC31E53
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88BF21473
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="I/eon35b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfFPIVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 04:21:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1478 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfFPIVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 04:21:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45RS3Q4XrGz9v19r;
        Sun, 16 Jun 2019 10:21:06 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=I/eon35b; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IVYRmuuTueHB; Sun, 16 Jun 2019 10:21:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45RS3Q3VBdz9v19n;
        Sun, 16 Jun 2019 10:21:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560673266; bh=nDddjU62SJMnatBSBKFnzXb/nxJGkqucoMGf//3m8xY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I/eon35beLILDeNdqn5+T0Mrn9iajXcmzRWKFgcL1xtoTPsLiJsM9Zt+pv/RHb8/2
         pPBbZNB2LIMIo40jsiyfjTtYbOoYFFAnptyjTWGI9tYdUG0D5NAPnEDLa+TOIoueM3
         gXYPJ6VA1t384O8OCP7MeYf9egBEM3qNkEKrGJCg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 551628B7D1;
        Sun, 16 Jun 2019 10:21:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id j5p44WTEn-_X; Sun, 16 Jun 2019 10:21:09 +0200 (CEST)
Received: from [192.168.232.53] (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BCED38B7CD;
        Sun, 16 Jun 2019 10:21:08 +0200 (CEST)
Subject: Re: [PATCH v5 13/16] powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
 <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
 <87blyz9jor.fsf@igel.home>
From:   christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <a76f7759-a407-3d9a-0f43-654fd7ea0b1e@c-s.fr>
Date:   Sun, 16 Jun 2019 10:20:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <87blyz9jor.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 190616-0, 16/06/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/06/2019 à 13:23, Andreas Schwab a écrit :
> This breaks suspend (or resume) on the iBook G4.  no_console_suspend
> doesn't give any clues, the display just stays dark.
> 

After a quick look at the suspend functions, I have the feeling that 
those functions only store and restore BATs 0 to 3.

Could you build your kernel with CONFIG_PPC_PTDUMP and see in file 
/sys/kernel/debug/powerpc/segment_registers how many IBATs registers are 
used.
If any of registers IBATs 4 to 7 are used, could you adjust 
CONFIG_ETEXT_SHIFT so that only IBATs 0 to 3 be used, and check if 
suspend/resume works when IBATs 4 to 7 are not used ?

Thanks
Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

