Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53663C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D232085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f6G1ZksP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfEAVJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 17:09:16 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37585 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEAVJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:09:15 -0400
Received: by mail-vk1-f196.google.com with SMTP id o187so76389vkg.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wf8ksqkRVK4oyVCJMyeMzEmCY6+2TIH7ALeORxibxXk=;
        b=f6G1ZksPI/h+lB6mB0xG7hOHTUI0dMAPgrgoLITmo/kPaPXQXVvynQdyTjGvrXw1Pb
         r8ZaFmPNBB5+yLEr5KxHOAfwm5fiGoIfObLdhSlswYLLuzEY2j8ZCKUFwZpquTvrqHpK
         AyiIDvr3b17hsR8rz4RiBoDHiqw5yh76yxO+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wf8ksqkRVK4oyVCJMyeMzEmCY6+2TIH7ALeORxibxXk=;
        b=MX7RHwfGU+AOpHsok/npiA97vJ11rNYVgBD+SpRrQ81oVRrEqhS/XMZsl6fJqnCIof
         GV0sq2280jhnCdUkVv9M+HmH8niyDiya72CbaxLa3vjC+Zd0uytirt5+pINesY13a8CG
         lPKir7EPK6tuRoArQC0f2UuoUf2mvRBd2aRKVECqZy50buyCyoFXsWTtPIMbBTvH4cYv
         DcI40OmCyM5kQDhmvvYOwz2Pwsas844/WFil4P59ICXMrzyBMLOy1nWsSxFzC6e0UvAw
         HTNrhYFOvH8X/xEVYtOk5NWccww5SGiWywdMtnzlLqGXp5j34zupxrUm90EMY5UFT66k
         Q57A==
X-Gm-Message-State: APjAAAW1nCxSz9lT9IR/d64ZHduUp9cn/b/j9+/WQUOIdhPitKXDDYoY
        MR2QP+T99nBnYQJsA1k83ufh6TspIm0=
X-Google-Smtp-Source: APXvYqwJZcP4Qk+P7yQI8dUdAumACf32pdH5hdAcrcUkR5nHaU+/oLjGGw8l5w7GoKxGzyMaBag80g==
X-Received: by 2002:a1f:8407:: with SMTP id g7mr11122727vkd.27.1556744954112;
        Wed, 01 May 2019 14:09:14 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id j63sm567456vke.8.2019.05.01.14.09.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 14:09:13 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id b23so184023vso.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 14:09:12 -0700 (PDT)
X-Received: by 2002:a67:c909:: with SMTP id w9mr42079vsk.222.1556744952510;
 Wed, 01 May 2019 14:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190424180934.GA29307@embeddedor>
In-Reply-To: <20190424180934.GA29307@embeddedor>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 1 May 2019 14:09:01 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLKgsz7JXGk=4MZg_dOxSAMTygK2WS5558gJYQcurOuJA@mail.gmail.com>
Message-ID: <CAGXu5jLKgsz7JXGk=4MZg_dOxSAMTygK2WS5558gJYQcurOuJA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: sony-laptop: Fix unintentional fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Mattia Dongili <malattia@linux.it>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:09 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> It seems that the default case should return AE_CTRL_TERMINATE, instead
> of falling through to case ACPI_RESOURCE_TYPE_END_TAG and returning AE_OK;
> otherwise the line of code at the end of the function is unreachable and
> makes no sense:
>
> return AE_CTRL_TERMINATE;
>
> This fix is based on the following thread of discussion:
>
> https://lore.kernel.org/patchwork/patch/959782/
>
> Fixes: 33a04454527e ("sony-laptop: Add SNY6001 device handling (sonypi reimplementation)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/platform/x86/sony-laptop.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> index 4bfbfa3f78e6..2058445fc456 100644
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -4424,14 +4424,16 @@ sony_pic_read_possible_resource(struct acpi_resource *resource, void *context)
>                         }
>                         return AE_OK;
>                 }
> +
> +       case ACPI_RESOURCE_TYPE_END_TAG:
> +               return AE_OK;
> +
>         default:
>                 dprintk("Resource %d isn't an IRQ nor an IO port\n",
>                         resource->type);
> +               return AE_CTRL_TERMINATE;
>
> -       case ACPI_RESOURCE_TYPE_END_TAG:
> -               return AE_OK;
>         }
> -       return AE_CTRL_TERMINATE;
>  }
>
>  static int sony_pic_possible_resources(struct acpi_device *device)
> --
> 2.21.0
>


-- 
Kees Cook
