Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C3EC2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5657324670
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1LXHG0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLGWY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 17:24:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41403 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfLGWYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 17:24:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id bd4so4199620plb.8;
        Sat, 07 Dec 2019 14:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ExI/TKDdtqZJzeoXoc2AmfkP7V2dbpxkrYjX02g6qW8=;
        b=U1LXHG0VqwagIGA58czXmw1H4VD/s4EQgeoMRqcaqrB4IHMlYDFRyLonTr3/YNyqfQ
         ssWFu20NjDv55dUc6YSELfgM2hGxVqpE8E2EEzCeiNr28psNeLADRkC67b4dZTnX/8Ag
         GF/Xij3GKtlCwBTwIUNgng+p82rkDjxUGC/UUdPzLyewnRZ/IVHBTNcp0HWBA3z/TW6X
         sSoufAOKOQoQcSbrKpW+SY18KjvhVrhMuBT7tDuv3fahEWQUEeRAc1n/AiFKO5R1oGGF
         qUznNHp8pumNfO7tnNk9ZTzOCPpdEKHxPLSX610n37BAZJ16kc2fIFso407JTCNEbQlv
         sd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ExI/TKDdtqZJzeoXoc2AmfkP7V2dbpxkrYjX02g6qW8=;
        b=S6KWBgTUtP0hZ4PV3OmTaoRDzQXo1y73eSnPxCEsAxBu74Vz+lBpfRwUELFJH9O/uU
         p8XxywAROP4uXrDt9Mzvwc8CYmkaH9eIhUJYRu2xPQqh4TkXIX+BP6vdw8ivf0p/jjSd
         v/jyy49emjTQpsMbB3KE2p2AT/YXidl7WVtGAEstigBiuHcNnpApIJ/cOGCsvXv/Agl9
         uYk0NNHwwKYG+FqUOYYiF9eWtVkLrXbSSj4hMZVYyZaoL8dzmdB/1dgjqGlotSn6Usdo
         4SMnvKHtIQcwnafC2Taka1A6pi9/tTegRtZVJZffslck5y+ylGqtvAl2lyIS2vZSwwls
         7ECQ==
X-Gm-Message-State: APjAAAUAWfihxU7kzGDNtfgprA7bww9LHBireY0BIHDYRhmb9LHmugr4
        hsSBmarKbQnAF+yF7HK9M6s=
X-Google-Smtp-Source: APXvYqx7bStIx6xSAxvlhcLeWquMhjmkWNjHW7tGd9W2s1pTJYJMoxzoc3cto86XzIWwTO2kvqyL3Q==
X-Received: by 2002:a17:90a:2486:: with SMTP id i6mr24849994pje.9.1575757493839;
        Sat, 07 Dec 2019 14:24:53 -0800 (PST)
Received: from [192.168.0.53] ([211.243.117.64])
        by smtp.gmail.com with ESMTPSA id w11sm16400204pfn.4.2019.12.07.14.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 14:24:53 -0800 (PST)
Subject: Re: [PATCH 1/2] irqchip: define EXYNOS_IRQ_COMBINER
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux@armlinux.org.uk, kgene@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Hyunki Koo <hyunki00.koo@samsung.com>
References: <20191207130049.27533-1-hyunki00.koo@gmail.com>
 <20191207130049.27533-2-hyunki00.koo@gmail.com>
 <20191207132855.GA4384@kozik-lap>
 <CAJKOXPcUXRGa7+ZgSYomo5v_eh=GjqyWYBkzsXUJi0zAPHcOjg@mail.gmail.com>
