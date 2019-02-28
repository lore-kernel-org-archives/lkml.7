Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7D0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3033120857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvkQZQJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbfB1LRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:17:13 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36067 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfB1LRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:17:13 -0500
Received: by mail-it1-f195.google.com with SMTP id v83so15065231itf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 03:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEqCH0xeq/DKANfJYARB3choSwMbkMxuXgceEII+fxc=;
        b=lvkQZQJM3bIepgY8ryxe6yBsM0QLCZUK+oYoObsdY7Xp/3OotdEzIHhifzZRJLEVV7
         GvjbF7gc7fmj5y3V1mXf9+TRUINIR/80Tr+sFnyDcYj5uch9GEKJqsBMsYNz1sUnnvWG
         bKwY2VtMagWcrWpXQlLdEeKNxresxU6irhvd940AGu+XvWKSqFA981PrIXMADMylLzfU
         yP9vsa3sxLe8oy7m7JCC3yEo2ZBSwEWa1XHlNe/1slwU1poeiJ0hvfJk+aUzUZPwuFAX
         oDH5h9Il0JA3xZBuEac5FkddbEPo/Vp7+bv2caj1R4dZfXdrii8uettZjnu4wyOG4AoX
         3rSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEqCH0xeq/DKANfJYARB3choSwMbkMxuXgceEII+fxc=;
        b=KW+5pRHoQw9l83hx0luC/HOa6l+c+c8/04Njm9l4KGydBCPm8k2ISQYw9hHk04Xl20
         FiIaf07mQp0CAUsVZVEFWd8azsX5OIuqr2SFJhkzz8MeQAEbbF7pTYguGkAq0xCZv4I7
         voSNfQX7uJKWIZmV1vFDm/R4gcrEN8eZrj9V8wqPGHbCf7hVKxzDnHLtHa9PUB9A/dU3
         UWBxVWhvPTzZClxVEyVO1GeUPIEnlC+vgiawWp5jWZH5Q8zqBZ0KwQ637p5rurW8e2sI
         pBgAaOOeicsay5k88Nd8nolenO7E6mXRdErQxCf3dV05A7rBoBwphhccIsv7/ms8tvBj
         2+3g==
X-Gm-Message-State: APjAAAW4Ls7SD3yPpawhx8yvFSLEqGOV7q/fGwLfz3yclEOB7MdlTAKr
        xP3Q28Y5wZluK6OJdtJTXYr8Pole4n5X54u0mIiFEA==
X-Google-Smtp-Source: AHgI3Ias1DO9gaSTOptHADlxI8kCjfhOIoSN5CAHE9bZL+71Ano9AGzLkASONE3XtdvCtRSEz0cP2AuyR0lwpBWfc/w=
X-Received: by 2002:a24:9686:: with SMTP id z128mr2501961itd.97.1551352632347;
 Thu, 28 Feb 2019 03:17:12 -0800 (PST)
MIME-Version: 1.0
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr> <1550928043-14889-6-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1550928043-14889-6-git-send-email-Julia.Lawall@lip6.fr>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 28 Feb 2019 12:17:01 +0100
Message-ID: <CAHUa44HdtbAocBgc3gj5RZZPQs_uf85XnDsgUKfGPuzi+H0Z7w@mail.gmail.com>
Subject: Re: [PATCH 05/12] tee: optee: add missing of_node_put after of_device_is_available
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,
On Sat, Feb 23, 2019 at 2:58 PM Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> Add an of_node_put when a tested device node is not available.
>
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
>
> // <smpl>
> @@
> identifier f;
> local idexpression e;
> expression x;
> @@
>
> e = f(...);
> ... when != of_node_put(e)
>     when != x = e
>     when != e = x
>     when any
> if (<+...of_device_is_available(e)...+>) {
>   ... when != of_node_put(e)
> (
>   return e;
> |
> + of_node_put(e);
>   return ...;
> )
> }
> // </smpl>
>
> Fixes: db878f76b9ff ("tee: optee: take DT status property into account")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  drivers/tee/optee/core.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff -u -p a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -703,8 +703,10 @@ static int __init optee_driver_init(void
>                 return -ENODEV;
>
>         np = of_find_matching_node(fw_np, optee_match);
> -       if (!np || !of_device_is_available(np))
> +       if (!np || !of_device_is_available(np)) {
> +               of_node_put(np);
>                 return -ENODEV;
> +       }
>
>         optee = optee_probe(np);
>         of_node_put(np);
>

Applied.

Thanks,
Jens
