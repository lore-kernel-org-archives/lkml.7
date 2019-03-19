Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F38EC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007BE2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YQKMODLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfCSUX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:23:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51346 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfCSUX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:23:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id n19so18223547wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 13:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ko57RkHWPQkVm3K0JFUtK8DPri+oySpxmdfi+52IKgo=;
        b=YQKMODLNqMN6FtVyX1X/eMBCrG8dI/zrETNzs1EJ7xo7hN4nWve9O5DYfwwcCwgOXN
         o96EjF/NNb0kBkAVsgaImCF2nb2hxP5HbGEeEbY7r+xtH6xGcgCgKQeMd/os7hf6frpx
         g6u231yoQ7rQM+IhsqU+5cx1tmWGNBSZDPUj9dkGCl21TnWuT6WrHh91WKYrMJVTIvG0
         FBOhLo0m7HS76XGlgWvCNbuGKXLFP0niyvBaJs7BNjmBhiKcyUMFIyhxnU5oBudQGxd8
         hCkvNTyJw0DGNuMOLkpK2AL5l66Xyr4zDFyiYrurMVm4g4z340RlqotpUF6Xr04AWJHE
         lGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ko57RkHWPQkVm3K0JFUtK8DPri+oySpxmdfi+52IKgo=;
        b=RuLqBTu5F5C9sgG6sYNAqWrbDlHcWnonWERGpNwJqAaaGDl0vKWqRyvnD7G+kWJ+uT
         1bFaTI+sNRk/W7sFLb4X6zUhDxkIvANxJGsM/GeAmRaockkPuQYFqhabI+J5wEvLTZjP
         81a3PwRj2MDn5qXSImzzn9jxDsReK6gk3YdH5v3TZj3mLgKmzSLGHmdcdJ3GlROR+TNq
         PDZqJIBs3JY34hkSbPsKNuwqlcanvXwsnDoCmBSPWJ7Q7pViztiWJkFcejwFICXB53Gj
         C37k5HtxwPkBWCiGq1tItLCXDSpO2Zc99MHzp5IVq+gISpo6srGxIRMe6QebMI0P7pNt
         AotQ==
X-Gm-Message-State: APjAAAWBBsQwqhHjFf8QfF2Tphxz2yn2oSsjIVFucGc8VtIVZqVrnJ6x
        ytbRF6QJnoDeiy33iPacZUhANBV+hIVhQVHt
X-Google-Smtp-Source: APXvYqzpWjzk3k5cXK3ebbe+B8tX5f+7NHtSlTIxlZ+yPx3/H0J8npMwtEixWgDxP2kPWmaVqw6Ftg==
X-Received: by 2002:a1c:40d6:: with SMTP id n205mr5106851wma.146.1553027034571;
        Tue, 19 Mar 2019 13:23:54 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o20sm43329wmh.21.2019.03.19.13.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 13:23:53 -0700 (PDT)
Subject: Re: [PATCH 0/3] clk: meson: add support for PCIE PLL
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190307141455.23879-1-narmstrong@baylibre.com>
 <2f8d217befcc4fdec36e5a31947cccfe74ccd49f.camel@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <18c924b3-2b06-802d-712a-23f973285128@baylibre.com>
Date:   Tue, 19 Mar 2019 21:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <2f8d217befcc4fdec36e5a31947cccfe74ccd49f.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 11:01, Jerome Brunet wrote:
> On Thu, 2019-03-07 at 15:14 +0100, Neil Armstrong wrote:
>> The Amlogic G12A SoCs embeds a dedicated PLL to feed the USB3+PCIE
>> Combo PHY. This PLL needs a very specific and strict register sequence
>> in order to correcly enable it and deliver the 100MHz reference clock
>> to the Analog PHY.
>>
>> After lot of trials and errors, and since this PLL will ever feed 100MHz
>> with a static configuration, it is simpler to setup a dedicated ops
>> structure with a custom _enable() op applying the init register sequence.
>>
>> The rate calculation ops are kept in order to keep the nominal read
>> ops as-in, but set_rate is removed.
>>
>> With this setup, the PLL can be enabled and disable safely and always have
>> the recommended PLL setup to feed the USB3+PCIE Combo PHY.
>>
>> Neil Armstrong (3):
>>   clk: meson-pll: add reduced specific clk_ops for G12A PCIe PLL
>>   dt-bindings: clk: g12a-clkc: add PCIE PLL clock ID
>>   clk: meson-g12a: add PCIE PLL clocks
>>
>>  drivers/clk/meson/clk-pll.c           |  26 ++++++
>>  drivers/clk/meson/clk-pll.h           |   1 +
>>  drivers/clk/meson/g12a.c              | 118 ++++++++++++++++++++++++++
>>  drivers/clk/meson/g12a.h              |   5 +-
>>  include/dt-bindings/clock/g12a-clkc.h |   1 +
>>  5 files changed, 150 insertions(+), 1 deletion(-)
> 
> Well this PLL is indeed a nasty one ;)
> 
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> 

Applied patch 2 on next/headers, patches 1 & 3 on next/drivers

Neil
