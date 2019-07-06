Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2431C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 13:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878DD20843
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 13:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OpeCV7Dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfGFNNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 09:13:47 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:59775 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfGFNNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 09:13:47 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x66DDh6Q009895
        for <linux-kernel@vger.kernel.org>; Sat, 6 Jul 2019 22:13:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x66DDh6Q009895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562418823;
        bh=e2JdIb42SpLrSPeYe2x3rwr5/vj30CwDJrGofHRtPcQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OpeCV7DpVXFEJaJiflMkdBarlsrDKlZFWi2wrEiXlacaGP6vrbLtnUQDIhhEgIiuv
         F39wDpxAhFUGQm+jb8xOFpiiVDFt3j72F1CCLsACBwxPC1iye94x+ViOTKTChshHFV
         SYB0q3HIuwbwH+8aiJ1R9mzJWVPuAq7fv+7oWCuVEhRJ1PWL5oMMHVa5EiOwdbnoQd
         EMK5MvgB1LSipVXpyjaxTKAcX8H19DF+et8dXcsFDZVYt/uYhGN2cTSWc9B8b6I+O1
         le5ryMRW6p7/6rFahQCsBRS8/Z3ZaX7uRi838j68sPuuA5NlGKxROcK8FHXVu2InIl
         AqOn+Zv7O6q+g==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id j21so3178185uap.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 06:13:43 -0700 (PDT)
X-Gm-Message-State: APjAAAWOqBNXPYiYpN5ys636J/KjV7xIFrnY7sERRICd6GybLTIlyrol
        kSHjWHbEybWR9t7RnIEoc1TnRbwCF2b/cQLeqDY=
X-Google-Smtp-Source: APXvYqyCmZNNAH3HX1+U1sPCnry+OjVGTzY7HA5gSSqHJPNpCJJ86QhC/3VJO6gn503UNHnpEfLyqBNYAHnoRh4iXtQ=
X-Received: by 2002:a9f:2265:: with SMTP id 92mr4965431uad.121.1562418822502;
 Sat, 06 Jul 2019 06:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de> <308f5571-68f3-7505-d5ad-59ee68091959@web.de>
In-Reply-To: <308f5571-68f3-7505-d5ad-59ee68091959@web.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 6 Jul 2019 22:13:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmqVDG8V=S5zfSAmKgeDE0M__P_mi0FpahYLLxmAQ-dw@mail.gmail.com>
Message-ID: <CAK7LNARmqVDG8V=S5zfSAmKgeDE0M__P_mi0FpahYLLxmAQ-dw@mail.gmail.com>
Subject: Re: [Cocci] [PATCH 1/5] Coccinelle: put_device: Adjust a message construction
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 5:59 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 7 May 2019 11:20:48 +0200
>
> The Linux coding style tolerates long string literals so that
> the provided information can be easier found also by search tools
> like grep.
> Thus simplify a message construction in a SmPL rule by concatenating text
> with two plus operators less.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Applied to linux-kbuild.


>  scripts/coccinelle/free/put_device.cocci | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
> index c9f071b0a0ab..3ebebc064f10 100644
> --- a/scripts/coccinelle/free/put_device.cocci
> +++ b/scripts/coccinelle/free/put_device.cocci
> @@ -42,11 +42,10 @@ p1 << search.p1;
>  p2 << search.p2;
>  @@
>
> -coccilib.report.print_report(p2[0], "ERROR: missing put_device; "
> -                             + "call of_find_device_by_node on line "
> -                             + p1[0].line
> -                             + ", but without a corresponding object release "
> -                             + "within this function.")
> +coccilib.report.print_report(p2[0],
> +                             "ERROR: missing put_device; call of_find_device_by_node on line "
> +                             + p1[0].line
> +                             + ", but without a corresponding object release within this function.")
>
>  @script:python depends on org@
>  p1 << search.p1;
> --
> 2.21.0
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



-- 
Best Regards
Masahiro Yamada
