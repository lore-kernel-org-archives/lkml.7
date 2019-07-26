Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCC0C41517
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E0D22CBD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="TIH72VEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfGZMvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:51:44 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34834 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGZMvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:51:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so40144319oii.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvMVXgkYpNN9sZPuxppMuXcoMoKSnEUwXCqI78r7ick=;
        b=TIH72VEwJpwTnsuWC8zz3OaqzRUPMGxpFxy6dYsj38j88Af6eYXPrhYU3vDK71zZIj
         uSKZHqDtlQ6qqNh57BpEnpBsJpDdc90pdEkJLWLyUeosw14uIiEZANxw+3HhOjeDMHNn
         w6De2kMAu5Iyk+tKmj5wBKSauJDf5dg0E5KrgDwKwb721u8CVWXa1NpMvnsp6EYu6cSL
         qfh+NsvPIsu+UOhGfgFUR+6N75jEGBlHyHPyKervAB+TCwrTtl+ifj+YqTaZDQO5F9dO
         O7upC+DFuIYrIvY+CHu0i8DSmUqSu53iyGGnLmqmpljmvEXXFjLW/YQKd1ck1Ub9xrcI
         f+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvMVXgkYpNN9sZPuxppMuXcoMoKSnEUwXCqI78r7ick=;
        b=k+wQXGPLQ1twLzH0H/yowvQOiN/uFmadoxuGMYITSLXf20761uD4c8KL8DXXg1jf22
         BdwQyTNFsftsCiXeLmPIB6PWjTLqdesAch2+LIJdXvEwrMJ3Ik439QhCRjD0KiC2CIUK
         yKHunFSJ3HoFcqIsWoaFQT8xnztr2GwBUVYIR0Srqw4138bC1YP5Gm7nhOhl8JOzE2Qq
         lVIBRhs89j5AQWgizPlSwHlLcSxynzfNQmHklskUL/jQD4gUGC318kcxsyrTuMPHlFxx
         ha5TSMixqBJUrph+fDCE/csrHKO8Z+jqop891wHSJOKCrg4TwtnAgnhI19WrjPh/Ux5E
         MAIA==
X-Gm-Message-State: APjAAAWQC1JREHVeI9KzhmYLjKo80UOB75eFXpOmpasy0E0eoc1goQ67
        JKZ74L0fBFQTjgbpmPhFOc+UkOQRp2hLQJo/ifpAUg==
X-Google-Smtp-Source: APXvYqwx6IXRb/OfiRGUc3dedl/UOL9sv4gr0GbVlzrNIsbqHM0mqlH5VsShWnu+ldh/+do6QZlIJDvDZLjBtdjsE1A=
X-Received: by 2002:aca:b107:: with SMTP id a7mr44870887oif.83.1564145501803;
 Fri, 26 Jul 2019 05:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190726022836.7182-1-hslester96@gmail.com>
In-Reply-To: <20190726022836.7182-1-hslester96@gmail.com>
From:   Patrick Havelange <patrick.havelange@essensium.com>
Date:   Fri, 26 Jul 2019 14:51:30 +0200
Message-ID: <CAKKE0ZG9hKqOnPHCfmW8Mpe2tdcdpdv4Njvx7XNuw6ykJf3P0w@mail.gmail.com>
Subject: Re: [PATCH v2] counter/ftm-quaddec: Use device-managed registration API
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jul 26, 2019 at 4:28 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Make use of devm_counter_register.
> Then we can remove redundant unregistration API
> usage to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Use devm_add_action_or_reset to keep
>     resource release order.

This is better now indeed.

However it seems there is an issue with the mail/patch format, I'm
unable to apply it with git am, and if you look at
https://lore.kernel.org/patchwork/patch/1105782/ the diff section is
missing the beginning of the patch. I don't know why, but I think it
should be looked into.

Otherwise, it's fine by me.

Regards,

Patrick Havelange


>   - _remove() function is redundant now,
>     delete it.
>
>  drivers/counter/ftm-quaddec.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index 68a9b7393457..76c70a6c3593 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -100,16 +100,17 @@ static void ftm_quaddec_init(struct ftm_quaddec *ftm)
>         ftm_set_write_protection(ftm);
>  }
>
> -static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
> +static void ftm_quaddec_disable(void *ftm)
>  {
> -       ftm_clear_write_protection(ftm);
> -       ftm_write(ftm, FTM_MODE, 0);
> -       ftm_write(ftm, FTM_QDCTRL, 0);
> +       struct ftm_quaddec *ftm_qua = ftm;
>
> +       ftm_clear_write_protection(ftm_qua);
> +       ftm_write(ftm_qua, FTM_MODE, 0);
> +       ftm_write(ftm_qua, FTM_QDCTRL, 0);
>         /*
>          * This is enough to disable the counter. No clock has been
>          * selected by writing to FTM_SC in init()
>          */
> -       ftm_set_write_protection(ftm);
> +       ftm_set_write_protection(ftm_qua);
>  }
>
>  static int ftm_quaddec_get_prescaler(struct counter_device *counter,
> @@ -316,22 +317,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
>         mutex_init(&ftm->ftm_quaddec_mutex);
>
>         ftm_quaddec_init(ftm);
> -
> -       ret = counter_register(&ftm->counter);
> +       ret = devm_add_action_or_reset(&pdev->dev, ftm_quaddec_disable, ftm);
>         if (ret)
> -               ftm_quaddec_disable(ftm);
> -
> -       return ret;
> -}
> -
> -static int ftm_quaddec_remove(struct platform_device *pdev)
> -{
> -       struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
> -
> -       counter_unregister(&ftm->counter);
> -
> -       ftm_quaddec_disable(ftm);
> +               return ret;
>
> +       ret = devm_counter_register(&pdev->dev, &ftm->counter);
> +       if (ret)
> +               return ret;
>         return 0;
>  }
>
> @@ -346,7 +338,6 @@ static struct platform_driver ftm_quaddec_driver = {
>                 .of_match_table = ftm_quaddec_match,
>         },
>         .probe = ftm_quaddec_probe,
> -       .remove = ftm_quaddec_remove,
>  };
>
>  module_platform_driver(ftm_quaddec_driver);
> --
> 2.20.1
>
