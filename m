Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDCACA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 18:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0AF21744
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 18:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="H9JGfR6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfKCSYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 13:24:07 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:35842 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfKCSYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 13:24:07 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 34EDB5C007C;
        Sun,  3 Nov 2019 19:24:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1572805444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9fntE1N5AsxqOETEl0Wde7bowPGM0/SedoanyW84npw=;
        b=H9JGfR6Hnx3O3JQWlqYwe5gxmek/VvGEgb/LxRsQIy00QvWxciE48gTPkgGsOItjFt1qPf
        RNogeHnunwNSbTpTqhAHOI0h9tPfXiYrb5LgyC5EGlfjHlyuX139zaF0JvbqUBfxLiniac
        rHYlaY+bnWNmsdSin9GegTwXicQoZdk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 03 Nov 2019 19:24:04 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     ndesaulniers@google.com, nico@fluxnic.net, rfranz@marvell.com,
        linus.walleij@linaro.org, ard.biesheuvel@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ARM: use APSR_nzcv instead of r15 as mrc operand
In-Reply-To: <20191101220939.GK25745@shell.armlinux.org.uk>
References: <472f8bd1f000f45343cc0c66a26380fe4b532147.1572644664.git.stefan@agner.ch>
 <20191101220939.GK25745@shell.armlinux.org.uk>
Message-ID: <0a24fe5e4aeba78c5fada3fca0bbeb99@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On 2019-11-01 23:09, Russell King - ARM Linux admin wrote:
> On Fri, Nov 01, 2019 at 10:47:58PM +0100, Stefan Agner wrote:
>> LLVM's integrated assembler does not accept r15 as mrc operand.
>>   arch/arm/boot/compressed/head.S:1267:16: error: operand must be a register in range [r0, r14] or apsr_nzcv
>>   1: mrc p15, 0, r15, c7, c14, 3 @ test,clean,invalidate D cache
>>                  ^
>>
>> Use APSR_nzcv instead of r15. The GNU assembler supports this
>> syntax since binutils 2.21 [0].
>>
>> [0] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=db472d6ff0f438a21b357249a9b48e4b74498076
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Looks fine, please put it in the patch system; however, please note
> that I've been tweaking the patch system over the last week (mainly
> with the database, which has impacted almost everything) so there
> may be issues that I've not yet found...

I used the form to submit the patch. From what I can tell it worked
fine, patch number is 8929/1.

--
Stefan

> 
> Thanks.
> 
>> ---
>>  arch/arm/boot/compressed/head.S | 2 +-
>>  arch/arm/mm/proc-arm1026.S      | 4 ++--
>>  arch/arm/mm/proc-arm926.S       | 4 ++--
>>  3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
>> index 15ecad944847..ead21e5f2b80 100644
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -1273,7 +1273,7 @@ iflush:
>>  __armv5tej_mmu_cache_flush:
>>  		tst	r4, #1
>>  		movne	pc, lr
>> -1:		mrc	p15, 0, r15, c7, c14, 3	@ test,clean,invalidate D cache
>> +1:		mrc	p15, 0, APSR_nzcv, c7, c14, 3	@ test,clean,invalidate D cache
>>  		bne	1b
>>  		mcr	p15, 0, r0, c7, c5, 0	@ flush I cache
>>  		mcr	p15, 0, r0, c7, c10, 4	@ drain WB
>> diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
>> index 10e21012380b..0bdf25a95b10 100644
>> --- a/arch/arm/mm/proc-arm1026.S
>> +++ b/arch/arm/mm/proc-arm1026.S
>> @@ -138,7 +138,7 @@ ENTRY(arm1026_flush_kern_cache_all)
>>  	mov	ip, #0
>>  __flush_whole_cache:
>>  #ifndef CONFIG_CPU_DCACHE_DISABLE
>> -1:	mrc	p15, 0, r15, c7, c14, 3		@ test, clean, invalidate
>> +1:	mrc	p15, 0, APSR_nzcv, c7, c14, 3		@ test, clean, invalidate
>>  	bne	1b
>>  #endif
>>  	tst	r2, #VM_EXEC
>> @@ -363,7 +363,7 @@ ENTRY(cpu_arm1026_switch_mm)
>>  #ifdef CONFIG_MMU
>>  	mov	r1, #0
>>  #ifndef CONFIG_CPU_DCACHE_DISABLE
>> -1:	mrc	p15, 0, r15, c7, c14, 3		@ test, clean, invalidate
>> +1:	mrc	p15, 0, APSR_nzcv, c7, c14, 3		@ test, clean, invalidate
>>  	bne	1b
>>  #endif
>>  #ifndef CONFIG_CPU_ICACHE_DISABLE
>> diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
>> index 3188ab2bac61..1ba253c2bce1 100644
>> --- a/arch/arm/mm/proc-arm926.S
>> +++ b/arch/arm/mm/proc-arm926.S
>> @@ -131,7 +131,7 @@ __flush_whole_cache:
>>  #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
>>  	mcr	p15, 0, ip, c7, c6, 0		@ invalidate D cache
>>  #else
>> -1:	mrc	p15, 0, r15, c7, c14, 3 	@ test,clean,invalidate
>> +1:	mrc	p15, 0, APSR_nzcv, c7, c14, 3 	@ test,clean,invalidate
>>  	bne	1b
>>  #endif
>>  	tst	r2, #VM_EXEC
>> @@ -358,7 +358,7 @@ ENTRY(cpu_arm926_switch_mm)
>>  	mcr	p15, 0, ip, c7, c6, 0		@ invalidate D cache
>>  #else
>>  @ && 'Clean & Invalidate whole DCache'
>> -1:	mrc	p15, 0, r15, c7, c14, 3 	@ test,clean,invalidate
>> +1:	mrc	p15, 0, APSR_nzcv, c7, c14, 3 	@ test,clean,invalidate
>>  	bne	1b
>>  #endif
>>  	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
>> --
>> 2.23.0
>>
>>
