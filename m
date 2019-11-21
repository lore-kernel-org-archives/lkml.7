Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23642C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5EC20643
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574352570;
	bh=qtUc667Q7wg3zPw/QS2ID8HQ0EtL7AIUIqStkjbd7cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hkAt7hKt23OxwYT7HmyVK7i1GP5IahTCi6hp4ACbB1mgH/GMjo3LBkZvXcffi3cSG
	 3gQImnai4nlIBekdg8YZE/gI90g1/wcuzlpC29YLpFP8TRVd9+v40iiVwBLdLyPhGo
	 Bf0Y9SV6ag8ct0b/rJwezDIKo0a57nLmajCB99k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKUQJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfKUQJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:09:28 -0500
Received: from linux-8ccs (x2f7fc2f.dyn.telefonica.de [2.247.252.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B27D720637;
        Thu, 21 Nov 2019 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574352567;
        bh=qtUc667Q7wg3zPw/QS2ID8HQ0EtL7AIUIqStkjbd7cA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=axuEVukImzj09aDRfgD0HEvDjkLBonuEsdqPIqsk/jzxmUCSf3WwcM4T9k6PSIHZ/
         aYSMIAn0RNztBzBqJL9iwr0ncM4mHN5OLlF+r3q5QxHMBq7wc1TwubSDmpjc1oKySF
         Va2bMW6iBG85yVmbUa7rFzwXzaV+U6Qz639NYiOM=
Date:   Thu, 21 Nov 2019 17:09:20 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] export.h: reduce __ksymtab_strings string duplication by
 using "MS" section flags
Message-ID: <20191121160919.GB22213@linux-8ccs>
References: <20191120145110.8397-1-jeyu@kernel.org>
 <93d3936d-0bc4-9639-7544-42a324f01ac1@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <93d3936d-0bc4-9639-7544-42a324f01ac1@rasmusvillemoes.dk>
X-OS:   Linux linux-8ccs 5.4.0-rc5-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Rasmus Villemoes [21/11/19 11:51 +0100]:
>On 20/11/2019 15.51, Jessica Yu wrote:
>>
>> We can alleviate this situation by utilizing the SHF_MERGE and
>> SHF_STRING section flags. SHF_MERGE|SHF_STRING indicate to the linker
>> that the data in the section are null-terminated strings
>
>[pet peeve: nul, not null.]

Ah, right you are!

>> As of v5.4-rc5, the following statistics were gathered with x86
>> defconfig with approximately 10.7k exported symbols.
>>
>> Size of __ksymtab_strings in vmlinux:
>> -------------------------------------
>> v5.4-rc5: 213834 bytes
>> v5.4-rc5 with commit c3a6cf19e695: 224455 bytes
>> v5.4-rc5 with this patch: 205759 bytes
>>
>> So, we already see memory savings of ~8kB compared to vanilla -rc5 and
>> savings of nearly 18.7kB compared to -rc5 with commit c3a6cf19e695 on top.
>
>Yippee :) Thanks for picking up the ball and sending this.

And thanks for the idea in the first place :-)

>>  /*
>> - * note on .section use: @progbits vs %progbits nastiness doesn't matter,
>> - * since we immediately emit into those sections anyway.
>> + * note on .section use: we specify @progbits vs %progbits since usage of
>> + * "M" (SHF_MERGE) section flag requires it.
>>   */
>> +
>> +#ifdef CONFIG_ARM
>> +#define ARCH_PROGBITS %progbits
>> +#else
>> +#define ARCH_PROGBITS @progbits
>> +#endif
>
>Did you figure out a way to determine if ARM is the only odd one? I was
>just going by gas' documentation which mentions ARM as an example, but
>doesn't really provide a way to know what each arch uses. I suppose 0day
>will tell us shortly.

I *think* so. At least, I was going off of
drivers/base/firmware_loader/builtin/Makefile and
scripts/recordmcount.pl, which were the only other places that I found
that reference the %progbits vs @progbits oddity. They only use
%progbits in the case of CONFIG_ARM and @progbits for other
arches. I wasn't sure about arm64, but I looked at the assembly files
gcc produced and it looked like @progbits was used there. Added some
arm64 people to CC since they would know :-)

>If we want to avoid arch-ifdefs in these headers (and that could become
>unwieldy if ARM is not the only one) I think one could add a
>asm-generic/progbits.h, add progbits.h to mandatory-y in
>include/asm-generic/Kbuild, and then just provide a progbits.h on ARM
>(and the other exceptions) - then I think the kbuild logic automatically
>makes "#include <asm/progbits.h>" pick up the right one. And the header
>could define ARCH_PROGBITS with or without the double quotes depending
>on __ASSEMBLY__.

I think this would work, and it feels like the more correct solution
especially if arm isn't the only one with the odd progbits char. It
might be overkill if it's just arm that's affected though. I leave it
to Masahiro to see what he prefers.

Thanks!

Jessica


