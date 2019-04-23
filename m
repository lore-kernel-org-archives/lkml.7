Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B668C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B34217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nhWB+QJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfDWPQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:16:06 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33221 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:16:06 -0400
Received: by mail-vs1-f65.google.com with SMTP id s11so8505158vsn.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UdWn7HGGxLgwLS0KfoftDBazyNSUX//gUGrcgrKRNbs=;
        b=nhWB+QJbIpc2jYUWw8PRRXSvLb6dRLkh0a6ycZSZv4VjQYfVdv09VChN+zmDaYNGRw
         SlLm8Zeha0LuQ3aO+TTn7MTD6eW1jwPuxMtEjuoGwPMV6fd2kZ+cqs/kxh12yqJ4FBoC
         CO5JeUX7FMOovl1+9AZfQSye6rIfgEgktfQOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UdWn7HGGxLgwLS0KfoftDBazyNSUX//gUGrcgrKRNbs=;
        b=faFEDJT+sOI2khjoG/GyHME68lvxH9Nuaioyj3dZeegTfL2z6hPWEBQ/hKJw+410yY
         /beSWPerz35jYPpSmCF+yGLf9QpvJ0gm0pW6qXHHHx7fVuStmnMX06wes54c4mB6NQtn
         i9Py/b67f0GcJNKFzF113blvd5UvAC8W/TJIgyN/ctoOql7B3gwAdoFXbrW2bIPmjMzA
         OM7qEJv0YjVqIMrizAOx2tiaCbQoFSBkMJzlVDE5FL5ZaD+Wcs+P17PXM5iH1YaTJwjB
         OjLZrcBk6ZrayMrxsrssHI+UHSmaG57ik3TmwLrOTZmj+aiwOjqKRInYjJjcWzK12RzR
         Kv+w==
X-Gm-Message-State: APjAAAXO2T2R+A4xp+wtODyYotev5LUSHx9RsucxlnoD1mmQj2d6gEmg
        cZGixJoxf5nOAbV5ejLD59vZ+bYS2gA=
X-Google-Smtp-Source: APXvYqxa3wW675Z903fdMi2jAxNc1wFsxxFZu+ppleOCOa9er2VewmFdxKuVeP+dEXGHLkXgi181eA==
X-Received: by 2002:a67:f813:: with SMTP id l19mr13573742vso.46.1556032564400;
        Tue, 23 Apr 2019 08:16:04 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id b142sm1182242vke.4.2019.04.23.08.16.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 08:16:02 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id d8so8424999vsp.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 08:16:02 -0700 (PDT)
X-Received: by 2002:a05:6102:417:: with SMTP id d23mr4336693vsq.48.1556032561834;
 Tue, 23 Apr 2019 08:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190213025707.GA16307@embeddedor>
In-Reply-To: <20190213025707.GA16307@embeddedor>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 08:15:47 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKdYiMtnO3wbOwCv2fy0PmvCBSLF8ANpBzBg057zaenRg@mail.gmail.com>
Message-ID: <CAGXu5jKdYiMtnO3wbOwCv2fy0PmvCBSLF8ANpBzBg057zaenRg@mail.gmail.com>
Subject: Re: [PATCH] memstick: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alex Dubov <oakad@yahoo.com>, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 6:57 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> drivers/memstick/host/jmb38x_ms.c: In function =E2=80=98jmb38x_ms_write_d=
ata=E2=80=99:
> drivers/memstick/host/jmb38x_ms.c:261:15: warning: this statement may fal=
l through [-Wimplicit-fallthrough=3D]
>    host->io_pos++;
>    ~~~~~~~~~~~~^~
> drivers/memstick/host/jmb38x_ms.c:262:2: note: here
>   case 2:
>   ^~~~
> drivers/memstick/host/jmb38x_ms.c:264:15: warning: this statement may fal=
l through [-Wimplicit-fallthrough=3D]
>    host->io_pos++;
>    ~~~~~~~~~~~~^~
> drivers/memstick/host/jmb38x_ms.c:265:2: note: here
>   case 1:
>   ^~~~
> drivers/memstick/host/tifm_ms.c: In function =E2=80=98tifm_ms_write_data=
=E2=80=99:
> drivers/memstick/host/tifm_ms.c:168:15: warning: this statement may fall =
through [-Wimplicit-fallthrough=3D]
>    host->io_pos++;
>    ~~~~~~~~~~~~^~
> drivers/memstick/host/tifm_ms.c:169:2: note: here
>   case 2:
>   ^~~~
> drivers/memstick/host/tifm_ms.c:171:15: warning: this statement may fall =
through [-Wimplicit-fallthrough=3D]
>    host->io_pos++;
>    ~~~~~~~~~~~~^~
> drivers/memstick/host/tifm_ms.c:172:2: note: here
>   case 1:
>   ^~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/memstick/host/jmb38x_ms.c | 2 ++
>  drivers/memstick/host/tifm_ms.c   | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jm=
b38x_ms.c
> index bcdca9fbef51..49c71f55489f 100644
> --- a/drivers/memstick/host/jmb38x_ms.c
> +++ b/drivers/memstick/host/jmb38x_ms.c
> @@ -259,9 +259,11 @@ static unsigned int jmb38x_ms_write_data(struct jmb3=
8x_ms_host *host,
>         case 3:
>                 host->io_word[0] |=3D buf[off + 2] << 16;
>                 host->io_pos++;
> +               /* fall through */
>         case 2:
>                 host->io_word[0] |=3D buf[off + 1] << 8;
>                 host->io_pos++;
> +               /* fall through */
>         case 1:
>                 host->io_word[0] |=3D buf[off];
>                 host->io_pos++;
> diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm=
_ms.c
> index bed205849d02..1bbb2ead9556 100644
> --- a/drivers/memstick/host/tifm_ms.c
> +++ b/drivers/memstick/host/tifm_ms.c
> @@ -166,9 +166,11 @@ static unsigned int tifm_ms_write_data(struct tifm_m=
s *host,
>         case 3:
>                 host->io_word |=3D buf[off + 2] << 16;
>                 host->io_pos++;
> +               /* fall through */
>         case 2:
>                 host->io_word |=3D buf[off + 1] << 8;
>                 host->io_pos++;
> +               /* fall through */
>         case 1:
>                 host->io_word |=3D buf[off];
>                 host->io_pos++;
> --
> 2.20.1
>


--=20
Kees Cook
