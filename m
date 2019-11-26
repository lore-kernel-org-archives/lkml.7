Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA97C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F7420722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="eiNhmX/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKZIBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:01:16 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:6143 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfKZIBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:01:15 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47MbvF4RBrz9txbj;
        Tue, 26 Nov 2019 09:01:13 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eiNhmX/3; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KmC-aZ693UsB; Tue, 26 Nov 2019 09:01:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47MbvF2TGnz9txbg;
        Tue, 26 Nov 2019 09:01:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574755273; bh=Yl4+kZ1p5Cyb6s3+0jQVbC3UJyF9FtAmAp/UXPPoPNo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eiNhmX/3p1JSMZxMYYU53b3Uvj/rLBVVA1ZgG4CV7ArQenXRfe5Mjcmpel0LxhRo9
         PBCT/b4XU75Inbcs/D4NpzEKL6FDQFfbtBjKScGeZtPHcfq3AC+OCTURoNKjyVVviS
         BZNDVGsocwry4drv/vSThNE9hEkl9aWVnaJNzShI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4CBC28B7D8;
        Tue, 26 Nov 2019 09:01:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VvPLu6ECgQep; Tue, 26 Nov 2019 09:01:14 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EAFB88B771;
        Tue, 26 Nov 2019 09:01:13 +0100 (CET)
Subject: Re: [PATCH] powerpc/8xx: Fix permanently mapped IMMR region.
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <ad9d45119a48a92bf122781d0c79c9407baa12d7.1566554026.git.christophe.leroy@c-s.fr>
 <87sgmlcu1x.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d22ac38c-0b03-fbc0-88d1-899e356fa487@c-s.fr>
Date:   Tue, 26 Nov 2019 08:01:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87sgmlcu1x.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/2019 11:17 AM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> When not using large TLBs, the IMMR region is still
>> mapped as a whole block in the FIXMAP area.
>>
>> Do not remove pages mapped in the FIXMAP region when
>> initialising paging.
>>
>> Properly report that the IMMR region is block-mapped even
>> when not using large TLBs.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/mm/mem.c        |  8 --------
>>   arch/powerpc/mm/nohash/8xx.c | 13 +++++++------
>>   2 files changed, 7 insertions(+), 14 deletions(-)
> 
> This blows up pmac32_defconfig + qemu mac99 for me with:
> 
>    NET: Registered protocol family 1
>    RPC: Registered named UNIX socket transport module.
>    RPC: Registered udp transport module.
>    RPC: Registered tcp transport module.
>    RPC: Registered tcp NFSv4.1 backchannel transport module.
>    PCI: CLS 0 bytes, default 32
>    Trying to unpack rootfs image as initramfs...
>    BUG: Unable to handle kernel data access on write at 0xfffdf000

I tested it with pmac32_defconfig and qemu mac99 and don't get the problem:

NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 32
Initialise system trusted keyrings
workingset: timestamp_bits=30 max_order=15 bucket_order=0
NFS: Registering the id_resolver key type
Key type id_resolver registered
...

Looks like I don't get that 'Trying to unpack rootfs image as 
initramfs...', do you change anything to pmac32_defconfig ?

Anyway, when rebasing this patch on next branch, only the 
arch/powerpc/mm/nohash/8xx.c change remains. The other part is already 
applied through another patch.

So I believe the remaining part is safe to apply

Christophe

