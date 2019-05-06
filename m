Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77B4C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74E720C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="P5+DJ7Wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfEFQbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:31:46 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42457 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfEFQbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:31:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44yStK1Tgsz9v0K7;
        Mon,  6 May 2019 18:31:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=P5+DJ7Wb; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id CpNBf7_aZXGe; Mon,  6 May 2019 18:31:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44yStK0FMgz9v0K6;
        Mon,  6 May 2019 18:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557160297; bh=yRinLegSyNuQk1RUEKDqwhCd8nwbiVxqrPc16LJu4GU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P5+DJ7WbCCG+/X0uMpSJWcr0mfyFEW5HxVlaji0QqDgeSWmgAwSXBwr6QvPxcUmo+
         WfMLuJ2l4oWXBtaoH0Oman/cVy25hsthMVccUN+MJRH8DpX/32HySF9MgUN35bIhoZ
         0SLSQMphHjygVMgYin2hepj2y/t4AWCMa0/wao5g=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 46BF28B8E9;
        Mon,  6 May 2019 18:31:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hGgPJhHpLTle; Mon,  6 May 2019 18:31:42 +0200 (CEST)
Received: from localhost.localdomain (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 168478B8E7;
        Mon,  6 May 2019 18:31:42 +0200 (CEST)
Subject: Re: [PATCH] powerpc/32: Remove memory clobber asm constraint on
 dcbX() functions
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20180109065759.4E54B6C73D@localhost.localdomain>
 <e482662f-254c-4ab7-b0a8-966a3159d705@c-s.fr>
 <20190503181508.GQ8599@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c2391ff5-ae01-5a3c-ad87-9cbda82b36ab@c-s.fr>
Date:   Mon, 6 May 2019 16:31:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190503181508.GQ8599@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Segher,


On 05/03/2019 06:15 PM, Segher Boessenkool wrote:
> Hi Christophe,
> 
> On Fri, May 03, 2019 at 04:14:13PM +0200, Christophe Leroy wrote:
>> A while ago I proposed the following patch, and didn't get any comment
>> back on it.
> 
> I didn't see it.  Maybe because of holiday :-)

Thanks for this answer, I guess I'll drop it for the time being.

However, I've tried your suggestion below and get unnexpected result.

[...]

> 
> 
> [ Btw.  Instead of
> 
> 	__asm__ __volatile__ ("dcbf 0, %0" : : "r"(addr) : "memory");
> 
> you can do
> 
> 	__asm__ __volatile__ ("dcbf %0" : : "Z"(addr) : "memory");
> 
> to save some insns here and there. ]

Tried that change on dcbz() and checked function clear_page()

static inline void clear_page(void *addr)
{
	unsigned int i;

	for (i = 0; i < PAGE_SIZE / L1_CACHE_BYTES; i++, addr += L1_CACHE_BYTES)
		dcbz(addr);
}

void clear_user_page(void *page, unsigned long vaddr, struct page *pg)
{
	clear_page(page);

	/*
	 * We shouldn't have to do this, but some versions of glibc
	 * require it (ld.so assumes zero filled pages are icache clean)
	 * - Anton
	 */
	flush_dcache_page(pg);
}
EXPORT_SYMBOL(clear_user_page);


Before the change,

clear_user_page:
	mflr 0
	stw 0,4(1)
	bl _mcount
	stwu 1,-16(1)
	li 9,128
	mflr 0
	mtctr 9
	stw 0,20(1)
.L46:
#APP
  # 88 "./arch/powerpc/include/asm/cache.h" 1
	dcbz 0, 3
  # 0 "" 2
#NO_APP
	addi 3,3,32
	bdnz .L46
	lwz 0,20(1)
	mr 3,5
	mtlr 0
	addi 1,1,16
	b flush_dcache_page


After the change


clear_user_page:
	mflr 0
	stw 0,4(1)
	bl _mcount
	stwu 1,-32(1)
	li 9,128
	mflr 0
	mtctr 9
	stw 0,36(1)
.L46:
	stw 3,8(1)
	addi 9,1,8
#APP
  # 88 "./arch/powerpc/include/asm/cache.h" 1
	dcbz 0(9)
  # 0 "" 2
#NO_APP
	addi 3,3,32
	bdnz .L46
	mr 3,5
	bl flush_dcache_page
	lwz 0,36(1)
	addi 1,1,32
	mtlr 0
	blr


So first of all it uses an unexisting form of dcbz : "dcbz 0(9)"
And in addition, it stores r3 somewhere and I guess expects to read it 
with dcbz ???

Looks like 'Z' is not the right constraint to use.

Christophe
