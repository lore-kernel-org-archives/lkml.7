Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF5BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CFA217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="lfY4eMt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfCSWHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:07:39 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:58928 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfCSWHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:07:39 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id DEAA35C01C4;
        Tue, 19 Mar 2019 23:07:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1553033255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zku767815alubGZKI3FUMQcNR5dleh8JfwJ33Armyzk=;
        b=lfY4eMt8md6/REwdfSzw09Eydi/qfPF6O4aMs/lFxfmlWJI5MN9MgxvbTMCyGhmH4Nd5Nr
        0C+brQcaoJfYIcgoZkyZAEWwvhBrQ4E4gfo2OYv8M6AUuE1TJVtHuOx6+HoZz3EsNjkDlt
        d/VY79xHwubznS4I7aXuLQsxXOOmqL4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Mar 2019 23:07:35 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        julien.thierry@arm.com, Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] ARM: drop WASM to work around LLVM issue
In-Reply-To: <CAKwvOdnE93+TGwxNiKRdksZseKP_-qF2D=2dUWE_bRX_FpQLmg@mail.gmail.com>
References: <e3f3bf27430712ee88c0b600f3d62cb86d327b75.1552863571.git.stefan@agner.ch>
 <CAKwvOdnE93+TGwxNiKRdksZseKP_-qF2D=2dUWE_bRX_FpQLmg@mail.gmail.com>
Message-ID: <d84493fc316e207864c8ba2bdcf7ab64@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.2019 19:09, Nick Desaulniers wrote:
> On Sun, Mar 17, 2019 at 4:05 PM Stefan Agner <stefan@agner.ch> wrote:
>>
>> Currently LLVM's integrated assembler does not recognize .w form
>> of the pld instructions (LLVM Bug 40972 [0]):
>>
>>   ./arch/arm/include/asm/processor.h:133:5: error: invalid instruction
>>                           "pldw.w\t%a0 \n"
>>                            ^
>>   <inline asm>:2:1: note: instantiated into assembly here
>>   pldw.w  [r0]
>>   ^
>>   1 error generated.
>>
>> The W macro for generating wide instructions when targeting Thumb-2
>> is not strictly required for the preload data instructions (pld, pldw)
>> since they are only available as wide instructions. The GNU assembler
>> works with or without the .w appended when compiling an Thumb-2 kernel.
>>
>> Drop the macro to work around LLVM Bug 40972 issue.
>>
>> [0] https://bugs.llvm.org/show_bug.cgi?id=40972
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Thanks for the bug report and patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Just curious, there are only 3 other expansion sites of this macro.
> Are any of those problematic?  Looks like nop.w, sev.w and b.w?
> 

All three sites are in inline assembly, and I did a bunch of successful
Thumb2 builds using the integrated assembler, so I think all those sites
have been assembled by LLVM successfully.

Also confirmed those three instructions with the reproducer example from
the LLVM bug above.

--
Stefan

>> ---
>> Changes in v2:
>> - Reword commit message to reflect the fact that this is a work around
>>   for LLVM.
>>
>>  arch/arm/include/asm/processor.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
>> index 57fe73ea0f72..5d06f75ffad4 100644
>> --- a/arch/arm/include/asm/processor.h
>> +++ b/arch/arm/include/asm/processor.h
>> @@ -135,8 +135,8 @@ static inline void prefetchw(const void *ptr)
>>         __asm__ __volatile__(
>>                 ".arch_extension        mp\n"
>>                 __ALT_SMP_ASM(
>> -                       WASM(pldw)              "\t%a0",
>> -                       WASM(pld)               "\t%a0"
>> +                       "pldw\t%a0",
>> +                       "pld\t%a0"
>>                 )
>>                 :: "p" (ptr));
>>  }
>> --
>> 2.21.0
>>
