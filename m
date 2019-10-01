Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C04C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9D920640
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rTsyBF4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbfJANPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:15:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35269 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbfJANPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:15:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so3217405wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 06:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=DGm+jAKzcyF9jL/nAhZEw01gpHilyJv1iBgg1UwcO5I=;
        b=rTsyBF4vLm99v9d1KGwh8d1rbKgIWDAaHB6/bpo+pUKuKNfi/Hkwd2ektAhOZAG9h8
         i1pJgrjhTedbVbq9/Rdz07hnxeVdepDGKcfpLSPBTGLR31jsL21Ptrtab6OSTLuFUFTX
         1QK+WmbtXbF2rCTbs606Z8SBkuF12Qy0ikh3cdpi6DONpUfuMWyeGaRf5KXWVLgY3JIl
         TUG2EGpzQrzKvxohcBNO8bAQHC4ELBFciyoeOhjnmQ9kvmj8iGinr0lBUZCYWbv/s3Jc
         eZqzaTM1o90YA6e5QOy3RcBybGGAin5YjmQFT00wQyK9t+k2XYKXr8zBqCG5E1Q1kjEz
         e7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=DGm+jAKzcyF9jL/nAhZEw01gpHilyJv1iBgg1UwcO5I=;
        b=OrvUeiJbUTzfBQoVmc+MXJXdP1XjNL5nS121ubVpGZNk/DCzsJj9DIaKPf7M1EvDou
         IVcj59OxRVFVt6iyjGis+xEg3uJIEIVl3NbOIvFDdWL4D13yiAwrpg4j/5aqIqAjRcFx
         1uBWX5XzK+kAZfXIzbJwO5UFI4NXFyPDWNVf/hrRjIRLkdWZGV80AlmZSwhaSxnI4IuN
         PWkGfhMMQGoVEkCQd/VZoNbFmiaRxHbWmMlcNTeSinxNP3IShVMwmOi/iRq6X9ubVJwT
         KB8V6tqYwy8uX6Cya5Kiq6uOikwPXQpTiALjrIvYriy4gNhssXEfrurQ3hMnXGDHrP66
         tf1A==
X-Gm-Message-State: APjAAAXWrK0vQqgVaSpFsZgD0V5ofcs2znu944P9t45OX91vOfpnc1et
        9mmbs8vsHEp+Zf1tonoGeY04AQ==
X-Google-Smtp-Source: APXvYqy9u48k/I0891LpeWRVLsDnw8XWv4XSzhE2JT0unm7u7wxQCSBojPGSF2V8pa6KZeJmjxKotw==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr3681665wmi.151.1569935712186;
        Tue, 01 Oct 2019 06:15:12 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y186sm5172875wmd.26.2019.10.01.06.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:15:11 -0700 (PDT)
References: <20190921150411.767290-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     narmstrong@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/1] clk: meson: gxbb: let sar_adc_clk_div set the parent clock rate
In-reply-to: <20190921150411.767290-1-martin.blumenstingl@googlemail.com>
Date:   Tue, 01 Oct 2019 15:15:10 +0200
Message-ID: <1jimp8r4ip.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 21 Sep 2019 at 17:04, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> The meson-saradc driver manually sets the input clock for
> sar_adc_clk_sel. Update the GXBB clock driver (which is used on GXBB,
> GXL and GXM) so the rate settings on sar_adc_clk_div are propagated up
> to sar_adc_clk_sel which will let the common clock framework select the
> best matching parent clock if we want that.
>
> This makes sar_adc_clk_div consistent with the axg-aoclk and g12a-aoclk
> drivers, which both also specify CLK_SET_RATE_PARENT.
>
> Fixes: 33d0fcdfe0e870 ("clk: gxbb: add the SAR ADC clocks and expose them")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied, Thx