From:   Hyunki Koo <hyunki00.koo@gmail.com>
Message-ID: <e6c3661e-36df-5ae8-eedb-1961063bcabb@gmail.com>
Date:   Sun, 8 Dec 2019 07:24:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcUXRGa7+ZgSYomo5v_eh=GjqyWYBkzsXUJi0zAPHcOjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19. 12. 7. 오후 10:37, Krzysztof Kozlowski wrote:
> On Sat, 7 Dec 2019 at 14:28, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On Sat, Dec 07, 2019 at 10:00:48PM +0900, Hyunki Koo wrote:
>>> From: Hyunki Koo <hyunki00.koo@samsung.com>
>>>
>>> Not all exynos device have IRQ_COMBINER.
>>> Thus add the config for EXYNOS_IRQ_COMBINER.
>>>
>>> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
>>> ---
>>>   drivers/irqchip/Kconfig  | 7 +++++++
>>>   drivers/irqchip/Makefile | 2 +-
>>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>> Hi,
>>
>> There is no changelog and versioning of this patch so I do not
>> understand how it differs with previous. It's a resend? v2? It brings
>> the confusion and looks like you're ignoring previous comments.
>>
>> Looks the same and looks like breaking Exynos platforms in the same way.
>>
>> If you not want to skip combiner on ARMv8, it makes sense, then please
>> follow the approach we did for Pinctrl drivers (PINCTRL_EXYNOS_ARM and
>> PINCTRL_EXYNOS_ARM64).
>>
>> Best regards,
>> Krzysztof
> Ah, now I see the second patch. Still you break bisect which requires
> specific ordering of patches or squashing them into one. Optionally
> this could be default=y if ARCH_EXYNOS && ARM. I prefer just squashing
> both into one patch in this case.

you mean squashing two files arch/arm/mach-exynos/Kconfig and 
arch/arm/mach-exynos/Kconfig into one patch

or squashing into only one file like blow?

+config EXYNOS_IRQ_COMBINER
+       bool "Samsung Exynos IRQ combiner support"
+       depends on (ARCH_EXYNOS  && ARM) || COMPILE_TEST
+       default y

I prefer first one (squashing two files into one patch)

>
>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>>> index ba152954324b..3ed7b7f2ae26 100644
>>> --- a/drivers/irqchip/Kconfig
>>> +++ b/drivers/irqchip/Kconfig
>>> @@ -499,4 +499,11 @@ config SIFIVE_PLIC
>>>
>>>           If you don't know what to do here, say Y.
>>>
>>> +config EXYNOS_IRQ_COMBINER
>>> +     bool "Samsung Exynos IRQ combiner support"
> Now point it to be visible. Only for COMPILE_TEST
>
>>> +     depends on ARCH_EXYNOS
> Since you make it a separate option, make it COMPILE_TEST.

Is this  good ?

+config EXYNOS_IRQ_COMBINER

+       bool "Samsung Exynos IRQ combiner support"
+       depends on (ARCH_EXYNOS  && ARM) || COMPILE_TEST

>
> Best regards,
> Krzysztof
>
>>> +     help
>>> +       Say yes here to add support for the IRQ combiner devices embedded
>>> +       in Samsung Exynos chips.
>>> +
>>>   endmenu
>>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>>> index e806dda690ea..60d7c7260fc3 100644
>>> --- a/drivers/irqchip/Makefile
>>> +++ b/drivers/irqchip/Makefile
>>> @@ -9,7 +9,7 @@ obj-$(CONFIG_ARCH_BCM2835)            += irq-bcm2835.o
>>>   obj-$(CONFIG_ARCH_BCM2835)           += irq-bcm2836.o
>>>   obj-$(CONFIG_DAVINCI_AINTC)          += irq-davinci-aintc.o
>>>   obj-$(CONFIG_DAVINCI_CP_INTC)                += irq-davinci-cp-intc.o
>>> -obj-$(CONFIG_ARCH_EXYNOS)            += exynos-combiner.o
>>> +obj-$(CONFIG_EXYNOS_IRQ_COMBINER)    += exynos-combiner.o
>>>   obj-$(CONFIG_FARADAY_FTINTC010)              += irq-ftintc010.o
>>>   obj-$(CONFIG_ARCH_HIP04)             += irq-hip04.o
>>>   obj-$(CONFIG_ARCH_LPC32XX)           += irq-lpc32xx.o
>>> --
>>> 2.17.1
>>>
