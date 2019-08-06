Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78078C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2C72086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="I8CviA6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbfHFItw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:49:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54574 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732320AbfHFItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:49:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so77307073wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=e/5FlaB9m3gEnKe48majyR+7xFOfFfXfyiygau9Wh2Q=;
        b=I8CviA6xn+lteqKb2DklgcnuqBxGyR27LIonjjd1h6SlJ7vCnVT73BukBTDQpMD/QN
         U2y4909fk17Tj5+3DdR7UNyfYIEf0X01AupJp7sjyy+38+tOjJs0Uf+JrTykxS5yDnwl
         wpOTes3fxdYyL63v1gnEB0C5Yv8qgoEypMDTFHQyFrFNwkr3OnK1em/jY5s6AmTUf0bq
         Ru/EEqxoGZ1zYjLzFWFmPK8ebIGnhYIBm77pE5A4FxWigCCjJ7LHtKmhzsCkqNbHyIPQ
         vHE+9pliBkDd0CMU9qbuKNEbEw1dETq0tYpY6S4ziSkyt3NVkefhqW5/l6FiivltiBZ4
         qeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=e/5FlaB9m3gEnKe48majyR+7xFOfFfXfyiygau9Wh2Q=;
        b=OrIzPSwH292XWKHlkFkJcSAmLVVA6QqJAgIdSAlpncCLqMUA1OqRT4g1XvAo/Xfiil
         /z1FAacGBVWeKgCBzEqt+3+Pu/aukTe8zpuub9ia5VNi8MhsV7pe9Zvmi0wg9gO5QbBz
         DLYKib6OPKhMF8bXnkHeikWTOAbclUp+RWeI5BSBlx9vP6qXCgXLw1vqfpaGCqQ+jaN6
         qpArTQZtHHGr0b3Jr+r+Z9x/f4D/XCVGorFowmt/fak8coPkpiPclNquXfLfPyu5w4GW
         7x2YmP9mwo54UKzF+sZ88W1+qD9jlttd3zNaXIuvKe3dhmVDquNIJkK6EqrP7DYTvWpZ
         djmQ==
X-Gm-Message-State: APjAAAUumBZxXL/arlQ2SlxgXuKNjv/jnY9gQo74k71GCCY686Fca1tm
        r6WXfYjXrkH2R000CqpgU6B6lQ==
X-Google-Smtp-Source: APXvYqydrWSyKv/Z8aE0wnm5mBDuLQIs85p2Q4UZiFE76n+eAsC040k+pd2/Q6j5qysjYrVv9GE9ZA==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr3443503wmc.53.1565081389300;
        Tue, 06 Aug 2019 01:49:49 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x8sm74356883wmc.5.2019.08.06.01.49.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 01:49:48 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/9] clk: meson: axg-audio: Don't reference clk_init_data after registration
In-Reply-To: <20190731193517.237136-4-sboyd@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org> <20190731193517.237136-4-sboyd@kernel.org>
Date:   Tue, 06 Aug 2019 10:49:47 +0200
Message-ID: <1jwofqvftg.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31 Jul 2019 at 12:35, Stephen Boyd <sboyd@kernel.org> wrote:

> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.

Hi Stephen,

What to do you indend to do with this one ? Will you apply directly or
should we take it ?

We have several changes for the controller which may conflict with this
one. It is nothing major but the sooner I know how this changes goes in,
the sooner I can rebase the rest.

Also, We were (re)using the init_data only on register failures.
I understand that you want to guarantee .init is NULL when the clock is
registered, but it this particular case, the registeration failed so the
clock is not registered.

IMO, it would be better if devm_clk_hw_register() left the init_data
untouched if the registration fails.

>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>
> Please ack so I can take this through clk tree
>
>  drivers/clk/meson/axg-audio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index 8028ff6f6610..db0b73d53551 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -992,15 +992,18 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>  
>  	/* Take care to skip the registered input clocks */
>  	for (i = AUD_CLKID_DDR_ARB; i < data->hw_onecell_data->num; i++) {
> +		const char *name;
> +
>  		hw = data->hw_onecell_data->hws[i];
>  		/* array might be sparse */
>  		if (!hw)
>  			continue;
>  
> +		name = hw->init->name;
> +
>  		ret = devm_clk_hw_register(dev, hw);
>  		if (ret) {
> -			dev_err(dev, "failed to register clock %s\n",
> -				hw->init->name);
> +			dev_err(dev, "failed to register clock %s\n", name);
>  			return ret;
>  		}
>  	}
> -- 
> Sent by a computer through tubes
