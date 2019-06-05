Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDBCC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF6820717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GDQBRzOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFETFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 15:05:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41047 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFETFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 15:05:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id s24so9895207plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 12:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iS6BQh1C6vCLCfActHRCjVYV0hGtWo3NiXD5P8bj2wg=;
        b=GDQBRzOXmregmP/eonPzjTe9knm+yNX+cys1+MeVuz/61vUmh1oWXMwA+r21TqBi1P
         X7tGm8Xq6andxEBOFf6WUpol6Hjc5+IJeVA5FpQsflWBskgxgDIAL0S5AFlIrT+oyv5D
         5p9L+Eu//s13GkK4x2NIviI+2PT9LeOk/vJi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iS6BQh1C6vCLCfActHRCjVYV0hGtWo3NiXD5P8bj2wg=;
        b=mVBDKRDvNxcP1P2qsa3KZDawQtj7thwESlVhB2TOaWISjaCkzvwoqY51YOiuB3Emx6
         HVc2ewLE98QRMJYtwvl7LAwsS8jxiiM2fWlEx4Dld46Mx9COxnvVLacyLGNsWrOzH28V
         r4lmPtW3iLFGFxKqTnFAQqJpae0w8YjO9OfR4cOY901OIa3CaW1dpvTEW0rF11G82M00
         PwEbSdAFP/RosRy4EccKyDv1K8mQTQNmJSIBq6b1eZF2Ui4lSq/0LMtZgPDPF0HY0xCY
         EjWjDPXqYHMAPv1VlWnhoeu7TmOTPPZfxnUQRROFb9mkag17x/bn1CVUzZ1W3o3TtOvl
         cuVg==
X-Gm-Message-State: APjAAAUPNc0Io38vFwJIHe2EmiCR/llvMti9cSS1XDRXqdVntkGnIDM5
        rXJM9RjTk3WMruPkeSOwQKDQJbItqRJUvZzzHngwcQl/EHLY7PfVmaS4+8AeHtYC2ZonCiawXrt
        W26ZR7SUJ74fLEAFY8yaCr9IpfI8/Kg60XjTx71BsytccdcuyFVystcf0COw2480x25rJAlentU
        AAGoBIFcXU8g==
X-Google-Smtp-Source: APXvYqyxh6Sy/dh/uh0PdYOiT611tPfPb8XrWlNhzmqLlD5pfKUlETsTReuXly5uvSnayQvH8yBbdQ==
X-Received: by 2002:a17:902:2847:: with SMTP id e65mr43108666plb.319.1559761537974;
        Wed, 05 Jun 2019 12:05:37 -0700 (PDT)
Received: from [10.67.49.123] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j20sm18062211pff.183.2019.06.05.12.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:05:36 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] ARM: use arch_extension directive instead of arch
 argument
To:     Stefan Agner <stefan@agner.ch>, arm@kernel.org, olof@lixom.net
Cc:     linux@armlinux.org.uk, arnd@arndb.de, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, nico@fluxnic.net, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kgene@kernel.org,
        krzk@kernel.org, robh@kernel.org, ssantosh@kernel.org,
        jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, tony@atomide.com,
        marc.w.gonzalez@free.fr, mans@mansr.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <c0ca465daa7c7663c19b0bcb848c70e8da22baff.1558996564.git.stefan@agner.ch>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Openpgp: preference=signencrypt
