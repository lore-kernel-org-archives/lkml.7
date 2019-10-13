Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E65AC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 06:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D5520679
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 06:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jda3HR+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfJMGXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 02:23:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38273 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfJMGXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 02:23:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so8533606pfe.5;
        Sat, 12 Oct 2019 23:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5eAeBtymwWzWnzR8l2A7/RM2ROOsOpGfG8hUMk0mlW4=;
        b=jda3HR+16RcTF8c7KGYZ0KkV/GcM59GIC22PWLPJ41jQCCMx42ZTbC4Go+SHG8uOsN
         zD9Y6ltddf5wAXAAqaXYBIzuwb0254PeqmwRU1ryVYncbuN1YiWeSv/0cRvM5Y7QPtQX
         Kq0uqHCYZNcjoL/vO3Xq+sH43Kwa7vyHBlFpQ1ro9JmciFdzKqpcAhK+UTS9ELKxTX4I
         7RMgQeosY7P4DblvMYeNUqGPzdGwjrpKc7VtqpJDxjZUHLYLY/qNW7DjSKg56qSO+qDL
         FSU/CUlxp9ndOU4uXrfCMpPk0/yMiR2IyIDVvrBEBfLt7wTLucCsh3IcMFvfpQMp+R8I
         wxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5eAeBtymwWzWnzR8l2A7/RM2ROOsOpGfG8hUMk0mlW4=;
        b=mp2QKsmj+bIaJTQcR17zhPIZEutpo88/bXaE5kNuvVZi7EopB0DtANidT9STCZBXRT
         3N7tcCY834ZU3q6lSyLhuMtiuIKM4T181869TWYFO5vbavv7MjaQA2nxA+KJ19xGsIBs
         n/9iYJVySTfma4R+DZS5Qg2Ttq/VEUfx/DnbDWKLmNUf08hgcm2VpJt4beWnuH4tWAob
         LZVpHOfkaQZpZLbFMpiKpSDXg18Mt6qNpugb+Cv89U6IlpgMi3CvWzQoSihQPF7dyNHU
         PCVRk/2avwqCeQYH5mIqB/QMp0POl0Aj8hikS9P0NjiZz6Hhmb/VlU7AjLFaG9euCmN6
         5Zkw==
X-Gm-Message-State: APjAAAWHKV/rfOV91j6Lie60e27ezrjK3h0i0NgzMMXKadhtH1mvzI9D
        aUeuM1p/03K+8ZbkDAD+2riIYJk2nWWN7B8n6Rc=
X-Google-Smtp-Source: APXvYqz+Ib92xlYbc0zQ+h/EYI9nkOxpO/3BtsUfc5FLQoeJMoxYAVC+P7oRwWch8D5uw/KNqkXhnbHTrzxfZKf4Qxk=
X-Received: by 2002:a17:90a:b391:: with SMTP id e17mr29194193pjr.132.1570947834316;
 Sat, 12 Oct 2019 23:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191012171114.6589-1-j.neuschaefer@gmx.net> <20191012171114.6589-2-j.neuschaefer@gmx.net>
In-Reply-To: <20191012171114.6589-2-j.neuschaefer@gmx.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 13 Oct 2019 09:23:42 +0300
Message-ID: <CAHp75VfJLDd315SUx+s6WN6-mp-gUSZmhDbydU91_oe0pLbYwg@mail.gmail.com>
Subject: Re: [PATCH 2/4] docs: admin-guide: Move Dell RBU document from driver-api
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Linux Documentation List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 8:17 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> This document describes how an admin can use the dell_rbu driver, rather
> than any in-kernel API details.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/{driver-api =3D> admin-guide}/dell_rbu.rst | 0
>  Documentation/admin-guide/index.rst                    | 1 +
>  Documentation/driver-api/index.rst                     | 1 -
>  drivers/platform/x86/Kconfig                           | 2 +-
>  drivers/platform/x86/dell_rbu.c                        | 2 +-
>  5 files changed, 3 insertions(+), 3 deletions(-)
>  rename Documentation/{driver-api =3D> admin-guide}/dell_rbu.rst (100%)
>
> diff --git a/Documentation/driver-api/dell_rbu.rst b/Documentation/admin-=
guide/dell_rbu.rst
> similarity index 100%
> rename from Documentation/driver-api/dell_rbu.rst
> rename to Documentation/admin-guide/dell_rbu.rst
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-gu=
ide/index.rst
> index 545ea26364b7..4405b7485312 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -72,6 +72,7 @@ configure specific aspects of kernel behavior to your l=
iking.
>     clearing-warn-once
>     cpu-load
>     cputopology
> +   dell_rbu
>     device-mapper/index
>     efi-stub
>     ext4
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-ap=
i/index.rst
> index 2b3b6949381e..6a3ac50f51f0 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -72,7 +72,6 @@ available subsections can be seen below.
>     connector
>     console
>     dcdbas
> -   dell_rbu
>     edid
>     eisa
>     ipmb
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index ae21d08c65e8..a890f47fbeec 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -259,7 +259,7 @@ config DELL_RBU
>          DELL system. Note you need a Dell OpenManage or Dell Update pack=
age (DUP)
>          supporting application to communicate with the BIOS regarding th=
e new
>          image for the image update to take effect.
> -        See <file:Documentation/driver-api/dell_rbu.rst> for more detail=
s on the driver.
> +        See <file:Documentation/admin-guide/dell_rbu.rst> for more detai=
ls on the driver.
>
>
>  config FUJITSU_LAPTOP
> diff --git a/drivers/platform/x86/dell_rbu.c b/drivers/platform/x86/dell_=
rbu.c
> index 3691391fea6b..7d5453326b43 100644
> --- a/drivers/platform/x86/dell_rbu.c
> +++ b/drivers/platform/x86/dell_rbu.c
> @@ -24,7 +24,7 @@
>   * on every time the packet data is written. This driver requires an
>   * application to break the BIOS image in to fixed sized packet chunks.
>   *
> - * See Documentation/driver-api/dell_rbu.rst for more info.
> + * See Documentation/admin-guide/dell_rbu.rst for more info.
>   */
>  #include <linux/init.h>
>  #include <linux/module.h>
> --
> 2.20.1
>


--=20
With Best Regards,
Andy Shevchenko
