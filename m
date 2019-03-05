Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4599620652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="e3SUrqCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfCEWkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:40:10 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:57450 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEWkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:40:10 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 7D36C5C0816;
        Tue,  5 Mar 2019 23:40:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1551825608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQfb3QbroPrfgtYXjPkGa7eeT2bgaoktns9dhI1//as=;
        b=e3SUrqCXQpmAs0tM+ooqAT4LQ0XgmJiiXFnHIjs9PuAf5sMkX5vuAwN37h9ghBtGGrgQ6h
        R2cr+uXKnxXLcHdRKze9Nsl7iv3vwutJvzAl4gg2Z0TDvPw9rLbi2Igufd34/3ybODQVYj
        TKKAL1/YswwjzojdQZlOoZphm8m86eU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Mar 2019 23:40:08 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        julien.thierry@arm.com, Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] ARM: drop -mauto-it
In-Reply-To: <CAKwvOd=1sEfg94kg6gbjCrrn3Wcp7BuwWKtGdD9pr_+P03eTMQ@mail.gmail.com>
References: <13835555f8ef44b21d1b7ddfe1c4203d0981f77e.1551824161.git.stefan@agner.ch>
 <7b70b64738db468ab3b830c503524058163b5c3f.1551824161.git.stefan@agner.ch>
 <CAKwvOd=1sEfg94kg6gbjCrrn3Wcp7BuwWKtGdD9pr_+P03eTMQ@mail.gmail.com>
Message-ID: <f822090431e21d31b0b4fcd98c983d60@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.03.2019 23:21, Nick Desaulniers wrote:
> On Tue, Mar 5, 2019 at 2:17 PM Stefan Agner <stefan@agner.ch> wrote:
>>
>> The assembler option -mauto-it is no longer a valid option. It has
>> been removed from the documentation in July 2009, which is well
>> before the release date of the currently supported binutils version
>> 2.20.
> 
> Do you by chance have a link to the relevant commit?
> 

Documentation got removed in
https://github.com/bminor/binutils-gdb/commit/529707530657a333a304c651c808ea630c955223

I think -mauto-it never really made it upstream. Documentation has been
introduced here, but it seems that the option already has been renamed:
https://github.com/bminor/binutils-gdb/commit/e07e6e58be1c5273ed79a25c80ba831e71ac86b1

>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm/Makefile | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index 9561325c5201..ebf67bebe73d 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -113,8 +113,7 @@ CFLAGS_ABI  +=-funwind-tables
>>  endif
>>
>>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
>> -AFLAGS_AUTOIT  :=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
>> -CFLAGS_ISA     :=-mthumb $(AFLAGS_AUTOIT)
>> +CFLAGS_ISA     :=-mthumb -Wa$(comma)-mimplicit-it=always
> 
> Is $(comma) still needed? I thought it was only needed when a flag
> that would contain commas would be in another set of parens (thus
> making an ambiguity), like cc-ldoption or such?  Can you replace
> `$(comma)` here with `,`?  I suspect it should work.

Could catch, yes comma should work here.

--
Stefan
