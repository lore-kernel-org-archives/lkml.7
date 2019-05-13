Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E65C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA34620879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayvSBY5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfEMMIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:08:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43867 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfEMMIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:08:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id u27so8831490lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ac4KtOUsNoDvhwtf3ctSxXYmUHfwscjlSjgUuFBgLgc=;
        b=ayvSBY5SqK3dHApMglm4NnvF2Cn8ewBJkdkjrAXDUz05PQiGVjpvRF3+XClC/rS+7y
         w2QwbSVX0QSgedqUHVt/NQLuHiTgd4KptSYM8ZX1KYkV21Zl0IVTfaSMMDJFZoDAxAKl
         Ldcu6GHWpLq7D/sumOCb5st2LfbLau2MFhWF+Kd+KL5EJhPu8bNHI8deOpXLJoyKL/XH
         8O+2OMgq6/bpFLORQ9v7LTfgUg3xQItT7YvqnX7babI/q8rsE/PhiwFWz895dv4dOzV4
         NpUdxdjloCvZbXie5EAaqdpjddFcAqrteUSS1gqh6JESdh4Rw/CNX2yq4sefmVAkjQuw
         j53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ac4KtOUsNoDvhwtf3ctSxXYmUHfwscjlSjgUuFBgLgc=;
        b=LfitJ4mG4RrhCJjxOEaEXvwdXEQtey9nvkAt5JQ9V33n6d0oCAx/Iwlv/AiBDYCNdq
         dius0JF1YvzUnHOYqLbDOSvqkngdp54hG4Lzi4Uu4TXYC5SwO4UmoatDrfzgiKk6EgCQ
         oFG8KNhBZR//3kMJnit57/uxGL2JHX+IgjeOj66Of9UqaNeRq0KeAWEiAdmopvU1jMQM
         0lF9bEbb/0kvXOQFiTSkRvRHLQoUbrLeCSNwyT9I07aCJPDtu626+b8QoZAbr9z6stZ5
         vgPD0hl5q718Ot3CMjbZO06V+NiH6AGRCCtj65XgDmAZ9F35rDWBnJrzKwCyI8GJF4HE
         L38w==
X-Gm-Message-State: APjAAAVkshgOm9ZL2Z4zE2z/tghJzGUM/tH2Z6fXmzUyVpThK+qvykb6
        gDfgMzrZmyaWFdmd8Fq6NlCewBo7+bgVEdqTMQItow==
X-Google-Smtp-Source: APXvYqwJF+xPBJwJm+E8FKTc14obKjNiPyvFkQedIXVqqN5g+cLaP46UDWt9HDKLLIbctb7iaU1MffjgsblDjMEnym4=
X-Received: by 2002:ac2:5621:: with SMTP id b1mr14096133lff.27.1557749298694;
 Mon, 13 May 2019 05:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <5cd6d102.1c69fb81.b7df1.aae9@mx.google.com>
In-Reply-To: <5cd6d102.1c69fb81.b7df1.aae9@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 13 May 2019 17:38:06 +0530
Message-ID: <CAFqt6zZie-ei1L6qNvDJc=BSmfy-3vbFq6cX5Q7GrY1V4ROR6g@mail.gmail.com>
Subject: Re: [PATCH] ARM: Remove duplicate header
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 7:11 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove linux/tty.h which is included more than once
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/arm/mach-sa1100/hackkit.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
> index 643d5f2..0016d25 100644
> --- a/arch/arm/mach-sa1100/hackkit.c
> +++ b/arch/arm/mach-sa1100/hackkit.c
> @@ -22,7 +22,6 @@
>  #include <linux/serial_core.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> -#include <linux/tty.h>
>  #include <linux/gpio.h>
>  #include <linux/leds.h>
>  #include <linux/platform_device.h>
> --
> 2.7.4
>
