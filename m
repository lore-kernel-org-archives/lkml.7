Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136ADC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57982075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cOoelbzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfKUKvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:51:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35490 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUKvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:51:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id r7so2702233ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FdEPe6fpUNXI9/WAZZIOxWELNA+kAoI7dzDky4bTZis=;
        b=cOoelbzVpuDCXItrFwxTJF/U/0gy8t5gB2RgT8FVGP8uiqR75cwQA4BAtqadKS31di
         7G5OJUuaQOGdSbOXKXffvaGa9BFA4s8NJhxsv7eaYcoczQfAPyweOCCyRDu+oKVNkB0r
         MlUf6jOKZrG14pcYrk0WLpVdLeXGhoCPR22tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FdEPe6fpUNXI9/WAZZIOxWELNA+kAoI7dzDky4bTZis=;
        b=pLufeJ/qq7Gm+/O/6w4vPlYlEJHZXP12boluxF+ClIyPSed3eCpwbt4s7AOjPatkv7
         qD2wcG+RADlY06YuCWfidk/XH92txpb5cgLlqkYG80Oan4vw/8j+6k2EB5kqf/hChdOj
         RSTKlpCSHFrjf3rvCF/wwXLOxnTV4S3vRsdWTzKgfAzKyChS6TOrcLM8anwqDhxdxxcK
         7K9p/BGLjcP7Y9xBswQ+sfzWtkPWhOv1jSJXbr2mqe7NFHYel7LjOdzLeedrklaxTWY+
         7xBpZQtQmzyR0YkA0XiCdTODWmOlQbbYxI10IMy3vobtX32uC4LtQmrycROFDWD0Qa67
         Xvbw==
X-Gm-Message-State: APjAAAWXfeg7iwijdcivVtePpxm/UOweiQRIEkw+N3pHjAOg0zSNq21/
        pUgZBxLboOvRfOYXFgB73cNfiQ==
X-Google-Smtp-Source: APXvYqwsrJHfNqQKBJ6Az9UWRwDqhmW2Ry/0CYXbRk7uXrYHeOnurDm9is8KSqA1zJkocIOHYpYdEA==
X-Received: by 2002:a2e:9e97:: with SMTP id f23mr6817404ljk.89.1574333493384;
        Thu, 21 Nov 2019 02:51:33 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p18sm1167891lfh.24.2019.11.21.02.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 02:51:32 -0800 (PST)
Subject: Re: [PATCH] export.h: reduce __ksymtab_strings string duplication by
 using "MS" section flags
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20191120145110.8397-1-jeyu@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <93d3936d-0bc4-9639-7544-42a324f01ac1@rasmusvillemoes.dk>
Date:   Thu, 21 Nov 2019 11:51:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120145110.8397-1-jeyu@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2019 15.51, Jessica Yu wrote:
> 
> We can alleviate this situation by utilizing the SHF_MERGE and
> SHF_STRING section flags. SHF_MERGE|SHF_STRING indicate to the linker
> that the data in the section are null-terminated strings 

[pet peeve: nul, not null.]

> As of v5.4-rc5, the following statistics were gathered with x86
> defconfig with approximately 10.7k exported symbols.
> 
> Size of __ksymtab_strings in vmlinux:
> -------------------------------------
> v5.4-rc5: 213834 bytes
> v5.4-rc5 with commit c3a6cf19e695: 224455 bytes
> v5.4-rc5 with this patch: 205759 bytes
> 
> So, we already see memory savings of ~8kB compared to vanilla -rc5 and
> savings of nearly 18.7kB compared to -rc5 with commit c3a6cf19e695 on top.

Yippee :) Thanks for picking up the ball and sending this.

>  /*
> - * note on .section use: @progbits vs %progbits nastiness doesn't matter,
> - * since we immediately emit into those sections anyway.
> + * note on .section use: we specify @progbits vs %progbits since usage of
> + * "M" (SHF_MERGE) section flag requires it.
>   */
> +
> +#ifdef CONFIG_ARM
> +#define ARCH_PROGBITS %progbits
> +#else
> +#define ARCH_PROGBITS @progbits
> +#endif

Did you figure out a way to determine if ARM is the only odd one? I was
just going by gas' documentation which mentions ARM as an example, but
doesn't really provide a way to know what each arch uses. I suppose 0day
will tell us shortly.

If we want to avoid arch-ifdefs in these headers (and that could become
unwieldy if ARM is not the only one) I think one could add a
asm-generic/progbits.h, add progbits.h to mandatory-y in
include/asm-generic/Kbuild, and then just provide a progbits.h on ARM
(and the other exceptions) - then I think the kbuild logic automatically
makes "#include <asm/progbits.h>" pick up the right one. And the header
could define ARCH_PROGBITS with or without the double quotes depending
on __ASSEMBLY__.

OTOH, adding a whole new header just for this may be overkill.

Rasmus
