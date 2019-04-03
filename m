Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3955C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDCF2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TffAhkN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfDCDIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:08:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36541 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCDIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:08:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so13480729ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hQ9sKU/iiavQ9B8EkZ6+toQU3gERUIkFxl9eRv73Wk=;
        b=TffAhkN5a/dcPunTWEnKUCYMDW9dEmTQJdgPyi6nZdYdaOLHpBVK66UzyMf755XAmt
         /ch0ZWz/y3nH0c/P0X5YT9jHpEB6MW3aTfs6Ti2XoP3NDJXHvkS0i3odaA19Wij0EJML
         RftHxMEJQEJxIACXPZ+Ee5oTAkrg8/CPEgdbW0Z258HIjUQIJ1BMIsNTg6n/4AwIEvLT
         2yegBBkZUp+hk6YLnZ9y945Uzj6/kbfIvIElYK3kiOvo3Qr4aMYzpjk9hnvWNtbJQHb+
         nvoa6/mRgc01O7chlrZ4TvSaOvk78vTyd/bJxHdTmJfmuMyiTnUkWbNXKhP+u8kG/0tg
         6d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hQ9sKU/iiavQ9B8EkZ6+toQU3gERUIkFxl9eRv73Wk=;
        b=lGgaSka7kwXl6XAMzWD2k4JNoR/gSLSU8Mu6noqmw3hkVqPugGKZ2N6Ql6WXDEupjU
         IMgmc8C8hDgbaE6hU7S0L34PzcFV4PkBJk7S5f+t6XXg9XiCRAKhw094q6zkI2ys5f5j
         TxYX3rjBkaNyque3d1lVXmw2Y0bCUQhYFTBIfXoQbFJtXxH7mi9fclkpguWQi+gt3ww5
         7xq2j5cXFgWA4DqK6OC9Hywo00pbgIXzXyQhGvBkutFw2oH6F4lSGN9JDrHiH5JqNKSN
         o5WpgjcV8J8j+V3m8QoGDKjppnDH71lxiICk1s1D6ApIeWWh6RAQm+eWG1AGd5K2ioPu
         /QLA==
X-Gm-Message-State: APjAAAVPDZbiBf4qEJlq0LZPM+M+Z2jEcz/P6ZNa7VZcXtHHRZWTUya7
        TBmn431hLBNJqEX5TaQAfcqglY/3d8UvthJGjYn2ZQ==
X-Google-Smtp-Source: APXvYqz/Nz6s1XYQIByWAHt3araD6UA1VWRk51JrLrpa/hciHD6rmc9JzC1zFAyQy3MoF2ZCGXDmQHAXcJaDXE5b1WY=
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr37463781lje.138.1554260884419;
 Tue, 02 Apr 2019 20:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <d3b12ed4-67e6-2993-4f56-80b1be572a24@gmail.com> <1552333805-23235-1-git-send-email-info@metux.net>
In-Reply-To: <1552333805-23235-1-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:07:52 +0700
Message-ID: <CACRpkdYODv81GnsAV=n=TwKjbcAAqh3BVHYddCtMzVWXR4h9iQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: omap: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 2:50 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied with Grygorii's ACK.

Yours,
Linus Walleij
