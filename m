Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B71C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48722184C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tygwppE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbfCQKmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:42:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51036 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfCQKmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 06:42:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so1740766wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=rr2XQQY0S98IGjtgX/+det4iBMjXVIyqfJdXkkSDzJs=;
        b=tygwppE9atD4qLtfFCN8xcRZcqp/1vei8iMh+v3PTg8wIPiqTn7r7/j+AVCxkYzt9k
         3ntmj+GFQwxE/mQBXTfZk7FQVF0aso6NNCkP3mlBLuFLNZ11i2u2fAyKN1f9i6hmwI69
         JRa9wzSqdCnl8wtEuYHa9ZPaTvSkAwF1fsOnZi8RSdedq1g9v6fgLXKJ7O2LC3BAx8HF
         3og0/uYdJQ+RjBuHTPX0RiCdZfY2CZjRSRrnKuANarXcfMiwsAde7ptYEWJ6SUISg+mF
         F/pj4KRPtciojpNaGl3Jjotrz+Qf01alPaWiVwiXrjss7WVrjL5hQwJZ119HiqefDZdO
         75zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=rr2XQQY0S98IGjtgX/+det4iBMjXVIyqfJdXkkSDzJs=;
        b=RXlzuz0MOid8Vf05H5VLVkz4Ni933WRPFFxwjxQD+rPvxmPu4eUyXhkP28MiSdIii0
         RPtG5NSr+JP0zU7qbDrhuxEfpIC45FMzPIOiUMNIwMC2vNfXkioIR6PYtOXqSxQxW4lR
         TG39Nj9UYHnZZcEqFasGT2hz4vt6OyJJi7fKMccFGUwULXNDILsVUeyrYTZ2qmvpSh6U
         ckzrBrxy5XZLVGS++DIylCfuT/7q9LX19r+vkLQlaGTdqe1B5a4uZ40ScJISD506jA5V
         ErqGTqLQ+QVSuKbnf4ca+gfMnMMh6+wVjsuCyWEzX0rohnDHZkn5bkbnxxWvv6lRXeVV
         RPUQ==
X-Gm-Message-State: APjAAAVMdRXhzTHhNA9LiAPxrPcgh8yQUpr3RkO3LTqVULXZ8GxnAAZW
        Xc91UetsLG38J/qNsSSJFYVZnQ==
X-Google-Smtp-Source: APXvYqz50M+S4xWTYCGyJyiMKK2A1dg1v5QnTQmci14qYM9kvCZigF7n8wzjjF8WBY5l+0UHAOSDvg==
X-Received: by 2002:a1c:4044:: with SMTP id n65mr7997626wma.85.1552819330840;
        Sun, 17 Mar 2019 03:42:10 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o8sm8110872wma.1.2019.03.17.03.42.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Mar 2019 03:42:09 -0700 (PDT)
Message-ID: <5C8E2480.8020402@baylibre.com>
Date:   Sun, 17 Mar 2019 11:42:08 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/9] arm64: dts: meson: g12a: Add UART A, B & C nodes
 and pins
References: <20190307151342.7381-1-narmstrong@baylibre.com> <20190307151342.7381-7-narmstrong@baylibre.com> <CAFBinCAa+ZjxJi491_dG+kvLFPLFoLXHFZToGP8W1ECeeqOYVQ@mail.gmail.com> <5C8D099D.5020206@baylibre.com> <CAFBinCBHiLjrwXA4jXSg3qnGa925r--Nj_RH7xUFqyTkYzhKGA@mail.gmail.com>
In-Reply-To: <CAFBinCBHiLjrwXA4jXSg3qnGa925r--Nj_RH7xUFqyTkYzhKGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/03/2019 23:14, Martin Blumenstingl a écrit :
> Hi Neil,
> 
> On Sat, Mar 16, 2019 at 3:35 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>>>> +                                       uart_ao_a_c_pins: uart_ao_a_c {
>>>> +                                               mux {
>>>> +                                                       groups = "uart_ao_a_rx_c",
>>>> +                                                                "uart_ao_a_tx_c";
>>>> +                                                       function = "uart_ao_a_c";
>>>> +                                                       bias-disable;
>>>> +                                               };
>>>> +                                       };
>>> I'm fine with this part if you mention it in the subject and/or the description
>>> uart_ao_a_c routes two pins from bank C (from the EE domain) to the
>>> uart_AO controller (from the AO domain)
>>
>> Not sure DT is the right place for that, I think I'll remove this until
>> we have it actually used somewhere.
> I'm fine with that as well
> 
> [...]
>>>> +
>>>> +                       uart_C: serial@22000 {
>>>> +                               compatible = "amlogic,meson-gx-uart";
>>>> +                               reg = <0x0 0x22000 0x0 0x18>;
>>>> +                               interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
>>>> +                               clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
>>> does uart_C really use CLKID_UART1? on GX uart_C uses CLKID_UART2
>>
>> It seems so :
>> https://github.com/hardkernel/linux/blob/odroidn2-4.9.y/arch/arm64/boot/dts/amlogic/mesong12a.dtsi#L1020
> it's weird but we can always fix it up later if needed. so let's keep
> it for now to stay consistent with the vendor kernel until we know
> better
> 
> Jianxin, can you please check with the hardware team whether the
> uart_C gate clock (pclk) is CLKID_UART1 or CLKID_UART2 on G12A?

I think it's a typo, it should use CLKID_UART2

Neil

> 
> 
> Regards
> Martin
> 
