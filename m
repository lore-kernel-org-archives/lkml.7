Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2393CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 03:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E6020896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 03:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sYRe5GER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfCQDzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 23:55:36 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:23155 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfCQDzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 23:55:36 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x2H3t8kF002063
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:55:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2H3t8kF002063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552794909;
        bh=b/hQlo1K2wkwL8J4yGkeesSbm2fg+cRWS3jk6oc6bzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sYRe5GERKhx7+2p70/hw7EV53YTLEgDFwwq3asevwwa7Iq0tgiIH84sacqQgenSHG
         c02jRXHCW2xo0Qv0JebrWEq7H6kkV1EBwYbO01QW69rvnTalsN4yaqYlmKP4ej/pN6
         ORGEhVpHgtlf0Jj2in+Kx/56F4Xkn5XvZbeIURX6eV4GKz4Kw4kePOMrOX074IV2Ru
         WDcfRsMERWb2paTzwjNuoMgYgMFZT0T1oID5AqSJdyStYECP4xBn/y3BJfn3Ss2I3f
         HudsT9RT4f0SuW2exkXxla+bxNLmS8DvltP6Zatn8iBEWmIFbV/CGhlqzgZdsJ2bqV
         a9OCo9tYoh0FQ==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id w13so1585574vsc.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 20:55:08 -0700 (PDT)
X-Gm-Message-State: APjAAAWKSL/mgCnYVXW+E1GE6Dg+H+L2CL7gT1eMt4t6NDqOmfO9RZG1
        QWRU59x/RgWIX+e5ipUyHPqzRIRmY5zvwgUEogo=
X-Google-Smtp-Source: APXvYqysqYTzFnnEiOcf1ghbCXUTl19ig6DV9irjlBcfCXhyKVYxbQI5+q61WzTjarhkOhxiJZaZJueLE99ZDnQ7INo=
X-Received: by 2002:a67:7c04:: with SMTP id x4mr6051575vsc.155.1552794907647;
 Sat, 16 Mar 2019 20:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 17 Mar 2019 12:54:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzd=bL1H34w-E_UD9x6w2=ObyS+EPDZ_jrvfV+ncw-yA@mail.gmail.com>
Message-ID: <CAK7LNASzd=bL1H34w-E_UD9x6w2=ObyS+EPDZ_jrvfV+ncw-yA@mail.gmail.com>
Subject: Re: [PATCH v5] coccinelle: semantic code search for missing put_device()
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, Markus.Elfring@web.de,
        wang.yi59@zte.com.cn, Wen Yang <yellowriver2010@hotmail.com>,
        cheng.shengyu@zte.com.cn, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 12:35 AM Wen Yang <wen.yang99@zte.com.cn> wrote:
>
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
> The implementation of this semantic code search is:
> In a function, for a local variable returned by calling
> of_find_device_by_node(),
> a, if it is released by a function such as
>    put_device()/of_dev_put()/platform_device_put() after the last use,
>    it is considered that there is no reference leak;
> b, if it is passed back to the caller via
>    dev_get_drvdata()/platform_get_drvdata()/get_device(), etc., the
>    reference will be released in other functions, and the current functio=
n
>    also considers that there is no reference leak;
> c, for the rest of the situation, the current function should release the
>    reference by calling put_device, this code search will report the
>    corresponding error message.
>
> By using this semantic code search, we have found some object reference l=
eaks,
> such as:
> commit 11907e9d3533 ("ASoC: fsl-asoc-card: fix object reference leaks in
> fsl_asoc_card_probe")
> commit a12085d13997 ("mtd: rawnand: atmel: fix possible object reference =
leak")
> commit 11493f26856a ("mtd: rawnand: jz4780: fix possible object reference=
 leak")
>
> There are still dozens of reference leaks in the current kernel code.
>
> Further, for the case of b, the object returned to other functions may al=
so
> have a reference leak, we will continue to develop other cocci scripts to
> further check the reference leak.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Reviewed-by: Markus Elfring <Markus.Elfring@web.de>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Markus Elfring <Markus.Elfring@web.de>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Wen Yang <yellowriver2010@hotmail.com>
> Cc: cheng.shengyu@zte.com.cn
> Cc: cocci@systeme.lip6.fr
> Cc: linux-kernel@vger.kernel.org


Applied to linux-kbuild. Thanks.



> ---
> v5->v4:
> - exchange the word =E2=80=9Cpatch=E2=80=9D by =E2=80=9Ccode search=E2=80=
=9D
> - add a SPDX identifierfix
> - a split string literal can be unwanted.
> - Change the content of the reported information.
> v4->v3:
> - add Masahiro Yamada
> - omit a blank line
> - split the long message parameter
> - reduce the number of metavariables
> - Describe the implementation of the semantic patch,
>   explain the scenarios it can detect,
>   and further software development considerations.
> v3->v2:
> - reduction of a bit of redundant C code within SmPL search specification=
s.
> - consider the message construction without using the extra Python variab=
le =E2=80=9Cmsg=E2=80=9D
> v2->v1:
> - put exists after search, and then drop the when exists below.
> - should not use the same e as in the when's below.
> - Make a new type metavariable and use it to put a cast on the result of
>   platform_get_drvdata.
>
>  scripts/coccinelle/free/put_device.cocci | 56 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 scripts/coccinelle/free/put_device.cocci
>
> diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinell=
e/free/put_device.cocci
> new file mode 100644
> index 0000000..7395697
> --- /dev/null
> +++ b/scripts/coccinelle/free/put_device.cocci
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/// Find missing put_device for every of_find_device_by_node.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2018-2019 Wen Yang, ZTE.
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual report
> +virtual org
> +
> +@search exists@
> +local idexpression id;
> +expression x,e,e1;
> +position p1,p2;
> +type T,T1,T2,T3;
> +@@
> +
> +id =3D of_find_device_by_node@p1(x)
> +... when !=3D e =3D id
> +if (id =3D=3D NULL || ...) { ... return ...; }
> +... when !=3D put_device(&id->dev)
> +    when !=3D platform_device_put(id)
> +    when !=3D of_dev_put(id)
> +    when !=3D if (id) { ... put_device(&id->dev) ... }
> +    when !=3D e1 =3D (T)id
> +    when !=3D e1 =3D &id->dev
> +    when !=3D e1 =3D get_device(&id->dev)
> +    when !=3D e1 =3D (T1)platform_get_drvdata(id)
> +(
> +  return
> +(    id
> +|    (T2)dev_get_drvdata(&id->dev)
> +|    (T3)platform_get_drvdata(id)
> +);
> +| return@p2 ...;
> +)
> +
> +@script:python depends on report@
> +p1 << search.p1;
> +p2 << search.p2;
> +@@
> +
> +coccilib.report.print_report(p2[0], "ERROR: missing put_device; "
> +                             + "call of_find_device_by_node on line "
> +                             + p1[0].line
> +                             + ", but without a corresponding object rel=
ease "
> +                             + "within this function.")
> +
> +@script:python depends on org@
> +p1 << search.p1;
> +p2 << search.p2;
> +@@
> +
> +cocci.print_main("of_find_device_by_node", p1)
> +cocci.print_secs("needed put_device", p2)
> --
> 2.9.5
>


--=20
Best Regards
Masahiro Yamada
