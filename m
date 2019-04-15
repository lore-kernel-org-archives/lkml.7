Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27311C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D412077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVZN7S4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfDOMh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:37:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34447 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:37:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so8545996pfd.1;
        Mon, 15 Apr 2019 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xa6jjHflkzVp6geEZRvxsF3ygTrUd40lz1AHWCxLn4I=;
        b=fVZN7S4YtVLZbyxoG1H9GJSQZuL4N7mEfXwrvivWdCOLCRgxA6O0nwkTIxh24bOsAK
         y/bdk0j3kASrvsJwLJ6RFLE+AMB/gDDwExHanLTHUByGEmEXKDk8K9twpn10qadzTQSq
         Aup9ppS5oySRQDMlhgBGHIc2uWHqHL1UGAukJFTBUEcAH6MQqR6ZPIyg8/optjr/5fQK
         TqvoB0QwaCXqd7GI5gz+hRpBPYRdjb6pqbb8JSZKxvTaPqahenQXP8pKq11zrS9WplGE
         IIz36n/tqZgzlXESZvuNFXT71tQ3YrTtf+dQFvdry4wcYoXVI0GQVmlu40o5FkAiShPY
         0Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xa6jjHflkzVp6geEZRvxsF3ygTrUd40lz1AHWCxLn4I=;
        b=WAxe5uUccvwdqWOcgQIHJv9+0Ms4eEaLr6BWOy63LflQ0W56iuxMafAcfcRzOJJSg3
         GbpBzrDcrUwyN6JBRtjIdjR6GZcZdqwtcpfOlRSpGo1wqI6fKzt54Xy7T1S0ZQzyQfGE
         3vrRb+m1T2lJRBT24qU9s/1uOrHIUDObhErHrfcaEcMYQ81NoxQYBwNT7LkdPUc9LaG/
         ux1/hKcRTX2NijbjI4sIuAQiC1JOXzKiL69erJ7VU27lqLvdvaXrY0zxKYlZs0WVNSEt
         J4daftBht75by0NqlIFybXv5YeZNTmMYDK3uyRrVjkRtQ4j5/sr7KVcCe9EhqyEHM295
         JRgw==
X-Gm-Message-State: APjAAAXcsFkp0D6HjgcAleRUHRytp0WxO7ZDRl3qG2xdSvwhjnMTLesh
        KMaHCVteJH9/yJXX9cIY7GX4r4DJcJrhLEA7ZImf6G2cC/oZYQ==
X-Google-Smtp-Source: APXvYqytPIE790S7DxBuychfe3y9JmXIaVZf8d3f22yuqTqDPsS50+mmfsEgz7nIM3fWJPXlAtCwhN7FgFJvQh/mSVU=
X-Received: by 2002:a62:6587:: with SMTP id z129mr75772062pfb.88.1555331875726;
 Mon, 15 Apr 2019 05:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com> <20190403124019.8947-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190403124019.8947-6-wsa+renesas@sang-engineering.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Apr 2019 15:37:44 +0300
Message-ID: <CAHp75VcnwMpWWDdg=y2z7N84kr8ZpUXW9un3UxB3uA__F56tGQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] i2c: demux: handle the new atomic callbacks
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 3:42 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> If the parent has an atomic callback, we need to translate it the same
> way as the non-atomic callback.
>

Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/muxes/i2c-demux-pinctrl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> index 035032e20327..d50454c565ee 100644
> --- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
> +++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> @@ -99,6 +99,8 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
>
>         /* Now fill out current adapter structure. cur_chan must be up to date */
>         priv->algo.master_xfer = i2c_demux_master_xfer;
> +       if (adap->algo->master_xfer_atomic)
> +               priv->algo.master_xfer_atomic = i2c_demux_master_xfer;
>         priv->algo.functionality = i2c_demux_functionality;
>
>         snprintf(priv->cur_adap.name, sizeof(priv->cur_adap.name),
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
