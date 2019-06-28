Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1000C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEA02064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaNMjaTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfF1OuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:50:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45490 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfF1OuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:50:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi6so3366366plb.12;
        Fri, 28 Jun 2019 07:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Yox1Etvd/O+wwizvg1jrjE81RtPEp0HNcZ5IkOo3Ak=;
        b=YaNMjaTPCrB+bDLeQKq/X2mMqux5lvGVZPIzqMFreBdBTmpuScV01jzfHx3U6QaE7M
         2aUSFp84Nv1IZIedckhwYFiFKlgNp5UOJvODsN2M/t5Pdydmvnwd+migHm1obnidoR2u
         JblGFygQzhf8sE8WvrrJCsf4d7BXR6kssAnihJicnTu6RL/oUw9i4CL5aYjBulp2OZOg
         VD9+SpNpvumFvIDkvnYhocFuL4+DgCnFxZgZ0wiC0lG8Dziyw8mwaB7RuQqCgR5ausm0
         SD1H6tDbI2fZqYxqfPFnTX12Qq+C0nwghmlY326QyIWl4K1ik6YFIdRSVF0REueiz3/f
         6rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Yox1Etvd/O+wwizvg1jrjE81RtPEp0HNcZ5IkOo3Ak=;
        b=sipIiEN2lN6BMLoLorUNArFGhBysL6bMpjdA/lSpQ2mphJ0JCAEwxUJRqWayLqwYtf
         F+sv+5LZk5ULKgW0kS2kYbBYnpCQlMqnwc12GtwmugZOe4nzsOIGvxTtH73B2qYNPPAs
         V7A6C2JygACqwWi057YuBhQBgVok8akuEd0DYoGO32eGXqGFpWx3haFAeBMOfZpn+Eh7
         RPkiun0OZjoiJxDJL4dv0TYaz0Kgzar7Vz5yibdLJG3JK3RgjcLTHb4S5EbY+1u1zyUw
         DDRJNhBTwfDurEk1seile61fBCQ1w4FgWrBZr6N0/KCcYSeQa+1/nVvWZQsEJL3qDQeQ
         qyjw==
X-Gm-Message-State: APjAAAXuPnGeaYRaJfObhYZYnI9zKPzPn1+8HGmT7+PnXrmowqjNU4wl
        ZzSzPXNvvOBzZa6S6FYppz3tQBuANqENy1nc2R0tosE1RW0=
X-Google-Smtp-Source: APXvYqz2CJc5HkKnMGYkO9OkYVTfzYJVA8oK2MsisH/DY8ZSO3O1PjNfe5djKMOja8J3xJgvIWxCVEpVxT59Iu992iU=
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr11968167plt.255.1561733399956;
 Fri, 28 Jun 2019 07:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561723736.git.mchehab+samsung@kernel.org> <9472251c3ff159b832b4e82d77836c44f89b49b0.1561723736.git.mchehab+samsung@kernel.org>
In-Reply-To: <9472251c3ff159b832b4e82d77836c44f89b49b0.1561723736.git.mchehab+samsung@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Jun 2019 17:49:48 +0300
Message-ID: <CAHp75VfkWkVvvufTje1G+w=7gjsr7D2On-NsOsOoTEBNLVLJzQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] platform: x86: get rid of a non-existent document
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 3:12 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Changeset 163ede97a9a2 ("Documentation: platform: Delete x86-laptop-drivers.txt")
> removed the x86-laptop-drivers.txt file, but forgot to update its
> Kconfig.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Fixes: 163ede97a9a2 ("Documentation: platform: Delete x86-laptop-drivers.txt")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  drivers/platform/x86/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bd15b47abcb4..c318501773bc 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -433,9 +433,6 @@ config COMPAL_LAPTOP
>           It adds support for rfkill, Bluetooth, WLAN, LCD brightness, hwmon
>           and battery charging level control.
>
> -         For a (possibly incomplete) list of supported laptops, please refer
> -         to: Documentation/platform/x86-laptop-drivers.txt
> -
>  config SONY_LAPTOP
>         tristate "Sony Laptop Extras"
>         depends on ACPI
> --
> 2.21.0
>


-- 
With Best Regards,
Andy Shevchenko
