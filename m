Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534D1C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BC02133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9SrL7yF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDKNnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:43:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36116 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfDKNnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:43:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id u17so4765903lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiz8phefZFmKlnnYWEqdA3Wt/jQaZnTjvp73GqMgfKY=;
        b=M9SrL7yFslmZUI4Tccz9uheIZfcTjlZztvIyTrABlTLFWOVFrvc4s3gvWjdo3GcKwy
         CeUxqtiUpIBbbxL5U5N/XARGnFc8VYH5hE8SQ28BZTgP/1ChyBBk/I9kzeFnIiHnymNr
         +JTGZgHheFk5ZFZouYTAG5D10iLhC22adgVB8OeXm1B+/NkNGzyl8E0BFsdMqLq2MTsH
         +JlaA34juZX64dlNZcj60r5fOwiNdTb9yzxSa5j9Je3DC/U3ko8TW/PBumQygvgkTSMf
         bLgRNBt7URw816SHA23yHsWH5GFqtbROCQE5xaBNdfGRfZhJ8+6Sky1mn+ajxxivRhk0
         6uPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiz8phefZFmKlnnYWEqdA3Wt/jQaZnTjvp73GqMgfKY=;
        b=JbAEQt/8dPVGopP0XdtApvMEZF6TFjNXRl1BPurU+uumI23EbpgH1urvTWQEwQ4lP5
         iYUkmoPllGxhlLEbGxTTtCLt9O9PwewPtEYpwqFJYsPuyzcqzA/qsAqpfly/zDXEpYh8
         jVWUHQRBmOBPQRegFW5mWswtW3G7TSEG2ZJEYo1MQ1tvi4zBwT71RmsOY99ZQnfgO3vz
         cOlBCZenkVw9UkD9pqfHx7FNzhBNMtjvzRf9/RcyUK5l35cgePx2Xb3Gna4hv02QowBP
         dXaCInrpYxUfAGNSwsU00HwJ5Edo1Bo+/+1VgdhM6yMKmKVTuQ+ERg/rVzZQ5XPvAKnu
         fmZw==
X-Gm-Message-State: APjAAAVn4RpNfDW/cN0Tq348k7QIyg3DYJyebdB7z1hsvp88zH2q8F9b
        6OOj1hZPYZM9Zo31hb1gpCvWOVREiG+1mKvCfj81gQ==
X-Google-Smtp-Source: APXvYqySdIp78o4cr4EheD8Nr1G4qzkbNkoUdbVJfMJGF8BbHBcjay2euwFrsAYUldePTdrJfO0E/keZETXmOVjiXfk=
X-Received: by 2002:ac2:546c:: with SMTP id e12mr15610628lfn.121.1554990224289;
 Thu, 11 Apr 2019 06:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190410084558.35160-1-yuehaibing@huawei.com>
In-Reply-To: <20190410084558.35160-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:43:32 +0200
Message-ID: <CACRpkdZw6SMOgWgTsQC=XYs5qni8xz+1HzOLcPCWgwrH59umpQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads7950: Fix build error without CONFIG_GPIOLIB
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Stefan Popa <stefan.popa@analog.com>,
        Mark Brown <broonie@kernel.org>,
        Justin Chen <justinpopo6@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 10:47 AM Yue Haibing <yuehaibing@huawei.com> wrote:

> From: YueHaibing <yuehaibing@huawei.com>
>
> When building with CONFIG_GPIOLIB is not set
> gcc warns this:
>
> drivers/iio/adc/ti-ads7950.c:75:19: error: field chip has incomplete type
>   struct gpio_chip chip;
>                    ^~~~
> drivers/iio/adc/ti-ads7950.c: In function ti_ads7950_set:
> drivers/iio/adc/ti-ads7950.c:409:32: error: implicit declaration of function gpiochip_get_data; did you mean acpi_get_data? [-Werror=implicit-function-declaration]
>   struct ti_ads7950_state *st = gpiochip_get_data(chip);
>                                 ^~~~~~~~~~~~~~~~~
>                                 acpi_get_data
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: c97dce792dc8 ("iio: adc: ti-ads7950: add GPIO support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
