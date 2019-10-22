Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66951CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F5321872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeP7vgis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbfJVTCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:02:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45478 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732436AbfJVTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:02:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so18338242ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODZrm/rP7oHITb+NAb6AT+ekfsFAz8Z8DIgMpULpRQc=;
        b=EeP7vgis4oHoauMG+PYOC0a9rpOYSNAMp3eKA9t/KXTu2YpY8sNIX8wPZtQjcSXPon
         yjPsrJAkTxG8gy9OaDwpD3wJ/L/G8qyBOunP+4IfbAQKN5cEwPQumyg8MU2DmFS695eg
         lze3xTVq+LLzZkQ+jWm9J3RBIf0Ozvh6JuGnrz568EOtqfk8Zn0jK33bZU9W5amsLlWF
         0YjykSgLv43MTy1dHr0XxNI+EtOqZ2/dHO24XRYEIAp+8oEE0DjKs8ZKhGKrUcW/GQZm
         Fm0wWpPq5MiTiaYPk3G5isWuVZ7hGzzWP1MYi/wn1O+/2OIj8WBc7PzB9GOnStKV0Jim
         UvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODZrm/rP7oHITb+NAb6AT+ekfsFAz8Z8DIgMpULpRQc=;
        b=XzUt64JbOvOpROv1oVP1oFA6jdGOgRQWyWlua/LKIPf8QkZZOOzq9AcWo8mWm3ypzl
         8PtrdNwkpjA2xwv+KzhljH+QMLHTJ3N1yAU7EnJMX1mkSfldxHPy3t+cla32RfRne0On
         RMsDjNANgZgVYOjqSaV7kCakYTfTus++h5xXwqELvBrdOW046lDLHI33SAwyZJ6YboC+
         yRRuOU2WWQeP67AkDcYvz4Gz4W2/9Rhb/j+Re6LSg9ECZjlbetY61Iy2BPdt+IedUHqs
         ebhcjMabm5PFKmEg7Iy1XNtMSxhT4nqhyExHVwlhetZzLUQ3YwfoOMPmUCYVQgGPF7sF
         +9nA==
X-Gm-Message-State: APjAAAX4Y9fLqEBuccpfaK+oYfXauS9L5HSbjdgudJCpZlcyxpBWefKU
        rbEFpoztfyoLivhAh1tOBrylOEyEHss3HAtE+1Y=
X-Google-Smtp-Source: APXvYqwRnDdLQWpJT9C0Olg4cjksGgTXctgTE+XFYx90vIV/7/vIpENMrwScfxbfMRzJm/7vMp7IcRovj6EB2yrOLiE=
X-Received: by 2002:a2e:3111:: with SMTP id x17mr2616135ljx.146.1571770925975;
 Tue, 22 Oct 2019 12:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191016210629.1005086-1-ztuowen@gmail.com> <20191016210629.1005086-4-ztuowen@gmail.com>
In-Reply-To: <20191016210629.1005086-4-ztuowen@gmail.com>
From:   Roman Gilg <subdiff@gmail.com>
Date:   Tue, 22 Oct 2019 21:01:58 +0200
Message-ID: <CAJcyoyvymcUE4ckPzYno6f9oM6qTUPL_yCZSeJaENtF1UEt5NQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mfd: intel-lpss: use devm_ioremap_uc for MMIO
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, mcgrof@kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 7:48 PM Tuowen Zhao <ztuowen@gmail.com> wrote:
>
> Some BIOS erroneously specifies write-combining BAR for intel-lpss-pci
> in MTRR. This will cause the system to hang during boot. If possible,
> this bug could be corrected with a firmware update.
>
> This patch use devm_ioremap_uc to overwrite/ignore the MTRR settings
> by forcing the use of strongly uncachable pages for intel-lpss.
>
> The BIOS bug is present on Dell XPS 13 7390 2-in-1:
>
> [    0.001734]   5 base 4000000000 mask 6000000000 write-combining
>
> 4000000000-7fffffffff : PCI Bus 0000:00
>   4000000000-400fffffff : 0000:00:02.0 (i915)
>   4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203485
> Cc: <stable@vger.kernel.org>
> Tested-by: AceLan Kao <acelan.kao@canonical.com>
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/intel-lpss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index bfe4ff337581..b0f0781a6b9c 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -384,7 +384,7 @@ int intel_lpss_probe(struct device *dev,
>         if (!lpss)
>                 return -ENOMEM;
>
> -       lpss->priv = devm_ioremap(dev, info->mem->start + LPSS_PRIV_OFFSET,
> +       lpss->priv = devm_ioremap_uc(dev, info->mem->start + LPSS_PRIV_OFFSET,
>                                   LPSS_PRIV_SIZE);
>         if (!lpss->priv)
>                 return -ENOMEM;
> --
> 2.23.0
>

Tested this v5 series on an XPS 13 7390 2-in-1 with Manjaro/KDE
install and works fine there. Fixes hang during boot. Currently being
backported to 5.3 on that distro:
https://gitlab.manjaro.org/packages/core/linux53/commit/c00ddfb5

Tested-by: Roman Gilg <subdiff@gmail.com>
