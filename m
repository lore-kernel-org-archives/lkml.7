Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F026C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DACC20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gzAHvdsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDJVqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:46:34 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45717 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfDJVqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:46:34 -0400
Received: by mail-vs1-f68.google.com with SMTP id o10so2259028vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L4wfj6kbBNmWuCSiV+dDFg+QkSIBv+gB6fE5Jwj8vIs=;
        b=gzAHvdsgoeWoVQBFxGJBJxZT9XP8+Imiedq3yDGVpJfp0hsdyMXPywrdY+pGvFUNw/
         CanjlOjhYObsTSrHMtndU6GnSdlHjXpQjnSm1JyJoRcuJy5TXZLnIjQy1aBbNwsQFsXh
         92mG9J3EcTFM3TTeNM03P8Y5O6p0yKAKHuv/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L4wfj6kbBNmWuCSiV+dDFg+QkSIBv+gB6fE5Jwj8vIs=;
        b=RNhQXnkyCu5eBZv7PgsRaQrUhcQ6cNghG4EuTUL4hziP49JfOjrwIM6JNSja4r5M5j
         AWI+ANDMp0qK/UFZAsFt6e5LTmEhVrbrvTz489d6BKr/eVYoG0Y0zt8D6s5DJDPPGyPI
         0scX906LzaKR9sIZOm2IkphK03rhIzgBdqRZpORylQLMjP0WPv5vQlLPDPYbLlEX5mxs
         fLCG4ssPRP6xksG3fPoJmD0Ngnc2iO7ceOshRo4DSfP7GAqxdur0NSfKJBJaGcOAomBM
         5Y9kctaQ/hlqu3Ake9ueFPNvVEKny0UiVy4aHbqRK8il4RMqUnAK1fiE6yM8Y7cCYZ2p
         Mf0w==
X-Gm-Message-State: APjAAAVu8m3vnxEhWVN5MEmFZ8E8T7M2SpU/X2u6tDP4g9/9DMEz4iQN
        CTdrbzNVg2JlOkPbc51pLs1Wacccdv8=
X-Google-Smtp-Source: APXvYqyEWzodJGaabUUheev6V20q4+eb7tKe/Oo/BWRYNG46hXGBXW1tZhgws+Iypd0NWy3x8X3Lkw==
X-Received: by 2002:a05:6102:201:: with SMTP id z1mr26258662vsp.43.1554932792886;
        Wed, 10 Apr 2019 14:46:32 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id m23sm54389345vsl.24.2019.04.10.14.46.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 14:46:32 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id i207so2271148vsd.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:46:31 -0700 (PDT)
X-Received: by 2002:a67:1345:: with SMTP id 66mr24844706vst.30.1554932791555;
 Wed, 10 Apr 2019 14:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190208180202.GA16603@embeddedor>
In-Reply-To: <20190208180202.GA16603@embeddedor>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 14:46:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+p6aSOR5Tz_0TkqC7k30yxsSzSU0vAP44a0dMCbtEaeQ@mail.gmail.com>
Message-ID: <CAGXu5j+p6aSOR5Tz_0TkqC7k30yxsSzSU0vAP44a0dMCbtEaeQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: cfi_util: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 10:02 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> drivers/mtd/chips/cfi_util.c: In function =E2=80=98cfi_build_cmd=E2=80=99=
:
> drivers/mtd/chips/cfi_util.c:110:10: warning: this statement may fall thr=
ough [-Wimplicit-fallthrough=3D]
>    onecmd |=3D (onecmd << (chip_mode * 32));
>    ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/chips/cfi_util.c:112:2: note: here
>   case 4:
>   ^~~~
> drivers/mtd/chips/cfi_util.c:113:10: warning: this statement may fall thr=
ough [-Wimplicit-fallthrough=3D]
>    onecmd |=3D (onecmd << (chip_mode * 16));
>    ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/chips/cfi_util.c:114:2: note: here
>   case 2:
>   ^~~~
> drivers/mtd/chips/cfi_util.c: In function =E2=80=98cfi_merge_status=E2=80=
=99:
> drivers/mtd/chips/cfi_util.c:163:7: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>    res |=3D (onestat >> (chip_mode * 32));
>    ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/chips/cfi_util.c:165:2: note: here
>   case 4:
>   ^~~~
> drivers/mtd/chips/cfi_util.c:166:7: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>    res |=3D (onestat >> (chip_mode * 16));
>    ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/chips/cfi_util.c:167:2: note: here
>   case 2:
>   ^~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/mtd/chips/cfi_util.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mtd/chips/cfi_util.c b/drivers/mtd/chips/cfi_util.c
> index 6f16552cd59f..e3b266ee06af 100644
> --- a/drivers/mtd/chips/cfi_util.c
> +++ b/drivers/mtd/chips/cfi_util.c
> @@ -109,10 +109,13 @@ map_word cfi_build_cmd(u_long cmd, struct map_info =
*map, struct cfi_private *cfi
>         case 8:
>                 onecmd |=3D (onecmd << (chip_mode * 32));
>  #endif
> +               /* fall through */
>         case 4:
>                 onecmd |=3D (onecmd << (chip_mode * 16));
> +               /* fall through */
>         case 2:
>                 onecmd |=3D (onecmd << (chip_mode * 8));
> +               /* fall through */
>         case 1:
>                 ;
>         }
> @@ -162,10 +165,13 @@ unsigned long cfi_merge_status(map_word val, struct=
 map_info *map,
>         case 8:
>                 res |=3D (onestat >> (chip_mode * 32));
>  #endif
> +               /* fall through */
>         case 4:
>                 res |=3D (onestat >> (chip_mode * 16));
> +               /* fall through */
>         case 2:
>                 res |=3D (onestat >> (chip_mode * 8));
> +               /* fall through */
>         case 1:
>                 ;
>         }
> --
> 2.20.1
>


--=20
Kees Cook
