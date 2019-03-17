Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6D2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 03:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FE0218D0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 03:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OhphDw5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCQDDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 23:03:44 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:53742 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfCQDDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 23:03:43 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x2H33YBl018547;
        Sun, 17 Mar 2019 12:03:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x2H33YBl018547
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552791814;
        bh=PLgMZ2viq+2YOOfeXUK8Nf3DRZR23j2SxjeCLaT0Mcg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OhphDw5zlnrnB7wAvU6Oe2vpF+dg2jrNVi2peQCM4rizh5BWBmWO5jOnUubmmyM/Y
         EAI3q0aiPI0FKhXShd1UokL8OJ63+HqbTfhxslfTRRr9bmbEiEo0bs5xdPo2qha/PP
         RHUeYrsF1z3a3Lu17dc6WfhcvN6t7/bhQCrAMkItwe0qXg7U4E9Em1UnnAAJ2VSCQD
         1q+PxHOWT6Y+dUxgzinQmmQ4cvERYHTN9GtK79nAwO6n5DJGTiCcxRLGMnaF7qzZEX
         kddgQqbOXRnm6RA9nHheXVtDJ0XJauJBVzAMawiOBBwmw8q5hk1ZMyMWHHJYPZfPSQ
         +JThBC8iIhBQw==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id w13so1559715vsc.4;
        Sat, 16 Mar 2019 20:03:34 -0700 (PDT)
X-Gm-Message-State: APjAAAW1XvnshnRs5VK5cU6B6GfF+io1DjcT40Y1I606LTAwPTJddgap
        60cZhUEAcW+WYRIx/6xhW4GejXOKa+8obYiKyGI=
X-Google-Smtp-Source: APXvYqxuDNj7UAXvk9pVhmFBwDOZ1tdyT2BEjxN/WA2QganCB0yHw73zBWZNt/bIcQ22di1H06n8OsiwBIf4zZRyQLk=
X-Received: by 2002:a67:ea05:: with SMTP id g5mr5902158vso.179.1552791813401;
 Sat, 16 Mar 2019 20:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190309154307.23039-1-ar@cs.msu.ru> <20190309154307.23039-2-ar@cs.msu.ru>
In-Reply-To: <20190309154307.23039-2-ar@cs.msu.ru>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 17 Mar 2019 12:02:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNASRctWUMXG5PSUSG2FMGkQV7jNNcUieUKzxho9r81TU1A@mail.gmail.com>
Message-ID: <CAK7LNASRctWUMXG5PSUSG2FMGkQV7jNNcUieUKzxho9r81TU1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scripts/package/mkdebian: avoid implicit effects
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 12:44 AM Arseny Maslennikov <ar@cs.msu.ru> wrote:
>
> * The man page for dpkg-source(1) notes:
>
> >      -b, --build directory [format-specific-parameters]
> >             Build  a  source  package  (--build since dpkg 1.17.14).
> >             <...>
> >
> >             dpkg-source will build the source package with the first
> >             format found in this ordered list: the format  indicated
> >             with  the  --format  command  line  option,  the  format
> >             indicated in debian/source/format, =E2=80=9C1.0=E2=80=9D.  =
The  fallback
> >             to =E2=80=9C1.0=E2=80=9D is deprecated and will be removed =
at some point
> >             in the future, you should always  document  the  desired
> >             source   format  in  debian/source/format.  See  section
> >             SOURCE PACKAGE FORMATS for an extensive  description  of
> >             the various source package formats.
>
>   Thus it would be more foolproof to explicitly use 1.0 (as we always
>   did) than to rely on dpkg-source's defaults.
>
> * In a similar vein, debian/rules is not made executable by mkdebian,
>   and dpkg-source warns about that but still silently fixes the file.
>   Let's be explicit once again.
>
> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
> ---


Applied to linux-kbuild. Thanks.


>  scripts/package/mkdebian | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index f030961c5165..d276eb671a27 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -132,7 +132,9 @@ else
>          echo >&2 "Install lsb-release or set \$KDEB_CHANGELOG_DIST expli=
citly"
>  fi
>
> -mkdir -p debian/
> +mkdir -p debian/source/
> +echo "1.0" > debian/source/format
> +
>  echo $debarch > debian/arch
>
>  # Generate a simple changelog template
> @@ -221,5 +223,6 @@ clean:
>
>  binary: binary-arch
>  EOF
> +chmod +x debian/rules
>
>  exit 0
> --
> 2.20.1
>


--=20
Best Regards
Masahiro Yamada
