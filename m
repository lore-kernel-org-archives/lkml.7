Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0048EC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5AD2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qj4QNTMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404051AbfFKGqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 02:46:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45524 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390485AbfFKGqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 02:46:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so11568090wre.12;
        Mon, 10 Jun 2019 23:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xaxK2cOJGhx/VdHimxeYocKNki8UteruN2DyLSA9lqE=;
        b=qj4QNTMgASzEMOBpzYHzyHzzClLpXmTOL7qOUKCaZRQuJppoA/7/Z58q9TPjAfoqCK
         RszQR+97Ii/JzYpegUzxhQqmyHCAeRIfz9uYce1pr0HQGfQhxm7HWei7ElNNmLKByt0M
         8EemVEXbjp6yrZuPCu86eR0rIsWjqMW1f0gve+ZK7FEujP/IF2jJjUEI+iZq5XLwuxmJ
         dsM+raIPUrM+6X2QFx+AT1bOTGxyJ6qkV+/dDxaG0mk1xs+ysui+4OLx57+ncD5GbXrd
         8bK54wFvn3I4gA2Nul1a+LKuYE3lZ1Ps3C5n7ihasx8y+W3EaowQzlVg7AzwEc4fleGd
         gxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xaxK2cOJGhx/VdHimxeYocKNki8UteruN2DyLSA9lqE=;
        b=IU+QI6ljqvMSV9Pwd8wsP7JlpltKJxm0ZSdxEnaDC7cQwc4oBnyWFGLNqNJkXFVX5+
         eEt6dzIkcpcg7ubvCs4KKK24IwXn8tO904QO6mgzdL685D9tatMGT3GPmZ49ndR1s3wH
         2WOvLFHsvUkFnheAO9FfSfggd3u0G9BX25hUn9BOhXyQv5jQzCrJ6pDmUAd/tQHfKL3B
         H1YkfAQCpnaq5FImISlxMGwNGfE3lbtSJW1qRPLspJKWXiG9sZpfBVSxyo6TlVO1w3u7
         QMYVN+DLiVQbGWQQ08eQhdWfhjyxBm6weD8rfHSUkcgq03OM3bwqhYjITFae4X9Co1eq
         0KmQ==
X-Gm-Message-State: APjAAAW165VUubk3EM5ykbKIICDq9kNQd8q2T7ta/T4MquhXdGbxFcRc
        YlgVbmBzFl7X6Q7LefGS5Jo7Q5HmjZQS3XP2jJg=
X-Google-Smtp-Source: APXvYqyiCGtrkBdd7wPq/5oueuA5FZMEmjCwiT3TZbB58uld1OzRrPn8KlwupjVbH5Q9WeW5FtiskSCWIhZQPzI7yyI=
X-Received: by 2002:adf:fc85:: with SMTP id g5mr48329708wrr.324.1560235589961;
 Mon, 10 Jun 2019 23:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190524072745.27398-1-amergnat@baylibre.com>
In-Reply-To: <20190524072745.27398-1-amergnat@baylibre.com>
From:   wens Tsai <wens213@gmail.com>
Date:   Tue, 11 Jun 2019 14:46:17 +0800
Message-ID: <CAGb2v661GYVmq9Xvw9j3RN1jV5Xe2c-naHkvEcVFSbHkeW3HBQ@mail.gmail.com>
Subject: Re: [PATCH] clk: fix clock global name usage.
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        baylibre-upstreaming@groups.io,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 3:29 PM Alexandre Mergnat <amergnat@baylibre.com> wrote:
>
> A recent patch allows the clock framework to specify the parent
> relationship with either the clk_hw pointer, the global name or through
> Device Tree name.
>
> But the global name isn't handled by the clk framework because the DT name
> is considered valid even if it's NULL, so of_clk_get_hw() returns an
> unexpected clock (the first clock specified in DT).
>
> This can be fixed by calling of_clk_get_hw() only when DT name is not NULL.
>
> Fixes: fc0c209c147f ("clk: Allow parents to be specified without string names")
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  drivers/clk/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index bdb077ba59b9..9624a75e5a8d 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -368,7 +368,7 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
>         const char *dev_id = dev ? dev_name(dev) : NULL;
>         struct device_node *np = core->of_node;
>
> -       if (np && index >= 0)
> +       if (name && np && index >= 0)

I think the opposite should be the case. If either the name or index is valid,
and there's a device node backing it, the code path should be entered.

This is implied by the description of struct clk_parent_data:

    @index: parent index local to provider registering clk (if @fw_name absent)

So the code path should be valid regardless of the value of .index.

That would make it

        if (np && (name || index >= 0)) ...

Regards
ChenYu


>                 hw = of_clk_get_hw(np, index, name);
>
>         /*
> --
> 2.17.1
>
