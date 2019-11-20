Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDBAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C584222DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfKTHi5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 02:38:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:19371 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfKTHi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:38:57 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47HvhF3JJsz9txdb;
        Wed, 20 Nov 2019 08:38:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 2Je4SgxbiTWQ; Wed, 20 Nov 2019 08:38:53 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47HvhF1c8fz9txdY;
        Wed, 20 Nov 2019 08:38:53 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id C7CEAC70; Wed, 20 Nov 2019 08:38:55 +0100 (CET)
Received: from 37-170-47-250.coucou-networks.fr
 (37-170-47-250.coucou-networks.fr [37.170.47.250]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Wed, 20 Nov 2019 08:38:55 +0100
Date:   Wed, 20 Nov 2019 08:38:55 +0100
Message-ID: <20191120083855.Horde.tWflxXv8u6A3uBxaMJth5g7@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, dja@axtens.net, npiggin@gmail.com,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 15/15] powerpc/32s: Activate CONFIG_VMAP_STACK
References: <cover.1568106758.git.christophe.leroy@c-s.fr>
 <a99bdfb64e287b16b8cd3f7ec1abfdfb50c7cc64.1568106758.git.christophe.leroy@c-s.fr>
 <875zjgcpyx.fsf@mpe.ellerman.id.au>
In-Reply-To: <875zjgcpyx.fsf@mpe.ellerman.id.au>
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
> This is faulting with qemu mac99 model:
>
>   Key type id_resolver registered
>   Key type id_legacy registered
>   BUG: Unable to handle kernel data access on read at 0x2f0db684
>   Faulting instruction address: 0x00004130
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   BE PAGE_SIZE=4K MMU=Hash PowerMac
>   Modules linked in:
>   CPU: 0 PID: 65 Comm: modprobe Not tainted 5.4.0-rc2-gcc49+ #63
>   NIP:  00004130 LR: 000008c8 CTR: b7eb86e0
>   REGS: f106de80 TRAP: 0300   Not tainted  (5.4.0-rc2-gcc49+)
>   MSR:  00003012 <FP,ME,DR,RI>  CR: 4106df38  XER: 20000000
>   DAR: 2f0db684 DSISR: 40000000
>   GPR00: b7ec5d64 f106df38 00000000 bf988a70 00000000 2f0db540  
> b7ec3620 bf988d38
>   GPR08: 10000880 0000d032 72656773 f106df38 b7ed10ec 00000000  
> b7ed3d38 b7ee8900
>   GPR16: bf988d10 00000001 00000000 bf988d10 b7ec3620 bf988d50  
> b7ee76ec b7ee7320
>   GPR24: 10000878 00000000 b7ee8900 00000000 10029f00 10000879  
> b7ee7ff4 bf988d30
>   NIP [00004130] 0x4130
>   LR [000008c8] 0x8c8
>   Call Trace:
>   [f106df38] [c0016224] ret_from_syscall+0x0/0x34 (unreliable)
>   --- interrupt: c01 at 0xb7ed0f50
>       LR = 0xb7ec5d64
>   Instruction dump:
>   db8300e0 XXXXXXXX XXXXXXXX XXXXXXXX fc00048e XXXXXXXX XXXXXXXX XXXXXXXX
>   60a52000 XXXXXXXX XXXXXXXX XXXXXXXX 80850144 XXXXXXXX XXXXXXXX XXXXXXXX
>   ---[ end trace 265da51c6d8b86c5 ]---
>
>
> I think I'll have to drop this series for now.

What about taking the series up to patch 13 ?

I think the problem is related to hash handling as it is working well  
on the 8xx (and on the 83xx which is a nohash book3s). I'll look at  
book3s hash next week.

Christophe




