Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BDEC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE03C21019
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UHjoqITw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfCGMdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:33:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52073 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGMdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:33:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id n19so9081076wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 04:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/q50ecZZR61sGX7s3g//9jg5N10pWQr6sU81Kq0BRwU=;
        b=UHjoqITwQ+q7SXZUv8ZgpFxAn90/twuSJgnSe4Y0BcAV5oPQ1XRRpO3P26Ny3MJBOU
         DHQVVUmVdvKNa/bppRD9IHnXb4VrJi9td0pLvWBM2DahWajJFnjMHucI3aSeVCVieOd6
         WbP9ERoizCHLTvHVDmkouKPXX0M5+/ZSoufMxHR5BDZ6VUaLoItEqqn22pGDDAtMTFym
         a+wlZu4ZhTxXKfTA7nskNJOKhgkPrn8jhRy9tTmgqs6bzcSImIV+PJ6KFYiqmLUjc3C0
         iKniBla5M/AkLpz4otxWFyaQR1HhM0eFI4kfeZotVosxCrZl9ofFjJXjvPL190FvIoLa
         3cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/q50ecZZR61sGX7s3g//9jg5N10pWQr6sU81Kq0BRwU=;
        b=SAv9pqVHuKJK7kXD1XDFPe0jcuAqSYpfUoyiGLtH8bpBR2ffdBRx2QXUVVs1V3oX/i
         1/tBchJ7IzFpJgr4YgeNui378RBsVlxf5XYcW9GToayT6RNfDSmR8qRZd6RZRWYdbpi/
         lsMbFkzW4cOuor9HSrMm1kCX5u0NPTa0pXcF9r/4vRXHKK8UZk56ejDBqlYAVW6wgmsu
         Ij/7BQmzhpFh1JcWDXfEECG/fb7mdJjFCtTPX/AapsjuRdAJtE6ghO17BfOJFs6P5CcD
         fbZgaig/CUWy9yQE3/NlSnKg7UEq5H3LwjVxDtVcRkfPD9VJ4LwH7YPKCNYEVzo3z7pW
         bGHw==
X-Gm-Message-State: APjAAAUejcwjmK5tVzoI9M1ADJCbbrDc92/qu1Tjb8piHPFNAoYzHqzM
        286EaV3/T64T2A7PZBZQB0JtIUl435zBCQ==
X-Google-Smtp-Source: APXvYqypDbk7wxdZ9VKUVGtZupodZqew/nXUwDJ9e9GC6JtWQbp/mb2EA3xhMJNjHgsru8GdqazrbQ==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr5519572wma.114.1551961988200;
        Thu, 07 Mar 2019 04:33:08 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a1sm6638423wrq.96.2019.03.07.04.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 04:33:07 -0800 (PST)
Subject: Re: [PATCH v2 0/2] irqchip/meson-gpio: Add support for Meson-G12A SoC
To:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181205064611.29076-1-xingyu.chen@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <47112db1-76b5-6834-a054-2ed260b94f4d@baylibre.com>
Date:   Thu, 7 Mar 2019 13:33:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181205064611.29076-1-xingyu.chen@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xingyu,

On 05/12/2018 07:46, Xingyu Chen wrote:
> This series try to add GPIO interrupt controller support for Meson-G12A SoCs.
> Although the total number of pins is the same as the Meson-AXG SoC, the gpio
> banks and irq numbers are different. To avoid confusion on use, i think the
> new compatible string is needed.

Could you resent this serie rebased on v5.1-rc1 when tagged ?

Thanks,
Neil

> 
> Changes since v1: [1]
> - share the device data with Meson-AXG
> 
> [1]: https://lore.kernel.org/lkml/20181203061324.36248-1-xingyu.chen@amlogic.com
> 
> Xingyu Chen (2):
>   dt-bindings: interrupt-controller: New binding for Meson-G12A SoC
>   irqchip/meson-gpio: Add support for Meson-G12A SoC
> 
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt    | 1 +
>  drivers/irqchip/irq-meson-gpio.c                                 | 1 +
>  2 files changed, 2 insertions(+)
> 

