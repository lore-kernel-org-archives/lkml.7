Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E4C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32B520718
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3t2CYkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfKUJqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:46:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36109 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUJqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:46:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id y10so3005390qto.3;
        Thu, 21 Nov 2019 01:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FRfqoR3D1Sv4wDhO7DSIhI3w3vZXZBxgc60xTbqdsxY=;
        b=X3t2CYkkZUaeaOQCVKiD90VrNN+uF1V3yWfQ0ph4KLKp+fv7PuXqs2CIpnOVpTnR7M
         9t0u76IQmgQUsdfauacp5DnN01TgCZnf+UetNVnsCUcMSoB4+8hCWyx0Xmcq9r4Exgra
         /r4k/Le0pbZlc3xyap/+otfwyUZjZ8iZ+ORruZLSbf5Yfif/OiK4HSR4elY8QZ6lYbzd
         Wjw9m6gSKsqupC4ICx7z9lpLuGUhjpiD86JjJ1C3d+a60Xn5X8FH0kHqNGjdikNIY8dk
         5PvhbPbcZTGZk9MaCFK0UNRT4+p7P+rPHENs4OqtnCJFDFwO1yKn1WJwRtBVWlvFklVh
         9vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FRfqoR3D1Sv4wDhO7DSIhI3w3vZXZBxgc60xTbqdsxY=;
        b=j6sbpPdB49JHyPdfe2shaNY2I9XRvjUHWy28SlUyuJjCPFZcxgyiXTsVOMFnDJTjyE
         02/AHlSWFdOKIim9G9S5tVJNP7wcIfpEjmRCiEh1sA8Ifu3pWaMXbCoOzeXuKdxfzZfm
         6/g2qSp921JKG4ekMC/ttfn/AcCOzxxtZSdvtgMhQOc2KUmjDgTa/O5UfZKJI5b9e+Qw
         k8g4M86CwqHM8GAGklJ58qrDr/LGtPbvsuBPPEWqhJeswp+UacQrhJjiwIryjmKrldYC
         KtZDnIX16B6AbCdI9UFnz6Xa8QySwhtdwEdg6hDogys6to+n7cFcyIGgNHjuXg2f2vz7
         BkjQ==
X-Gm-Message-State: APjAAAXh5MbijeRnN70Qpy39RRrkTxpNIz1zWXdflqajLQHyaakFSjAe
        /VZdF8xEl00SkZpVXeFLilxMqQL4C6rxFuxKWJ8=
X-Google-Smtp-Source: APXvYqwHDM7gnSQ1Zkv2iezgoGH8WwNvDlYZq1yaIeipIdjlmbZThfLF8JhLPHiRc+6qC9dQV3lAccNpQmyuYhH+I+s=
X-Received: by 2002:ac8:6d31:: with SMTP id r17mr7447476qtu.28.1574329601933;
 Thu, 21 Nov 2019 01:46:41 -0800 (PST)
MIME-Version: 1.0
References: <20190808173028.1930-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190808173028.1930-1-yamada.masahiro@socionext.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Thu, 21 Nov 2019 17:46:05 +0800
Message-ID: <CAEbi=3cZ29rmO55DcZSi8PmELay08HByabPETu_UOgXKZPk0cw@mail.gmail.com>
Subject: Re: [PATCH] nds32: remove unneeded clean-files for DTB
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nickhu <nickhu@andestech.com>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> =E6=96=BC 2019=E5=B9=B48=E6=
=9C=889=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:31=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> These patterns are cleaned-up by the top-level Makefile
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/nds32/boot/dts/Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/nds32/boot/dts/Makefile b/arch/nds32/boot/dts/Makefile
> index fff8ade7a84f..f84bd529b6fd 100644
> --- a/arch/nds32/boot/dts/Makefile
> +++ b/arch/nds32/boot/dts/Makefile
> @@ -5,5 +5,3 @@ else
>  BUILTIN_DTB :=3D
>  endif
>  obj-$(CONFIG_OF) +=3D $(BUILTIN_DTB)
> -
> -clean-files :=3D *.dtb *.dtb.S

Thanks, Masahiro.
Acked-by: Greentime Hu <green.hu@gmail.com>
