Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C2FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7A420659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="COChlb5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393738AbfJXNpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:45:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34639 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393632AbfJXNpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:45:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so25113536lja.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/fWYhCmJ93NQhT0I63wTXutn+dxi511+rgvXvN58Juw=;
        b=COChlb5Mp2PZWd2gN4YbVP4ENvRu9Tw+0i1E65YlR/n6dbdc00DDRL9BlVyRNiMzYo
         6Yi2HjsraB7heDkJ5SbI744uW2oJLsgjAAcCh0u5XHnKl7UmZWz07cVo9m2hjofK+R8K
         Xat1zC5Pb9+DssUbOVRAaNt8qxC53pcGyoGTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/fWYhCmJ93NQhT0I63wTXutn+dxi511+rgvXvN58Juw=;
        b=mhG4zrtrqGmNSSML8b94UuL00PnkxEDIMUJKT5nZJMVL5Q0u29DCXqDlsTjBDYZZ9+
         RqtySC7UvAo9N/icWmbZKG2vXeIlTBAT60U2cjQBlapryfYVg0iv+bALkyJAtGOFdJor
         e4oN1/ozOG6T1LnRkf2A+/pzGRO5/IvGX495278+HaTK5onlAhTIayyMfICByBZG7UOz
         lvS0Hw9wPriVvGHl6EZX57pltsbd9kG6sf7rhs0BfPRXiGraKHdfseSBagOELbf5+M2S
         +SNPoIdW1QaG82Abe2jwbJYYb0l4WuU+xsKfE1wGyn2mXUS8RGK/fb524dvJa8UT3N27
         FHdw==
X-Gm-Message-State: APjAAAWmXY2oGALK+zWvWc4SDUtuvF59PtZXeux6zpNqTKzl9Lg39Xnn
        d3af2b4pwy67hp6qpfHussikfw==
X-Google-Smtp-Source: APXvYqy2DBWkOtEXsuzhsqwJjpCTQz3sNvep3L9L8lQliUGX0tAat3ID5dEFH7aEnbHO+0vQecjBwA==
X-Received: by 2002:a2e:b4e8:: with SMTP id s8mr7270549ljm.73.1571924722093;
        Thu, 24 Oct 2019 06:45:22 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o196sm10069411lff.59.2019.10.24.06.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 06:45:21 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] decompress/keepalive.h: add config option for
 toggling a set of bits
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>
References: <20191017114906.30302-1-linux@rasmusvillemoes.dk>
 <20191017114906.30302-4-linux@rasmusvillemoes.dk>
 <CACRpkdYpnX0JMT9tG8AYhRQiXo90GJoF_J8c6f+KoWKvZmyj-g@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <23b46dec-30f5-29a1-7bca-99d3af10c98e@rasmusvillemoes.dk>
Date:   Thu, 24 Oct 2019 15:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYpnX0JMT9tG8AYhRQiXo90GJoF_J8c6f+KoWKvZmyj-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2019 14.17, Linus Walleij wrote:
> On Thu, Oct 17, 2019 at 1:49 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> 
>> +config DECOMPRESS_KEEPALIVE_TOGGLE_REG
>> +       hex "Address of register to modify while decompressing"
>> +       help
>> +         Set this to a physical address of a 32-bit memory word to
>> +         modify while decompressing.
>> +
>> +config DECOMPRESS_KEEPALIVE_TOGGLE_MASK
>> +       hex "Bit mask to toggle while decompressing"
>> +       help
>> +         The register selected above will periodically be xor'ed with
>> +         this value during decompression.
> 
> I would not allow users to store these vital hex values in their
> defconfig and other unsafe places. Instead follow the pattern from
> arch/arm/Kconfig.debug for storing the DEBUG_UART_PHYS:
> 
> config DEBUG_UART_PHYS
>         hex "Physical base address of debug UART"
>         default 0x01c20000 if DEBUG_DAVINCI_DMx_UART0
>         default 0x01c28000 if DEBUG_SUNXI_UART0
>         default 0x01c28400 if DEBUG_SUNXI_UART1
> ....
> i.e. make sure to provide the right default values. We probably
> need at least one example for others to follow.
>
> Maybe this is your plan, I don't know, wanted to point it out
> anyways.

The thing is, there is no proper default value for the use cases I have
in mind: Custom hardware based on some SOC, where the designer has wired
on an external gpio-triggered watchdog. That could be gpio 25 of gpio
bank 0, or gpio 2 of gpio bank 3, or ... so I don't see how there could
possibly be any sane default value - the kernel certainly shouldn't grow
a config option for every single custom board out there.

That's why this is different from the previously existing
arch_decomp_wdog - that was (AFAICT) about feeding the SOC's builtin
watchdog.

I realize this is rather specific, and the current implementation for
example won't work if the gpio value cannot be toggled in such a simple
way (perhaps there are separate "set" and "clear" registers or whatnot)
- but as I said, it is sufficient for the many different cases I've seen
so far (and something like my patches have been used for years on those
boards).

An alternative is to simply provide a complete implementation of
decompress_keepalive() (or arch_decomp_wdog if we want to keep that
name) in an external .o/.c/.S file, and do something like

OBJS += $(CONFIG_DECOMP_WDOG:"%"=%)

in arch/foo/boot/compressed/Makefile. Then the physical address etc. do
not get written in Kconfig, and it should work for all cases, including
the ones that need to write 0x55, 0xaa, 0x12 in order to some
SOC-specific register.

Rasmus
