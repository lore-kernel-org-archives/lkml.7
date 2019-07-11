Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A01C74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B905F2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QtY5LSfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfGKRA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:00:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42174 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfGKRA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:00:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so3223262pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GU/67RfZIGaVv3I1gykKW+OAEzbKYvssQxM3jRxvovg=;
        b=QtY5LSfYEvpupp4jevn4Y2xXMuduFeEnqLGM4nvdKFwQSJw4rCnq7IY6Mkn2JlUVsJ
         zICi81PVvBFWPsRhbQ+/T29JbwpyABA2BNqkCU6QYLdJLrjV5oYVutBWUKpBtgVDENRw
         98AuoF+gzRf8vEtDCYMUJ+dZ6Vx9hAE2ErxBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GU/67RfZIGaVv3I1gykKW+OAEzbKYvssQxM3jRxvovg=;
        b=HxjlpFVVn66Z3g2ALHDLxSxQ7ilOVvfDouuqQYzFYa3qgO25lJLELNgOkHNRaGN4Vt
         BXjJA+W7SOUUANHKCnCunODi+yiFW461eNn0t94ZSlq4kHuZ7TfTMtmesAbO51cca7Up
         pDicn3pEi3lT6Or/qnSvYn6IvDv46NYlkRnm4c4kbYrrHOvgAKLrTZTfKP0tDUaiQ3jr
         LgiBkgxw6DpXV5VIQRPKcXqHE1K0s2GqmazPAW6TWe7sqJcKcW+uYE7J82HC8GnKQ+Ic
         1x2yWnB3jpQ7gMF7xWigqVqLTcKuQKXSj2XgaT+qY9PQDlc2H0Qrku2Moo2li8g1NH/j
         QoRg==
X-Gm-Message-State: APjAAAUS+msXBbFMfQiJBGXW7CgPKdkEVoBTrJBLdDjpTYAQ4vuC9Xhq
        6oYNgoTe5N3TLgRx5OgyyKflnw==
X-Google-Smtp-Source: APXvYqwGhoEYKDDfuMlPsdi0PmR11605QNQVDKDRZbg0XiTefEm9hfAXshYIUX8kqkFFYG+E73koJA==
X-Received: by 2002:a17:90a:d998:: with SMTP id d24mr5929058pjv.89.1562864427900;
        Thu, 11 Jul 2019 10:00:27 -0700 (PDT)
Received: from [10.67.49.31] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r13sm7233865pfr.25.2019.07.11.10.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:00:27 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] KASan for arm
To:     Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>, christoffer.dall@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>, jinb.park7@gmail.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        liuwenliang@huawei.com, Rob Landley <rob@landley.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>, thgarnie@google.com,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andre Przywara <andre.przywara@arm.com>,
        julien.thierry@arm.com, drjones@redhat.com, philip@cog.systems,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        kasan-dev@googlegroups.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvmarm@lists.cs.columbia.edu,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
References: <20190617221134.9930-1-f.fainelli@gmail.com>
 <CACRpkdbqW2kJNdPi6JPupaHA_qRTWG-MsUxeCz0c38MRujOSSA@mail.gmail.com>
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
Message-ID: <0ba50ae2-be09-f633-ab1f-860e8b053882@broadcom.com>
Date:   Thu, 11 Jul 2019 10:00:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACRpkdbqW2kJNdPi6JPupaHA_qRTWG-MsUxeCz0c38MRujOSSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/19 2:06 PM, Linus Walleij wrote:
> Hi Florian,
> 
> On Tue, Jun 18, 2019 at 12:11 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> Abbott submitted a v5 about a year ago here:
>>
>> and the series was not picked up since then, so I rebased it against
>> v5.2-rc4 and re-tested it on a Brahma-B53 (ARMv8 running AArch32 mode)
>> and Brahma-B15, both LPAE and test-kasan is consistent with the ARM64
>> counter part.
>>
>> We were in a fairly good shape last time with a few different people
>> having tested it, so I am hoping we can get that included for 5.4 if
>> everything goes well.
> 
> Thanks for picking this up. I was trying out KASan in the past,
> got sidetracked and honestly lost interest a bit because it was
> boring. But I do realize that it is really neat, so I will try to help
> out with some review and test on a bunch of hardware I have.
> 
> At one point I even had this running on the ARMv4 SA1100
> (no joke!) and if I recall correctly, I got stuck because of things
> that might very well have been related to using a very fragile
> Arm testchip that later broke down completely in the l2cache
> when we added the spectre/meltdown fixes.

A blast from the past!

> 
> I start reviewing and testing.

Great, thanks a lot for taking a look. FYI, I will be on holiday from
July 19th till August 12th, if you think you have more feedback between
now and then, I can try to pick it up and submit a v7 with that feedback
addressed, or it will happen when I return, or you can pick it up if you
refer, all options are possible!

@Arnd, should we squash your patches in as well?
-- 
Florian
