Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1B3C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBDE206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/81MK+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbgAIPQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:16:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45644 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgAIPQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:16:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so3342379pgk.12;
        Thu, 09 Jan 2020 07:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8x3KQtdmLCGHQVMYlEwX9SAKLMp3jvxPuMlzPlJ4tQ=;
        b=B/81MK+aNeBQJoCL8tlwF9wWgD686trbtuROKH0xoRZ0Xqs588QFBY9P6tgWHDyTxv
         QyHjGIDcEKP6eHN5w57X6enHflhWsM/WWcEwY0UQQQTNPa6BlrKacq/JxvURvZ7vIO/Y
         dYAu3vmxRSLYEljiuTamb7hS/fHgFYVo3s2jGDf+s9IGP3sO8quWOoqBbEKlPq01ZxSJ
         upjATrnswkmLP1oSDadYVmvsxTpyyDGxQV1c3EVbTwIWhaZXATfjgpX2zVpnclEFh63d
         4u7qbR9L/oG5G07dSZrVkodwRFKry9LvFQWk0/Hj1z8ojBo4VkEtXke17Q18aAbkU5U8
         5kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8x3KQtdmLCGHQVMYlEwX9SAKLMp3jvxPuMlzPlJ4tQ=;
        b=Kjop1woQBDH69TUoOSnyeXelBPREOizmwD4qWvOVJ/Vaw2MeZM9VMFKXETEJ4lq9fK
         +TO2cd5/rBqpsalROMT/uvIzOiGw664mlCURLy/LbxffRyRixywX9MTKzvxKvBE+kEQx
         twDcFBui87DkM1HPfDo4tG4WpRJTwaRl7ACg1mWRbn3MwFPDT2FQbB/lUPLGfyXx9up1
         4XMPIxxcaCaYrehrC5RGi6urHNWr/NrgWZoHj86osWkJJMGK4pbcxlpaYJCvD7vKmJKB
         I/r93foD7Rgs/zkrWsIsZFYAPy7Q13BOXCJL0sP9Favm3qXwftT6acSJVO6aGiNyFC4M
         WfCw==
X-Gm-Message-State: APjAAAXwoPc3qPy4eJE5o/PjpsSxclBIUXEDDnPz4tAqEoZDnr2Z5DQN
        JR+Cp6hmdAW3RK2byXxoNWIIC5Z9lUTSpn9Jux4=
X-Google-Smtp-Source: APXvYqxVs+WHk742H4qNx1RfprwAhLCoHofNTwximDsXi0CRghIlz56lP75MPfGosrYXm1d2XDOpK4ib6Ekbg6SHQ5U=
X-Received: by 2002:a63:3d8e:: with SMTP id k136mr11632479pga.4.1578582982149;
 Thu, 09 Jan 2020 07:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20191231102917.24181-1-vadimp@mellanox.com> <20191231102917.24181-5-vadimp@mellanox.com>
In-Reply-To: <20191231102917.24181-5-vadimp@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jan 2020 17:16:13 +0200
Message-ID: <CAHp75VfJL8o1=5tVkicnMXUJ+Ry9q2r3oGD1x-B7Om_5Dvnkig@mail.gmail.com>
Subject: Re: [PATCH platform-next v1 4/9] platform/x86: mlx-platform: Cosmetic changes
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 12:29 PM Vadim Pasternak <vadimp@mellanox.com> wrote:
>
> Remove redundant semicolons at the end of few functions.
>

Sounds like this can be patch in the beginning of the series.
(Taking into account any bug fixes that have to prepend all the rest,
like Documentation fix)

> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> ---
>  drivers/platform/x86/mlx-platform.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
> index aed6ac18074e..7e92dc52071f 100644
> --- a/drivers/platform/x86/mlx-platform.c
> +++ b/drivers/platform/x86/mlx-platform.c
> @@ -1918,7 +1918,7 @@ static int __init mlxplat_dmi_default_matched(const struct dmi_system_id *dmi)
>         mlxplat_wd_data[0] = &mlxplat_mlxcpld_wd_set_type1[0];
>
>         return 1;
> -};
> +}
>
>  static int __init mlxplat_dmi_msn21xx_matched(const struct dmi_system_id *dmi)
>  {
> @@ -1937,7 +1937,7 @@ static int __init mlxplat_dmi_msn21xx_matched(const struct dmi_system_id *dmi)
>         mlxplat_wd_data[0] = &mlxplat_mlxcpld_wd_set_type1[0];
>
>         return 1;
> -};
> +}
>
>  static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
>  {
> @@ -1956,7 +1956,7 @@ static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
>         mlxplat_wd_data[0] = &mlxplat_mlxcpld_wd_set_type1[0];
>
>         return 1;
> -};
> +}
>
>  static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
>  {
> @@ -1975,7 +1975,7 @@ static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
>         mlxplat_wd_data[0] = &mlxplat_mlxcpld_wd_set_type1[0];
>
>         return 1;
> -};
> +}
>
>  static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
>  {
> @@ -1998,7 +1998,7 @@ static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
>         mlxplat_regmap_config = &mlxplat_mlxcpld_regmap_config_ng;
>
>         return 1;
> -};
> +}
>
>  static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
>         {
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
