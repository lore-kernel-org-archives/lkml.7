Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F52CC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089532184B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="NFaF/0+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391889AbfGYLb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:31:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37698 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391826AbfGYLbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:31:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id t76so37431480oih.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 04:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KhuBXKW1pqwu3I/a51C/lMMrHG93yOL/odw0jXksmsM=;
        b=NFaF/0+HWBocaTISPRN64FldkQJsCLdLOvTsLvCXfup95wjAONzWuBKO5ZBfS6oF1J
         ekdw5EqRu1vDsLkUPP8yayxmbdrOGMKKvDgdSqTumrq/ZI2blPkLolJokz3tMpSz5Od7
         HWqfiq+FtTHlUP+8d6HXhtaQyDxiNFxwvQFtqs/IPrI2nN9+kLAbJhhHho20DwC9vkII
         iPPEL36enx+NCendroTEzk3RZ2eR4hq/QsxLtDL7oviQHOAk7K1QoZ4arpkFtKrTG0OF
         2qXJXB2jE18QVAJwsyM2BX8o5PSu/f32LtkYRTY6e+0sXgxGSTCjNCgu8MFCj2e64/FE
         njZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KhuBXKW1pqwu3I/a51C/lMMrHG93yOL/odw0jXksmsM=;
        b=kV1UVxCyYC7nP7q21kWOLIf4Q9t1C9TTSCHaPXo4H/1W6VQ5VvobKOaeJdS6jjSZgU
         MJDsIwo2g68zFfZt4Hg1mYzcWpwwZaPGXsdN/LWtTuSZRi0L5wMzgMFsJus4pOd++4RQ
         URRsYEgpsIhmqflzgd9OEO5L6BwK40RVt8l8QfUU3uPb/tj73LoPH1LuAeRRqk8lN8PO
         8USrQdKOBxbuOhH9DQ4GoLwwYdX7okAw2m4H3IV3FIO37//F+3iameZR4a21AZ8Xns8j
         xfTF8KryjutrrZX3C3kXwmzf6R8/YQNGh7Jco3yHHo82dBtXrlD/Ge+0m6tBPQLzXba1
         ClaQ==
X-Gm-Message-State: APjAAAWyQP98MSGCjB587w6yAA8MxBks2wTG9RZrrSSZjkpA8UHp/uXR
        tHxx1tlG1QU7yfTQue0h2VCf3Zcil/iFJfaSoE7vvg==
X-Google-Smtp-Source: APXvYqyTumoJZ0ix0stK6lv6nkJJmb3o/KhhwbmFxp6XK2dHaRDdSRFrJZl7q7gsxLKrWmIrfy6vJiZqQtl3NavRNws=
X-Received: by 2002:a05:6808:8d3:: with SMTP id k19mr41623577oij.164.1564054314741;
 Thu, 25 Jul 2019 04:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190725085458.21838-1-hslester96@gmail.com>
In-Reply-To: <20190725085458.21838-1-hslester96@gmail.com>
From:   Patrick Havelange <patrick.havelange@essensium.com>
Date:   Thu, 25 Jul 2019 13:31:43 +0200
Message-ID: <CAKKE0ZE_9dK=nCodqHjTZFF2iQQvJRn=etdT_fm4ug7L_maCgg@mail.gmail.com>
Subject: Re: [PATCH] counter/ftm-quaddec: Use device-managed registration API
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Comments inline

On Thu, Jul 25, 2019 at 10:55 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Make use of devm_counter_register.
> Then we can remove redundant unregistration API
> usage to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/counter/ftm-quaddec.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index 68a9b7393457..bccbca8681b6 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -317,7 +317,7 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
>
>         ftm_quaddec_init(ftm);
>
> -       ret = counter_register(&ftm->counter);
> +       ret = devm_counter_register(&pdev->dev, &ftm->counter);
>         if (ret)
>                 ftm_quaddec_disable(ftm);
>
> @@ -328,8 +328,6 @@ static int ftm_quaddec_remove(struct platform_device *pdev)
>  {
>         struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
>
> -       counter_unregister(&ftm->counter);
> -

The orders of (de)initialization should be kept symmetrical.
In this case, now that counter_unregister() will be called via devm,
it will be executed after ftm_quaddec_remove()

This introduces a race condition where the ftm-quaddec is disabled but
the counter entry itself is not.

Somebody else (William?) should confirm this.


>         ftm_quaddec_disable(ftm);
>
>         return 0;
> --
> 2.20.1
>
