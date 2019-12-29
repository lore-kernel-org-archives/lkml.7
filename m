Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083BAC2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 10:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE935207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 10:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNFNjOW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfL2KpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 05:45:06 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41370 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfL2KpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 05:45:06 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so25674255ioo.8;
        Sun, 29 Dec 2019 02:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Gb+ONSF3piDYqauQDyCRW7orC1MjUr6i6hl9Z1quPME=;
        b=PNFNjOW0KqxeL09lLhXsrTTDSzd6SsVOoyS77t3cXLn1ztSzUtmLCMslU+TpoZsEGt
         UhlrF4VLGJmKv4PfluHNrqfxfzMa+EoeNmuVKRFdfyJrFvs38pBwRPeiFc8R6JfPw09c
         C2FKOjsdvXG7/fSeth3jH3Fddsdklf/u6AddHhcaA2kTOogA1xV+st97GSfSW+o8wZa0
         GgECIUuDiLBcIEqavM3P+VqeJojsNIgP+Cc5U1Elbqg0ItREImJtrYJZONvY2vk32Ncz
         fJIQbgiOkF8tMu0MUDXWUfXAr6/jSKjoGGWhBY7o63jYb/50wYWFVdJwQajAWjI8PltS
         3Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Gb+ONSF3piDYqauQDyCRW7orC1MjUr6i6hl9Z1quPME=;
        b=Yb/Bb7vTDRhb1v/XB2KHAxfkeWYF1oRzFghEgH71fyScM1j4o8bJ68qTDbO7xoGhzT
         O/0KzrqzlmNISlEj/nqy1enDr8208PWW4SxumtLpz9SyaRwSGtBCQHdkbWL+0hmy9Hif
         EZ5Yeqz//E7qqXYWYBHHbP176Sm+ZdGASWd8kik3ODTmcsLLayhYgCEpqgQ6QC06S7Z8
         El+eEjZyH/+4GkSCFlPtXPbumDMWSumpYAcabcvNDcJEMvUFT3/pqm9KDomxOAcnXytC
         Z2nvvHUIZfTCvvsgRcjq9Drw8VPlx8WqD0YMABFzWNBsa7JskFRit5JGI9HYOB4JLsDc
         3I3w==
X-Gm-Message-State: APjAAAV/sIwfG8ysonxqVNGXySrOjZqmkGiRH2FchdRO46ku0eYi/MSP
        9Uz+rMVNrWYHbYtr/sSCz/INv+eAxlPj6LbfWqA=
X-Google-Smtp-Source: APXvYqyLQj+vclB/xrWDh2FyNJJ9gsRkYWFqmhBkC++9MnOALJskz0muhMT/WIOfrsPWkz+D8aRFol3RhCLTz+Xlutk=
X-Received: by 2002:a6b:b941:: with SMTP id j62mr43177730iof.168.1577616305444;
 Sun, 29 Dec 2019 02:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20191229104325.10132-1-tiny.windzz@gmail.com> <20191229104325.10132-2-tiny.windzz@gmail.com>
In-Reply-To: <20191229104325.10132-2-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 29 Dec 2019 18:44:54 +0800
Message-ID: <CAEExFWujEpQ0F4bGi9Z94=ymRh5nx_3ftwUZfwLhPvaAbHNCrw@mail.gmail.com>
Subject: Re: [PATCH] platform: goldfish: pipe: switch to platform_get_irq
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bgolaszewski@baylibre.com, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        matti.vaittinen@fi.rohmeurope.com, phil.edworthy@renesas.com,
        suzuki.poulose@arm.com, saravanak@google.com,
        heikki.krogerus@linux.intel.com, dan.j.williams@intel.com,
        Joe Perches <joe@perches.com>, jeffrey.t.kirsher@intel.com,
        mans@mansr.com, tglx@linutronix.de, hdegoede@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, ztuowen@gmail.com,
        sergei.shtylyov@cogentembedded.com, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore this, I posted it just now...

On Sun, Dec 29, 2019 at 6:43 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> platform_get_resource(pdev, IORESOURCE_IRQ) is not recommended for
> requesting IRQ's resources, as they can be not ready yet. Using
> platform_get_irq() instead is preferred for getting IRQ even if it
> was not retrieved earlier.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/platform/goldfish/goldfish_pipe.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
> index cef0133aa47a..a1ebaec6eea9 100644
> --- a/drivers/platform/goldfish/goldfish_pipe.c
> +++ b/drivers/platform/goldfish/goldfish_pipe.c
> @@ -913,11 +913,9 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> -       r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -       if (!r)
> -               return -EINVAL;
> -
> -       dev->irq = r->start;
> +       dev->irq = platform_get_irq(pdev, 0);
> +       if (dev->irq < 0)
> +               return dev->irq;
>
>         /*
>          * Exchange the versions with the host device
> --
> 2.17.1
>
