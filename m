Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A53BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277542087C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="fT/td5/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfCFH6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:58:50 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:35666 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFH6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:58:47 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id CFCCE5C0878;
        Wed,  6 Mar 2019 08:58:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1551859123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j62psRips7w+AV5XkJWTeBZt6Uz5zCpP5GEzVKosuGE=;
        b=fT/td5/5Cwpf0st+1O1UdOMaIGjPRdDF6S/ctObGmKvIHA4XW8WWjdxTWtuvQREFHb3Q1w
        IR9tHxkHeUVrmwp7oHretImEvMuFR+PvYKkM9UwBYSPAK0dRz9FV68v4UssvkUVTORW6Mg
        SwER9EV3qAeKla9uiGJSUQrKHJRYYRo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Mar 2019 08:58:43 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux@armlinux.org.uk, nicolas.pitre@linaro.org,
        mark.rutland@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, julien.thierry@arm.com,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, natechancellor@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: drop unnecessary WASM
In-Reply-To: <cdf451c0-3947-9be1-3bee-2366577c4c5f@arm.com>
References: <13835555f8ef44b21d1b7ddfe1c4203d0981f77e.1551824161.git.stefan@agner.ch>
 <cdf451c0-3947-9be1-3bee-2366577c4c5f@arm.com>
Message-ID: <1a23b99ac6319815dd23e2df4e4cd064@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.2019 00:39, Robin Murphy wrote:
> Hi Stefan,
> 
> On 2019-03-05 10:18 pm, Stefan Agner wrote:
>> The W macro for generating wide instructions when targeting Thumb-2
>> is not required for the preload data instructions (pld, pldw) since
>> they are only available as wide instructions. The GNU assembler seems
>> to work with or without the .w appended when compiling an Thumb-2
>> kernel. However, Clang's integrated assembler does not consider the
>> .w variants as valid instructions:
>>
>>    ./arch/arm/include/asm/processor.h:133:5: error: invalid instruction
>>                            "pldw.w\t%a0 \n"
>>                             ^
>>    <inline asm>:2:1: note: instantiated into assembly here
>>    pldw.w  [r0]
>>    ^
>>    1 error generated.
> 
> Have you filed a bug against Clang for that? Something like "pldwal.w"
> may be super-redundant, but it's still perfectly valid syntax. The
> "Standard assembler syntax fields" section of the Arm ARM even calls
> out that "...the .W qualifier has no effect" on ARM/A32 instructions
> since they are inherently 32-bit; that should equally apply for 32-bit
> only Thumb/T32 instructions. There are certainly a few instructions
> which don't allow a condition code (even "AL"), but off-hand I don't
> remember any not having the optional {<q>} field in their syntax.

Good point, bug filed:
https://bugs.llvm.org/show_bug.cgi?id=40972

Will send a v2 and note that this is a work around for Clang and
reference the bug.

--
Stefan

> 
> That said, obviously the patch itself is no problem since the syntax
> *is* redundant here, but it really is just a workaround for an
> assembler bug.
> 
> Robin.
> 
>> Drop the macro to make sure non-wide variants of pld and pldw are
>> emitted in all cases.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>   arch/arm/include/asm/processor.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
>> index 120f4c9bbfde..042d77cf686d 100644
>> --- a/arch/arm/include/asm/processor.h
>> +++ b/arch/arm/include/asm/processor.h
>> @@ -131,8 +131,8 @@ static inline void prefetchw(const void *ptr)
>>   	__asm__ __volatile__(
>>   		".arch_extension	mp\n"
>>   		__ALT_SMP_ASM(
>> -			WASM(pldw)		"\t%a0",
>> -			WASM(pld)		"\t%a0"
>> +			"pldw\t%a0",
>> +			"pld\t%a0"
>>   		)
>>   		:: "p" (ptr));
>>   }
>>