Autocrypt: addr=florian.fainelli@broadcom.com; prefer-encrypt=mutual; keydata=
 mQENBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAG0MEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPokB
 xAQQAQgArgUCXJvPrRcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFrZXktdXNh
 Z2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2RpbmdAcGdw
 LmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29tLmNvbQUb
 AwAAAAMWAgEFHgEAAAAEFQgJCgAKCRCBMbXEKbxmoE4DB/9JySDRt/ArjeOHOwGA2sLR1DV6
 Mv6RuStiefNvJ14BRfMkt9EV/dBp9CsI+slwj9/ZlBotQXlAoGr4uivZvcnQ9dWDjTExXsRJ
 WcBwUlSUPYJc/kPWFnTxF8JFBNMIQSZSR2dBrDqRP0UWYJ5XaiTbVRpd8nka9BQu4QB8d/Bx
 VcEJEth3JF42LSF9DPZlyKUTHOj4l1iZ/Gy3AiP9jxN50qol9OT37adOJXGEbix8zxoCAn2W
 +grt1ickvUo95hYDxE6TSj4b8+b0N/XT5j3ds1wDd/B5ZzL9fgBjNCRzp8McBLM5tXIeTYu9
 mJ1F5OW89WvDTwUXtT19P1r+qRqKuQENBFPAG8EBCACsa+9aKnvtPjGAnO1mn1hHKUBxVML2
 C3HQaDp5iT8Q8A0ab1OS4akj75P8iXYfZOMVA0Lt65taiFtiPT7pOZ/yc/5WbKhsPE9dwysr
 vHjHL2gP4q5vZV/RJduwzx8v9KrMZsVZlKbvcvUvgZmjG9gjPSLssTFhJfa7lhUtowFof0fA
 q3Zy+vsy5OtEe1xs5kiahdPb2DZSegXW7DFg15GFlj+VG9WSRjSUOKk+4PCDdKl8cy0LJs+r
 W4CzBB2ARsfNGwRfAJHU4Xeki4a3gje1ISEf+TVxqqLQGWqNsZQ6SS7jjELaB/VlTbrsUEGR
 1XfIn/sqeskSeQwJiFLeQgj3ABEBAAGJAkEEGAECASsFAlPAG8IFGwwAAADAXSAEGQEIAAYF
 AlPAG8EACgkQk2AGqJgvD1UNFQgAlpN5/qGxQARKeUYOkL7KYvZFl3MAnH2VeNTiGFoVzKHO
 e7LIwmp3eZ6GYvGyoNG8cOKrIPvXDYGdzzfwxVnDSnAE92dv+H05yanSUv/2HBIZa/LhrPmV
 hXKgD27XhQjOHRg0a7qOvSKx38skBsderAnBZazfLw9OukSnrxXqW/5pe3mBHTeUkQC8hHUD
 Cngkn95nnLXaBAhKnRfzFqX1iGENYRH3Zgtis7ZvodzZLfWUC6nN8LDyWZmw/U9HPUaYX8qY
 MP0n039vwh6GFZCqsFCMyOfYrZeS83vkecAwcoVh8dlHdke0rnZk/VytXtMe1u2uc9dUOr68
 7hA+Z0L5IQAKCRCBMbXEKbxmoLoHCACXeRGHuijOmOkbyOk7x6fkIG1OXcb46kokr2ptDLN0
 Ky4nQrWp7XBk9ls/9j5W2apKCcTEHONK2312uMUEryWI9BlqWnawyVL1LtyxLLpwwsXVq5m5
 sBkSqma2ldqBu2BHXZg6jntF5vzcXkqG3DCJZ2hOldFPH+czRwe2OOsiY42E/w7NUyaN6b8H
 rw1j77+q3QXldOw/bON361EusWHdbhcRwu3WWFiY2ZslH+Xr69VtYAoMC1xtDxIvZ96ps9ZX
 pUPJUqHJr8QSrTG1/zioQH7j/4iMJ07MMPeQNkmj4kGQOdTcsFfDhYLDdCE5dj5WeE6fYRxE
 Q3up0ArDSP1L
Message-ID: <7d054879-ea11-d3e4-de5c-f35504039104@broadcom.com>
Date:   Wed, 5 Jun 2019 12:05:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c0ca465daa7c7663c19b0bcb848c70e8da22baff.1558996564.git.stefan@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/19 3:40 PM, Stefan Agner wrote:
> The LLVM Target parser currently does not allow to specify the security
> extension as part of -march (see also LLVM Bug 40186 [0]). When trying
> to use Clang with LLVM's integrated assembler, this leads to build
> errors such as this:
>   clang-8: error: the clang compiler does not support '-Wa,-march=armv7-a+sec'
> 
> Use ".arch_extension sec" to enable the security extension in a more
> portable fasion. Also make sure to use ".arch armv7-a" in case a v6/v7
> multi-platform kernel is being built.
> 
> Note that this is technically not exactly the same as the old code
> checked for availabilty of the security extension by calling as-instr.
> However, there are already other sites which use ".arch_extension sec"
> unconditionally, hence de-facto we need an assembler capable of
> ".arch_extension sec" already today (arch/arm/mm/proc-v7.S). The
> arch extension "sec" is available since binutils 2.21 according to
> its documentation [1].
> 
> [0] https://bugs.llvm.org/show_bug.cgi?id=40186
> [1] https://sourceware.org/binutils/docs-2.21/as/ARM-Options.html
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Mans Rullgard <mans@mansr.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> Changes since v1:
> - Explicitly specify assembler architecture as armv7-a to avoid
>   build issues when bulding v6/v7 multi arch kernel.
> 
> Changes since v2:
> - Add armv7-a also in mach-tango
> - Move .arch armv7-a outside of ifdef'ed area in sleep44xx.S
>   to make the kernel compile also without CONFIG_SMP/PM.
> 
> Changes since v3:
> - Rebase on top of v5.2-rc2
> 
>  arch/arm/mach-bcm/Makefile         | 3 ---

For mach-bcm:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
